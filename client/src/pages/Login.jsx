import React, { useState } from 'react';
    
export default function Login() {
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [error, setError] = useState('');
  const navigate = useNavigate();

  const handleSubmit = async (event) => {
    event.preventDefault();

    try {
      await authenticate(email, password);
      const from = location.state?.from || "/"; 
      navigate(from);
    } catch {
      setError('Invalid username or password');
    }
  };

  const authenticate = (email, password) => {

  }

  return (
    <form onSubmit={handleSubmit}>
      <label>
        Username:
        <input
          type="text"
          value={username}
          onChange={(e) => setUsername(e.target.value)}
        />
      </label>
      <label>
        Password:
        <input
          type="password"
          value={password}
          onChange={(e) => setPassword(e.target.value)}
        />
      </label>
      {error && <p>{error}</p>}
      <input type="submit" value="Submit" />
    </form>
  );
}
   