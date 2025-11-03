import { createApp, createElement as h } from '../framework/core.js';
import { createRouter } from '../framework/router.js';

const initialState = {
    todos: JSON.parse(localStorage.getItem('todos-miniframework') || '[]'),
    newTodo: '',
    currentFilter: '#/',
    editingId: null,
    editingText: ''
};

let store;

function saveTodos(todos) {
    localStorage.setItem('todos-miniframework', JSON.stringify(todos));
}

function addTodo() {
    const trimmedValue = store.getState().newTodo.trim();
    if (trimmedValue) {
        const newTodo = {
            id: Date.now(),
            title: trimmedValue,
            completed: false,
            editing: false
        };
        const updatedTodos = [...store.getState().todos, newTodo];
        store.setState({ 
            todos: updatedTodos,
            newTodo: ''
        });
        saveTodos(updatedTodos);
        
        const input = document.querySelector('.new-todo');
        if (input) {
            setTimeout(() => input.focus(), 0);
        }
    }
}

function renderHeader(state) {
    const showAddButton = state.newTodo.length >= 3;
    
    return h('header', { class: 'header' },
        h('h1', {}, 'ToDos'),
        h('div', { class: 'input-wrapper' },
            h('input', {
                class: 'new-todo',
                placeholder: 'What needs to be done?',
                autofocus: 'true',
                value: state.newTodo,
                oninput: (event) => {
                    const newValue = event.target.value;
                    const currentState = store.getState();
                    if (currentState.newTodo !== newValue) {
                        store.setState({ newTodo: newValue });
                    }
                },
                onkeypress: (event) => {
                    if (event.key === 'Enter') {
                        event.preventDefault();
                        addTodo();
                    }
                }
            }),
            showAddButton ? h('button', {
                class: 'add-button',
                onclick: (event) => {
                    event.preventDefault();
                    addTodo();
                }
            }, 
                h('span', { class: 'add-icon' }, '+'),
                h('span', { class: 'add-text' }, 'Add')
            ) : null
        )
    );
}

