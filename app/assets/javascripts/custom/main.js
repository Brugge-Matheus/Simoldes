document.addEventListener("turbo:load", function() {

    (function() {

        // DOM elements
        const window = this;
        const head = document.head;
        const body = document.body;

        // Breakpoints management
        const breakpoints = {
            xlarge: ['1281px', '1680px'],
            large: ['981px', '1280px'],
            medium: ['737px', '980px'],
            small: ['481px', '736px'],
            xsmall: ['361px', '480px'],
            xxsmall: [null, '360px'],
            'xlarge-to-max': '(min-width: 1681px)',
            'small-to-xlarge': '(min-width: 481px) and (max-width: 1680px)',
            active: function(query) {
                // Implementation of active breakpoint detection
                if (query === '>large') {
                    return window.matchMedia('(min-width: 1281px)').matches;
                } else if (query === '<=large') {
                    return window.matchMedia('(max-width: 1280px)').matches;
                }
                return false;
            },
            on: function(query, callback) {
                // Execute callback based on breakpoint query
                if (query === '>large') {
                    if (window.matchMedia('(min-width: 1281px)').matches) {
                        callback();
                    }
                    window.matchMedia('(min-width: 1281px)').addEventListener('change', function(e) {
                        if (e.matches) callback();
                    });
                } else if (query === '<=large') {
                    if (window.matchMedia('(max-width: 1280px)').matches) {
                        callback();
                    }
                    window.matchMedia('(max-width: 1280px)').addEventListener('change', function(e) {
                        if (e.matches) callback();
                    });
                }
            }
        };

        // Browser detection (simplified version)
        const browser = {
            name: navigator.userAgent.toLowerCase().indexOf('chrome') > -1 ? 'chrome' :
                navigator.userAgent.toLowerCase().indexOf('safari') > -1 ? 'safari' : 'other',
            os: navigator.userAgent.toLowerCase().indexOf('android') > -1 ? 'android' : 'other',
            canUse: function(property) {
                // Simple feature detection
                const element = document.createElement('div');
                return property in element.style;
            }
        };

        // Load event - remove preload class
        window.addEventListener('load', function() {
            window.setTimeout(function() {
                body.classList.remove('is-preload');
            }, 100);
        });

        // Resize handler
        let resizeTimeout;
        window.addEventListener('resize', function() {
            // Mark as resizing
            body.classList.add('is-resizing');

            // Unmark after delay
            clearTimeout(resizeTimeout);
            resizeTimeout = setTimeout(function() {
                body.classList.remove('is-resizing');
            }, 100);
        });

        // Object fit images fix
        if (!browser.canUse('object-fit') || browser.name == 'safari') {
            const objectFitImages = document.querySelectorAll('.image.object');
            objectFitImages.forEach(function(imgContainer) {
                const img = imgContainer.querySelector('img');

                // Hide original image
                img.style.opacity = '0';

                // Get computed styles
                const computedStyle = window.getComputedStyle(img);
                const objectFit = computedStyle.getPropertyValue('object-fit') || 'cover';
                const objectPosition = computedStyle.getPropertyValue('object-position') || 'center';

                // Set background
                imgContainer.style.backgroundImage = `url("${img.getAttribute('src')}")`;
                imgContainer.style.backgroundSize = objectFit;
                imgContainer.style.backgroundPosition = objectPosition;
            });
        }

        // Sidebar
        const sidebar = document.getElementById('sidebar');
        const sidebarInner = sidebar.querySelector('.inner');

        // Inactive by default on <= large
        breakpoints.on('<=large', function() {
            sidebar.classList.add('inactive');
        });

        breakpoints.on('>large', function() {
            sidebar.classList.remove('inactive');
        });

        // Workaround for Chrome/Android scrollbar position bug
        if (browser.os == 'android' && browser.name == 'chrome') {
            const style = document.createElement('style');
            style.textContent = '#sidebar .inner::-webkit-scrollbar { display: none; }';
            head.appendChild(style);
        }

        // Create and append toggle button
        const toggleBtn = document.createElement('a');
        toggleBtn.href = '#sidebar';
        toggleBtn.className = 'toggle';
        toggleBtn.textContent = 'Toggle';
        sidebar.appendChild(toggleBtn);

        // Toggle event
        toggleBtn.addEventListener('click', function(event) {
            event.preventDefault();
            event.stopPropagation();
            sidebar.classList.toggle('inactive');
        });

        // Link clicks in sidebar
        const sidebarLinks = sidebar.querySelectorAll('a');
        sidebarLinks.forEach(function(link) {
            link.addEventListener('click', function(event) {
                // >large? Bail.
                if (breakpoints.active('>large')) return;

                const href = this.getAttribute('href');
                const target = this.getAttribute('target');

                // Prevent default for valid links
                if (href && href != '#' && href != '') {
                    event.preventDefault();
                    event.stopPropagation();

                    // Hide sidebar
                    sidebar.classList.add('inactive');

                    // Redirect to href
                    setTimeout(function() {
                        if (target == '_blank') {
                            window.open(href);
                        } else {
                            window.location.href = href;
                        }
                    }, 500);
                }
            });
        });

        // Prevent event bubbling within sidebar
        ['click', 'touchend', 'touchstart', 'touchmove'].forEach(function(eventType) {
            sidebar.addEventListener(eventType, function(event) {
                // >large? Bail.
                if (breakpoints.active('>large')) return;

                // Prevent propagation
                event.stopPropagation();
            });
        });

        // Hide panel on body click/tap
        ['click', 'touchend'].forEach(function(eventType) {
            body.addEventListener(eventType, function(event) {
                // >large? Bail.
                if (breakpoints.active('>large')) return;

                // Don't hide if the click was inside the sidebar
                if (sidebar.contains(event.target)) return;

                // Deactivate
                sidebar.classList.add('inactive');
            });
        });

        // Scroll lock
        window.addEventListener('load', function() {
            let sh, wh, st;

            // Reset scroll position to 0 if it's 1
            if (window.scrollY == 1) {
                window.scrollTo(0, 0);
            }

            function updateScrollLock() {
                // <=large? Bail.
                if (breakpoints.active('<=large')) {
                    sidebarInner.dataset.locked = 0;
                    sidebarInner.style.position = '';
                    sidebarInner.style.top = '';
                    return;
                }

                // Calculate positions
                const x = Math.max(sh - wh, 0);
                const y = Math.max(0, window.scrollY - x);

                // Lock/unlock
                if (sidebarInner.dataset.locked == 1) {
                    if (y <= 0) {
                        sidebarInner.dataset.locked = 0;
                        sidebarInner.style.position = '';
                        sidebarInner.style.top = '';
                    } else {
                        sidebarInner.style.top = -1 * x + 'px';
                    }
                } else {
                    if (y > 0) {
                        sidebarInner.dataset.locked = 1;
                        sidebarInner.style.position = 'fixed';
                        sidebarInner.style.top = -1 * x + 'px';
                    }
                }
            }

            function updateSidebarDimensions() {
                wh = window.innerHeight;
                sh = sidebarInner.offsetHeight + 30;
                updateScrollLock();
            }

            // Set up event listeners
            window.addEventListener('scroll', updateScrollLock);
            window.addEventListener('resize', updateSidebarDimensions);

            // Initial update
            updateSidebarDimensions();
        });

        // Menu
        const menu = document.getElementById('menu');
        const menuOpeners = menu.querySelectorAll('ul .opener');

        // Setup openers
        menuOpeners.forEach(function(opener) {
            opener.addEventListener('click', function(event) {
                // Prevent default
                event.preventDefault();

                // Toggle
                menuOpeners.forEach(function(otherOpener) {
                    if (otherOpener !== opener) {
                        otherOpener.classList.remove('active');
                    }
                });
                opener.classList.toggle('active');

                // Trigger resize (for sidebar lock)
                const resizeEvent = new Event('resize');
                window.dispatchEvent(resizeEvent);
            });
        });

    })();
})
