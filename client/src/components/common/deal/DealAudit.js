import React from 'react';

const DealAudit = (props) => {
    let items;
    if (props.audit) {
        var sorted = props.audit.sort(function (a, b) {
            return a.ID - b.ID;
        });

        items = sorted.map(item => {
            let id = item.ID;
            let aType = item.AType;
            let aTime = item.ATime;
            let column = item.AuditColumn;
            let value = item.AuditValue;


            let loginName = item.LoginName;

            return (
                <tr key={id}>
                    <td> {aType} </td>
                    <td> {aTime} </td>
                    <td> {column} </td>
                    <td> {value} </td>
                    <td> {loginName} </td>
                </tr>
            )
        });
    }
    return (
        <div className="portlet box red">
            <div className="portlet box red">
                <div className="portlet-title">
                    <div className="caption">
                        <i className="fa fa-picture"></i>Credit Status </div>
                </div>
                <div className="portlet-body">
                    <div className="table-scrollable">
                        <table className="table table-condensed table-hover">
                            <thead>
                                <tr>
                                    <th> AType </th>
                                    <th> ATime </th>
                                    <th> Column </th>
                                    <th> Value </th>
                                    <th> LoginName </th>
                                </tr>
                            </thead>
                            <tbody>
                                {items}
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    );
};

export default DealAudit;