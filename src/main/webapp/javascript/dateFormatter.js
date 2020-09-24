/**
 * formatDate
 * 
 * @param {type} dateElement
 * @returns {undefined}
 */
function formatDate(dateElement) {
    //Getting the date from the HTML document
    var passedInDate = dateElement.innerText;
    console.log("The inner content is: " + passedInDate);
    var passedInYear = passedInDate.split("-")[0];
    var passedInMonth = passedInDate.split("-")[1] - 1; //month is always a "zero-based" index, so subtract one
    var passedInDay = passedInDate.split("-")[2];
    //converting the string to a date
    let date = new Date(passedInYear, passedInMonth, passedInDay);
    console.log("The raw JS Date: " + date);


    //Getting the year
    year = date.getFullYear()
    console.log("Year: " + year);


    //Getting the name of the month from the getMonth() Function and using an array of the days
    month = date.getMonth();
    var months = [
            "January",
            "February",
            "March",
            "April",
            "May",
            "June",
            "July",
            "August",
            "September",
            "October",
            "November",
            "December"
    ]
    console.log("Month: " + months[month]);


    //Getting the name of the day of the week from the getDate() Function and using an array of the days
    weekday = date.getDay();
    var weekdays = [
            "Sunday",
            "Monday",
            "Tuesday",
            "Wednesday",
            "Thursday",
            "Friday",
            "Saturday"
    ]
    console.log("Date of week: " + weekday);


    //Get the Day of the month
    var endDate = getDays(year, month);
    console.log("End Date: " + endDate);
    day = date.getDate();
    console.log("Pre-Formatted Date of month: " + day);
    if(day > endDate || date !== 1){
            day = date.getDate(); 
    }else{
            day = date.getDate() + 1; //0 Based index so we must add 1 to the date
    }
    console.log("Post Formatted Date of month: " + day);

    //Creating the Ordinal Indicator
    switch (day){
            case 1:
                    var ordinalIndicator = "st";
                    break;

            case 21:
                    var ordinalIndicator = "st";
                    break;

            case 31:
                    var ordinalIndicator = "st";
                    break;

            case 2:
                    var ordinalIndicator = "nd";
                    break;

            case 22:
                    var ordinalIndicator = "nd";
                    break;

            case 3:
                    var ordinalIndicator = "rd";
                    break;

            case 23:
                    var ordinalIndicator = "rd";
                    break;

            default:
                    var ordinalIndicator = "th";
                    break;
    }
    
    //Putting all the parts together in a single variable 
    return (weekdays[weekday] + ', ' + months[month] + ' ' + day + ordinalIndicator + ', ' + year);
}

//Inserting the date back into the html
var dateElement = document.getElementById("date");
dateElement.innerHTML = formatDate(dateElement);
