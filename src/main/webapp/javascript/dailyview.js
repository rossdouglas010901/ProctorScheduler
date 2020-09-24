APP = "/ProctorScheduler"; //should be empty string when deploying to Heroku, as that is deployed on the root
        
/* ************************************************************************* */
/* Appointment List view */
/* ************************************************************************* */
/* toggle Timeslot view OFF, toggle Appointment view ON */
document.getElementById('appointmentViewIcon').addEventListener('click', function () {
    document.getElementById('timeslotView').setAttribute('class', 'hide');
    document.getElementById(this.id.replace('Icon', '')).setAttribute('class', 'show');
});

/* toggle Timeslot view ON, toggle Appointment view OFF */
document.getElementById('timeslotViewIcon').addEventListener('click', function () {
    document.getElementById('appointmentView').setAttribute('class', 'hide');
    document.getElementById(this.id.replace('Icon', '')).setAttribute('class', 'show');
});


// AJAX appointment Renew-Release response handling to display a confirmation message before actually adding or removing oneself to/from an Appointment
var reserveLinks = document.querySelectorAll('.eventOptionsReserve');
for (i = 0; i < reserveLinks.length; i++) {
    reserveLinks[i].addEventListener('click', function (event) {
        if (confirm('Are you sure you want to ' + this.title + '?\n' + this.getAttribute('data-appointment-title')) !== false) {
            event.preventDefault();
            makeRequest('/ProctorScheduler/editAppointment', this.getAttribute('data-appointment-params'), 'PUT', 'text/json');

            //switch display and class to RELEASE			
            this.innerHTML = 'Release <span class="eventText">Proctored Event</span> <i class="far fa-calendar-times"></i>';
            this.setAttribute('class', 'eventOptionsRelease');
            this.setAttribute('data-appointment-params', this.getAttribute('data-appointment-params').replace('action=reserve', 'action=release'));
            this.title = 'Release your Proctoring reservation back to Calendar';
        }
    });
}

var releaseLinks = document.querySelectorAll('.eventOptionsRelease');
for (i = 0; i < releaseLinks.length; i++) {
    releaseLinks[i].addEventListener('click', function (event) {
        if (confirm('Are you sure you want to ' + this.title + '?\n' + this.getAttribute('data-appointment-title')) !== false) {
            event.preventDefault();
            makeRequest('/ProctorScheduler/editAppointment', this.getAttribute('data-appointment-params'), 'PUT', 'text/json');

            //switch display and class to RESERVE
            this.innerHTML = 'Reserve <span class="eventText">Event</span> <i class="fas fa-check"></i>';
            this.setAttribute('class', 'eventOptionsReserve');
            this.setAttribute('data-appointment-params', this.getAttribute('data-appointment-params').replace('action=release', 'action=reserve'));
            this.title = 'Reserve event (with yourself as the Proctor)';
        }
    });
}

// AJAX appointment Delete response handling
var deleteLinks = document.querySelectorAll('.eventOptionsDelete');
for (i = 0; i < deleteLinks.length; i++) {
    deleteLinks[i].addEventListener('click', function (event) {
        if (confirm('Are you sure you want to completely Delete: \n' + this.getAttribute('data-appointment-title')) !== false) {
            event.preventDefault();
            makeRequest('/ProctorScheduler/deleteAppointment', this.getAttribute('data-appointment-params'), 'DELETE', 'text/json');
            //TODO: replace with a nicer modal/loading type messaging mechanism 			alert('Selected event has been deleted...');
            this.parentElement.parentElement.setAttribute('class', 'hide');
        }
    });
}


/* ************************************************************************* */
/* Appointment Timeslots view */
/* ************************************************************************* */
function getStyle(ele) {
    return ele.currentStyle || window.getComputedStyle(ele);
}
const containerWidth = (document.getElementById('appointments').clientWidth || document.getElementById('appointments').offsetWidth);
const containerHeight = (document.getElementById('appointments').clientHeight || document.getElementById('appointments').offsetHeight);
var content = document.getElementsByClassName('content')[0];
var contentStyle = getStyle(content);
var schedule = document.getElementsByClassName('schedule')[0]
var scheduleStyle = getStyle(schedule);
var days = document.getElementsByClassName('days')[0]
var daysStyle = getStyle(schedule);
const SCREEN_WIDTH = screen.width || screen.availWidth;
const CONTENT_WIDTH = (schedule.clientWidth || schedule.offsetWidth);
const topOffsetResponsive = document.getElementsByClassName('scheduleSubtitle1')[0].getBoundingClientRect().top;
const leftOffsetResponsive = 10 + parseInt(contentStyle.marginLeft.replace('px', '')) + parseInt(scheduleStyle.paddingLeft.replace('px', '')) + parseInt(daysStyle.paddingLeft.replace('px', '')) + (document.getElementsByClassName('scheduleSubtitle1')[0].clientWidth || document.getElementsByClassName('scheduleSubtitle1')[0].offsetWidth);
/* DEBUG */
console.debug("Screen width: '" + SCREEN_WIDTH + "' | Content width: '" + CONTENT_WIDTH + "' | Left offset: '" + leftOffsetResponsive + "'");
/* DEBUG */
const minutesinDay = 60 * 12;
let collisions = [];
let width = [];
let leftOffSet = [];


