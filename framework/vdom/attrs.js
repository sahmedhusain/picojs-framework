import { registerEventHandler } from '../events.js';

// Updates DOM element attributes by comparing old and new attribute objects
// Handles special cases: event handlers, boolean properties, and property vs attribute distinction
export function patchAttrs(element, oldAttrs, newAttrs) {
    // Map JSX-style prop names to HTML attribute names
    const propertyMap = {
        className: 'class',
        htmlFor: 'for'
    };

    // Properties that should be set as booleans
    const booleanProps = new Set(['checked', 'selected', 'disabled', 'readOnly', 'multiple', 'autofocus']);
    
    // Properties that should be set as element properties rather than attributes
    const knownProps = new Set(['value', 'checked', 'selected', 'disabled', 'readOnly', 'multiple', 'autofocus', 'className', 'htmlFor']);

    const allKeys = new Set([...Object.keys(oldAttrs), ...Object.keys(newAttrs)]);

    allKeys.forEach(key => {
        const oldValue = oldAttrs[key];
        const newValue = newAttrs[key];

        if (key.startsWith('on') && typeof newValue === 'function') {
            // Event handler: register with delegation system
            const eventName = key.substring(2).toLowerCase();
            if (oldValue !== newValue) {
                const handlerId = registerEventHandler(eventName, newValue);
                element.setAttribute(`data-ev-${eventName}`, handlerId);
            }
        } else if (key.startsWith('on') && !newValue) {
            // Event handler removed
            const eventName = key.substring(2).toLowerCase();
            element.removeAttribute(`data-ev-${eventName}`);
        } else if (knownProps.has(key)) {
            // Known property: set as element property for reactivity
            if (oldValue !== newValue) {
                if (booleanProps.has(key)) {
                    // Boolean properties need special handling
                    element[key] = newValue === 'true' || newValue === true || newValue === '';
                } else {
                    element[key] = newValue;
                }
            }
        } else {
            // Standard attribute
            if (!newValue && oldValue) {
                element.removeAttribute(key);
            } else if (oldValue !== newValue) {
                element.setAttribute(key, newValue);
            }
        }
    });
}
