/* @refresh reload */
import { render } from 'solid-js/web';

import './index.css';
import { Route, Router } from "@solidjs/router";
import { lazy } from "solid-js";
import Navbar from './components/Navbar';
const Home = lazy(() => import("./pages/Home"));

const root = document.getElementById('root');

if (import.meta.env.DEV && !(root instanceof HTMLElement)) {
    throw new Error(
        'Root element not found. Did you forget to add it to your index.html? Or maybe the id attribute got misspelled?',
    );
}

render(
    () =>
        <>
            <Navbar />
            <div class="bg-base-300 rounded-box   container mx-auto p-4">
                <Router>
                    <Route path="/" component={Home} />
                </Router>
            </div>
        </>,
    root!);
