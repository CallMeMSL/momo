import { Component } from "solid-js";
import Subscription from "./Subscription";
import { RowData } from "../types";


const Subscriptions: Component = () => {
  // Example array of row data
  const rowData: RowData[] = [
    {
      id: 1,
      name: "Hart Hagerty",
      location: "United States",
      company: "Zemlak, Daniel and Leannon",
      role: "Desktop Support Technician",
      color: "Purple",
      avatar: "https://img.daisyui.com/images/profile/demo/2@94.webp",
    },
    {
      id: 2,
      name: "Brice Swyre",
      location: "China",
      company: "Carroll Group",
      role: "Tax Accountant",
      color: "Red",
      avatar: "https://img.daisyui.com/images/profile/demo/3@94.webp",
    },
    {
      id: 3,
      name: "Marjy Ferencz",
      location: "Russia",
      company: "Rowe-Schoen",
      role: "Office Assistant I",
      color: "Crimson",
      avatar: "https://img.daisyui.com/images/profile/demo/4@94.webp",
    },
    {
      id: 4,
      name: "Yancy Tear",
      location: "Brazil",
      company: "Wyman-Ledner",
      role: "Community Outreach Specialist",
      color: "Indigo",
      avatar: "https://img.daisyui.com/images/profile/demo/5@94.webp",
    },
  ];

  const subscription = rowData.map((row) => {
    return <Subscription row={row} />;
  });

  

  return (
    <div class="overflow-x-auto">
      <table class="table">
        <thead>
          <tr>
            <th>
              <label>
                <input type="checkbox" class="checkbox" />
              </label>
            </th>
            <th>Name</th>
            <th>Job</th>
            <th>Favorite Color</th>
            <th></th>
          </tr>
        </thead>
        <tbody>{subscription}</tbody>
      </table>
    </div>
  );
};

export default Subscriptions;