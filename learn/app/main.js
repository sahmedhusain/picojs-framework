import { createApp, createElement as h, bindInput } from '../framework/core.js';
import { createRouter } from '../framework/router.js';

console.log('🚀 PicoJS Framework Demo App Started!');
console.log('📚 This app demonstrates all framework features with detailed logging\n');

// =============================================================================
// FEATURE 1: REACTIVE STATE STORE
// =============================================================================
console.log('✅ FEATURE 1: Creating Reactive State Store');
console.log('   - Centralized state management');
console.log('   - Automatic re-rendering on state changes');
console.log('   - Pub/sub pattern with subscribers\n');

const initialState = {
    count: 0,
    message: 'Welcome to PicoJS Framework!',
    showAdvanced: false,
    currentFilter: '#/',
    user: {
        name: '',
        email: ''
    },
    todos: [
        { id: 1, text: 'Learn Virtual DOM', done: false },
        { id: 2, text: 'Understand State Management', done: false },
        { id: 3, text: 'Master Event Handling', done: false }
    ],
    inputValue: ''
};

console.log('📦 Initial State:', initialState);

// =============================================================================
// FEATURE 2: STATE SUBSCRIPTIONS
// =============================================================================
console.log('\n✅ FEATURE 2: State Subscriptions (Observer Pattern)');
console.log('   - Subscribe to state changes');
console.log('   - Multiple subscribers supported');
console.log('   - Useful for debugging and side effects\n');

let renderCount = 0;

// Will be set up after store is created
function setupSubscription(storeInstance) {
    storeInstance.subscribe((state) => {
        renderCount++;
        console.log(`🔄 Render #${renderCount} - State Updated:`, {
            count: storeInstance.getState().count,
            todosCount: storeInstance.getState().todos.length,
            completedTodos: storeInstance.getState().todos.filter(t => t.done).length,
            showAdvanced: storeInstance.getState().showAdvanced,
            currentRoute: storeInstance.getState().currentFilter
        });
    });
}

// =============================================================================
// STORE REFERENCE (for action handlers)
// =============================================================================
let store;

// =============================================================================
// FEATURE 3: HASH-BASED ROUTING
// =============================================================================
console.log('✅ FEATURE 3: Hash-Based Routing');
console.log('   - URL synchronization with state');
console.log('   - Browser back/forward support');
console.log('   - Filter todos by route (#/, #/active, #/completed)\n');

// =============================================================================
// FEATURE 4: ACTION HANDLERS (State Updates)
// =============================================================================
console.log('✅ FEATURE 4: Action Handlers');
console.log('   - Pure functions that update state');
console.log('   - Trigger re-renders automatically\n');

function increment() {
    console.log('➕ Action: Increment');
    const currentState = store.getState();
    store.setState({ count: currentState.count + 1 });
}

function decrement() {
    console.log('➖ Action: Decrement');
    const currentState = store.getState();
    store.setState({ count: currentState.count - 1 });
}

function reset() {
    console.log('🔄 Action: Reset Counter');
    store.setState({ count: 0 });
}

function toggleAdvanced() {
    console.log('🎛️  Action: Toggle Advanced Features');
    const currentState = store.getState();
    store.setState({ showAdvanced: !currentState.showAdvanced });
}

function toggleTodo(id) {
    console.log(`✓ Action: Toggle Todo #${id}`);
    const currentState = store.getState();
    store.setState({
        todos: currentState.todos.map(todo =>
            todo.id === id ? { ...todo, done: !todo.done } : todo
        )
    });
}

function addTodo(e) {
    if (e.key === 'Enter' && e.target.value.trim()) {
        console.log(`➕ Action: Add Todo - "${e.target.value}"`);
        const currentState = store.getState();
        const newTodo = {
            id: Date.now(),
            text: e.target.value.trim(),
            done: false
        };
        store.setState({
            todos: [...currentState.todos, newTodo],
            inputValue: ''
        });
    }
}

function handleInput(e) {
    const currentState = store.getState();
    store.setState({ inputValue: e.target.value });
}

function removeTodo(id) {
    console.log(`🗑️  Action: Remove Todo #${id}`);
    const currentState = store.getState();
    store.setState({
        todos: currentState.todos.filter(todo => todo.id !== id)
    });
}

