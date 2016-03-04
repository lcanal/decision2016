{{ template "header.html" }}
{{ template "sidemenu.html" }}

<!-- Do a count first -->

<div id="main">
    <div class="header">
        <h1>Commited Delegates</h1>
        <h2>By Party</h2>
    </div>
    <div class="content">
      <h1>Total Delegate Counts</h1>
      <table class="pure-table">
        <thead>
          <tr>
            <th>Candidate</th>
            <th>Total Delegates</th>
          </tr>
        </thead>
        <tbody>
          {{ range $cid,$dtotal := .totalDelsByCand }}
          <tr class="pure-table-odd">
            <td> {{ $cid }}</td>
            <td> {{ $dtotal }}</td>
          </tr>
          {{end}}
      </tbody>
    </table>

    </div>
</div>
{{ template "footer.html" }}
