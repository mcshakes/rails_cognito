import React, { useContext } from 'react';
import { Link, useHistory } from 'react-router-dom';

import UserContext from '../../services/UserContext';

const Header = () => {
	const [ currentUser, setCurrentUser ] = useContext(UserContext);
	const history = useHistory();

	const handleLogOut = () => {
		localStorage.removeItem('user');
		setCurrentUser({});
		history.push('/');
	};

	console.log('header', currentUser);

	return (
		<>
			<header>
				<nav>
					<ul>
						<li>
							<Link to='/'>Home</Link>
						</li>
						<li>
							<Link to='/products'>Products</Link>
						</li>
						<li>
							<Link to='/users'>Users</Link>
						</li>
					</ul>
					<button
						type='button'
						onClick={handleLogOut}
					>
						Log out
					</button>
				</nav>
			</header>
		</>
	);
};

export default Header;