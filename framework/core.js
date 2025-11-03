/**
 * Mini Framework - Core Module
 * Handles DOM abstraction, state management, and event handling
 */

/**
 * Phase 1 - Prompt 3: Create Element Factory (createElement)
 * Create a virtual DOM element
 * @param {string} tag - The HTML tag name
 * @param {object} attrs - Element attributes
 * @param {...any} children - Child elements (can be nested arrays or primitives)
 * @returns {object} Virtual node object
 */
export function createElement(tag, attrs = {}, ...children) {
    // Flatten children array (handles nested arrays)
    const flattenedChildren = children.flat(Infinity);
    
    // Map children to virtual nodes
    const processedChildren = flattenedChildren.map(child => {
        // Handle primitive values (strings, numbers, booleans)
        if (typeof child === 'string' || typeof child === 'number') {
            return {
                tag: 'TEXT_ELEMENT',
                attrs: { nodeValue: String(child) },
                children: []
            };
        }
        
        // Handle null, undefined, or false (filter these out later if needed)
        if (child === null || child === undefined || child === false) {
            return null;
        }
        
        // Already a virtual node
        return child;
    }).filter(child => child !== null); // Remove null values
    
    return {
        tag,
        attrs: attrs || {},
        children: processedChildren
    };
}

/**
 * Phase 1 - Prompt 4: Create DOM Renderer (render)
 * Render a virtual DOM node to a real DOM container
 * @param {object} vNode - Virtual node to render
 * @param {HTMLElement} container - DOM container to render into
 */
export function render(vNode, container) {
    // Store the currently focused element and its state
    const activeElement = document.activeElement;
    const isInputFocused = activeElement && (activeElement.tagName === 'INPUT' || activeElement.tagName === 'TEXTAREA');
    const activeValue = isInputFocused ? activeElement.value : null;
    const activeSelectionStart = isInputFocused ? activeElement.selectionStart : null;
    const activeSelectionEnd = isInputFocused ? activeElement.selectionEnd : null;
    const activeClass = isInputFocused && activeElement.className ? activeElement.className : null;
    
    // Use a document fragment to batch DOM operations
    const fragment = document.createDocumentFragment();
    
    // Create the real DOM element from the virtual node
    const domElement = createDOMElement(vNode);
    
    // Append to fragment
    fragment.appendChild(domElement);
    
    // Clear and update container in one operation
    container.innerHTML = '';
    container.appendChild(fragment);
    
    // Restore focus and cursor position if input was focused
    if (isInputFocused && activeClass) {
        // Restore immediately without requestAnimationFrame to avoid flicker
        const newElement = container.querySelector(`.${activeClass}`);
        if (newElement && (newElement.tagName === 'INPUT' || newElement.tagName === 'TEXTAREA')) {
            newElement.focus();
            // Restore cursor position
            if (activeSelectionStart !== null && activeSelectionEnd !== null) {
                try {
                    newElement.setSelectionRange(activeSelectionStart, activeSelectionEnd);
                } catch (e) {
                    // Ignore errors for non-text inputs
                }
            }
        }
    }
}

/**
 * Helper function to create a real DOM element from a virtual node
 * Phase 2 - Prompt 6: Implement Event Handling (integrated here)
 * @param {object} vNode - Virtual node
 * @returns {Node} Real DOM node
 */
function createDOMElement(vNode) {
    // Handle text nodes
    if (vNode.tag === 'TEXT_ELEMENT') {
        return document.createTextNode(vNode.attrs.nodeValue);
    }
    
    // Create element
    const element = document.createElement(vNode.tag);
    
    // Set attributes and event listeners
    if (vNode.attrs) {
        Object.keys(vNode.attrs).forEach(key => {
            // Check if attribute is an event handler (starts with 'on')
            if (key.startsWith('on') && typeof vNode.attrs[key] === 'function') {
                // Extract event name (remove 'on' prefix and convert to lowercase)
                const eventName = key.substring(2).toLowerCase();
                const handler = vNode.attrs[key];
                
                // Add event listener
                element.addEventListener(eventName, handler);
            } else {
                // Regular attribute
                element.setAttribute(key, vNode.attrs[key]);
            }
        });
    }
    
    // Recursively render children
    if (vNode.children && vNode.children.length > 0) {
        vNode.children.forEach(child => {
            const childElement = createDOMElement(child);
            element.appendChild(childElement);
        });
    }
    
    return element;
}

/**
 * Phase 2 - Prompt 5: Create State Management (createStore)
 * Create a global state store with subscription capability
 * @param {object} initialState - Initial state object
 * @returns {object} Store object with subscribe, getState, and setState methods
 */
export function createStore(initialState) {
    // Private state variable
    let state = initialState;
    
    // Private listeners array
    const listeners = [];
    
    return {
        /**
         * Subscribe a listener function to state changes
         * @param {function} listener - Function to call when state changes
         */
        subscribe(listener) {
            listeners.push(listener);
        },
        
        /**
         * Get the current state
         * @returns {object} Current state object
         */
        getState() {
            return state;
        },
        
        /**
         * Update the state and notify all listeners
         * @param {object} newState - Object with state updates to merge
         */
        setState(newState) {
            // Merge new state with current state
            state = { ...state, ...newState };
            
            // Notify all listeners
            listeners.forEach(listener => listener());
        }
    };
}

/**
 * Phase 2 - Prompt 7: Create the App Core (createApp)
 * Create the main application with state management and rendering
 * @param {object} config - Configuration object
 * @param {function} config.view - View function that takes state and returns vNode
 * @param {object} config.initialState - Initial state for the store
 * @param {HTMLElement} config.rootElement - Root DOM element to render into
 * @returns {object} Store object for external state management
 */
export function createApp({ view, initialState, rootElement }) {
    // Create the store with initial state
    const store = createStore(initialState);
    
    let isRendering = false;
    let pendingRender = false;
    
    // Define the render loop function
    function renderLoop() {
        if (isRendering) {
            pendingRender = true;
            return;
        }
        
        isRendering = true;
        
        // Get current state
        const state = store.getState();
        
        // Call view function with state to get vNode tree
        const vNode = view(state);
        
        // Render the vNode tree to the root element
        render(vNode, rootElement);
        
        isRendering = false;
        
        if (pendingRender) {
            pendingRender = false;
            requestAnimationFrame(renderLoop);
        }
    }
    
    // Subscribe the render loop to state changes
    store.subscribe(renderLoop);
    
    // Perform initial render
    renderLoop();
    
    // Return the store so the app can interact with state
    return store;
}

