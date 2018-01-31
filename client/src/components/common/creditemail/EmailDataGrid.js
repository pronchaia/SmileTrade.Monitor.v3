import React, { Component } from 'react';
import ReactTable from "react-table";
import matchSorter from 'match-sorter'


class EmailDataGrid extends Component {

    render() {
        return (
            <div>
                <ReactTable
                    data={this.props.data}
                    filterable
                    defaultFilterMethod={(filter, row) =>
                        String(row[filter.id]) === filter.value}
                    columns={[{
                        Header: "PK_SyAQu",
                        id: "PK_SyAQu",
                        accessor: d => d.PK_SyAQu,
                        filterMethod: (filter, rows) =>
                            matchSorter(rows, filter.value, { keys: ["PK_SyAQu"] }),
                        filterAll: true
                    },
                    {
                        Header: "Subject",
                        id: "Subject",
                        accessor: d => d.Subject,
                        filterMethod: (filter, rows) =>
                            matchSorter(rows, filter.value, { keys: ["Subject"] }),
                        filterAll: true
                    },
                    {
                        Header: "Body",
                        id: "Body",
                        accessor: d => d.Body,
                        filterMethod: (filter, rows) =>
                            matchSorter(rows, filter.value, { keys: ["Body"] }),
                        filterAll: true
                    },
                    {
                        Header: "Status",
                        id: "Status",
                        accessor: d => d.Status,
                        filterMethod: (filter, rows) =>
                            matchSorter(rows, filter.value, { keys: ["Status"] }),
                        filterAll: true
                    },
                    {
                        Header: "Initiated",
                        id: "Initiated",
                        accessor: d => d.Initiated,
                        filterMethod: (filter, rows) =>
                            matchSorter(rows, filter.value, { keys: ["Initiated"] }),
                        filterAll: true
                    }]}

                    defaultPageSize={50}
                    className="-striped -highlight"
                />
            </div>
        );
    }
}

export default EmailDataGrid;