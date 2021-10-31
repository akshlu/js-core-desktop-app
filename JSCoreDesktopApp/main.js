// impl
function View(props, ...children) {
    return {
        type: 'View',
        ...props,
        children
    }
}

function Button(props) {
    return {
        type: 'Button',
        ...props
    }
}


// usage


function Application() {
    return View({},
        Button({title: "Press me"})
    );
}

function main() {
    return Application()
}
