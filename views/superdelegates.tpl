{{ template "header.html" }}
{{ template "sidemenu.html" }}


<div id="main">
    <div class="header">
        <h1>Super Delegates <!--({{ $.superDelegateTotal }} total)--> by State</h1>
    </div>
    <div class="content">
    <div id="legendDiv"></div>
      <canvas id="myChart" width="1000" height="550"></canvas>
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
            label: "SANDERS - {{ index .totalCommittedDelegates "1445"}}",
            fillColor: "rgba(150,204,195,0.5)",
            strokeColor: "rgba(150,204,195,1)",
            pointColor: "rgba(150,204,195,1)",
            pointStrokeColor: "#fff",
            pointHighlightFill: "#fff",
            pointHighlightStroke: "rgba(150,204,195,1)",
            data: [
            {{ with $statecountarray := index $.delegateCountByState "1445" }}
            {{ range $statecount := $statecountarray }}
              "{{ $statecount.Count }}",
            {{end}}
            {{end}}
            ]
        },
        {
            label: "CLINTON - {{ index .totalCommittedDelegates "1746"}}",
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
        },
        {
            label: "TRUMP - {{ index .totalCommittedDelegates "8639"}}",
            fillColor: "rgba(206,50,26,0.2)",
            strokeColor: "rgba(206,50,26,1)",
            pointColor: "rgba(206,50,26,1)",
            pointStrokeColor: "#fff",
            pointHighlightFill: "#fff",
            pointHighlightStroke: "rgba(206,50,26,1)",
            data: [
              {{ with $statecountarray := index $.delegateCountByState "8639" }}
              {{ range $statecount := $statecountarray }}
                "{{ $statecount.Count }}",
              {{end}}
              {{end}}
          ]
        },
        {
            label: "CRUZ - {{ index .totalCommittedDelegates "61815"}}",
            fillColor: "rgba(189,133,219,0.2)",
            strokeColor: "rgba(189,133,219,1)",
            pointColor: "rgba(189,133,219,1)",
            pointStrokeColor: "#fff",
            pointHighlightFill: "#fff",
            pointHighlightStroke: "rgba(189,133,219,1)",
            data: [
              {{ with $statecountarray := index $.delegateCountByState "61815" }}
              {{ range $statecount := $statecountarray }}
                "{{ $statecount.Count }}",
              {{end}}
              {{end}}
          ]
        },
        {
            label: "RUBIO - {{ index .totalCommittedDelegates "53044"}}",
            fillColor: "rgba(214,155,19,0.2)",
            strokeColor: "rgba(214,155,19,1)",
            pointColor: "rgba(214,155,19,1)",
            pointStrokeColor: "#fff",
            pointHighlightFill: "#fff",
            pointHighlightStroke: "rgba(214,155,19,1)",
            data: [
              {{ with $statecountarray := index $.delegateCountByState "53044" }}
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
                    +''
                    +'<span style=\"background-color:<%=datasets[i].fillColor%>\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>'
                    +'<% if (datasets[i].label) { %><%= datasets[i].label %><% } %>'
                  +'&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'
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
