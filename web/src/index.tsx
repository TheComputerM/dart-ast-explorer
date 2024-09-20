/* @refresh reload */
import { render } from 'solid-js/web'

import '@fontsource-variable/roboto-mono';
import './index.css'
import App from './App'

const root = document.getElementById('root')

render(() => <App />, root!)
