{{ template "header.html" }}
{{ template "sidemenu.html" }}

<!-- Do a count first -->

<div id="main">
    <div class="header">
        <h1>Commited Delegates</h1>
        <h2>By Party</h2>
    </div>
    <div class="content-data">
      <h1>Total Delegate Counts</h1>
      <table class="pure-table">
        <thead>
          <tr>
            <th>Candidate</th>
            <th>Total</th>
            {{  with $headerStateArray := index $.delegateCountByState "36679" }}
              {{ range $state := $headerStateArray  }}
                <th>{{ $state.SID }}</th>
              {{end}} <!--end -->
            {{end}} <!--end with-->
          </tr>
        </thead>
        <tbody>
          {{ range $cid,$dtotal := .totalCommittedDelegates }}
            {{ if $dtotal }}
              <tr class="pure-table-odd">
              <td> {{ index $.cidToCName $cid }}</td>
              <td> {{ $dtotal }}</td>
              {{ with $statecountarray := index $.delegateCountByState $cid }}
                {{ range $statecount := $statecountarray  }}
                    <!-- <td>{{ $statecount.SID }}</td> -->
                    <td>{{ $statecount.Count }}</td>
                {{end}} <!-- range statecount -->
              {{end}} <!-- with statecountarray -->
              </tr>
            {{end}} <!-- if -->
         {{end}} <!-- range totalCommittedDelegates -->
      </tbody>
    </table>
    </div>
</div>
{{ template "footer.html" }}
