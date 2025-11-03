/**
 * Mini Framework - Router Module
 * Phase 3 - Prompt 8: Create the Router
 * Handles client-side hash-based routing and URL synchronization with app state
 */

/**
 * Create a router that syncs URL hash with app state
 * @param {object} store - The app's store object
 */
export function createRouter(store) {
    /**
     * Handler for hash changes
     * Gets current hash and updates the store's currentFilter state
     */
    function handleHashChange() {
        // Get the current hash (e.g., '#/', '#/active', '#/completed')
        const hash = window.location.hash || '#/';
        
        // Update the store with the current filter based on the hash
        store.setState({ currentFilter: hash });
    }
    
    // Listen for hash changes
    window.addEventListener('hashchange', handleHashChange);
    
    // Call handler once immediately to set initial filter state from URL
    handleHashChange();
}
