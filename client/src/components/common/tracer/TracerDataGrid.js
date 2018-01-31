import React, { Component } from 'react';
import ReactTable from "react-table";
import matchSorter from 'match-sorter'


class TracerDataGrid extends Component {

    render() {
        return (
            <div>
                <ReactTable
                    data={this.props.data}
                    filterable
                    defaultFilterMethod={(filter, row) =>
                        String(row[filter.id]) === filter.value}
                    columns={[{
                        Header: "PK_SyTr",
                        accessor: "PK_SyTr",
                        filterMethod: (filter, rows) =>
                            matchSorter(rows, filter.value, { keys: ["PK_SyTr"] }),
                        filterAll: true
                    },
                    {
                        Header: "REQ",
                        id: "REQ",
                        accessor: d => d.REQ,
                        filterMethod: (filter, rows) =>
                            matchSorter(rows, filter.value, { keys: ["REQ"] }),
                        filterAll: true
                    },
                    {
                        Header: "HOST",
                        id: "HOST",
                        accessor: d => d.HOST,
                        filterMethod: (filter, rows) =>
                            matchSorter(rows, filter.value, { keys: ["HOST"] }),
                        filterAll: true
                    },
                    {
                        Header: "USERID",
                        id: "USERID",
                        accessor: d => d.USERID,
                        filterMethod: (filter, rows) =>
                            matchSorter(rows, filter.value, { keys: ["USERID"] }),
                        filterAll: true
                    },
                    {
                        Header: "LOGINNAME",
                        id: "LOGINNAME",
                        accessor: d => d.LOGINNAMEREQ,
                        filterMethod: (filter, rows) =>
                            matchSorter(rows, filter.value, { keys: ["LOGINNAME"] }),
                        filterAll: true
                    },
                    {
                        Header: "DATE",
                        id: "DATE",
                        accessor: d => d.DATE,
                        filterMethod: (filter, rows) =>
                            matchSorter(rows, filter.value, { keys: ["DATE"] }),
                        filterAll: true
                    },
                    {
                        Header: "PARAMETER",
                        id: "PARAMETER",
                        accessor: d => d.PARAMETER,
                        filterMethod: (filter, rows) =>
                            matchSorter(rows, filter.value, { keys: ["PARAMETER"] }),
                        filterAll: true
                    }]}

                    defaultPageSize={50}
                    className="-striped -highlight"
                />
            </div>
        );
    }
}

export default TracerDataGrid;