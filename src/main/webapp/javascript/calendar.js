/*******************************************************/
/* calendar.js                                         */
/*******************************************************/


/**
 * isEmpty
 *   Indicates true if passed in variable is empty, null or undefined, false otherwise.
 *   
 * @param variable
 * @returns Boolean  
 */
function isEmpty(variable) {
    if (typeof variable === 'undefined' || variable === null || variable === 'null' || variable.length < 1) {
        return true;
    }
    return false;
}


/**
 * Turns a single-digit Date number (like 1 or 9) into a double-digit Date String (like "01" or "09") 
 */
function numberToString(num) {
	return (num < 10 || num.length === 1) ? '0'+num : num;
}

/**
 * getTime
 *   Get the current time as a user-readable text.
 *   
 * @return time string
 */
function getTime() {
    // initialize time-related variables with current time settings
    var now = new Date();
    var hour = now.getHours();
    var minute = now.getMinutes();
    now = null;
    var ampm = '';

    // validate hour values and set value of ampm
    if (hour >= 12) {
        hour -= 12;
        ampm = 'PM';
    } else {
        ampm = 'AM';
    }
    hour = (hour == 0) ? 12 : hour;

    // add zero digit to a one digit minute
    if (minute < 10) {
        minute = '0' + minute; // do not parse this number!
    }

    return hour + ':' + minute + ' ' + ampm;
}


/**
 * leapYear
 *   Basic Leap Year checking rules.
 *   
 * @param year  the numerical year
 * @return boolean true if Leap Year, false otherwise
 */
function leapYear(year) {
    if (year % 4 == 0) {
        return true; // is leap year
    }
    return false; // is not leap year
}


/**
 * getDays 
 *   Get the number of days in the month, with provision for leap year calculation.
 *   
 * @param year  the year used to calculate leap year to determine Feb number of days
 * @param month  number of the month with index starting at 0
 * @return number of days in the specified month (parameter)
 */
function getDays(year, month) {
    // create array to hold number of days in each month
    var ar = new Array(12);
	    ar[0] = 31; // January
	    ar[1] = (leapYear(year)) ? 29 : 28; // February
	    ar[2] = 31; // March
	    ar[3] = 30; // April
	    ar[4] = 31; // May
	    ar[5] = 30; // June
	    ar[6] = 31; // July
	    ar[7] = 31; // August
	    ar[8] = 30; // September
	    ar[9] = 31; // October
	    ar[10] = 30; // November
	    ar[11] = 31; // December
    return ar[month];
}


/**
 * getMonthNumber 
 *   Converts a month English name to corresponding "month of the year" number.
 *   
 * @param month  the number of the month which will be converted to a full English name
 * @return name specified month name
 */
function getMonthNumber(monthName) {
    var monthNames = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];
    return monthNames.indexOf(monthName);
}


/**
 * getMonthName 
 *   Converts a number to the proper English month name.
 *   
 * @param month  the number of the month which will be converted to a full English name
 * @return name specified month name
 */
function getMonthName(month) {
    // create array to hold name of each month
    var ar = new Array(12);
		ar[0] = 'January';
		ar[1] = 'February';
		ar[2] = 'March';
		ar[3] = 'April';
		ar[4] = 'May';
		ar[5] = 'June';
		ar[6] = 'July';
		ar[7] = 'August';
		ar[8] = 'September';
		ar[9] = 'October';
		ar[10] = 'November';
		ar[11] = 'December';
    return ar[month];
}


/**
 * drawCal 
 *   Creates an HTML Table to be displayed in the browser.
 *   
 * @param firstDay  number first day of the given month
 * @param lastDay  number of last day of the given month
 * @param date  current date number
 * @param monthName  name of the Month to display in calendar
 * @param year  number of the year
 */
