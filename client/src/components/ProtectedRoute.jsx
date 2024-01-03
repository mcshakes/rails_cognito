import React from 'react';
import { Route, Navigate, useLocation } from 'react-router-dom';

export default function ProtectedRoute({ component: Component, ...rest }) {
  const isAuthenticated = true; // CHECK the user's authentication status here
  const location = useLocation();

  return (
    <Route {...rest}>
      { isAuthenticated ? (
        <Component /> 
      ) : (
        <Navigate to="/login" state={{ from: location }}/>
      )}
    </Route>
  );
}