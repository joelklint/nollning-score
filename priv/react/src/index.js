import React from 'react';
import ReactDOM from 'react-dom';
import { Provider } from 'react-redux'
import { getStore } from './state';

// Required by material-ui
import MuiThemeProvider from 'material-ui/styles/MuiThemeProvider'
import injectTapEventPlugin from 'react-tap-event-plugin';
injectTapEventPlugin();

import './index.css';

import App from './App'

const store = getStore()

ReactDOM.render(
  <Provider store={store}>
    <MuiThemeProvider>
      <App />
    </MuiThemeProvider>
  </Provider>,
  document.getElementById('root')
);
