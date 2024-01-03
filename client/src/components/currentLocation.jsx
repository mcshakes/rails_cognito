import { useLocation } from 'react-router-dom';
    
export default function CurrentLocation() {
  const location = useLocation();

  return (
    <div>
      <h2>Current location</h2>
      <p>Pathname: {location.pathname}</p>
      <p>Search: {location.search}</p>
      <p>State: {JSON.stringify(location.state)}</p>
    </div>
  );
}