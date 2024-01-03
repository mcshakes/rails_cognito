import React from 'react';
import { Switch, Route } from 'react-router-dom';

import Home from './pages/Home';
import Login from './pages/Login';
import Profile from './pages/Profile';

const Routes = () => {
	return (
		<Switch>
			<Route path='/' exact component={Home} />
			<Route path='/login' exact component={Login} />
			{/* <Route path='/admin' component={Dashboard} /> */}
			<Route path='/profile' component={Profile} />
		</Switch>
	);
};

export default Routes;