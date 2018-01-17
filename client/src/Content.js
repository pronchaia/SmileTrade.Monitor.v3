import React from 'react';
import { Switch, Route } from 'react-router-dom';

import Dashboard from './components/views/Dashboard';
import Tracer from './components/views/Tracer';
import CreditEmail from './components/views/CreditEmail';
import CpWorstdate from './components/views/CpWorstdate';

// The Main component renders one of the three provided
// Routes (provided that one matches). Both the /roster
// and /schedule routes will match any pathname that starts
// with /roster or /schedule. The / route will only match
// when the pathname is exactly the string "/"
const Content = () => (
    <main>
        <Switch>
            <Route exact path='/' component={Dashboard} />
            <Route path="/Tracer" component={Tracer} />
            <Route path="/Email" component={CreditEmail} />
            <Route path="/Worstdate" component={CpWorstdate} />
        </Switch>
    </main>
)

export default Content