/*

HTCondorView

SIMPLE USAGE:

	<script>
	HTCondorView.simple("url=submitters.now.json&title=Total Jobs&order=JobStatus&group=JobStatus;Count&chart=pie");
	</script>

This will insert a <div> whereever the script appears and place a chart inside, as described by the single argument which is an Afterquery query.  The <div> will have a class of "HTCondorViewSimple" and a unique, arbitrary ID.

Returns an HTCondorView object, which is not currently useful.


COMPLEX USAGE:

	<div id="myexample"></div>

	<script>
	new HTCondorView({
			dst_id: "myexample",
			data_url: "submitters.json",
			graph_query: "order=Date&pivot=Date;JobStatus;Count&chart=stacked",
			title: "Total Jobs",
			table_query: "order=Date&pivot=Name;JobStatus;avg(Count)",
			select_tuple: ["Name"],
			has_fullscreen_link: true
		});
	</script>

dst_id - The chart will be placed inside the <div> or other element with this id.  Previous contents will be destroyed.

data_url - URL, possibly relative, to the data to be loaded.

graph_query - Afterquery query, but not including the title or url entries.  This is the chart to display.

title - Optional. A title to display with the chart.

table_query - Optional. Afterquery query, not including title or url entries.  This specifies a second chart to display.  Probably should be a simple table (that is, don't specify "chart").  If not present, no second chart is present.

select_tuple - Optional. If table_query is present and is a table, when a user clicks on a row in the table, these fields will be extracts from the selected row and used to filter the graph specified in graph_query.

has_fullscreen_link: true/false - Optional. Defaults to true. If false (and exactly false, not 0), the link to show the graph fullscreen will be suppressed.


*/


function HTCondorView(id, url, graph_args, options) {
	"use strict";
	var that = this;
	$(document).ready(function() { that.initialize(id,url,graph_args,options); });
}

HTCondorView.simple = function(query, thisclass) {
	var newid = HTCondorView.prototype.new_graph_id();
	if(thisclass === null || thisclass === undefined) { 
		thisclass = "HTCondorViewSimple";
	}
	var tag = '<div id="'+newid+'" class="'+thisclass+'"></div>';
	document.write(tag);
	return new HTCondorView(newid, query);
};

HTCondorView.prototype.initialize_from_object = function(options) {
	"use strict";

	if(typeof(options) !== 'object') { options = {}; }

	var id = options.dst_id;
	var url = options.data_url;
	var graph_args = options.graph_query;
	var table_args = options.table_query;
	var select_tuple = options.select_tuple;
	this.urlTool = document.createElement('a');
	var mythis = this;
	var i;

	this.original_title = options.title;
	this.title = options.title;
	this.url = url;

	var container = $('#'+id);
	if(container.length === 0) {
		console.log('HTCondor View is not able to intialize. There is no element with an ID of "'+id+'".');
		return false;
	}
	container.empty();

	var has_fullscreen_link = true;
	if(options.has_fullscreen_link === false) {
		has_fullscreen_link = false;
	}
	var starting_elements = this.starting_elements({
		has_table: !!table_args,
		has_fullscreen_link: has_fullscreen_link
	});
	container.append(starting_elements);
	this.graph_fullscreen_link = $('#'+this.graph_fullscreen_id);
	this.graph_edit_link = $('#'+this.graph_edit_id);

	this.table_fullscreen_link = $('#'+this.table_fullscreen_id);
	this.table_edit_link = $('#'+this.table_edit_id);

	$('.download-link').click(function(ev) { mythis.download_csv(mythis.data.value); ev.preventDefault();});


	//this.change_view()
	this.starting_graphargs = graph_args;
	this.set_graph_query(graph_args);
	this.set_table_query(table_args);
	if(select_tuple) {
		this.select_tuple = {};
		for(i = 0; i < select_tuple.length; i++) {
			this.select_tuple[select_tuple[i]] = true;
		}
	}
	this.load_and_render(this.current_graphargs, this.current_tableargs);
};

HTCondorView.prototype.initialize = function(id, query) {
	"use strict";

	if(typeof(id) === 'object') {
		return this.initialize_from_object(id);
	}

	// This is a (hopefully) a raw afterquery query.
	var args = afterquery.parseArgs(query);
	var options = {
		dst_id: id,
		title: args.get("title"),
		data_url: args.get("url"),
		graph_query: "",
	};

	for(var argi in args.all) {
		var arg = args.all[argi];
		var key = arg[0];
		if(key.length && key !== "title" && key !== "url") {
			var val = arg[1];
			options.graph_query += encodeURIComponent(key) + "=" + encodeURIComponent(val) + "&";	
		}
	}
	return this.initialize_from_object(options);
};

