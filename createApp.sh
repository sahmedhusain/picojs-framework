#!/bin/bash

set -e

GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

if [ -z "$1" ]; then
    echo -e "${YELLOW}Usage: ./createApp.sh <app-name>${NC}"
    echo "Example: ./createApp.sh my-todo-app"
    exit 1
fi

APP_NAME=$1
APP_DIR="./$APP_NAME"

if [ -d "$APP_DIR" ]; then
    echo -e "${YELLOW}Error: Directory '$APP_NAME' already exists!${NC}"
    exit 1
fi

echo -e "${BLUE}Creating new Mini Framework app: ${GREEN}$APP_NAME${NC}"

mkdir -p "$APP_DIR/framework/vdom"
mkdir -p "$APP_DIR/app"
mkdir -p "$APP_DIR/styles"

echo -e "${GREEN}✓${NC} Created directory structure"

echo -e "${BLUE}Copying framework files...${NC}"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

cp "$SCRIPT_DIR/framework/core.js" "$APP_DIR/framework/core.js"
cp "$SCRIPT_DIR/framework/app.js" "$APP_DIR/framework/app.js"
cp "$SCRIPT_DIR/framework/events.js" "$APP_DIR/framework/events.js"
cp "$SCRIPT_DIR/framework/store.js" "$APP_DIR/framework/store.js"
cp "$SCRIPT_DIR/framework/router.js" "$APP_DIR/framework/router.js"
cp "$SCRIPT_DIR/framework/vdom.js" "$APP_DIR/framework/vdom.js"
cp "$SCRIPT_DIR/framework/vdom/createElement.js" "$APP_DIR/framework/vdom/createElement.js"
cp "$SCRIPT_DIR/framework/vdom/render.js" "$APP_DIR/framework/vdom/render.js"
cp "$SCRIPT_DIR/framework/vdom/patch.js" "$APP_DIR/framework/vdom/patch.js"
cp "$SCRIPT_DIR/framework/vdom/attrs.js" "$APP_DIR/framework/vdom/attrs.js"
cp "$SCRIPT_DIR/framework/vdom/domElement.js" "$APP_DIR/framework/vdom/domElement.js"

echo -e "${GREEN}✓${NC} Copied framework files"

cat > "$APP_DIR/styles/main.css" << 'EOF'
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Helvetica Neue', Arial, sans-serif;
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    min-height: 100vh;
    display: flex;
    justify-content: center;
    align-items: center;
    padding: 20px;
    -webkit-font-smoothing: antialiased;
    -moz-osx-font-smoothing: grayscale;
}

#root {
    background: rgba(255, 255, 255, 0.95);
    -webkit-backdrop-filter: blur(10px);
    backdrop-filter: blur(10px);
    border-radius: 24px;
    box-shadow: 
        0 20px 60px rgba(0, 0, 0, 0.3),
        0 0 0 1px rgba(255, 255, 255, 0.1) inset;
    padding: 48px;
    max-width: 500px;
    width: 100%;
    animation: fadeIn 0.4s ease-out;
}