// =============================================================================
// FEATURE 5: VIRTUAL DOM with h() function
// =============================================================================
console.log('✅ FEATURE 5: Virtual DOM (h function)');
console.log('   - h(tag, props, children) creates virtual nodes');
console.log('   - Efficient diffing and patching');
console.log('   - Minimal DOM manipulations\n');

// =============================================================================
// FEATURE 6: EVENT HANDLING
// =============================================================================
console.log('✅ FEATURE 6: Event Handling');
console.log('   - Declarative event binding (onclick, onkeydown, etc.)');
console.log('   - Event delegation for performance');
console.log('   - Automatic cleanup\n');

// =============================================================================
// FEATURE 7: CONDITIONAL RENDERING
// =============================================================================
console.log('✅ FEATURE 7: Conditional Rendering');
console.log('   - Show/hide elements based on state');
console.log('   - Clean declarative syntax\n');

// =============================================================================
// FEATURE 8: LIST RENDERING with Keys
// =============================================================================
console.log('✅ FEATURE 8: List Rendering with Keys');
console.log('   - Efficient list updates using keys');
console.log('   - DOM node reuse for performance');
console.log('   - Proper reconciliation\n');

// =============================================================================
// FEATURE 9: CONTROLLED INPUTS
// =============================================================================
console.log('✅ FEATURE 9: Controlled Inputs');
console.log('   - Two-way data binding');
console.log('   - Focus preservation with data-focuskey');
console.log('   - Input value synced with state\n');

// =============================================================================
// FEATURE 10: bindInput HELPER
// =============================================================================
console.log('✅ FEATURE 10: bindInput Helper');
console.log('   - Simplified two-way binding for nested state');
console.log('   - Uses dot notation (e.g., "user.name")');
console.log('   - Automatic state updates on input\n');

// Render todo item with all features demonstrated
function renderTodo(todo) {
    return h('li', { 
        key: todo.id,
        class: todo.done ? 'todo-item done' : 'todo-item'
    }, [
        h('input', {
            type: 'checkbox',
            checked: todo.done,
            onchange: () => toggleTodo(todo.id),
            'data-focuskey': `todo-${todo.id}`
        }),
        h('span', { class: 'todo-text' }, [todo.text]),
        h('button', {
            onclick: () => removeTodo(todo.id),
            class: 'delete-btn'
        }, ['×'])
    ]);
}