HTCondorView.next_graph_id = 0;

HTCondorView.prototype.new_graph_id = function() {
	"use strict";
	HTCondorView.next_graph_id++;
	var new_id = "htcondorview-private-" + HTCondorView.next_graph_id;
	return new_id;
};

HTCondorView.prototype.set_graph_query = function(graph_query) {
	this.current_graphargs = graph_query;
	var search = '?';
		if(this.title) {
			search += "title=" + encodeURIComponent(this.title) + "&";	
		}
		search += "data_url=" + encodeURIComponent(this.url) + "&";	
		search += "graph_query=" + encodeURIComponent(this.current_graphargs) + "&";	
	if(this.graph_fullscreen_link) {
		this.graph_fullscreen_link.attr('href', "fullscreen.html" + search);
	}

	if(this.graph_edit_link) {
		this.graph_edit_link.attr('href', "edit.html" + search);
	}
};

HTCondorView.prototype.set_table_query = function(table_query) {
	this.current_tableargs = table_query;
	var search = '?';
		if(this.title) {
			search += "title=" + encodeURIComponent(this.title) + "&";	
		}
		search += "data_url=" + encodeURIComponent(this.url) + "&";	
		search += "graph_query=" + encodeURIComponent(this.current_tableargs) + "&";	
	if(this.table_fullscreen_link) {
		this.table_fullscreen_link.attr('href', "fullscreen.html" + search);
	}

	if(this.table_edit_link) {
		this.table_edit_link.attr('href', "edit.html" + search);
	}
};

HTCondorView.prototype.toggle_edit = function(btn, controls) {
	"use strict";
	$(controls).toggle();
	if($(controls).is(":visible")) {
		$(btn).text("❌");
	} else {
		$(btn).text("edit");
	}
};


HTCondorView.prototype.replace_search_arg = function(oldurl, newkey, newval) {
	"use strict";
	this.urlTool.href = oldurl;
	var oldsearch = this.urlTool.search;
	var args = afterquery.parseArgs(oldsearch);
	var newsearch = "?";
	for(var argi in args.all) {
		var arg = args.all[argi];
		var key = arg[0];
		if(key.length && key != newkey) {
			var val = arg[1];
			newsearch += encodeURIComponent(key) + "=" + encodeURIComponent(val) + "&";	
		}
	}
	if(newval !== undefined) {
		newsearch += encodeURIComponent(newkey) + "=" + encodeURIComponent(newval);	
	}
	this.urlTool.search = newsearch;
	return this.urlTool.href;
};


HTCondorView.prototype.load_and_render = function(graphargs, tableargs) {
	"use strict";

	var mythis = this;
	var callback_render_table = function() {
		$('#'+mythis.table_id+' .vizchart').empty();
		setTimeout(function() {
			var options = {
				select_handler: function(e,t,d){ mythis.table_select_handler(e,t,d); },
				num_pattern: '#,##0.0',
				disable_height: true
			};

			var query = "url="+mythis.url+"&"+tableargs;
			afterquery.render(query, mythis.data.value, null, mythis.table_id, options);
		}, 0);
	 };
	if(tableargs === this.last_tableargs) { callback_render_table = null; }
	if(!tableargs) { callback_render_table = null; }
	this.last_tableargs = tableargs;

	var callback_render_graph = function(){
		$('#'+mythis.graph_id+' .vizchart').empty();
		setTimeout(function() {
			var query = "url="+mythis.url+"&"+graphargs;
			if(mythis.title) {
				query += "&title="+ encodeURIComponent(mythis.title);
			}
			afterquery.render(query, mythis.data.value, callback_render_table, mythis.graph_id);
			},0);
		};

	if(!graphargs) {
		if(callback_render_table) {
			callback_render_graph = callback_render_table; 
		} else {
			return; // Nothing to do.
		}
	}

	var args = "url="+mythis.url+"&"+graphargs;
	var newurl = afterquery.parseArgs(args).get('url');
	if(newurl == this.data_url) {
		callback_render_graph();
	} else {
		this.data_url = newurl;
		this.data = afterquery.load(args, null, function(){
			callback_render_graph();
			}, this.graph_id);
	}
};

