# PicoJS Framework ⚡

<p align="center">
  <img src="https://capsule-render.vercel.app/api?type=waving&height=165&text=PicoJS%20Framework&fontSize=40&fontAlignY=30&fontColor=3da7f0&desc=Lightweight%20%7C%20Zero-dependency%20%7C%20Reactive%20UI%20from%20scratch&descAlignY=50&animation=twinkling" alt="PicoJS Framework Banner" />
</p>

<div align="center">
  <img src="logo.svg" alt="PicoJS Framework Logo" width="160" height="160">
  <h3>A lightweight, zero-dependency JavaScript framework for building reactive web applications</h3>
</div>

<p align="center">
  <a href="#-overview">Overview</a> •
  <a href="#-features">Features</a> •
  <a href="#-architecture">Architecture</a> •
  <a href="#-getting-started">Get Started</a> •
  <a href="#-api-documentation">API</a> •
  <a href="#-todomvc-demo">Demo</a>
</p>

<p align="center">
  <img src="https://readme-typing-svg.demolab.com?font=Fira+Code&pause=900&center=true&vCenter=true&width=980&lines=Virtual+DOM+diffing+%7C+Reactive+state+%7C+Event+delegation;Hash+router+that+syncs+with+state+%7C+ES6+Modules;Small%2C+understandable%2C+and+designed+for+learning" alt="Typing SVG" />
</p>

---

<p align="center">
  <a href="https://github.com/sahmedhusain/picojs-framework"><img src="https://img.shields.io/badge/GitHub-Repository-blue?style=flat-square&logo=github" alt="GitHub Repository"></a>
  <a href="https://sahmedhusain.github.io/picojs-framework"><img src="https://img.shields.io/badge/Live-Demo-green?style=flat-square&logo=github" alt="Live Demo"></a>
  <a href="https://opensource.org/licenses/MIT"><img src="https://img.shields.io/badge/License-MIT-yellow?style=flat-square" alt="MIT License"></a>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/JavaScript-F7DF1E?style=flat-square&logo=javascript&logoColor=black" alt="JavaScript">
  <img src="https://img.shields.io/badge/HTML5-E34F26?style=flat-square&logo=html5&logoColor=white" alt="HTML5">
  <img src="https://img.shields.io/badge/CSS3-1572B6?style=flat-square&logo=css3&logoColor=white" alt="CSS3">
  <img src="https://img.shields.io/badge/Git-F05032?style=flat-square&logo=git&logoColor=white" alt="Git">
  <img src="https://img.shields.io/badge/ES6+-yellow?style=flat-square" alt="ES6+">
</p>

---

A lightweight, zero-dependency JavaScript framework for building reactive web apps — designed to stay small, readable, and easy to learn from.

## 📋 Table of Contents

Jump to any section below — the framework is small, but the docs are detailed so it’s easy to understand and extend.

