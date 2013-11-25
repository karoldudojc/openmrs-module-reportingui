<%
    ui.decorateWith("appui", "standardEmrPage")
    ui.includeJavascript("uicommons", "angular.min.js")
    ui.includeJavascript("reportingui", "adHocAnalysis.js")
    ui.includeCss("reportingui", "runReport.css")
%>

<div class="ad-hock-report" ng-app="adHocAnalysis" ng-controller="AdHocAnalysisController">
    <h1>Patient Ad Hock Report</h1>

    <h3>Timeframe</h3>
    ${ ui.includeFragment("uicommons", "field/datetimepicker", [
        id: "startDate",
        label: "Start Date",
        formFieldName: "startDate",
        useTime: false
    ])}
    ${ ui.includeFragment("uicommons", "field/datetimepicker", [
        id: "endDate",
        label: "End Date",
        formFieldName: "endDate",
        useTime: false
    ])}

    <fieldset>
        <h3>Patient Search</h3>

        <input type="text" id="row-search" placeholder="add search criteria" definitionsearch action="addRow"
               definition-type="org.openmrs.module.reporting.cohort.definition.CohortDefinition" />

        <a class="view-all" href="javascript:void(0)">view all</a>

        <ul>
            <li class="item" ng-repeat="rowQuery in rowQueries">
                <label>{{ \$index + 1 }}.</label>
                {{ rowQuery.name }}
                <span class="actions">
                    <a ng-click="removeRow(\$index)"><i class="icon-remove"></i></a>
                </span>
            </li>
        </ul>
    </fieldset>
    <fieldset>
        <h3>Columns</h3>

        <input type="text" id="column-search" placeholder="add a column" definitionsearch action="addColumn"
               definition-type="org.openmrs.module.reporting.data.patient.definition.PatientDataDefinition" />

        <a class="view-all" href="javascript:void(0)">view all</a>

        <ul>
            <li class="item" ng-repeat="col in columns">
                <label>
                    {{ \$index + 1 }}.
                </label>
                {{ col.name }}

                <span class="actions">
                    <a ng-hide="\$first" ng-click="moveColumnUp(\$index)">Move up</a>
                    <a ng-hide="\$last" ng-click="moveColumnDown(\$index)">Move down</a>
                    <a ng-click="removeColumn(\$index)">X</a>
                </span>
            </li>
        </ul>
    </fieldset>

    <button ng-click="preview()">Preview</button>

    <div ng-show="results">
        <label>
            Preview of {{ results.allRows.length }} results
        </label>

        <table>
            <thead>
                <tr>
                    <th ng-repeat="colName in results.columnNames">{{ colName }}</th>
                </tr>
            </thead>
            <tbody>
                <tr ng-repeat="row in results.data">
                    <td ng-repeat="col in row">{{ col }}</td>
                </tr>
            </tbody>
        </table>

        <button class="confirm" ng-click="preview()">Download Report</button>
    </div>
</div>

<div id="search-criteria-dialog" class="dialog" style="display: none">
    <div class="dialog-header">
        <h3>Select a search criteria to add</h3>
    </div>
    <div class="dialog-content form">
        <p>

        </p>
    </div>
</div>

<script type="text/javascript">
    viewAllDialog = null;

    jq(function() {
        viewAllDialog = emr.setupConfirmationDialog({
            selector: '#search-criteria-dialog'
        });
    });

    jq('.view-all').click(function() {
        viewAllDialog.show();
    })
</script>