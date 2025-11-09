import { patchAttrs } from './attrs.js';
import { createDOMElement } from './domElement.js';

// Core diffing algorithm - compares old and new Virtual DOM nodes and updates real DOM
// Minimizes DOM operations by only patching differences
export function patch(parent, oldVNode, newVNode, index = 0) {
    const domNode = parent.childNodes[index];

    // Node removed
    if (!newVNode) {
        if (domNode) {
            parent.removeChild(domNode);
        }
        return;
    }

    // Node added
    if (!oldVNode) {
        const newElement = createDOMElement(newVNode);
        parent.appendChild(newElement);
        return;
    }

    // Handle primitive children (strings/numbers)
    if (typeof oldVNode === 'string' || typeof newVNode === 'string') {
        if (oldVNode !== newVNode) {
            const newElement = createDOMElement(newVNode);
            parent.replaceChild(newElement, domNode);
        }
        return;
    }

    // Different tag type - replace entire subtree
    if (oldVNode.tag !== newVNode.tag) {
        const newElement = createDOMElement(newVNode);
        parent.replaceChild(newElement, domNode);
        return;
    }

    // Text node - update content if changed
    if (oldVNode.tag === 'TEXT_ELEMENT') {
        if (oldVNode.attrs.nodeValue !== newVNode.attrs.nodeValue) {
            domNode.nodeValue = newVNode.attrs.nodeValue;
        }
        return;
    }

    // Same tag - patch attributes and recurse into children
    patchAttrs(domNode, oldVNode.attrs || {}, newVNode.attrs || {});

    const oldChildren = oldVNode.children || [];
    const newChildren = newVNode.children || [];

    // Use keyed reconciliation if any children have keys
    const oldHasKeys = oldChildren.some(child => child && child.attrs && child.attrs.key !== undefined);
    const newHasKeys = newChildren.some(child => child && child.attrs && child.attrs.key !== undefined);

    if (oldHasKeys || newHasKeys) {
        patchKeyedChildren(domNode, oldChildren, newChildren);
    } else {
        // Simple index-based reconciliation for unkeyed children
        const maxLength = Math.max(oldChildren.length, newChildren.length);
        for (let i = 0; i < maxLength; i++) {
            patch(domNode, oldChildren[i], newChildren[i], i);
        }
    }
}

// Advanced diffing for keyed children - preserves DOM nodes by matching keys
// Uses Maps for O(1) lookups instead of O(n) array searches
export function patchKeyedChildren(parent, oldChildren, newChildren) {
    // Build lookup maps for keyed nodes
    const oldKeyToNode = new Map();
    const oldKeyToVNode = new Map();
    const oldUnkeyedNodes = [];
    const oldUnkeyedVNodes = [];
    
    for (let i = 0; i < oldChildren.length; i++) {
        const child = oldChildren[i];
        const key = child && child.attrs && child.attrs.key;
        const domNode = parent.childNodes[i];
        
        if (key !== undefined) {
            oldKeyToNode.set(key, domNode);
            oldKeyToVNode.set(key, child);
        } else {
            oldUnkeyedNodes.push(domNode);
            oldUnkeyedVNodes.push(child);
        }
    }

    let unkeyedIndex = 0;

    // Process new children in order
    for (let i = 0; i < newChildren.length; i++) {
        const newChild = newChildren[i];
        const newKey = newChild && newChild.attrs && newChild.attrs.key;
        
        if (newKey !== undefined) {
            // Keyed node: reuse existing DOM node if found
            const oldDomNode = oldKeyToNode.get(newKey);
            const oldChild = oldKeyToVNode.get(newKey);
            
            if (oldDomNode && oldChild) {
                const currentDomNodeAtPosition = parent.childNodes[i];
                
                // Move node to correct position if needed
                if (oldDomNode !== currentDomNodeAtPosition) {
                    parent.insertBefore(oldDomNode, currentDomNodeAtPosition || null);
                }
                
                // Patch the node's attributes and children
                if (oldChild.tag === 'TEXT_ELEMENT') {
                    if (oldChild.attrs.nodeValue !== newChild.attrs.nodeValue) {
                        oldDomNode.nodeValue = newChild.attrs.nodeValue;
                    }
                } else {
                    patchAttrs(oldDomNode, oldChild.attrs || {}, newChild.attrs || {});
                    
                    const oldGrandChildren = oldChild.children || [];
                    const newGrandChildren = newChild.children || [];
                    const maxGrandChildren = Math.max(oldGrandChildren.length, newGrandChildren.length);
                    
                    for (let j = 0; j < maxGrandChildren; j++) {
                        patch(oldDomNode, oldGrandChildren[j], newGrandChildren[j], j);
                    }
                }
                
                // Mark this key as processed
                oldKeyToNode.delete(newKey);
            } else {
                // New keyed node: create and insert
                const newElement = createDOMElement(newChild);
                const currentDomNodeAtPosition = parent.childNodes[i];
                parent.insertBefore(newElement, currentDomNodeAtPosition || null);
            }
        } else {
            // Unkeyed node: reuse from unkeyed pool
            if (unkeyedIndex < oldUnkeyedVNodes.length) {
                const oldChild = oldUnkeyedVNodes[unkeyedIndex];
                const oldDomNode = oldUnkeyedNodes[unkeyedIndex];
                unkeyedIndex++;
                
                const currentDomNodeAtPosition = parent.childNodes[i];
                
                if (oldDomNode !== currentDomNodeAtPosition) {
                    parent.insertBefore(oldDomNode, currentDomNodeAtPosition || null);
                }
                
                patch(parent, oldChild, newChild, i);
            } else {
                // No unkeyed nodes left: create new
                const newElement = createDOMElement(newChild);
                const currentDomNodeAtPosition = parent.childNodes[i];
                parent.insertBefore(newElement, currentDomNodeAtPosition || null);
            }
        }
    }

    // Remove old keyed nodes that weren't reused
    for (const domNode of oldKeyToNode.values()) {
        if (domNode && domNode.parentNode === parent) {
            parent.removeChild(domNode);
        }
    }
    
    // Remove excess unkeyed nodes
    for (let i = unkeyedIndex; i < oldUnkeyedNodes.length; i++) {
        const domNode = oldUnkeyedNodes[i];
        if (domNode && domNode.parentNode === parent) {
            parent.removeChild(domNode);
        }
    }
}

