class UnreadNotificationsService extends Service {
    // every subclass of GObject.Object has to register itself
    static {
        // takes three arguments
        // the class itself
        // an object defining the signals
        // an object defining its properties
        Service.register(
            this,
            {
                // 'name-of-signal': [type as a string from GObject.TYPE_<type>],
                // 'changed': ['float'],
            },
            {
                // 'kebab-cased-name': [type as a string from GObject.TYPE_<type>, 'r' | 'w' | 'rw']
                // 'r' means readable
                // 'w' means writable
                // guess what 'rw' means
                'unread_notifications': ['bool', 'rw'],
            },
        );
    }

    #unread_notifications = false;
    get unread_notifications() {
        return this.#unread_notifications;
    }

    // the setter has to be in snake_case too
    set unread_notifications(value) {
        this.#unread_notifications = value;
        this.emit('changed'); 
    }

    constructor() {
        super();

        this.#onChange();
    }

    #onChange() {
        this.emit('changed'); // emits "changed"
    }

    // overwriting the connect method, let's you
    // change the default event that widgets connect to
    connect(event = 'changed', callback) {
        return super.connect(event, callback);
    }
}

// the singleton instance
const service = new UnreadNotificationsService;

// export to use in other modules
export default service;
