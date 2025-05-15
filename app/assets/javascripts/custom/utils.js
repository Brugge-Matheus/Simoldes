document.addEventListener("turbo:load", function() {


    (function () {
        
        // Close flash alert
        const flashAlert = document.querySelector('#btn-close-flash');
        if (flashAlert) {
            flashAlert.addEventListener('click', function (e) {
                e.preventDefault();
                window.location.reload();
            })
        }

        // Create a global utility object
        window.util = {};

        /**
         * Generate an indented list of links from a nav. Meant for use with panel().
         * @param {HTMLElement} navElement - The navigation element to process
         * @return {string} HTML string of the generated list.
         */
        window.util.navList = function (navElement) {
            const links = navElement.querySelectorAll('a');
            const b = [];

            links.forEach(function (link) {
                const indent = Math.max(0, link.closest('li') ? getParentCount(link, 'li') - 1 : 0);
                const href = link.getAttribute('href');
                const target = link.getAttribute('target');

                b.push(
                    '<a ' +
                    'class="link depth-' + indent + '"' +
                    ((target !== null && target !== '') ? ' target="' + target + '"' : '') +
                    ((href !== null && href !== '') ? ' href="' + href + '"' : '') +
                    '>' +
                    '<span class="indent-' + indent + '"></span>' +
                    link.textContent +
                    '</a>'
                );
            });

            return b.join('');

            // Helper function to count parent elements
            function getParentCount(element, parentSelector) {
                let count = 0;
                let current = element;

                while (current) {
                    current = current.parentElement;
                    if (current && current.matches(parentSelector)) {
                        count++;
                    }
                }

                return count;
            }
        };

        /**
         * Panel-ify an element.
         * @param {HTMLElement} element - The element to panel-ify
         * @param {object} userConfig - User configuration
         * @return {object} The panel controller
         */
        window.util.panel = function (element, userConfig) {
            // No elements?
            if (!element) return null;

            // Multiple elements? Handle as a NodeList
            if (element instanceof NodeList) {
                Array.from(element).forEach(el => window.util.panel(el, userConfig));
                return null;
            }

            // Variables
            const body = document.body;
            const window = self;
            const id = element.getAttribute('id');

            // Default config
            const defaultConfig = {
                // Delay.
                delay: 0,
                // Hide panel on link click.
                hideOnClick: false,
                // Hide panel on escape keypress.
                hideOnEscape: false,
                // Hide panel on swipe.
                hideOnSwipe: false,
                // Reset scroll position on hide.
                resetScroll: false,
                // Reset forms on hide.
                resetForms: false,
                // Side of viewport the panel will appear.
                side: null,
                // Target element for "class".
                target: element,
                // Class to toggle.
                visibleClass: 'visible'
            };

            // Merge configs
            const config = Object.assign({}, defaultConfig, userConfig);

            // If target is not an HTMLElement, try to query it
            if (!(config.target instanceof HTMLElement)) {
                config.target = typeof config.target === 'string'
                    ? document.querySelector(config.target)
                    : element;
            }

            // Panel methods
            const panel = {
                element: element,
                touchPosX: null,
                touchPosY: null,

                _hide: function (event) {
                    // Already hidden? Bail.
                    if (!config.target.classList.contains(config.visibleClass))
                        return;

                    // If an event was provided, cancel it.
                    if (event) {
                        event.preventDefault();
                        event.stopPropagation();
                    }

                    // Hide.
                    config.target.classList.remove(config.visibleClass);

                    // Post-hide stuff.
                    window.setTimeout(function () {
                        // Reset scroll position.
                        if (config.resetScroll)
                            element.scrollTop = 0;

                        // Reset forms.
                        if (config.resetForms)
                            element.querySelectorAll('form').forEach(form => form.reset());

                    }, config.delay);
                }
            };

            // Vendor fixes
            element.style.msOverflowStyle = '-ms-autohiding-scrollbar';
            element.style.webkitOverflowScrolling = 'touch';

            // Hide on click
            if (config.hideOnClick) {
                const links = element.querySelectorAll('a');

                links.forEach(link => {
                    link.style.webkitTapHighlightColor = 'rgba(0,0,0,0)';

                    link.addEventListener('click', function (event) {
                        const href = this.getAttribute('href');
                        const target = this.getAttribute('target');

                        if (!href || href === '#' || href === '' || href === '#' + id)
                            return;

                        // Cancel original event.
                        event.preventDefault();
                        event.stopPropagation();

                        // Hide panel.
                        panel._hide();

                        // Redirect to href.
                        window.setTimeout(function () {
                            if (target === '_blank')
                                window.open(href);
                            else
                                window.location.href = href;
                        }, config.delay + 10);
                    });
                });
            }

            // Event: Touch start
            element.addEventListener('touchstart', function (event) {
                panel.touchPosX = event.touches[0].pageX;
                panel.touchPosY = event.touches[0].pageY;
            });

            // Event: Touch move
            element.addEventListener('touchmove', function (event) {
                if (panel.touchPosX === null || panel.touchPosY === null)
                    return;

                const diffX = panel.touchPosX - event.touches[0].pageX;
                const diffY = panel.touchPosY - event.touches[0].pageY;
                const th = element.offsetHeight;
                const ts = (element.scrollHeight - element.scrollTop);

                // Hide on swipe?
                if (config.hideOnSwipe) {
                    let result = false;
                    const boundary = 20;
                    const delta = 50;

                    switch (config.side) {
                        case 'left':
                            result = (diffY < boundary && diffY > (-1 * boundary)) && (diffX > delta);
                            break;
                        case 'right':
                            result = (diffY < boundary && diffY > (-1 * boundary)) && (diffX < (-1 * delta));
                            break;
                        case 'top':
                            result = (diffX < boundary && diffX > (-1 * boundary)) && (diffY > delta);
                            break;
                        case 'bottom':
                            result = (diffX < boundary && diffX > (-1 * boundary)) && (diffY < (-1 * delta));
                            break;
                        default:
                            break;
                    }

                    if (result) {
                        panel.touchPosX = null;
                        panel.touchPosY = null;
                        panel._hide();
                        return false;
                    }
                }

                // Prevent vertical scrolling past the top or bottom.
                if ((element.scrollTop < 0 && diffY < 0)
                    || (ts > (th - 2) && ts < (th + 2) && diffY > 0)) {
                    event.preventDefault();
                    event.stopPropagation();
                }
            });

            // Event: Prevent certain events inside the panel from bubbling.
            ['click', 'touchend', 'touchstart', 'touchmove'].forEach(eventType => {
                element.addEventListener(eventType, function (event) {
                    event.stopPropagation();
                });
            });

            // Event: Hide panel if a child anchor tag pointing to its ID is clicked.
            element.querySelectorAll('a[href="#' + id + '"]').forEach(link => {
                link.addEventListener('click', function (event) {
                    event.preventDefault();
                    event.stopPropagation();
                    config.target.classList.remove(config.visibleClass);
                });
            });

            // Body: Event: Hide panel on body click/tap.
            ['click', 'touchend'].forEach(eventType => {
                document.body.addEventListener(eventType, function (event) {
                    // Check if the click is not inside the panel
                    if (!element.contains(event.target)) {
                        panel._hide(event);
                    }
                });
            });

            // Body: Event: Toggle.
            document.body.querySelectorAll('a[href="#' + id + '"]').forEach(link => {
                link.addEventListener('click', function (event) {
                    event.preventDefault();
                    event.stopPropagation();
                    config.target.classList.toggle(config.visibleClass);
                });
            });

            // Window: Event: Hide on ESC.
            if (config.hideOnEscape) {
                window.addEventListener('keydown', function (event) {
                    if (event.keyCode == 27)
                        panel._hide(event);
                });
            }

            return panel;
        };

        /**
         * Apply "placeholder" attribute polyfill to one or more forms.
         * @param {HTMLElement|NodeList} elements - Form element(s) to apply to
         * @return {object} The controller object
         */
        window.util.placeholder = function (elements) {
            // Browser natively supports placeholders? Bail.
            if (typeof (document.createElement('input')).placeholder !== 'undefined')
                return null;

            // No elements?
            if (!elements) return null;

            // Convert to array if it's a NodeList
            const elementsArray = elements instanceof NodeList ? Array.from(elements) : [elements];

            elementsArray.forEach(function (form) {
                // Text, TextArea.
                const textInputs = form.querySelectorAll('input[type=text],textarea');

                textInputs.forEach(function (input) {
                    if (input.value === '' || input.value === input.getAttribute('placeholder')) {
                        input.classList.add('polyfill-placeholder');
                        input.value = input.getAttribute('placeholder');
                    }

                    // Event: blur
                    input.addEventListener('blur', function () {
                        if (this.getAttribute('name').match(/-polyfill-field$/))
                            return;

                        if (this.value === '') {
                            this.classList.add('polyfill-placeholder');
                            this.value = this.getAttribute('placeholder');
                        }
                    });

                    // Event: focus
                    input.addEventListener('focus', function () {
                        if (this.getAttribute('name').match(/-polyfill-field$/))
                            return;

                        if (this.value === this.getAttribute('placeholder')) {
                            this.classList.remove('polyfill-placeholder');
                            this.value = '';
                        }
                    });
                });

                // Password inputs
                const passwordInputs = form.querySelectorAll('input[type=password]');

                passwordInputs.forEach(function (input) {
                    // Create clone
                    const newInput = document.createElement('input');
                    newInput.type = 'text';

                    // Copy attributes
                    Array.from(input.attributes).forEach(attr => {
                        if (attr.name !== 'type' && attr.name !== 'name') {
                            newInput.setAttribute(attr.name, attr.value);
                        }
                    });

                    if (input.getAttribute('id') !== '') {
                        newInput.setAttribute('id', input.getAttribute('id') + '-polyfill-field');
                    }

                    if (input.getAttribute('name') !== '') {
                        newInput.setAttribute('name', input.getAttribute('name') + '-polyfill-field');
                    }

                    newInput.classList.add('polyfill-placeholder');
                    newInput.setAttribute('value', newInput.getAttribute('placeholder'));

                    // Insert clone
                    input.parentNode.insertBefore(newInput, input.nextSibling);

                    // Hide original if empty
                    if (input.value === '') {
                        input.style.display = 'none';
                    } else {
                        newInput.style.display = 'none';
                    }

                    // Event: blur (original)
                    input.addEventListener('blur', function (event) {
                        event.preventDefault();

                        const polyfillField = input.parentNode.querySelector('input[name=' + input.getAttribute('name') + '-polyfill-field]');

                        if (input.value === '') {
                            input.style.display = 'none';
                            polyfillField.style.display = '';
                        }
                    });

                    // Event: focus (clone)
                    newInput.addEventListener('focus', function (event) {
                        event.preventDefault();

                        const originalField = newInput.parentNode.querySelector('input[name=' + newInput.getAttribute('name').replace('-polyfill-field', '') + ']');

                        newInput.style.display = 'none';
                        originalField.style.display = '';
                        originalField.focus();
                    });

                    // Event: keypress (clone)
                    newInput.addEventListener('keypress', function (event) {
                        event.preventDefault();
                        newInput.value = '';
                    });
                });

                // Events for the form

                // Submit event
                form.addEventListener('submit', function () {
                    const textInputs = form.querySelectorAll('input[type=text],input[type=password],textarea');

                    textInputs.forEach(function (input) {
                        if (input.getAttribute('name').match(/-polyfill-field$/)) {
                            input.setAttribute('name', '');
                        }

                        if (input.value === input.getAttribute('placeholder')) {
                            input.classList.remove('polyfill-placeholder');
                            input.value = '';
                        }
                    });
                });

                // Reset event
                form.addEventListener('reset', function (event) {
                    event.preventDefault();

                    // Reset selects
                    form.querySelectorAll('select').forEach(select => {
                        select.value = select.querySelector('option:first-child').value;
                    });

                    // Reset inputs and textareas
                    form.querySelectorAll('input,textarea').forEach(function (input) {
                        input.classList.remove('polyfill-placeholder');

                        switch (input.type) {
                            case 'submit':
                            case 'reset':
                                break;

                            case 'password':
                                input.value = input.getAttribute('defaultValue');

                                const polyfillField = input.parentNode.querySelector('input[name=' + input.getAttribute('name') + '-polyfill-field]');

                                if (input.value === '') {
                                    input.style.display = 'none';
                                    polyfillField.style.display = '';
                                } else {
                                    input.style.display = '';
                                    polyfillField.style.display = 'none';
                                }

                                break;

                            case 'checkbox':
                            case 'radio':
                                input.checked = input.getAttribute('defaultValue') === 'true';
                                break;

                            case 'text':
                            case 'textarea':
                                input.value = input.getAttribute('defaultValue');

                                if (input.value === '') {
                                    input.classList.add('polyfill-placeholder');
                                    input.value = input.getAttribute('placeholder');
                                }

                                break;

                            default:
                                input.value = input.getAttribute('defaultValue');
                                break;
                        }
                    });
                });
            });

            return elements;
        };

        /**
         * Moves elements to/from the first positions of their respective parents.
         * @param {HTMLElement|NodeList|string} elements - Elements to move
         * @param {boolean} condition - If true, moves elements to the top. Otherwise, moves elements back to their original locations.
         */
        window.util.prioritize = function (elements, condition) {
            const key = '__prioritize';

            // Convert selector to elements if it's a string
            if (typeof elements === 'string') {
                elements = document.querySelectorAll(elements);
            }

            // Convert to array if it's a single element or NodeList
            const elementsArray = elements instanceof NodeList
                ? Array.from(elements)
                : (elements instanceof HTMLElement ? [elements] : []);

            // Step through elements
            elementsArray.forEach(function (element) {
                const parent = element.parentNode;

                // No parent? Bail.
                if (!parent) return;

                // Not moved? Move it.
                if (!element.dataset[key]) {
                    // Condition is false? Bail.
                    if (!condition) return;

                    // Get placeholder (which will serve as our point of reference for when this element needs to move back).
                    const placeholderElement = element.previousElementSibling;

                    // Couldn't find anything? Means this element's already at the top, so bail.
                    if (!placeholderElement) return;

                    // Move element to top of parent.
                    parent.insertBefore(element, parent.firstChild);

                    // Mark element as moved.
                    element.dataset[key] = placeholderElement.outerHTML;
                }
                // Moved already?
                else {
                    // Condition is true? Bail.
                    if (condition) return;

                    // Get placeholder data
                    const placeholderHTML = element.dataset[key];
                    const tempDiv = document.createElement('div');
                    tempDiv.innerHTML = placeholderHTML;
                    const placeholder = tempDiv.firstChild;

                    // Find current placeholder element
                    let currentPlaceholder = Array.from(parent.children).find(
                        child => child.outerHTML === placeholderHTML
                    );

                    // If current placeholder exists, insert after it
                    if (currentPlaceholder) {
                        parent.insertBefore(element, currentPlaceholder.nextSibling);
                    }
                    // Otherwise find the right position based on original HTML
                    else {
                        let inserted = false;

                        // Try to find matching element and insert after it
                        Array.from(parent.children).forEach(child => {
                            if (!inserted && child.outerHTML === placeholderHTML) {
                                parent.insertBefore(element, child.nextSibling);
                                inserted = true;
                            }
                        });

                        // If not inserted, append to end
                        if (!inserted) {
                            parent.appendChild(element);
                        }
                    }

                    // Unmark element as moved.
                    delete element.dataset[key];
                }
            });
        };

    })();
});

