//var test = new Array();
//test[0] = "ok";
//function init() {
    
    
//}
//function get_test() {
//    test[0] = "ok";
//  //  return test[0];
//}
//basic library function
function time_slot(n, format) {
    if (n % 2 == 0)
        return (n / 2 + ":" + "00");
    else
        return ((n / 2 - 0.5) + ":" + "30");

}
function time_grid(time) {
    //this time is using decimal e.g. 10.5
    return time / 0.5 - 1;

}
//initialization
var group = new Array();
var events = new Array();

function get_group() {
    //read from the database

    //for test
    group.push("Jpop");
    group.push("cs290");
    group.push("CSSA");
    //end test
}
function get_event(userid) {
    //read the database

    //e.g.
    var event1 = { desp: "group meeting", weekday: 1, start: 10.0, end: 10.5, place: "HFH", cata: "cs290" };
    var event2 = { desp: "group meeting", weekday: 2, start: 10.0, end: 12.5, place: "HFH", cata: "cs290" };
    var event3 = { desp: "eating", weekday: 2, start: 11.0, end: 12.5, place: "HFH", cata: "private" };
    events.push(event1);
    events.push(event2);
    events.push(event3);
    
}

function get_event_by_day(weekday) {//filter and sort by start time
    var event_at_day = new Array();
    //filter
    for (var i = 0; i < events.length; i++)
        if (events[i].weekday == weekday)
            event_at_day.push(events[i]);

    //sort
    //var temp;
    //for(var i=0;i<event_at_day.length;i++)
    //    for (var j = 0; j < event_at_day.length - i - 1; j++) {
    //        if (event_at_day[j].start > event_at_day[event_at_day.length - i - 1]) {
    //            temp = event_at_day[j].start;
    //            event_at_day[j].start = event_at_day[event_at_day.length - i - 1];
    //            event_at_day[event_at_day.length - i - 1] = event_at_day[j].start;
    //        }
    //    }

    return event_at_day;
}
function isconcurr(start1, end1, start2, end2) {
    if (start2 >= end1 || start1 >= end2)
        return 0;
    return 1;
}
function event_concurrency(event_at_day) {
    //var event_at_day = get_event_by_day(weekday);
    var concurr = new Array();
    var temp;
    var time_table = new Array();
    for (var i = 0; i < 48; i++) {
        temp = 0;
        time_table.push(temp);
    }
    //init day hour occupy
    //for (var i = 0; i < event_at_day.length; i++) {
    //    for(var j=event_
    //}
    for (var i = 0; i < event_at_day.length; i++) {
        temp = 0;
        for (var j = 0; j < event_at_day.length; j++) {
            temp += isconcurr(event_at_day[i].start, event_at_day[i].end, event_at_day[j].start, event_at_day[j].end);
            //alert(event_at_day[i].start + "," + event_at_day[i].end + "," + event_at_day[j].start + "," + event_at_day[j].end + "," + temp);
            
        }
        //alert(temp);
        concurr.push(temp);
    }
    return concurr;
}

function event_sorted_today(event_at_day, event_concur) {
    //classify by concurrency
    if(event_at_day.length==0)
        return event_at_day;
    var temp;
    var event_at_day_classified = new Array();
    var event_classified_concur = new Array();
    var i=0, concur0,j;
    event_classified_concur = event_concur;
    event_classified_concur = event_classified_concur.sort(function (a, b) { return a - b; });

    //classify
    concur0 = event_classified_concur[i];
    while (i < event_concur.length) {
        for (j = 0; j < event_at_day.length; j++) {
            if (event_concur[j] == concur0)
                event_at_day_classified.push(event_at_day[j]);
        }
        //move to the next;
        while (i < event_concur.length) {
            if (event_classified_concur[i] != concur0) {
                concur0 = event_classified_concur[i];
                break;
            }
            i++;
        }
    }


    //sort by starting time
    i = 0; j = 0;//i start j end
    var k,l;
    concur0 = event_classified_concur[i];
    while (true) {
        //get sorting interval
        for (j = i; j < event_classified_concur.length; j++) {
            if (event_classified_concur[j] != concur0) {
                event_classified_concur[j] = concur0
                j--;
                break;
            }

        }
        //sorting
        for (k = i; k < j; k++) {
            for (l = i; l < j - (k - i) - 1; l++) {
                if (event_at_day_classified[l].start > event_at_day_classified[j - (k - i) - 1].start) {
                    temp = event_at_day_classified[j - (k - i) - 1];
                    event_at_day_classified[j - (k - i) - 1] = event_at_day_classified[l];
                    event_at_day_classified[l] = temp;
                }
            }
        }
        i = j + 1;
        if (i >= event_classified_concur.length)
            break;
    }
    return event_at_day_classified;
}





var add_day = new Array();
var add_group = new Array();
function add_init()
{
    var i;
    for(i=0;i<7;i++)
    {
        add_day[i] = new Array();
    }
}
function add_event(d, h) {
    var i;
    if (add_day[d - 1].indexOf(h) == -1)
        add_day[d - 1].push(h);
}
//test
function add_time_desp() {
    var desp = "";
    var i, j;
    for (i = 0; i < 7; i++)
        for (j = 0; j < add_day[i].length; j++)
            desp = desp + "(" + (i + 1) + "," + time_slot(add_day[i][j],0) + ")";
    return desp;
    
}
//end test
function add_submit(desp,group_button) {
    //submit to database
    
    //update current calender
    for (var i = 1; i <= 7; i++) {
        var today_time = add_day[i - 1].sort(function (a, b) { return a - b; });
        
        //group and save
        var period_start = 0;
        var period_end = 0;
        while (period_end < add_day[i - 1].length) {
            if (period_end != add_day[i - 1].length - 1) {
                if (add_day[i - 1][period_end] == add_day[i - 1][period_end + 1] - 1)
                    period_end++;
                else {
                    new_event = new Object();
                    new_event.desp = desp;
                    new_event.group = group_button;
                    new_event.weekday = i;
                    new_event.start = add_day[i-1][period_start] / 2;
                    new_event.end = add_day[i - 1][period_end] / 2+0.5;
                    period_start = period_end + 1;
                    period_end = period_end + 1;
                    events.push(new_event);
                }
            }
            else {
                new_event = new Object();
                new_event.desp = desp;
                new_event.group = group_button;
                new_event.weekday = i;
                new_event.start = add_day[i - 1][period_start] / 2;
                new_event.end = add_day[i - 1][period_end] / 2+0.5;
                period_start = 0;
                period_end = 0;
                events.push(new_event);
                break;
            }

        }
        //save back to the database
        //new_event = new Object();
        //new_event.desp = desp;
        //new_event.group = group;
        //new_event.time
    }
    
    add_event_clean();
}
function add_event_clean() {
    
    var i;
    for (i = 0; i < 7; i++) {
        add_day[i].length = 0;
    }
}


//==================================================draw
