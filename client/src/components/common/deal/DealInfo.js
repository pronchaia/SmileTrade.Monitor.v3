import React, { Component } from 'react';

const DealInfo = (props) => (
    <div>
        {
            props.deal.map((item) => (
                <div key={item.ID} className="search-container ">
                    <ul>
                        <li className="search-item-header">
                            <div className="row">
                                <div className="col-sm-9 col-xs-8">
                                    <h3> {item.DealID} ...</h3>
                                </div>
                            </div>
                        </li>
                        <li className="search-item clearfix">
                            <div className="search-content">
                                <div className="row">
                                    <div className="col-sm-4 col-xs-4">
                                        <h2 className="search-title">
                                            {item.DealType}
                                        </h2>
                                        <p class="search-desc">
                                            PSFlag : <span class="font-blue-soft">{item.PSFlag}</span>,
                                                CR Sec Only : <span class="font-blue-soft">{item.K_CrOnlySecurityLimit}</span>
                                        </p>
                                        <p class="search-desc">
                                            CreditStatus : <span class="font-blue-soft">{item.CreditStatus}</span>
                                        </p>
                                        <p class="search-desc">
                                            Priviledge : <span class="font-blue-soft">{item.Priviledge}</span>
                                        </p>
                                    </div>
                                    <div className="col-sm-2 col-xs-4">
                                        <p className="search-counter-number">{new Intl.NumberFormat('en-US', { minimumIntegerDigits: 2, minimumFractionDigits: 2 }).format(item.TotalValue)}</p>
                                        <p className="search-counter-label uppercase">Total Value</p>
                                    </div>
                                    <div className="col-sm-2 col-xs-4">
                                        <p className="search-counter-number">{new Intl.NumberFormat('en-US', { minimumIntegerDigits: 2, minimumFractionDigits: 2 }).format(item.UnrealValue)}</p>
                                        <p className="search-counter-label uppercase">Unreal Value</p>
                                    </div>
                                    <div className="col-sm-2 col-xs-4">
                                        <p className="search-counter-number">{new Intl.NumberFormat('en-US', { minimumIntegerDigits: 2, minimumFractionDigits: 2 }).format(item.NetAmountCompCCy)}</p>
                                        <p className="search-counter-label uppercase">Net Comp CCy</p>
                                    </div>
                                    <div className="col-sm-2 col-xs-4">
                                        <p className="search-counter-number">{new Intl.NumberFormat('en-US', { minimumIntegerDigits: 2, minimumFractionDigits: 2 }).format(item.K_PaymentAmountCompCCy)}</p>
                                        <p className="search-counter-label uppercase">Payment Comp CCy</p>
                                    </div>
                                </div>
                            </div>
                        </li>
                        <li className="search-item clearfix">
                            <div className="search-content">
                                <div className="row">
                                    <div className="col-sm-4 col-xs-4">
                                        <h2 className="search-title">
                                            Consume date
                                            </h2>
                                    </div>
                                    <div className="col-sm-2 col-xs-4">
                                        <p className="search-counter-number">{new Intl.DateTimeFormat('en-GB').format(new Date(item.StartDate))}</p>
                                        <p className="search-counter-label uppercase">Start Date</p>
                                    </div>
                                    <div className="col-sm-2 col-xs-4">
                                        <p className="search-counter-number">{new Intl.DateTimeFormat('en-GB').format(new Date(item.EndDate))}</p>
                                        <p className="search-counter-label uppercase">End Date</p>
                                    </div>
                                    <div className="col-sm-2 col-xs-4">
                                        <p className="search-counter-number">{new Intl.DateTimeFormat('en-GB').format(new Date(item.ConsumeStartDate))}</p>
                                        <p className="search-counter-label uppercase">Consume Start</p>
                                    </div>
                                    <div className="col-sm-2 col-xs-4">
                                        <p className="search-counter-number">{new Intl.DateTimeFormat('en-GB').format(new Date(item.ConsumeEndDate))}</p>
                                        <p className="search-counter-label uppercase">Consume End</p>
                                    </div>
                                </div>
                            </div>
                        </li>
                        <li className="search-item clearfix">
                            <div className="search-content">
                                <div className="row">
                                    <div className="col-sm-2 col-xs-4">
                                        <h2 className="search-title">
                                            Loading
                                            </h2>
                                    </div>
                                    <div className="col-sm-3 col-xs-4">
                                        <p className="search-counter-number">{item.CreditStructureName}</p>
                                        <p className="search-counter-label uppercase">Credit Structure</p>
                                    </div>
                                    <div className="col-sm-1 col-xs-4">
                                        <p className="search-counter-number">{item.DomainName}</p>
                                        <p className="search-counter-label uppercase">Domain</p>
                                    </div>
                                    <div className="col-sm-4 col-xs-4">
                                        <p className="search-counter-number">{item.Grade}</p>
                                        <p className="search-counter-label uppercase">Grade</p>
                                    </div>
                                    <div className="col-sm-2 col-xs-4">
                                        <p className="search-counter-number">{new Intl.DateTimeFormat('en-GB').format(new Date(item.MinBLDate))}</p>
                                        <p className="search-counter-label uppercase">B/L Date</p>
                                    </div>
                                </div>
                            </div>
                        </li>
                    </ul>
                </div>
            ))
        }
    </div>
);

export default DealInfo;