// Main view component
function view(state) {
    console.log('🎨 Rendering View Component');
    
    // Filter todos based on current route
    let filteredTodos = state.todos;
    if (state.currentFilter === '#/active') {
        filteredTodos = state.todos.filter(t => !t.done);
    } else if (state.currentFilter === '#/completed') {
        filteredTodos = state.todos.filter(t => t.done);
    }
    
    return h('div', { class: 'app-container' }, [
        // Header
        h('header', {}, [
            h('h1', {}, [
                h('img', {
                    src: 'logo.svg',
                    alt: 'PicoJS Framework Logo',
                    style: 'width: 48px; height: 48px; vertical-align: middle; margin-right: 15px;'
                }),
                'PicoJS Framework Demo'
            ]),
            h('p', { class: 'subtitle' }, [state.message])
        ]),

        // Main counter section
        h('section', { class: 'counter-section' }, [
            h('h2', {}, ['Counter Demo']),
            h('div', { class: 'count-display' }, [String(state.count)]),
            h('div', { class: 'button-group' }, [
                h('button', { onclick: increment }, ['➕ Increment']),
                h('button', { onclick: decrement }, ['➖ Decrement']),
                h('button', { onclick: reset, class: 'reset' }, ['🔄 Reset'])
            ])
        ]),

        // Toggle for advanced features
        h('div', { class: 'toggle-section' }, [
            h('button', {
                onclick: toggleAdvanced,
                class: 'toggle-btn'
            }, [state.showAdvanced ? '▼ Hide Advanced Features' : '▶ Show Advanced Features'])
        ]),

        // Conditional rendering - Advanced features
        ...(state.showAdvanced ? [
            h('section', { class: 'advanced-section' }, [
                h('h2', {}, ['📝 Todo List Demo']),
                h('p', { class: 'hint' }, ['Demonstrates: Lists, Keys, Controlled Inputs, Events, Routing']),
                
                // Controlled input
                h('input', {
                    type: 'text',
                    placeholder: 'Add a new todo (press Enter)',
                    value: state.inputValue,
                    oninput: handleInput,
                    onkeydown: addTodo,
                    class: 'todo-input',
                    'data-focuskey': 'todo-input'
                }),

                // Route filters
                h('div', { class: 'filter-tabs' }, [
                    h('a', {
                        href: '#/',
                        class: state.currentFilter === '#/' ? 'filter-tab active' : 'filter-tab'
                    }, ['All']),
                    h('a', {
                        href: '#/active',
                        class: state.currentFilter === '#/active' ? 'filter-tab active' : 'filter-tab'
                    }, ['Active']),
                    h('a', {
                        href: '#/completed',
                        class: state.currentFilter === '#/completed' ? 'filter-tab active' : 'filter-tab'
                    }, ['Completed'])
                ]),

                // Todo list with keys (filtered by route)
                h('ul', { class: 'todo-list' }, 
                    filteredTodos.map(todo => renderTodo(todo))
                ),

                // Stats
                h('div', { class: 'stats' }, [
                    `Total: ${state.todos.length} | `,
                    `Completed: ${state.todos.filter(t => t.done).length} | `,
                    `Active: ${state.todos.filter(t => !t.done).length}`
                ])
            ]),
            
            // bindInput demo section
            h('section', { class: 'advanced-section bind-input-demo' }, [
                h('h2', {}, ['🔗 bindInput Helper Demo']),
                h('p', { class: 'hint' }, ['Automatic two-way binding for nested state using dot notation']),
                
                h('div', { class: 'form-group' }, [
                    h('label', {}, ['Name:']),
                    h('input', {
                        type: 'text',
                        placeholder: 'Enter your name',
                        ...bindInput(store, 'user.name'),
                        class: 'bind-input',
                        'data-focuskey': 'user-name'
                    })
                ]),
                
                h('div', { class: 'form-group' }, [
                    h('label', {}, ['Email:']),
                    h('input', {
                        type: 'email',
                        placeholder: 'Enter your email',
                        ...bindInput(store, 'user.email'),
                        class: 'bind-input',
                        'data-focuskey': 'user-email'
                    })
                ]),
                
                h('div', { class: 'bind-preview' }, [
                    h('strong', {}, ['Live Preview:']),
                    h('pre', {}, [JSON.stringify(state.user, null, 2)])
                ])
            ])
        ] : []),

        // Footer with feature list
        h('footer', { class: 'feature-list' }, [
            h('h3', {}, ['✨ Framework Features Demonstrated:']),
            h('ul', {}, [
                h('li', {}, ['✅ Reactive State Store']),
                h('li', {}, ['✅ State Subscriptions']),
                h('li', {}, ['✅ Hash-Based Routing']),
                h('li', {}, ['✅ Virtual DOM (h function)']),
                h('li', {}, ['✅ Event Handling (onclick, onkeydown, etc.)']),
                h('li', {}, ['✅ Conditional Rendering']),
                h('li', {}, ['✅ List Rendering with Keys']),
                h('li', {}, ['✅ Controlled Inputs']),
                h('li', {}, ['✅ bindInput Helper']),
                h('li', {}, ['✅ Efficient DOM Patching'])
            ]),
            h('p', { class: 'console-hint' }, ['💡 Open DevTools Console to see detailed logs!'])
        ])
    ]);
}

// =============================================================================
// FEATURE 11: MOUNTING THE APP
// =============================================================================
console.log('✅ FEATURE 11: Mounting Application');
console.log('   - createApp({ view, initialState, rootElement })');
console.log('   - Renders to DOM and sets up reactivity\n');

const rootElement = document.getElementById('root');

store = createApp({
    view,
    initialState,
    rootElement
});

// Set up subscription logging
setupSubscription(store);

// Initialize router
console.log('🛣️  Initializing Hash-Based Router...');
createRouter(store);
console.log('   Router listening for hash changes (#/, #/active, #/completed)\n');

console.log('✨ App mounted successfully!');
console.log('👉 Try interacting with the app and watch the console logs\n');
console.log('═'.repeat(60));