function drawCal(firstDay, lastDate, date, monthName, year) {
//TODO: Clean up JS vars used for styling where practical
    // constant table settings
    var headerHeight = 50; // height of the table's header cell
    var border = 2; // 3D height of table's border
    var cellspacing = 4; // width of table's border
    var headerColor = 'midnightblue'; // color of table's header
    var headerSize = '+3'; // size of tables header font
    var colWidth = 60; // width of columns in table
    var dayCellHeight = 25; // height of cells containing days of the week
    var dayColor = 'darkblue'; // color of font representing week days
    var cellHeight = 40; // height of cells representing dates in the
    // calendar
    var todayColor = 'red'; // color specifying today's date in the calendar
    var timeColor = 'purple'; // color of font representing current time

    // calculate whether we should increment or decrement the year/month
    var monthNum = getMonthNumber(monthName);
    var theYear = parseInt(year);
    var lastYear;
    var nextYear;
    var theMonth = monthNum;
    var lastMonth = monthNum - 1;
    var nextMonth = monthNum + 1;
    if (lastMonth < 0) {
        lastMonth = 11;
        lastYear = parseInt(year, 10) - 1;
    } else if (nextMonth > 11) {
        nextMonth = 0;
        nextYear = parseInt(year, 10) + 1
    }

    // create basic table structure
    var text = ''; // initialize accumulative variable to empty string
    text += '<table class="calendar">'; // table settings
    text += '<th colspan="7">'; // create table header cell
    text += '<a href="?year=' + (isEmpty(lastYear) ? theYear : lastYear) + '&month=' + (isEmpty(lastMonth) ? theMonth : lastMonth) + '"><i class="fas fa-chevron-left"></i></a> &nbsp; '
            + '<span class="calendarMonth">' + monthName + '</span> <span class="calendarYear">' + (isEmpty(theYear) ? year : theYear) + '</span>'
            + '  &nbsp; <a href="?year=' + (isEmpty(nextYear) ? theYear : nextYear) + '&month=' + (isEmpty(nextMonth) ? theMonth : nextMonth) + '"><i class="fas fa-chevron-right"></i></a>';

    text += '</th>'; // close header cell

    // variables to hold constant settings
    var openCol = '<td><span>';
    var closeCol = '</span></td>';

    // create array of abbreviated day names
    var weekDay = new Array(7);
	    weekDay[0] = 'Sunday';
	    weekDay[1] = 'Monday';
	    weekDay[2] = 'Tuesday';
	    weekDay[3] = 'Wednesday';
	    weekDay[4] = 'Thursday';
	    weekDay[5] = 'Friday';
	    weekDay[6] = 'Saturday';

    // create first row of table to set column width and specify week day
    text += '<tr>';
    for (var dayNum = 0; dayNum < 7; ++dayNum) {
        text += '<th class="calendarWeekDay">' + weekDay[dayNum] + '</th>';
    }
    text += '</tr>';

    // declaration and initialization of two variables to help with tables
    var digit = 1;
    var curCell = 1;

    for (var row = 1; row <= Math.ceil((lastDate + firstDay - 1) / 7); ++row) {
        text += '<tr align="right" valign="top">';

        for (var col = 1; col <= 7; ++col) {
            if (digit > lastDate) {
                break;
            }

            if (curCell < firstDay) {
                text += '<td class="calendarEmpty"></td>';
                curCell++;
            } else {
                // current cell represent today's date
                var now = new Date();
                var year = now.getYear();
                if (year < 1000) {
                    year += 1900;
                }
                var curMonth = now.getMonth();
    
                text += '<td id="day-'+digit+'" class="' + ((digit === date && curMonth === monthNum && year === theYear) ? 'calendarCurDay' : 'calendarDay') + '">';
                text += '<a href="dailyview.jsp?date=' + theYear + '-' + ("0" + (monthNum + 1)).slice(-2) + '-' + ("0" + digit).slice(-2) + '">' +  digit + '</a>';
                text += '</td>';

                digit++;
            }
        }
        text += '</tr>';
    }
    // close all basic table tags
    text += '</table>';

    // print accumulative HTML string
    document.getElementById('calendar').innerHTML = text;
}

/**
 * setCal 
 *   Set the current time and date of the Calendar for where to render Calendar from.
 *    
 * @param _year OPTIONAL  passed in year or default to current year
 * @param _month OPTIONAL   passed in month or default to current month
 */
function setCal(_year, _month) {
    // standard time attributes
    var now = new Date();
    var year = _year || now.getYear();
    if (year < 1000) {
        year += 1900;
    }
    var month = _month || now.getMonth();
    var monthName = getMonthName(month);
    var date = now.getDate();

    // create instance of first day of month, and extract the day on which it
    // occurs
    var firstDayInstance = new Date(year, month, 1);
    var firstDay = firstDayInstance.getDay();
    firstDayInstance = null;

    // number of days in current month
    var days = getDays(year, month);

    // call function to draw calendar
    drawCal(firstDay + 1, days, date, monthName, year);
}
