import React from 'react';

const SubItem = (props) => {
    let items;
    if (props.names) {
        items = props.names.map(item, i => {
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
}

export default SubItem;