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
var event_color = ["#1f77b4", "#aec7e8", "#ff7f0e", "#ffbb78", "#2ca02c", "#98df8a", 
                          "#d62728", "#ff9896", "#9467bd", "#c5b0d5", "#8c564b", "#c49c94", 
                          "#e377c2", "#f7b6d2", "#7f7f7f", "#c7c7c7", "#bcbd22", "#dbdb8d", 
                          "#17becf", "#9edae5"];
                          
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
    for (var i = 0; i < event_at_day.length; i++) {
        for (var j = event_at_day[i].start * 2; j < event_at_day[i].end * 2; j++) {
            time_table[j]++;
        }
    }

    for (var i = 0; i < event_at_day.length; i++) {
        temp = 0;
        for (var j = event_at_day[i].start * 2; j < event_at_day[i].end * 2; j++) {
            //temp += isconcurr(event_at_day[i].start, event_at_day[i].end, event_at_day[j].start, event_at_day[j].end);
            if (temp < time_table[j])
                temp = time_table[j];
            //alert(event_at_day[i].start + "," + event_at_day[i].end + "," + event_at_day[j].start + "," + event_at_day[j].end + "," + temp);
            
        }
        //alert(temp);
        concurr.push(temp);
    }
    return concurr;
}
function event_show_position(event_at_day, event_concur) {
    var posi = new Array();
    var i, j;
    for (i = 0; i < event_at_day.length; i++) {
        var posi_occupied = new Array();
        for (j = 0; j < i; j++) {
            if (isconcurr(event_at_day[i].start, event_at_day[i].end, event_at_day[j].start, event_at_day[j].end))
                posi_occupied.push(posi[j]);
        }
        //least_not_occupied;
        for (j = 0; j < event_concur[i]; j++) {
            if (posi_occupied.length == 0) {
                posi.push(0);
                break;
            }
            if (posi_occupied.indexOf(j) == -1) {
                posi.push(j);
                break;
            }

        }
    }
    return posi;
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

function event_position_new(event_at_day) {
    //init
    //sort by start time
    var i, j;
    var event_posi = new Array();
    if (event_at_day.length == 0)
        return event_posi;
    var posi_rec = new Array();
    event_at_day.sort(function (x, y) { return x.start - y.start; });
    //setup record system
    var colume_event_rec = new Array(event_at_day.length + 1);
    var event_block_rec = new Array(event_at_day.length + 1);
    var block_member = new Array(event_at_day.length + 1);
    var block_width = new Array(event_at_day.length + 1);
    var event_block_end = 1;
    

    for (i = 0; i < event_at_day.length; i++) {

        var temp = new Object();
        temp = { block_no: -1, colum_no: -1 };
        posi_rec.push(temp);

        temp = new Object();
        temp = { block_length: -1, colum_no: -1 };
        event_posi.push(temp);
        
        temp = new Array();
        colume_event_rec[i] = temp;

        temp = new Array();
        block_member[i] = temp;
        block_width[i] = 0;


    }

    var current_block=-1;//first is 0
    for (i = 0; i < event_at_day.length; i++) {//for each event
        //find the leftmost availavle position
        for (j = 0; j < event_at_day.length; j++) {
            var atemp = colume_event_rec[j];
            if (atemp.length == 0) {
                break;
            }
             
            if (atemp[colume_event_rec[j].length-1].the_event.end <= event_at_day[i].start) {
                break;
            }
            

            ////if is not blocked from right side
            //if (colume_event_rec[j + 1].length != 0) {
            //    if (colume_event_rec[j + 1][colume_event_rec[j + 1].length - 1].endtime >= event_at_day.starttime) {
                    
            //    }
            //}
        }
        if (j == 0) {
            current_block++;
        }
        var colume_event_rec_unit = new Object();
        colume_event_rec_unit = { the_event: event_at_day[i], event_at_day_posi: i };
        colume_event_rec[j].push(colume_event_rec_unit);
        posi_rec[i].block_no = current_block;
        posi_rec[i].colum_no = j;
        block_width[current_block] = Math.max(block_width[current_block], j+1);
        block_member[current_block].push(i);
    }
    //for (i = 0; i <= current_block; i++) {
    //    block_width[i] = block_member[i].length;
    //}
    var needchange = 0;
    var needchangeto = 0;
    for (i = 1; i <= current_block; i++) {
        for (j = 0; j < block_member[i].length; j++) {
            var idx = block_member[i][j];
            if (colume_event_rec[posi_rec[idx].colum_no + 1].length == 0)
                break;
            for (var k = 0; k < colume_event_rec[posi_rec[idx].colum_no + 1].length; k++) {
                if (colume_event_rec[posi_rec[idx].colum_no + 1][k].the_event.end > event_at_day[idx].start && posi_rec[colume_event_rec[posi_rec[idx].colum_no + 1][k].event_at_day_posi].block_member < i) {
                    needchange = 1;
                    needchangeto = posi_rec[colume_event_rec[posi_rec[idx].colum_no + 1][k].event_at_day_posi].block_no;
                    block_width[needchangeto]=Math.max(block_width[needchangeto],block_width[i]);
                    break;
                }
            }
            if (needchange)
                break;
        }
        if (needchange) {
            for (j = 0; j < block_member[i].length; j++) {
                block_member[needchangeto].push(block_member[i][j]);
                posi_rec[block_member[i][j]].block_no = needchangeto;
            }
            block_member[i].length = 0;
            needchange = 0;
        }
    }
    //find the total number of colums
    
    for (i = 0; i < event_at_day.length; i++) {
        event_posi[i].block_length = block_width[posi_rec[i].block_no];
        event_posi[i].colum_no = posi_rec[i].colum_no;
    }
    return event_posi;
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
var current_pageid=0;
function add_submit(desp, group_button) {
    //update current calender
    var time_rec = new String();
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
                    new_event_group = new String();
                    for (var j = 0; j < group.length; j++) {
                        if (group_button[j] == 1) {
                            new_event_group += group[j];
                            new_event_group += ";"
                        }
                    }
                    if (group_button[j] == 1)
                        new_event_group += "private;";

                    if(desp=="")
                        desp="(Untitled)"
                    new_event.desp = desp;
                    new_event.group = new_event_group;
                    new_event.weekday = i;

                    new_event.eventsid=max_esid+1
                    max_esid=max_esid+1

                    new_event.start = add_day[i - 1][period_start] / 2;
                    new_event.end = add_day[i - 1][period_end] / 2 + 0.5;
                    period_start = period_end + 1;
                    period_end = period_end + 1;

                    time_rec += new_event.weekday + "," + new_event.start + "," + new_event.end + ";";
                    events.push(new_event);

                }

            }
            else {

                new_event = new Object();
                new_event_group = new String();
                for (var j = 0; j < group.length; j++) {
                    if (group_button[j] == 1) {
                        new_event_group += group[j];
                        new_event_group += ";"
                    }
                }
                if (group_button[j] == 1)
                    new_event_group += "private;";
                
                if(desp=="")
                    desp="(Untitled)"
                new_event.desp = desp;
                new_event.group = new_event_group;
                new_event.weekday = i;
                new_event.eventsid=max_esid+1
                max_esid=max_esid+1
                new_event.start = add_day[i - 1][period_start] / 2;
                new_event.end = add_day[i - 1][period_end] / 2 + 0.5;
                period_start = 0;
                period_end = 0;
                time_rec += new_event.weekday + "," + new_event.start + "," + new_event.end + ";";
                events.push(new_event);
                break;
            }


        }
     
        //save back to the database
        //new_event = new Object();
        //new_event.desp = desp;
        //new_event.group = group;
        //new_event.time
        //submit to database
        //return encoded group and encoded time

    }
    add_event_clean();
    
    var rec = new Object();
    rec = { t: time_rec, g: new_event_group };
    return rec;

}    
function add_event_clean() {
    
    var i;
    for (i = 0; i < 7; i++) {
        add_day[i].length = 0;
    }
}


//==================================================draw
