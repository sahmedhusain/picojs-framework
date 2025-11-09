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

echo -e "${GREEN}✓${NC} Created directory structure"

echo -e "${BLUE}Copying framework files...${NC}"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

cp "$SCRIPT_DIR/framework/core.js" "$APP_DIR/framework/core.js"
cp "$SCRIPT_DIR/framework/app.js" "$APP_DIR/framework/app.js"
cp "$SCRIPT_DIR/framework/events.js" "$APP_DIR/framework/events.js"
cp "$SCRIPT_DIR/framework/store.js" "$APP_DIR/framework/store.js"
cp "$SCRIPT_DIR/framework/router.js" "$APP_DIR/framework/router.js"
cp "$SCRIPT_DIR/framework/vdom/createElement.js" "$APP_DIR/framework/vdom/createElement.js"
cp "$SCRIPT_DIR/framework/vdom/render.js" "$APP_DIR/framework/vdom/render.js"
cp "$SCRIPT_DIR/framework/vdom/patch.js" "$APP_DIR/framework/vdom/patch.js"
cp "$SCRIPT_DIR/framework/vdom/attrs.js" "$APP_DIR/framework/vdom/attrs.js"
cp "$SCRIPT_DIR/framework/vdom/domElement.js" "$APP_DIR/framework/vdom/domElement.js"

echo -e "${GREEN}✓${NC} Copied framework files"

cat > "$APP_DIR/index.html" << 'EOF'
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mini Framework App</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
        }
        
        #root {
            background: white;
            border-radius: 12px;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
            padding: 40px;
            max-width: 600px;
            width: 100%;
        }
        
        h1 {
            color: #333;
            margin-bottom: 20px;
            font-size: 2rem;
        }
        
        .counter {
            text-align: center;
        }
        
        .count-display {
            font-size: 4rem;
            color: #667eea;
            margin: 30px 0;
            font-weight: bold;
        }
        
        .button-group {
            display: flex;
            gap: 10px;
            justify-content: center;
            flex-wrap: wrap;
        }
        
        button {
            background: #667eea;
            color: white;
            border: none;
            padding: 12px 24px;
            border-radius: 8px;
            font-size: 1rem;
            cursor: pointer;
            transition: all 0.3s ease;
            font-weight: 600;
        }
        
        button:hover {
            background: #5568d3;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(102, 126, 234, 0.4);
        }
        
        button:active {
            transform: translateY(0);
        }
        
        button.reset {
            background: #e74c3c;
        }
        
        button.reset:hover {
            background: #c0392b;
        }
    </style>
</head>
<body>
    <div id="root"></div>
    
    <script src="/app/main.js" type="module"></script>
</body>
</html>
EOF

echo -e "${GREEN}✓${NC} Created index.html"

cat > "$APP_DIR/app/main.js" << 'EOF'
import { createApp, createElement as h } from '../framework/core.js';

const initialState = {
    count: 0
};

function view(state) {
    return h('div', { class: 'counter' },
        h('h1', {}, 'Mini Framework Counter'),
        h('div', { class: 'count-display' }, state.count),
        h('div', { class: 'button-group' },
            h('button', {
                onclick: () => store.setState({ count: state.count - 1 })
            }, '- Decrement'),
            h('button', {
                onclick: () => store.setState({ count: state.count + 1 })
            }, '+ Increment'),
            h('button', {
                class: 'reset',
                onclick: () => store.setState({ count: 0 })
            }, 'Reset')
        )
    );
}

const rootElement = document.getElementById('root');
const store = createApp({ view, initialState, rootElement });

console.log('🚀 Mini Framework app initialized!');
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
└── framework/
    ├── core.js            # Main framework exports
    ├── app.js             # Application initialization
    ├── events.js          # Event delegation system
    ├── store.js           # State management
    ├── router.js          # Hash-based routing
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

function view(state) {
    return h('div', {},
        h('h1', {}, 'My Todo List'),
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
        }, 'Add'),
        h('ul', {},
            ...state.items.map(item => h('li', {}, item))
        )
    );
}

const rootElement = document.getElementById('root');
const store = createApp({ view, initialState, rootElement });
\`\`\`

## Learn More

For complete documentation, see the Mini Framework documentation.
EOF

echo -e "${GREEN}✓${NC} Created README.md"

cat > "$APP_DIR/.gitignore" << 'EOF'
.DS_Store
node_modules/
*.log
.vscode/
.idea/
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
