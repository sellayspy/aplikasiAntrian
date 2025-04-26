import { BrowserRouter as Router, Routes, Route } from "react-router";
import "./config/echo";
import SignIn from "./pages/AuthPages/SignIn";
import SignUp from "./pages/AuthPages/SignUp";
import NotFound from "./pages/OtherPage/NotFound";
import UserProfiles from "./pages/UserProfiles";
import Videos from "./pages/UiElements/Videos";
import Images from "./pages/UiElements/Images";
import Alerts from "./pages/UiElements/Alerts";
import Badges from "./pages/UiElements/Badges";
import Avatars from "./pages/UiElements/Avatars";
import Buttons from "./pages/UiElements/Buttons";
import LineChart from "./pages/Charts/LineChart";
import BarChart from "./pages/Charts/BarChart";
import Calendar from "./pages/Calendar";
import BasicTables from "./pages/Tables/BasicTables";
import FormElements from "./pages/Forms/FormElements";
import Blank from "./pages/Blank";
import AppLayout from "./layout/AppLayout";
import { ScrollToTop } from "./components/common/ScrollToTop";
import Home from "./pages/Dashboard/Home";
import TampilAntrian from "./pages/Antrian/TampilkanAntrian/TampilAntrian";
import PanggilAntrian from "./pages/Antrian/TampilkanAntrian/PanggilAntrian";
import ListPanggilAntrian from "./pages/Antrian/TampilkanAntrian/ListPanggilAntrian";
import DaftarListAntrian from "./pages/Antrian/TampilkanAntrian/DaftarListAntrian";
import AmbilAntrian from "./pages/Antrian/TampilkanAntrian/AmbilAntrian";
import ListAmbilAntrian from "./pages/Antrian/TampilkanAntrian/ListAmbilAntrian";

export default function App() {
  return (
    <>
      <Router>
        <ScrollToTop />
        <Routes>
          {/* Dashboard Layout */}
          <Route element={<AppLayout />}>
            <Route index path="/" element={<Home />} />

            {/* Others Page */}
            <Route path="/profile" element={<UserProfiles />} />
            <Route path="/calendar" element={<Calendar />} />
            <Route path="/blank" element={<Blank />} />

            {/* Forms */}
            <Route path="/form-elements" element={<FormElements />} />

            {/* Tables */}
            <Route path="/basic-tables" element={<BasicTables />} />

            <Route path="/panggil-antrian" element={<PanggilAntrian />} />
            <Route path="/daftar-antrian" element={<ListPanggilAntrian />} />
            <Route path="/daftar-tampil" element={<DaftarListAntrian />} />
            <Route path="/daftar-ambil" element={<ListAmbilAntrian />} />

            {/* Ui Elements */}
            <Route path="/alerts" element={<Alerts />} />
            <Route path="/avatars" element={<Avatars />} />
            <Route path="/badge" element={<Badges />} />
            <Route path="/buttons" element={<Buttons />} />
            <Route path="/images" element={<Images />} />
            <Route path="/videos" element={<Videos />} />

            {/* Charts */}
            <Route path="/line-chart" element={<LineChart />} />
            <Route path="/bar-chart" element={<BarChart />} />
          </Route>

          {/* Tampilan Antrian Layout */}
          <Route path="/tampilan-antrian" element={<TampilAntrian />} />
          <Route path="/ambil-antrian" element={<AmbilAntrian />} />

          {/* Auth Layout */}
          <Route path="/signin" element={<SignIn />} />
          <Route path="/signup" element={<SignUp />} />

          {/* Fallback Route */}
          <Route path="*" element={<NotFound />} />
        </Routes>
      </Router>
    </>
  );
}
