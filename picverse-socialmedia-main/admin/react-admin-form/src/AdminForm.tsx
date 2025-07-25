import React, { useState, useEffect } from "react";
import Swal from "sweetalert2";
import "./AdminForm.css";

const AdminForm: React.FC = () => {
  const [username, setUsername] = useState("");
  const [password, setPassword] = useState("");
  const [admins, setAdmins] = useState<{ id: number; username: string }[]>([]);

  // Fetch admins on component load
  useEffect(() => {
    fetchAdmins();
  }, []);

  const fetchAdmins = async () => {
    try {
      const response = await fetch("http://127.0.0.1:5000/api/getAdmins");
      const result = await response.json();

      if (result.success) {
        setAdmins(result.admins);
      } else {
        Swal.fire("Error", result.message, "error");
      }
    } catch (error) {
      Swal.fire("Error", "Network error. Try again!", "error");
    }
  };

  const handleSubmit = async (event: React.FormEvent) => {
    event.preventDefault();

    try {
      const response = await fetch("http://127.0.0.1:5000/api/reactAdminAdd", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ username, password }),
      });

      const result = await response.json();
      if (result.success) {
        Swal.fire("Success", "Admin added successfully!", "success");
        setUsername("");
        setPassword("");
        fetchAdmins(); // Refresh admin list
      } else {
        Swal.fire("Error", result.message || "Failed to add admin", "error");
      }
    } catch (error) {
      Swal.fire("Error", "Network error. Try again!", "error");
    }
  };

  const handleDelete = async (adminId: number) => {
    try {
      const response = await fetch(`http://127.0.0.1:5000/api/deleteAdmin/${adminId}`, {
        method: "DELETE",
      });

      const result = await response.json();
      if (result.success) {
        Swal.fire("Deleted!", "Admin removed successfully!", "success");
        setAdmins(admins.filter(admin => admin.id !== adminId));
      } else {
        Swal.fire("Error", result.message, "error");
      }
    } catch (error) {
      Swal.fire("Error", "Network error. Try again!", "error");
    }
  };

  return (
    <div className="container">
      <form onSubmit={handleSubmit} className="form">
        <h2 className="title">Add Admin</h2>
        <div className="input-group">
          <label>Username</label>
          <input
            type="text"
            value={username}
            onChange={(e) => setUsername(e.target.value)}
            required
          />
        </div>
        <div className="input-group">
          <label>Password</label>
          <input
            type="password"
            value={password}
            onChange={(e) => setPassword(e.target.value)}
            required
          />
        </div>
        <button type="submit" className="submit-button">Add Admin</button>
      </form>

      {/* Admin List Section */}
      <h2 className="title">Manage Admins</h2>
      <table>
        <thead>
          <tr>
            <th>ID</th>
            <th>Username</th>
            <th>Actions</th>
          </tr>
        </thead>
        <tbody>
          {admins.length > 0 ? (
            admins.map((admin) => (
              <tr key={admin.id}>
                <td>{admin.id}</td>
                <td>{admin.username}</td>
                <td>
                  <button className="delete-button" onClick={() => handleDelete(admin.id)}>
                    Delete
                  </button>
                </td>
              </tr>
            ))
          ) : (
            <tr>
              <td colSpan={3}>No admins found</td>
            </tr>
          )}
        </tbody>
      </table>
    </div>
  );
};

export default AdminForm;
