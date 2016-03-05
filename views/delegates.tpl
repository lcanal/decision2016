{{ template "header.html" }}
{{ template "sidemenu.html" }}
<div id="main">
    <div class="header">
        <h1>Committed Delegates</h1>
    </div>
    <div class="content">
    <h1>Total Delegate Counts</h1>  <div id="legendDiv"></div>
      <canvas id="myChart" width="1300" height="550"></canvas>
      <script>
      var data = {
        labels:   [
              {{ with $statecountarray := index $.delegateCountByState "1746" }}
              {{ range $statecount := $statecountarray }}
                "{{ $statecount.SID }}",
              {{end}}
              {{end}}
            ],
    datasets: [
        {
            label: "BERNIE",
            fillColor: "rgba(220,220,220,0.2)",
            strokeColor: "rgba(220,220,220,1)",
            pointColor: "rgba(220,220,220,1)",
            pointStrokeColor: "#fff",
            pointHighlightFill: "#fff",
            pointHighlightStroke: "rgba(220,220,220,1)",
            data: [
            {{ with $statecountarray := index $.delegateCountByState "1445" }}
            {{ range $statecount := $statecountarray }}
              "{{ $statecount.Count }}",
            {{end}}
            {{end}}
            ]
        },
        {
            label: "HILARY",
            fillColor: "rgba(151,187,205,0.2)",
            strokeColor: "rgba(151,187,205,1)",
            pointColor: "rgba(151,187,205,1)",
            pointStrokeColor: "#fff",
            pointHighlightFill: "#fff",
            pointHighlightStroke: "rgba(151,187,205,1)",
            data: [
              {{ with $statecountarray := index $.delegateCountByState "1746" }}
              {{ range $statecount := $statecountarray }}
                "{{ $statecount.Count }}",
              {{end}}
              {{end}}
            ]
        }
    ]
    };

    //legendTemplate takes a template as a string, you can populate the template with values from your dataset
    var options = {
      legendTemplate : '<ul>'
                  +'<% for (var i=0; i<datasets.length; i++) { %>'
                    +'<li>'
                    +'<span style=\"background-color:<%=datasets[i].fillColor%>\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>'
                    +'<% if (datasets[i].label) { %><%= datasets[i].label %><% } %>'
                  +'</li>'
                +'<% } %>'
              +'</ul>'
    }

    var ctx = document.getElementById("myChart").getContext("2d");
    var myLineChart = new Chart(ctx).Line(data, options);
    //generate legend
    document.getElementById("legendDiv").innerHTML = myLineChart.generateLegend();
    </script>
    </div>

</div>
{{ template "footer.html" }}
