import Echo from "laravel-echo";
import Pusher from "pusher-js";

declare global {
  interface Window {
    Pusher: typeof Pusher;
    Echo: Echo;
  }
}

window.Pusher = Pusher;

const echo = new Echo({
  broadcaster: "reverb",
  key: import.meta.env.VITE_REVERB_APP_KEY || "jvzoyvb8udj659o2hdmw",
  wsHost:
    import.meta.env.VITE_REVERB_APP_HOST?.trim() || window.location.hostname,
  wsPort: import.meta.env.VITE_REVERB_APP_PORT
    ? Number(import.meta.env.VITE_REVERB_APP_PORT)
    : 8080,
  wssPort: import.meta.env.VITE_REVERB_APP_PORT
    ? Number(import.meta.env.VITE_REVERB_APP_PORT)
    : 443,
  forceTLS: (import.meta.env.VITE_REVERB_SCHEME ?? "https") === "https:",
  enabledTransports: ["ws", "wss"],
});

window.Echo = echo;

export default echo;
