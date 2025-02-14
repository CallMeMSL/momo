
import { RowData } from "../types";

type SubscriptionProps = {
    row: RowData;
};

const Subscription = (props: SubscriptionProps) => {
    const { row } = props;
    return (
        <tr>
            <th>
                <label>
                    <input type="checkbox" class="checkbox" />
                </label>
            </th>
            <td>
                <div class="flex items-center gap-3">
                    <div class="avatar">
                        <div class="mask mask-squircle h-12 w-12">
                            <img src={row.avatar} alt={`Avatar of ${row.name}`} />
                        </div>
                    </div>
                    <div>
                        <div class="font-bold">{row.name}</div>
                        <div class="text-sm opacity-50">{row.location}</div>
                    </div>
                </div>
            </td>
            <td>
                {row.company}
                <br />
                <span class="badge badge-ghost badge-sm">{row.role}</span>
            </td>
            <td>{row.color}</td>
            <th>
                <button class="btn btn-ghost btn-xs">details</button>
            </th>
        </tr>
    );
};

export default Subscription;