/**
 * append one event to calendar
 * 
 * @param {type} events
 * @returns {undefined}
 */
var createEvent = (title, description, height, top, left, units) => {

    let node = document.createElement("DIV");
    node.className = "timeslot";
    node.innerHTML = '<span class="title">'+title+'</span> <br/> <span class="location">'+description+'</span>';

    // Customized CSS to position each event
    node.style.width = (containerWidth / units) + "px";
    node.style.height = height + "px";
    node.style.top = 100 + topOffsetResponsive + top + "px";
    if (CONTENT_WIDTH <= 760 && CONTENT_WIDTH > 460) {
        node.style.left = (leftOffsetResponsive - 8) + left + "px";
    } else if (CONTENT_WIDTH <= 460 && CONTENT_WIDTH >= 320) {
        node.style.left = 80 + left + "px";
    } else {
        node.style.left = leftOffsetResponsive + left + "px";
    }

    document.getElementById("appointments").appendChild(node);
}


/**
 * collisions is an array that tells you which events are in each 30 min slot
 *  - each first level of array corresponds to a 30 minute slot on the calendar 
 *  - [[0 - 30mins], [ 30 - 60mins], ...]
 *  - next level of array tells you which event is present and the horizontal order
 *  - [0,0,1,2] 
 * ==> event 1 is not present, event 2 is not present, event 3 is at order 1, event 4 is at order 2
 *
 * @param {type} events
 * @returns {undefined}
 */
function getCollisions(events) {

    //resets storage
    collisions = [];

    for (var i = 0; i < 24; i++) {
        var time = [];
        for (var j = 0; j < events.length; j++) {
            time.push(0);
        }
        collisions.push(time);
    }

    events.forEach((event, id) => {
        let end = event.end;
        let start = event.start;
        let order = 1;

        while (start < end) {
            timeIndex = Math.floor(start / 30);

            while (order < events.length) {
                if (collisions[timeIndex].indexOf(order) === -1) {
                    break;
                }
                order++;
            }

            collisions[timeIndex][id] = order;
            start = start + 30;
        }

        collisions[Math.floor((end - 1) / 30)][id] = order;
    });
}


/**
 * find width and horizontal position
 * width - number of units to divide container width by
 * horizontal position - pixel offset from left
 *
 * @param {type} events
 * @returns {undefined}
 */
function getAttributes(events) {

    //resets storage
    width = [];
    leftOffSet = [];

    for (var i = 0; i < events.length; i++) {
        width.push(0);
        leftOffSet.push(0);
    }

    collisions.forEach((period) => {

        // number of events in that period
        let count = period.reduce((a, b) => {
            return b ? a + 1 : a;
        })

        if (count > 1) {
            period.forEach((event, id) => {
                // max number of events it is sharing a time period with determines width
                if (period[id]) {
                    if (count > width[id]) {
                        width[id] = count;
                    }
                }

                if (period[id] && !leftOffSet[id]) {
                    leftOffSet[id] = period[id];
                }
            })
        }
    });
}


/**
 * lay out the given Day's Appointment Timeslots
 * 
 * @param {type} events
 * @returns {undefined}
 */
var layOutDay = (events) => {

// clear any existing nodes
    var myNode = document.getElementById("appointments");
    myNode.innerHTML = '';

    getCollisions(events);
    getAttributes(events);

    events.forEach((event, id) => {
        let title = event.title;
        let description = event.description;
        
        let end = event.end;
        let start = event.start;
        
        let height = (end - start) / minutesinDay * containerHeight;
        let top = start / minutesinDay * containerHeight;
        let units = width[id];
        if (!units) {
            units = 1;
        }

        let left = (containerWidth / width[id]) * (leftOffSet[id] - 1) + 10;
        if (!left || left < 0) {
            left = 10;
        }

        createEvent(title, description, height, top, left, units);
    });
}

var day = document.getElementById('date').textContent || document.getElementById('date').innerText;
const events = JSON.parse(makeRequest(APP+'/appointment', '?start='+day+'&end='+day+'&type=day', 'GET', 'application/json'));
// Sample data - some default events give
//const events = {"calendarAppointments": [{"start": 30, "end": 150}, {"start": 540, "end": 600}, {"start": 560, "end": 620}, {"start": 610, "end": 670}, {"start": 560, "end": 710}]};
//const events = {"calendarAppointments" : [{"id" : "2", "title" : "Dental Hygiene 101 Make-up Test", "description" : "Reading each section is required for this make-up test", "students" : "5", "start" : 360, "end": 420}]};

layOutDay(events.calendarAppointments);