HTCondorView.prototype.table_select_handler = function(evnt,table,data) {
	"use strict";
	var selection = table.getSelection();
	if(!selection) { return; }

	var col;
	var filter = "";

	var row = selection[0].row;

	this.title = this.original_title + " for ";
	var first_tuple = true;

	for(col = 0; col < data.getNumberOfColumns(); col++) {
		var label = data.getColumnLabel(col);
		if(this.select_tuple[label]) {
			var value = data.getValue(row, col);
			filter += "filter=" + label + "=" + value + "&";
			if(!first_tuple) { this.title += "/"; }
			first_tuple = false;
			this.title += value;
		}
	}

	this.set_graph_query(filter + this.starting_graphargs);

	this.load_and_render(this.current_graphargs, this.current_tableargs);
};

HTCondorView.prototype.html_for_graph = function() {
	"use strict";
	return "" +
		"<div class='vizstatus'>\n" +
		"  <div class='statustext'></div>\n" +
		"  <div class='statussub'></div>\n" +
		"</div>\n" +
		"<div class='vizraw'></div>\n" +
		"<div class='vizchart'></div>\n";
};

HTCondorView.prototype.starting_elements = function(options) {
	"use strict";

	var has_table = options.has_table;
	var has_fullscreen_link = options.has_fullscreen_link;

	this.graph_id = this.new_graph_id();
	this.table_id = this.new_graph_id();
	this.graph_fullscreen_id= this.new_graph_id();
	this.graph_edit_id= this.new_graph_id();

	this.table_fullscreen_id= this.new_graph_id();
	this.table_edit_id= this.new_graph_id();

	function editmenu(fullscreen_id, edit_id) {
		var editmenu = "<div class='editmenu'>\n";
		if(has_fullscreen_link) {
			editmenu += "<a href='#' id='"+fullscreen_id+"' class=\"editlink\">full screen</a><br>\n";
		}
		editmenu += "<a href='#' id='"+edit_id+"' class=\"editlink\">edit</a>\n";
		editmenu += "</div>\n";
		return editmenu;
	}


	var ret = "" +
		'<div class="htcondorview">\n' +
		  "<div id='"+this.graph_id+"' class='graph'>\n" +
			editmenu(this.graph_fullscreen_id, this.graph_edit_id) +
	        this.html_for_graph() + "\n"+
		  "</div>\n";
	if(has_table) {
		ret += "<div class=\"download-link\"> <a href=\"#\">Download this table</a> </div>\n" +
			"<div id='"+this.table_id+"' class='table'>\n" +
			editmenu(this.table_fullscreen_id, this.table_edit_id) +
			this.html_for_graph()+ "\n" +
			"</div>\n";
	}
	ret += "</div>\n";

	var element = $(ret);

	return element;
};


HTCondorView.prototype.afterquerydata_to_csv = function(dt) {
	"use strict";
	function csv_escape(instr) {
		instr = "" + instr;
		if((instr.indexOf('"') == -1) &&
			(instr.indexOf(',') == -1) &&
			(instr.charAt[0] != ' ') &&
			(instr.charAt[0] != "\t") &&
			(instr.charAt[instr.length-1] != " ") &&
			(instr.charAt[instr.length-1] != "\t"))
		{
			// No escaping necessary
			return instr;
		}
		instr = instr.replace(/"/g, '""');
		return '"' + instr + '"';
	}
	var ret = '';
	var columns = dt.headers.length;
	var rows = dt.data.length;

	var col;

	for(col = 0; col < columns; col++) {
		if(col > 0) { ret += ","; }
		ret += csv_escape(dt.headers[col]);
	}
	ret += "\n";

	for(var row = 0; row < rows; row++) {
		for(col = 0; col < columns; col++) {
			if(col > 0) { ret += ","; }
			var val = dt.data[row][col];
			if(typeof(val) === 'number' && isNaN(val)) {
				val = '';
			}
			ret += csv_escape(val);
		}
		ret += "\n";
	}

	return ret;
};

HTCondorView.prototype.download_data = function(filename, type, data) {
	"use strict";
	var link = document.createElement('a');
	link.download = filename;
	link.href = "data:"+type+";charset=utf-8,"+encodeURIComponent(data);
	document.body.appendChild(link);
	link.click();
	document.body.removeChild(link);
};

HTCondorView.prototype.download_csv = function(data) {
	"use strict";
	var mythis = this;
	var handle_csv = function() {
		var csv = mythis.afterquerydata_to_csv(mythis.csv_source_data.value);
		mythis.csv_source_data = undefined;
		mythis.download_data("HTCondor-View-Data.csv", "text/csv", csv);
	};
	this.csv_source_data = afterquery.load_post_transform(this.current_tableargs, data, handle_csv, null);
};



