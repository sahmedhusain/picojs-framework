# Mini Framework

A lightweight, zero-dependency JavaScript framework for building reactive web applications.

## 📋 Table of Contents

- [Overview](#overview)
- [Features](#features)
- [How It Works](#how-it-works)
- [Getting Started](#getting-started)
- [API Documentation](#api-documentation)
  - [createElement](#createelement)
  - [createApp](#createapp)
  - [createStore](#createstore)
  - [createRouter](#createrouter)
- [Code Examples](#code-examples)
- [TodoMVC Demo](#todomvc-demo)
- [Why Things Work The Way They Work](#why-things-work-the-way-they-work)

## 🎯 Overview

**Mini Framework** is a lightweight, zero-dependency framework for building reactive web applications. It features a Virtual DOM, component-based state management, and hash-based routing. This framework demonstrates core concepts used by popular frameworks like React and Vue, but in a simplified, educational format.

The framework is built on three core principles:
1. **Declarative UI** - Describe what your UI should look like based on state
2. **Reactive State Management** - Automatically re-render when state changes
3. **Simple Routing** - Hash-based navigation that syncs with app state

## ✨ Features

The framework implements the following key features:

- **DOM Abstraction** - Virtual DOM representation for efficient rendering
- **State Management** - Reactive store with automatic re-rendering
- **Event Handling** - Declarative event binding with delegation
- **Routing System** - Hash-based routing synchronized with app state

### Framework Architecture

The framework is organized into focused, modular files:

```
framework/
├── core.js                    # Main exports (barrel file)
├── app.js                     # Application initialization
├── events.js                  # Event delegation system
├── store.js                   # State management
├── router.js                  # Hash-based routing
└── vdom/
    ├── createElement.js       # Virtual node creation
    ├── render.js              # Main render with focus preservation
    ├── patch.js               # Diffing & patching algorithm
    ├── attrs.js               # Attribute handling
    └── domElement.js          # DOM element creation
```

Each module has a single, clear responsibility, making the framework easy to understand, maintain, and test.

## 🔧 How It Works

The framework works by creating a **virtual representation of the DOM**. Instead of directly manipulating the DOM, you define your UI as a function of your state:

```
State → View Function → Virtual DOM → Real DOM
```

**The Flow:**

1. You define your UI as a **view function** that takes state and returns a virtual DOM tree
2. When state changes, the framework re-runs this function to generate a new virtual tree
3. The framework efficiently updates the real DOM to match the new virtual tree

This approach provides several benefits:
- **Predictable** - The UI is always a pure function of the state
- **Efficient** - Only the changed parts of the DOM are updated
- **Easy to reason about** - No manual DOM manipulation needed

### Virtual DOM Structure

The framework represents HTML elements as plain JavaScript objects (vNodes):

```javascript
// HTML
<div class="container">
  <h1>Hello</h1>
  <p>World</p>
</div>

// Becomes a vNode object
{
  tag: 'div',
  attrs: { class: 'container' },
  children: [
    {
      tag: 'h1',
      attrs: {},
      children: [
        { tag: 'TEXT_ELEMENT', attrs: { nodeValue: 'Hello' }, children: [] }
      ]
    },
    {
      tag: 'p',
      attrs: {},
      children: [
        { tag: 'TEXT_ELEMENT', attrs: { nodeValue: 'World' }, children: [] }
      ]
    }
  ]
}
```

This virtual representation allows the framework to:
1. **Compare** old and new virtual trees (diffing)
2. **Calculate** minimal changes needed
3. **Apply** only those changes to the real DOM (patching)

## 🚀 Getting Started

### Quick Start with Script

The easiest way to create a new app is using the provided shell script:

```bash
# Create a new app
./createApp.sh my-app-name

# Navigate to your new app
cd my-app-name

# Start a local server
python3 -m http.server 8000

# Open http://localhost:8000 in your browser
```

The script will:
- Create a complete project structure
- Copy all framework files
- Generate a starter app with a counter example
- Include README and .gitignore files

### Manual Installation

No installation needed! Just create an HTML file with a root element and link your main app file:

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>My App</title>
</head>
<body>
    <div id="root"></div>
    
    <script src="/app/main.js" type="module"></script>
</body>
</html>
```

Then import the framework in your JavaScript app file (`/app/main.js`):

```javascript
import { createApp, createElement as h } from '../framework/core.js';
import { createRouter } from '../framework/router.js';
```

### Quick Start

Create your app file (`/app/main.js`):

```javascript
import { createApp, createElement as h } from '../framework/core.js';
import { createRouter } from '../framework/router.js';

// Define initial state
const initialState = {
    count: 0
};

// Define view function
function view(state) {
    return h('div', {},
        h('h1', {}, `Count: ${state.count}`),
        h('button', {
            onclick: () => store.setState({ count: state.count + 1 })
        }, 'Increment')
    );
}

// Create and mount app
const rootElement = document.getElementById('root');
const store = createApp({ view, initialState, rootElement });
```

## � API Documentation

### createElement

Creates a virtual DOM element (also aliased as `h` for convenience).

**Signature:**
```javascript
createElement(tag, attrs, ...children)
```

**Parameters:**
- `tag` (string) - The HTML tag name (e.g., 'div', 'button', 'input')
- `attrs` (object) - Element attributes and event handlers
- `children` (...any) - Child elements or text content

**Returns:**
- Virtual node object: `{ tag, attrs, children }`

**Example:**
```javascript
import { createElement as h } from '../framework/core.js';

// Simple element with text
const heading = h('h1', {}, 'Hello World');

// Element with attributes
const div = h('div', { id: 'container', class: 'wrapper' }, 'Content');

// Element with children
const list = h('ul', {},
    h('li', {}, 'Item 1'),
    h('li', {}, 'Item 2'),
    h('li', {}, 'Item 3')
);
```

### createApp

Creates and initializes the application with state management and rendering.

**Signature:**
```javascript
createApp({ view, initialState, rootElement })
```

**Parameters:**
- `view` (function) - Function that takes state and returns virtual DOM
- `initialState` (object) - Initial application state
- `rootElement` (HTMLElement) - DOM element to render into

**Returns:**
- Store object with `getState()`, `setState()`, and `subscribe()` methods

**Example:**
```javascript
import { createApp, createElement as h } from '../framework/core.js';

const initialState = { message: 'Hello!' };

function view(state) {
    return h('div', {}, h('p', {}, state.message));
}

const store = createApp({
    view,
    initialState,
    rootElement: document.getElementById('root')
});

// Update state later
store.setState({ message: 'Updated!' });
```

### createStore

Creates a reactive state store (typically used internally by `createApp`).

**Signature:**
```javascript
createStore(initialState)
```

**Parameters:**
- `initialState` (object) - Initial state object

**Returns:**
- Store object with methods:
  - `getState()` - Returns current state
  - `setState(newState)` - Merges new state and notifies listeners
  - `subscribe(listener)` - Adds a listener function for state changes

**Example:**
```javascript
import { createStore } from '../framework/core.js';

const store = createStore({ count: 0 });

// Subscribe to changes
store.subscribe(() => {
    console.log('State changed:', store.getState());
});

// Update state
store.setState({ count: 1 }); // Logs: State changed: { count: 1 }
```

### createRouter

Creates a hash-based router that syncs URL with app state.

**Signature:**
```javascript
createRouter(store)
```

**Parameters:**
- `store` (object) - The app's store object from `createApp`

**Example:**
```javascript
import { createApp, createElement as h } from '../framework/core.js';
import { createRouter } from '../framework/router.js';

const initialState = { currentFilter: '#/' };

function view(state) {
    return h('div', {},
        h('p', {}, `Current route: ${state.currentFilter}`),
        h('a', { href: '#/page1' }, 'Page 1'),
        h('a', { href: '#/page2' }, 'Page 2')
    );
}

const store = createApp({ view, initialState, rootElement: document.getElementById('root') });
createRouter(store); // Syncs hash changes to state.currentFilter
```

## 💡 Code Examples

### Creating an Element

```javascript
import { createElement as h } from '../framework/core.js';

// Basic element
const element = h('div', { id: 'foo' }, 'Hello');

// Result: <div id="foo">Hello</div>
```

### Nesting Elements

```javascript
import { createElement as h } from '../framework/core.js';

const nested = h('div', {},
    h('span', {}, 'Nested content'),
    h('strong', {}, 'Bold text')
);

// Result:
// <div>
//   <span>Nested content</span>
//   <strong>Bold text</strong>
// </div>
```

### Adding Attributes

```javascript
import { createElement as h } from '../framework/core.js';

const withAttrs = h('input', {
    type: 'text',
    class: 'my-input',
    placeholder: 'Enter text...',
    value: 'Initial value'
});

// Result: <input type="text" class="my-input" placeholder="Enter text..." value="Initial value">
```

### Creating an Event

```javascript
import { createElement as h } from '../framework/core.js';

const button = h('button', {
    onclick: () => alert('Button clicked!')
}, 'Click Me');

// Result: <button>Click Me</button> (with click event listener)
```

### Complete App Example

```javascript
import { createApp, createElement as h } from '../framework/core.js';

// Initial state
const initialState = {
    items: [],
    inputValue: ''
};

// View function
function view(state) {
    return h('div', { class: 'app' },
        h('h1', {}, 'Shopping List'),
        h('input', {
            type: 'text',
            value: state.inputValue,
            oninput: (e) => store.setState({ inputValue: e.target.value })
        }),
        h('button', {
            onclick: () => {
                if (state.inputValue.trim()) {
                    store.setState({
                        items: [...state.items, state.inputValue],
                        inputValue: ''
                    });
                }
            }
        }, 'Add Item'),
        h('ul', {},
            ...state.items.map((item, index) =>
                h('li', {}, 
                    item,
                    h('button', {
                        onclick: () => {
                            const newItems = state.items.filter((_, i) => i !== index);
                            store.setState({ items: newItems });
                        }
                    }, 'Remove')
                )
            )
        )
    );
}

// Create app
const rootElement = document.getElementById('root');
const store = createApp({ view, initialState, rootElement });
```

## 🎨 TodoMVC Demo

This framework includes a complete TodoMVC implementation demonstrating all features. To run it:

1. Open `index.html` in a browser (or use a local server)
2. The TodoMVC app will load with all standard features:
   - Add new todos
   - Mark todos as complete
   - Edit todos (double-click)
   - Delete todos
   - Filter by All/Active/Completed
   - Clear completed todos
   - Toggle all todos
   - Persistent storage (localStorage)

The TodoMVC source code is in `/app/main.js` and serves as a comprehensive example of using the framework.

## 🤔 Why Things Work The Way They Work

### Virtual DOM Pattern

**Why not manipulate the DOM directly?**

Direct DOM manipulation becomes complex and error-prone in large applications. The Virtual DOM pattern provides:

1. **Abstraction** - You describe what you want, not how to create it
2. **Simplicity** - No need to manually track DOM state
3. **Predictability** - The UI is a pure function of state

### Reactive State Management

**Why use a store with subscriptions?**

The reactive pattern ensures the UI automatically updates when state changes:

1. All state lives in one place (single source of truth)
2. State changes trigger automatic re-renders
3. Components don't need to manually update the UI

### Event Handling via Attributes

**Why pass events as attributes (onclick, oninput)?**

This declarative approach:

1. Makes event handling explicit in the UI definition
2. Automatically cleans up listeners when elements are removed
3. Keeps event logic close to the elements they affect

**How it differs from `addEventListener()`:**

Unlike the standard `addEventListener()` method, the framework uses a **custom event delegation system**:

```javascript
// Standard addEventListener (NOT used in this framework)
element.addEventListener('click', handler);

// Framework's declarative approach
const button = h('button', {
    onclick: () => console.log('Clicked!')
}, 'Click Me');
```

**Under the hood:**
1. Event handlers are registered in a central `eventRegistry`
2. A single delegated listener is attached to the root element for each event type
3. Events bubble up and are matched using `data-ev-{eventName}` attributes
4. Handlers are deduplicated using a WeakMap to prevent memory leaks
5. When elements are removed, their handlers are automatically cleaned up

This approach is more efficient than attaching individual listeners to every element.

### Hash-based Routing

**Why use hash routing instead of history API?**

Hash routing is simpler and works without a server:

1. No server configuration needed
2. Works with static file hosting
3. Changes don't trigger page reloads
4. Easy to sync with app state

### Immutable State Updates

**Why use `{ ...state, ...newState }` instead of mutating?**

Immutability ensures:

1. Previous state is never accidentally modified
2. State changes are predictable and traceable
3. Easier debugging and testing

### Function-based Components

**Why use view functions instead of classes?**

Functions are simpler:

1. No `this` binding issues
2. Easier to understand and test
3. State is managed externally by the store
4. Pure functions are easier to reason about

## �📄 License

This project is licensed under the MIT License. See the [LICENSE.md](LICENSE.md) file for details.

## 👨‍💻 Author

**Sayed Ahmed Husain**
- Email: [sayedahmed97.sad@gmail.com](mailto:sayedahmed97.sad@gmail.com)