@keyframes fadeIn {
    from {
        opacity: 0;
        transform: translateY(20px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
}

h1 {
    color: #2d3748;
    margin-bottom: 32px;
    font-size: 2.25rem;
    font-weight: 700;
    text-align: center;
    letter-spacing: -0.5px;
}

.counter {
    text-align: center;
}

.count-display {
    font-size: 5rem;
    color: #667eea;
    margin: 40px 0;
    font-weight: 800;
    text-shadow: 0 2px 10px rgba(102, 126, 234, 0.2);
    transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
}

.count-display:hover {
    transform: scale(1.05);
}

.button-group {
    display: flex;
    gap: 12px;
    justify-content: center;
    flex-wrap: wrap;
    margin-top: 24px;
}

button {
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    color: white;
    border: none;
    padding: 14px 28px;
    border-radius: 12px;
    font-size: 1rem;
    font-weight: 600;
    cursor: pointer;
    transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
    box-shadow: 0 4px 12px rgba(102, 126, 234, 0.3);
    position: relative;
    overflow: hidden;
    min-width: 130px;
}

button::before {
    content: '';
    position: absolute;
    top: 0;
    left: -100%;
    width: 100%;
    height: 100%;
    background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
    transition: left 0.5s;
}

button:hover::before {
    left: 100%;
}

button:hover {
    transform: translateY(-3px);
    box-shadow: 0 8px 20px rgba(102, 126, 234, 0.4);
}

button:active {
    transform: translateY(-1px);
    box-shadow: 0 4px 12px rgba(102, 126, 234, 0.3);
}

button.reset {
    background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
    box-shadow: 0 4px 12px rgba(245, 87, 108, 0.3);
}

button.reset:hover {
    box-shadow: 0 8px 20px rgba(245, 87, 108, 0.4);
}

/* Responsive design */
@media (max-width: 600px) {
    #root {
        padding: 32px 24px;
    }
    
    h1 {
        font-size: 1.75rem;
        margin-bottom: 24px;
    }
    
    .count-display {
        font-size: 4rem;
        margin: 32px 0;
    }
    
    button {
        padding: 12px 20px;
        font-size: 0.9rem;
        min-width: 110px;
    }
}

/* Header styles */
header {
    text-align: center;
    margin-bottom: 40px;
    border-bottom: 2px solid rgba(102, 126, 234, 0.1);
    padding-bottom: 24px;
}

.subtitle {
    color: #718096;
    font-size: 1.1rem;
    margin-top: 8px;
    font-weight: 500;
}

/* Counter section */
.counter-section {
    margin-bottom: 32px;
    padding-bottom: 32px;
    border-bottom: 2px solid rgba(102, 126, 234, 0.1);
}

.counter-section h2 {
    color: #4a5568;
    font-size: 1.5rem;
    margin-bottom: 20px;
    text-align: center;
}

/* Toggle section */
.toggle-section {
    text-align: center;
    margin: 32px 0;
}

.toggle-btn {
    background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
    min-width: 280px;
    font-size: 1.05rem;
}

.toggle-btn:hover {
    box-shadow: 0 8px 20px rgba(79, 172, 254, 0.4);
}

/* Advanced section */
.advanced-section {
    background: linear-gradient(135deg, rgba(102, 126, 234, 0.05) 0%, rgba(118, 75, 162, 0.05) 100%);
    padding: 32px;
    border-radius: 16px;
    margin: 32px 0;
    animation: slideIn 0.4s ease-out;
}

@keyframes slideIn {
    from {
        opacity: 0;
        transform: translateY(-20px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
}

.advanced-section h2 {
    color: #4a5568;
    font-size: 1.5rem;
    margin-bottom: 12px;
}

.hint {
    color: #718096;
    font-size: 0.9rem;
    margin-bottom: 20px;
    font-style: italic;
}

/* Todo input */
.todo-input {
    width: 100%;
    padding: 14px 18px;
    border: 2px solid rgba(102, 126, 234, 0.2);
    border-radius: 12px;
    font-size: 1rem;
    margin-bottom: 20px;
    transition: all 0.3s ease;
    font-family: inherit;
}

.todo-input:focus {
    outline: none;
    border-color: #667eea;
    box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
}

.todo-input::placeholder {
    color: #a0aec0;
}

/* Filter tabs for routing */
.filter-tabs {
    display: flex;
    gap: 8px;
    margin-bottom: 20px;
    background: white;
    padding: 6px;
    border-radius: 12px;
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
}

.filter-tab {
    flex: 1;
    padding: 10px 16px;
    text-align: center;
    text-decoration: none;
    color: #4a5568;
    border-radius: 8px;
    font-weight: 600;
    font-size: 0.95rem;
    transition: all 0.3s ease;
    cursor: pointer;
}

.filter-tab:hover {
    background: rgba(102, 126, 234, 0.1);
    color: #667eea;
}

.filter-tab.active {
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    color: white;
    box-shadow: 0 2px 8px rgba(102, 126, 234, 0.3);
}

/* Todo list */
.todo-list {
    list-style: none;
    margin: 20px 0;
}

.todo-item {
    display: flex;
    align-items: center;
    padding: 14px 18px;
    background: white;
    border-radius: 10px;
    margin-bottom: 10px;
    transition: all 0.3s ease;
    border: 2px solid transparent;
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
}

.todo-item:hover {
    border-color: rgba(102, 126, 234, 0.3);
    transform: translateX(4px);
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
}

.todo-item.done {
    opacity: 0.6;
    background: #f7fafc;
}

.todo-item.done .todo-text {
    text-decoration: line-through;
    color: #a0aec0;
}

.todo-item input[type="checkbox"] {
    width: 20px;
    height: 20px;
    margin-right: 14px;
    cursor: pointer;
    accent-color: #667eea;
}

.todo-text {
    flex: 1;
    color: #2d3748;
    font-size: 1rem;
}

.delete-btn {
    background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
    color: white;
    border: none;
    width: 32px;
    height: 32px;
    border-radius: 8px;
    font-size: 1.3rem;
    cursor: pointer;
    transition: all 0.3s ease;
    display: flex;
    align-items: center;
    justify-content: center;
    padding: 0;
    min-width: auto;
    box-shadow: 0 2px 8px rgba(245, 87, 108, 0.3);
}

.delete-btn:hover {
    transform: scale(1.1) rotate(90deg);
    box-shadow: 0 4px 12px rgba(245, 87, 108, 0.5);
}

/* Stats */
.stats {
    text-align: center;
    color: #718096;
    font-size: 0.95rem;
    font-weight: 600;
    padding: 16px;
    background: white;
    border-radius: 10px;
    margin-top: 16px;
}

/* bindInput demo section */
.bind-input-demo {
    margin-top: 24px;
}

.form-group {
    margin-bottom: 16px;
}

.form-group label {
    display: block;
    color: #4a5568;
    font-weight: 600;
    margin-bottom: 8px;
    font-size: 0.95rem;
}

.bind-input {
    width: 100%;
    padding: 12px 16px;
    border: 2px solid rgba(102, 126, 234, 0.2);
    border-radius: 10px;
    font-size: 1rem;
    transition: all 0.3s ease;
    font-family: inherit;
}

.bind-input:focus {
    outline: none;
    border-color: #667eea;
    box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
}

.bind-preview {
    margin-top: 20px;
    padding: 16px;
    background: white;
    border-radius: 10px;
    border: 2px solid rgba(102, 126, 234, 0.2);
}

.bind-preview strong {
    color: #4a5568;
    display: block;
    margin-bottom: 8px;
}

.bind-preview pre {
    color: #667eea;
    font-family: 'Monaco', 'Courier New', monospace;
    font-size: 0.9rem;
    margin: 0;
    white-space: pre-wrap;
}

/* Footer feature list */
.feature-list {
    margin-top: 40px;
    padding-top: 32px;
    border-top: 2px solid rgba(102, 126, 234, 0.1);
}

.feature-list h3 {
    color: #4a5568;
    font-size: 1.3rem;
    margin-bottom: 16px;
    text-align: center;
}

.feature-list ul {
    list-style: none;
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
    gap: 12px;
    margin-bottom: 20px;
}

.feature-list li {
    color: #2d3748;
    padding: 10px 16px;
    background: linear-gradient(135deg, rgba(102, 126, 234, 0.08) 0%, rgba(118, 75, 162, 0.08) 100%);
    border-radius: 8px;
    font-size: 0.95rem;
    transition: all 0.3s ease;
}

.feature-list li:hover {
    background: linear-gradient(135deg, rgba(102, 126, 234, 0.15) 0%, rgba(118, 75, 162, 0.15) 100%);
    transform: translateX(4px);
}

.console-hint {
    text-align: center;
    color: #667eea;
    font-weight: 600;
    font-size: 1.05rem;
    padding: 16px;
    background: linear-gradient(135deg, rgba(102, 126, 234, 0.1) 0%, rgba(118, 75, 162, 0.1) 100%);
    border-radius: 10px;
    animation: pulse 2s ease-in-out infinite;
}

/* Add subtle animation on load */
@keyframes pulse {
    0%, 100% {
        opacity: 1;
        transform: scale(1);
    }
    50% {
        opacity: 0.9;
        transform: scale(1.02);
    }
}

/* Responsive adjustments */
@media (max-width: 600px) {
    .feature-list ul {
        grid-template-columns: 1fr;
    }
    
    .advanced-section {
        padding: 20px;
    }
    
    .toggle-btn {
        min-width: 100%;
    }
}
EOF

echo -e "${GREEN}✓${NC} Created styles/main.css"

cat > "$APP_DIR/index.html" << 'EOF'
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mini Framework App</title>
    <link rel="stylesheet" href="/styles/main.css">
</head>
<body>
    <div id="root"></div>
    
    <script src="/app/main.js" type="module"></script>
</body>
</html>
EOF

echo -e "${GREEN}✓${NC} Created index.html"

cat > "$APP_DIR/app/main.js" << 'EOF'
import { createApp, createElement as h, bindInput } from '../framework/core.js';
import { createRouter } from '../framework/router.js';

console.log('🚀 Mini-Framework Demo App Started!');
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
    message: 'Welcome to Mini-Framework!',
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
            h('h1', {}, ['🚀 Mini-Framework Demo']),
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
EOF

echo -e "${GREEN}✓${NC} Created app/main.js"

cat > "$APP_DIR/README.md" << EOF
# $APP_NAME

A web application built with Mini Framework.

## Getting Started

### Run the App

You can run this app using any static file server. Here are a few options:

**Option 1: Using Python**
\`\`\`bash
# Python 3
python3 -m http.server 8000

# Python 2
python -m SimpleHTTPServer 8000
\`\`\`

**Option 2: Using Node.js (http-server)**
\`\`\`bash
npx http-server -p 8000
\`\`\`

**Option 3: Using PHP**
\`\`\`bash
php -S localhost:8000
\`\`\`

Then open your browser to: http://localhost:8000

## Project Structure

\`\`\`
$APP_NAME/
├── index.html              # Main HTML file
├── app/
│   └── main.js            # Your application code
├── styles/
│   └── main.css           # Application styles
└── framework/
    ├── core.js            # Main framework exports
    ├── app.js             # Application initialization
    ├── events.js          # Event delegation system
    ├── store.js           # State management
    ├── router.js          # Hash-based routing
    ├── vdom.js            # Virtual DOM exports
    └── vdom/
        ├── createElement.js   # Virtual node creation
        ├── render.js          # Main render function
        ├── patch.js           # Diffing & patching
        ├── attrs.js           # Attribute handling
        └── domElement.js      # DOM element creation
\`\`\`

## Modifying the App

Edit \`app/main.js\` to change your application:

1. **Update State**: Modify \`initialState\` object
2. **Update View**: Edit the \`view\` function to change the UI
3. **Add Routing**: Import and use \`createRouter\` from \`../framework/router.js\`

## Example: Adding a New Feature

\`\`\`javascript
import { createApp, createElement as h } from '../framework/core.js';

const initialState = {
    items: [],
    inputValue: ''
};

let store;

function addItem() {
    const trimmed = store.getState().inputValue.trim();
    if (trimmed) {
        store.setState({
            items: [...store.getState().items, trimmed],
            inputValue: ''
        });
    }
}

function view(state) {
    return h('div', {},
        h('h1', {}, 'My Todo List'),
        h('input', {
            type: 'text',
            value: state.inputValue,
            'data-focuskey': 'todo-input',
            oninput: (e) => store.setState({ inputValue: e.target.value }),
            onkeydown: (e) => {
                if (e.key === 'Enter') {
                    e.preventDefault();
                    addItem();
                }
            }
        }),
        h('button', {
            onclick: () => addItem()
        }, 'Add'),
        h('ul', {},
            ...state.items.map((item, index) => 
                h('li', { key: index }, item)
            )
        )
    );
}

const rootElement = document.getElementById('root');
store = createApp({ view, initialState, rootElement });
\`\`\`

## Learn More

For complete documentation, see the Mini Framework documentation.
EOF

echo -e "${GREEN}✓${NC} Created README.md"

cat > "$APP_DIR/.gitignore" << 'EOF'
# IDE specific files
.idea/
.vscode/
*.swp
*.swo
.DS_Store
*.pem

# Vercel
.vercel
.env*.local

# Logs
logs
*.log

# Testing
coverage/
.nyc_output/

# Cache directories
.npm/
.eslintcache
.stylelintcache
.parcel-cache/
.cache/
node_modules

# ---> Go
# If you prefer the allow list template instead of the deny list, see community template:
# https://github.com/github/gitignore/blob/main/community/Golang/Go.AllowList.gitignore
#
# Binaries for programs and plugins
*.exe
*.exe~
*.dll
*.so
*.dylib
# Test binary, built with `go test -c`
*.test
# Output of the go coverage tool, specifically when used with LiteIDE
*.out
# Dependency directories (remove the comment below to include it)
# vendor/
# Go workspace file
go.work
# ---> Linux
*~
# temporary files which can be created if a process still has a handle open of a deleted file
.fuse_hidden*
# KDE directory preferences
.directory
# Linux trash folder which might appear on any partition or disk
.Trash-*
# .nfs files are created when an open file is removed but is still being accessed
.nfs*
# ---> macOS
# General
*.DS_Store
.AppleDouble
.LSOverride
# Icon must end with two \r
Icon
# Thumbnails
._*
# Files that might appear in the root of a volume
.DocumentRevisions-V100
.fseventsd
.Spotlight-V100
.TemporaryItems
.Trashes
.VolumeIcon.icns
.com.apple.timemachine.donotpresent
# Directories potentially created on remote AFP share
.AppleDB
.AppleDesktop
Network Trash Folder
Temporary Items
.apdisk
# ---> Windows
# Windows thumbnail cache files
Thumbs.db
Thumbs.db:encryptable
ehthumbs.db
ehthumbs_vista.db
# Dump file
*.stackdump
# Folder config file
[Dd]esktop.ini
# Recycle Bin used on file shares
$RECYCLE.BIN/
# Windows Installer files
*.cab
*.msi
*.msix
*.msm
*.msp
# Windows shortcuts
*.lnk
EOF

echo -e "${GREEN}✓${NC} Created .gitignore"

echo ""
echo -e "${GREEN}========================================${NC}"
echo -e "${GREEN}✓ Success!${NC} App created: ${BLUE}$APP_NAME${NC}"
echo -e "${GREEN}========================================${NC}"
echo ""
echo -e "${BLUE}Next steps:${NC}"
echo -e "  1. cd $APP_NAME"
echo -e "  2. ${YELLOW}python3 -m http.server 8000${NC}  (or any static server)"
echo -e "  3. Open ${YELLOW}http://localhost:8000${NC} in your browser"
echo ""
echo -e "${BLUE}Start coding:${NC}"
echo -e "  Edit ${YELLOW}app/main.js${NC} to build your application"
echo ""
echo -e "Happy coding! 🚀"
echo ""
