import axios from 'axios';

const AuthAPI = axios.create({
  baseURL: `${process.env.API_URL}`,
  withCredentials: true,
  headers: {
    'Content-Type': 'application/json',
  },
});

export default AuthAPI;