/*
 * Event Listener for Calendar cell (day) selections.
 *   (`this` refers to the element the event was hooked on)
 */
function daySelectionHandler() {    
    document.location = this.getElementsByTagName('a')[0].href;
}

/* Polyfill forEach functionality to support older browsers */
if (!HTMLCollection.prototype.forEach) {
    Object.defineProperty(HTMLCollection.prototype, 'forEach', {
        value: Array.prototype.forEach
    });
}
document.addEventListener('DOMContentLoaded', function(){
    document.querySelectorAll('td').forEach(e => e.addEventListener('click', daySelectionHandler)); 
});