function renderMain(state) {
    if (state.todos.length === 0) {
        return null;
    }

    let filteredTodos = state.todos;
    if (state.currentFilter === '#/active') {
        filteredTodos = state.todos.filter(todo => !todo.completed);
    } else if (state.currentFilter === '#/completed') {
        filteredTodos = state.todos.filter(todo => todo.completed);
    }

    const allCompleted = state.todos.length > 0 && state.todos.every(t => t.completed);

    return h('section', { class: 'main' },
        h('input', {
            id: 'toggle-all',
            class: 'toggle-all',
            type: 'checkbox',
            checked: allCompleted ? 'checked' : '',
            onchange: (event) => {
                const checked = event.target.checked;
                const updatedTodos = state.todos.map(todo => ({
                    ...todo,
                    completed: checked
                }));
                store.setState({ todos: updatedTodos });
                saveTodos(updatedTodos);
            }
        }),
        h('label', { for: 'toggle-all' }, 'Mark all as complete'),
        h('ul', { class: 'todo-list' },
            ...filteredTodos.map(todo => {
                let liClass = '';
                if (todo.completed) liClass += 'completed ';
                if (todo.editing) liClass += 'editing ';
                liClass = liClass.trim();

                if (todo.editing) {
                    const toggleAttrs = {
                        class: 'toggle',
                        type: 'checkbox',
                        onchange: () => {
                            const updatedTodos = state.todos.map(t =>
                                t.id === todo.id ? { ...t, completed: !t.completed } : t
                            );
                            store.setState({ todos: updatedTodos });
                            saveTodos(updatedTodos);
                        }
                    };
                    if (todo.completed) {
                        toggleAttrs.checked = 'checked';
                    }
                    
                    return h('li', { class: liClass },
                        h('div', { class: 'view' },
                            h('input', toggleAttrs),
                            h('label', {
                                ondblclick: () => {
                                    const updatedTodos = state.todos.map(t =>
                                        t.id === todo.id ? { ...t, editing: true } : t
                                    );
                                    store.setState({ 
                                        todos: updatedTodos,
                                        editingId: todo.id,
                                        editingText: todo.title
                                    });
                                }
                            }, todo.title),
                            h('button', {
                                class: 'destroy',
                                onclick: () => {
                                    const updatedTodos = state.todos.filter(t => t.id !== todo.id);
                                    store.setState({ todos: updatedTodos });
                                    saveTodos(updatedTodos);
                                }
                            })
                        ),
                        h('input', {
                            class: 'edit',
                            value: state.editingId === todo.id ? state.editingText : todo.title,
                            oninput: (event) => {
                                store.setState({ editingText: event.target.value });
                            },
                            onkeydown: (event) => {
                                if (event.key === 'Enter') {
                                    const trimmedText = state.editingText.trim();
                                    if (trimmedText) {
                                        const updatedTodos = state.todos.map(t =>
                                            t.id === todo.id ? { ...t, title: trimmedText, editing: false } : t
                                        );
                                        store.setState({ 
                                            todos: updatedTodos,
                                            editingId: null,
                                            editingText: ''
                                        });
                                        saveTodos(updatedTodos);
                                    } else {
                                        const updatedTodos = state.todos.filter(t => t.id !== todo.id);
                                        store.setState({ 
                                            todos: updatedTodos,
                                            editingId: null,
                                            editingText: ''
                                        });
                                        saveTodos(updatedTodos);
                                    }
                                } else if (event.key === 'Escape') {
                                    const updatedTodos = state.todos.map(t =>
                                        t.id === todo.id ? { ...t, editing: false } : t
                                    );
                                    store.setState({ 
                                        todos: updatedTodos,
                                        editingId: null,
                                        editingText: ''
                                    });
                                }
                            },
                            onblur: () => {
                                const trimmedText = state.editingText.trim();
                                if (trimmedText) {
                                    const updatedTodos = state.todos.map(t =>
                                        t.id === todo.id ? { ...t, title: trimmedText, editing: false } : t
                                    );
                                    store.setState({ 
                                        todos: updatedTodos,
                                        editingId: null,
                                        editingText: ''
                                    });
                                    saveTodos(updatedTodos);
                                } else {
                                    const updatedTodos = state.todos.filter(t => t.id !== todo.id);
                                    store.setState({ 
                                        todos: updatedTodos,
                                        editingId: null,
                                        editingText: ''
                                    });
                                    saveTodos(updatedTodos);
                                }
                            }
                        })
                    );
                } else {
                    const toggleAttrs = {
                        class: 'toggle',
                        type: 'checkbox',
                        onchange: () => {
                            const updatedTodos = state.todos.map(t =>
                                t.id === todo.id ? { ...t, completed: !t.completed } : t
                            );
                            store.setState({ todos: updatedTodos });
                            saveTodos(updatedTodos);
                        }
                    };
                    if (todo.completed) {
                        toggleAttrs.checked = 'checked';
                    }
                    
                    return h('li', { class: liClass },
                        h('div', { class: 'view' },
                            h('input', toggleAttrs),
                            h('label', {
                                ondblclick: () => {
                                    const updatedTodos = state.todos.map(t =>
                                        t.id === todo.id ? { ...t, editing: true } : t
                                    );
                                    store.setState({ 
                                        todos: updatedTodos,
                                        editingId: todo.id,
                                        editingText: todo.title
                                    });
                                }
                            }, todo.title),
                            h('button', {
                                class: 'destroy',
                                onclick: () => {
                                    const updatedTodos = state.todos.filter(t => t.id !== todo.id);
                                    store.setState({ todos: updatedTodos });
                                    saveTodos(updatedTodos);
                                }
                            })
                        )
                    );
                }
            })
        )
    );
}

function renderFooter(state) {
    if (state.todos.length === 0) {
        return null;
    }

    const activeCount = state.todos.filter(t => !t.completed).length;
    const completedCount = state.todos.filter(t => t.completed).length;
    const itemText = activeCount === 1 ? 'item' : 'items';

    return h('footer', { class: 'footer' },
        h('span', { class: 'todo-count' },
            h('strong', {}, String(activeCount)),
            ` ${itemText} left`
        ),
        h('ul', { class: 'filters' },
            h('li', {},
                h('a', {
                    class: state.currentFilter === '#/' ? 'selected' : '',
                    href: '#/'
                }, 'All')
            ),
            h('li', {},
                h('a', {
                    class: state.currentFilter === '#/active' ? 'selected' : '',
                    href: '#/active'
                }, 'Active')
            ),
            h('li', {},
                h('a', {
                    class: state.currentFilter === '#/completed' ? 'selected' : '',
                    href: '#/completed'
                }, 'Completed')
            )
        ),
        completedCount > 0 ? h('button', {
            class: 'clear-completed',
            onclick: () => {
                const updatedTodos = state.todos.filter(t => !t.completed);
                store.setState({ todos: updatedTodos });
                saveTodos(updatedTodos);
            }
        }, 'Clear completed') : null
    );
}

function view(state) {
    return h('section', { class: 'todoapp' },
        renderHeader(state),
        renderMain(state),
        renderFooter(state)
    );
}

const rootElement = document.getElementById('root');
store = createApp({ view, initialState, rootElement });

createRouter(store);
