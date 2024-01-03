import { useNavigate } from 'react-router-dom';
    
export default function Home() {
  const navigate = useNavigate();

  const goToProfile = () => {
    navigate('/profile');
  };

  return (
    <div>
      <h2>Home</h2>
      <button onClick={goToProfile}>Go to profile</button>
    </div>
  );
}