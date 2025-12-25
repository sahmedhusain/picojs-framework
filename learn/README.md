# learn

A web application built with PicoJS Framework.

## Getting Started

### Run the App

You can run this app using any static file server. Here are a few options:

**Option 1: Using Python**
```bash
# Python 3
python3 -m http.server 8000

# Python 2
python -m SimpleHTTPServer 8000
```

**Option 2: Using Node.js (http-server)**
```bash
npx http-server -p 8000
```

**Option 3: Using PHP**
```bash
php -S localhost:8000
```

Then open your browser to: http://localhost:8000

## Project Structure

```
learn/
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
```

## Modifying the App

Edit `app/main.js` to change your application:

1. **Update State**: Modify `initialState` object
2. **Update View**: Edit the `view` function to change the UI
3. **Add Routing**: Import and use `createRouter` from `../framework/router.js`

## Example: Adding a New Feature

```javascript
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
```

## Learn More

For complete documentation, see the PicoJS Framework documentation.