- [Overview](#-overview)
- [Features](#-features)
- [Tech Stack](#-tech-stack)
- [Architecture](#-architecture)
- [Framework Structure](#-framework-structure)
- [Getting Started](#-getting-started)
- [API Documentation](#-api-documentation)
- [Code Examples](#-code-examples)
- [TodoMVC Demo](#-todomvc-demo)
- [Why It Works This Way](#-why-it-works-this-way)
- [Contributing](#-contributing)
- [License](#-license)


---

## ⭐ Key Highlights

- **Zero-dependency by design** — no external libraries required.
- **Reactive state + Virtual DOM** — UI updates automatically with minimal DOM changes.
- **Event delegation system** — performance-friendly handlers with cleanup.
- **Hash-based routing** — simple navigation that syncs with state.
- **Educational architecture** — modular, readable code meant to be studied and extended.

### 🧩 At a Glance

```text
State (store) → view(state) → Virtual DOM tree
                  ↓
             diff + patch
                  ↓
               Real DOM
```

---

## 🎯 Overview

**PicoJS Framework** is a small JavaScript framework built to show how modern UI ideas fit together while you build reactive web apps. It borrows familiar patterns from frameworks like React and Vue but keeps Virtual DOM rendering, reactive state management, event delegation, and hash-based routing in one place with zero external dependencies, staying under 10KB gzipped.

The code is written to be read: you can trace how state drives the UI without sifting through layers of abstraction, whether you're shipping a small project or studying framework internals.


---

## ✨ Features

### Core Functionality
- **Virtual DOM** - Calculates diffs and patches only the DOM nodes that change
- **Reactive State** - State updates automatically trigger re-renders
- **Component Architecture** - Compose UIs from plain functions that return virtual nodes
- **Event System** - Attach events declaratively; delegation handles cleanup
- **Router** - Hash-based navigation that stays in sync with application state

### Developer Experience
- **Zero Dependencies** - Runs without pulling in external libraries
- **Small Bundle Size** - Under 10KB gzipped to keep downloads small
- **ES6 Modules** - Uses native modules so bundlers can tree-shake if needed
- **Educational** - Organized for reading, tinkering, and modifying
- **Browser Native** - Works in all modern browsers without transpilation

### Performance
- **Efficient Diffing** - Compares virtual trees and updates only changed nodes
- **Event Delegation** - Shares listeners on the root instead of per element
- **Memory Efficient** - Cleans up listeners when elements leave the DOM
- **Fast Rendering** - Lean Virtual DOM patching keeps updates responsive


---

## 🛠 Tech Stack

### Core Technologies
- **JavaScript ES6+** - Uses native modules and modern syntax
- **Virtual DOM** - Custom implementation to control render work
- **Hash Routing** - Client-side routes via URL hashes without extra server setup
- **Event Delegation** - Centralized handling to reduce attached listeners

### Browser Support
- Chrome 60+
- Firefox 55+
- Safari 11+
- Edge 79+

### Development Tools
- **Local Server** - Uses Python's built-in server to serve files locally
- **ES6 Modules** - Relies on native browser module support; bundlers optional
- **Git** - Version control for changes and collaboration


---

## 🏗 Architecture

PicoJS keeps modules small and focused so it's clear how each part connects to the next. The framework leans on three ideas:

1. **State Management** - A reactive store that triggers re-renders whenever data changes
2. **Virtual DOM** - A lightweight representation of the real DOM to plan updates
3. **Event System** - Declarative event handling with delegation to avoid scattered listeners

### Data Flow

A user interaction moves through a handler, updates state, and re-runs the view. The view returns a Virtual DOM tree that's diffed against the previous one so only the necessary changes reach the real DOM.

```
User Interaction → Event Handler → State Update → View Function → Virtual DOM → DOM Patch → UI Update
```

This one-way path keeps applications predictable and easier to debug.


---

## 📁 Framework Structure

The framework is organized into focused modules, each handling a specific concern:

```
picojs-framework/
├── framework/
│   ├── core.js              # Main exports and framework initialization
│   ├── app.js               # Application lifecycle management
│   ├── store.js             # Reactive state management
│   ├── router.js            # Hash-based routing system
│   ├── events.js            # Event delegation and handling
│   └── vdom/                # Virtual DOM implementation
│       ├── createElement.js # Virtual node creation utilities
│       ├── render.js        # Main rendering pipeline
│       ├── patch.js         # DOM diffing and patching
│       ├── attrs.js         # Attribute management
│       └── domElement.js    # DOM element creation
├── app/                     # Application code
│   ├── main.js             # Main application entry point
│   └── styles.css          # Application styles
├── index.html              # Main HTML page
├── createApp.sh            # Project scaffolding script
└── README.md               # This documentation
```

### Module Relationships

```mermaid
graph TD
    A[core.js] --> B[app.js]
    A --> C[store.js]
    A --> D[router.js]
    A --> E[events.js]
    A --> F[vdom/]

    B --> C
    B --> F

    F --> G[createElement.js]
    F --> H[render.js]
    F --> I[patch.js]
    F --> J[attrs.js]
    F --> K[domElement.js]

    D --> C
    E --> F

    L[main.js] --> A
    L --> M[index.html]

    style A fill:#e1f5fe
    style F fill:#f3e5f5
    style L fill:#e8f5e8
```

**Core Module (core.js)** - The main entry point that exports all framework functionality
**App Module (app.js)** - Handles application initialization and the main render loop
**Store Module (store.js)** - Manages reactive state with subscription system
**Router Module (router.js)** - Provides hash-based navigation
**Events Module (events.js)** - Implements event delegation for performance
**VDOM Modules** - Handle virtual DOM creation, diffing, and patching


---

## 🚀 Getting Started

### Quick Start (Recommended)

The fastest way to get started is using the included setup script:

```bash
# Clone or download the framework
git clone https://github.com/sahmedhusain/picojs-framework.git
cd picojs-framework

# Create a new project
./createApp.sh my-awesome-app

# Move into your new project
cd my-awesome-app

# Start development server
python3 -m http.server 8000

# Open in browser
open http://localhost:8000
```

The script creates a complete project with:
- All framework files copied
- A starter application with counter example
- Proper directory structure
- Ready-to-run HTML file

### Manual Setup

If you prefer to set up manually:

1. **Create your HTML file:**
```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My PicoJS App</title>
    <link rel="stylesheet" href="/app/styles.css">
</head>
<body>
    <div id="root"></div>
    <script src="/app/main.js" type="module"></script>
</body>
</html>
```

2. **Create your main JavaScript file (`/app/main.js`):**
```javascript
import { createApp, createElement as h } from '../framework/core.js';

// Your app code here
const initialState = { count: 0 };

function view(state) {
    return h('div', {},
        h('h1', {}, `Count: ${state.count}`),
        h('button', {
            onclick: () => store.setState({ count: state.count + 1 })
        }, 'Increment')
    );
}

const store = createApp({
    view,
    initialState,
    rootElement: document.getElementById('root')
});
```

3. **Start a local server:**
```bash
python3 -m http.server 8000
```


---

<details open>
<summary><strong>📚 API Documentation (expand/collapse)</strong></summary>

## 📚 API Documentation

### createElement (alias: h)

Creates a virtual DOM element. This is the foundation of building UIs in PicoJS.

**Parameters:**
- `tag` (string) - HTML tag name ('div', 'span', 'button', etc.)
- `attrs` (object) - Attributes and event handlers
- `children` (...any) - Child elements or text content

**Returns:** Virtual node object

**Examples:**
```javascript
import { createElement as h } from './framework/core.js';

// Simple text element
const title = h('h1', {}, 'Hello World');

// Element with attributes
const input = h('input', {
    type: 'text',
    placeholder: 'Enter your name',
    value: 'John Doe'
});

// Nested elements
const card = h('div', { class: 'card' },
    h('h2', {}, 'Card Title'),
    h('p', {}, 'Card content here...')
);
```

### createApp

Initializes your PicoJS application with state management and rendering.

**Parameters:**
- `options.view` (function) - Function that returns virtual DOM based on state
- `options.initialState` (object) - Starting state for your application
- `options.rootElement` (HTMLElement) - DOM element to render into

**Returns:** Store object with state management methods

**Example:**
```javascript
import { createApp, createElement as h } from './framework/core.js';

const initialState = {
    todos: [],
    filter: 'all'
};

function view(state) {
    return h('div', {},
        // Your UI components here
    );
}

const store = createApp({
    view,
    initialState,
    rootElement: document.getElementById('root')
});
```

### createStore

Creates a reactive state store. Usually used internally by `createApp`.

**Methods:**
- `getState()` - Returns current state
- `setState(newState)` - Updates state and triggers re-render
- `subscribe(listener)` - Adds function to call on state changes

**Example:**
```javascript
import { createStore } from './framework/core.js';

const store = createStore({ count: 0 });

store.subscribe(() => {
    console.log('State updated:', store.getState());
});

store.setState({ count: 1 }); // Triggers subscription
```

### createRouter

Adds hash-based routing that syncs with your application state.

**Parameters:**
- `store` (object) - Your app's store from `createApp`

**Example:**
```javascript
import { createApp, createElement as h } from './framework/core.js';
import { createRouter } from './framework/router.js';

const initialState = { route: '#/' };

function view(state) {
    return h('div', {},
        h('nav', {},
            h('a', { href: '#/home' }, 'Home'),
            h('a', { href: '#/about' }, 'About')
        ),
        h('p', {}, `Current route: ${state.route}`)
    );
}

const store = createApp({ view, initialState, rootElement: document.getElementById('root') });
createRouter(store); // Now URL changes update state.route
```

</details>

---


<details>
<summary><strong>💡 Code Examples (expand/collapse)</strong></summary>

## 💡 Code Examples

### Basic Counter App

```javascript
import { createApp, createElement as h } from '../framework/core.js';

const initialState = { count: 0 };

function view(state) {
    return h('div', { class: 'counter' },
        h('h1', {}, `Count: ${state.count}`),
        h('button', {
            onclick: () => store.setState({ count: state.count + 1 })
        }, '+'),
        h('button', {
            onclick: () => store.setState({ count: state.count - 1 })
        }, '-')
    );
}

const store = createApp({
    view,
    initialState,
    rootElement: document.getElementById('root')
});
```

### Todo List Application

```javascript
import { createApp, createElement as h } from '../framework/core.js';

const initialState = {
    todos: [],
    inputValue: ''
};

function view(state) {
    return h('div', { class: 'todo-app' },
        h('h1', {}, 'Todo List'),
        h('input', {
            type: 'text',
            value: state.inputValue,
            placeholder: 'Add a new todo...',
            oninput: (e) => store.setState({ inputValue: e.target.value })
        }),
        h('button', {
            onclick: () => {
                if (state.inputValue.trim()) {
                    store.setState({
                        todos: [...state.todos, {
                            id: Date.now(),
                            text: state.inputValue,
                            completed: false
                        }],
                        inputValue: ''
                    });
                }
            }
        }, 'Add Todo'),
        h('ul', {},
            ...state.todos.map(todo =>
                h('li', {
                    class: todo.completed ? 'completed' : '',
                    onclick: () => {
                        const updatedTodos = state.todos.map(t =>
                            t.id === todo.id ? { ...t, completed: !t.completed } : t
                        );
                        store.setState({ todos: updatedTodos });
                    }
                }, todo.text)
            )
        )
    );
}

const store = createApp({
    view,
    initialState,
    rootElement: document.getElementById('root')
});
```

### Simple Router Example

```javascript
import { createApp, createElement as h } from '../framework/core.js';
import { createRouter } from '../framework/router.js';

const initialState = { route: '#/' };

function view(state) {
    const routes = {
        '#/': h('div', {}, h('h1', {}, 'Home Page'), h('p', {}, 'Welcome!')),
        '#/about': h('div', {}, h('h1', {}, 'About'), h('p', {}, 'About this app...')),
        '#/contact': h('div', {}, h('h1', {}, 'Contact'), h('p', {}, 'Get in touch!'))
    };

    return h('div', {},
        h('nav', {},
            h('a', { href: '#/home' }, 'Home'),
            h('a', { href: '#/about' }, 'About'),
            h('a', { href: '#/contact' }, 'Contact')
        ),
        routes[state.route] || h('div', {}, h('h1', {}, '404 - Page Not Found'))
    );
}

const store = createApp({ view, initialState, rootElement: document.getElementById('root') });
createRouter(store);
```

</details>

---

## 🎨 TodoMVC Demo

The framework includes a complete TodoMVC implementation that demonstrates all features in action. This is the classic TodoMVC example that developers use to compare framework capabilities.

**Features demonstrated:**
- Adding, editing, and deleting todos
- Marking todos as complete/incomplete
- Filtering todos (All, Active, Completed)
- Bulk actions (toggle all, clear completed)
- Local storage persistence
- Responsive design

**To run the demo:**
1. Open `index.html` in your browser
2. Start adding todos and explore the features
3. Check the browser's developer tools to see the Virtual DOM in action

The TodoMVC code serves as an excellent reference for building real applications with PicoJS.


---
## 🤔 Why It Works This Way

### Virtual DOM Approach

Instead of directly manipulating the DOM (which can be slow and error-prone), PicoJS uses a Virtual DOM:

1. **Describe your UI** as a function of state
2. **Generate virtual elements** (plain JavaScript objects)
3. **Compare** old vs new virtual trees
4. **Update only what changed** in the real DOM

This approach gives you:
- **Performance** - Minimal DOM operations
- **Predictability** - UI is always in sync with state
- **Simplicity** - No manual DOM manipulation

### Reactive State Management

State changes automatically trigger UI updates through a subscription system:

```javascript
// When you call setState
store.setState({ count: 1 });

// The framework automatically:
// 1. Updates internal state
// 2. Calls your view function with new state
// 3. Generates new virtual DOM
// 4. Patches the real DOM
// 5. UI updates instantly
```

### Event Delegation System

Instead of attaching event listeners to every element, PicoJS uses event delegation:

- **Single listener** per event type on the root element
- **Event bubbling** carries events up to the root
- **Data attributes** identify which element was clicked
- **Automatic cleanup** when elements are removed

This provides better performance and prevents memory leaks.

### Hash-Based Routing

Hash routing (`#/page`) works without server configuration:

- **No page reloads** - Changes happen instantly
- **Bookmarkable** - URLs work with browser back/forward
- **Simple** - No complex server setup needed
- **State synced** - URL changes update your app state


---
## 🌐 Live Demo

Check out the live demo deployed on GitHub Pages:  
**[https://sahmedhusain.github.io/picojs-framework](https://sahmedhusain.github.io/picojs-framework)**

The demo includes the full TodoMVC application running directly in the browser.


---
## 🤝 Contributing

We welcome contributions! Here's how you can help:

1. **Fork the repository**
2. **Create a feature branch** (`git checkout -b feature/amazing-feature`)
3. **Make your changes**
4. **Test thoroughly** - Make sure existing functionality still works
5. **Commit your changes** (`git commit -m 'Add amazing feature'`)
6. **Push to the branch** (`git push origin feature/amazing-feature`)
7. **Open a Pull Request**

### Development Guidelines

- Keep the bundle size small
- Maintain zero dependencies
- Write clear, commented code
- Add examples for new features
- Test in multiple browsers


---
## 📄 License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details.


---
## 👨‍💻 Author

**Sayed Ahmed Husain**  
Email: [sayedahmed97.sad@gmail.com](mailto:sayedahmed97.sad@gmail.com)

---

**Built with ❤️ for simplicity**
