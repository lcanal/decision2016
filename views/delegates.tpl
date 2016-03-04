{{ template "header.html" }}
{{ template "sidemenu.html" }}
<div id="main">
    <div class="header">
        <h1>Commited Delegates</h1>
        <h2>By Party</h2>
    </div>
    <div class="content">
      {{ range .committedDelegates }}
      <h2>{{ .PID }}</h2>
        {{ range .State }}
        <h3>{{ .SID }}</h2>
        <table class="pure-table">
          <thead>
              <tr>
                  <th>Name</th>
                  <th>Total Delegates</th>
              </tr>
          </thead>

          <tbody>
            {{ range .Cand }}
              <tr class="pure-table-odd">
                  <td>{{ .CName }}</td>
                  <td>{{ .DTot }}</td>
              </tr>
            {{end}}
          </tbody>
      {{end}} <!-- //State -->
      {{end}} <!-- //commmitedDelegates -->

    </div>
</div>
{{ template "footer.html" }}
