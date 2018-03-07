#include "ns3/core-module.h"
#include "ns3/network-module.h"
#include "ns3/mobility-module.h"
#include "ns3/lte-module.h"
#include "ns3/internet-module.h"
#include "ns3/applications-module.h"
#include "ns3/point-to-point-module.h"
#include "ns3/config-store-module.h"

using namespace ns3;

NS_LOG_COMPONENT_DEFINE ("HandOff2");

void
NotifyConnectionEstablishedUe (std::string context,
                               uint64_t imsi,
                               uint16_t cellid,
                               uint16_t rnti)
{
  std::cout << Simulator::Now ().GetSeconds () << " " << context
            << " UE IMSI " << imsi
            << ": connected to CellId " << cellid
            << " with RNTI " << rnti
            << std::endl;
}

void
NotifyHandoverStartUe (std::string context,
                       uint64_t imsi,
                       uint16_t cellid,
                       uint16_t rnti,
                       uint16_t targetCellId)
{
  std::cout << Simulator::Now ().GetSeconds () << " " << context
            << " UE IMSI " << imsi
            << ": previously connected to CellId " << cellid
            << " with RNTI " << rnti
            << ", doing handover to CellId " << targetCellId
            << std::endl;
}

void
NotifyHandoverEndOkUe (std::string context,
                       uint64_t imsi,
                       uint16_t cellid,
                       uint16_t rnti)
{
  std::cout << Simulator::Now ().GetSeconds () << " " << context
            << " UE IMSI " << imsi
            << ": successful handover to CellId " << cellid
            << " with RNTI " << rnti
            << std::endl;
}

void
NotifyConnectionEstablishedEnb (std::string context,
                                uint64_t imsi,
                                uint16_t cellid,
                                uint16_t rnti)
{
  std::cout << Simulator::Now ().GetSeconds () << " " << context
            << " eNB CellId " << cellid
            << ": successful connection of UE with IMSI " << imsi
            << " RNTI " << rnti
            << std::endl;
}

void
NotifyHandoverStartEnb (std::string context,
                        uint64_t imsi,
                        uint16_t cellid,
                        uint16_t rnti,
                        uint16_t targetCellId)
{
  std::cout << Simulator::Now ().GetSeconds () << " " << context
            << " eNB CellId " << cellid
            << ": start handover of UE with IMSI " << imsi
            << " RNTI " << rnti
            << " to CellId " << targetCellId
            << std::endl;
}

void
NotifyHandoverEndOkEnb (std::string context,
                        uint64_t imsi,
                        uint16_t cellid,
                        uint16_t rnti)
{
  std::cout << Simulator::Now ().GetSeconds () << " " << context
            << " eNB CellId " << cellid
            << ": completed handover of UE with IMSI " << imsi
            << " RNTI " << rnti
            << std::endl;
}

int main(int argc, char *argv[]){
  uint16_t nUes = 1; // One user
  uint16_t nEnbs = 3; // 3 eNodeBs
  uint16_t nBearersPerUe = 2; // Applications in the user to measure the communication performances later
  double distance = 500.0; // m
  double yForUe = 20.0;   // m
  double speed = 20;       // m/s
  double simTime = (double)(nEnbs + 1) * distance / speed; // 1500 m / 20 m/s = 75 secs
  double enbTxPowerDbm = 30;//46.0; 

  // change some default attributes so that they are reasonable for
  // this scenario, but do this before processing command line
  // arguments, so that the user is allowed to override these settings
  Config::SetDefault ("ns3::UdpClient::Interval", TimeValue (MilliSeconds (10)));
  Config::SetDefault ("ns3::UdpClient::MaxPackets", UintegerValue (1000000));
  Config::SetDefault ("ns3::LteHelper::UseIdealRrc", BooleanValue (true));

  // Command line arguments
  CommandLine cmd;
  cmd.AddValue ("simTime", "Total duration of the simulation (in seconds)", simTime);
  cmd.AddValue ("speed", "Speed of the UE (default = 20 m/s)", speed);
  cmd.AddValue ("enbTxPowerDbm", "TX power [dBm] used by HeNBs (defalut = 46.0)", enbTxPowerDbm);

  cmd.Parse (argc, argv);

  Ptr<LteHelper> lteHelper = CreateObject<LteHelper>();
  Ptr<PointToPointEpcHelper> epcHelper = CreateObject<PointToPointEpcHelper>();
  lteHelper->SetEpcHelper(epcHelper);
  lteHelper->SetSchedulerType("ns3::RrFfMacScheduler");
  lteHelper->SetHandoverAlgorithmType ("ns3::A2A4RsrqHandoverAlgorithm"); //made changes here.
  lteHelper->SetHandoverAlgorithmAttribute ("ServingCellThreshold",
                                        UintegerValue (30));
  lteHelper->SetHandoverAlgorithmAttribute ("NeighbourCellOffset",
                                         UintegerValue (2));

  Ptr<Node> pgw = epcHelper->GetPgwNode(); //Base helper class to handle the creation of the EPC entities.

  // Create a single RemoteHost
  NodeContainer remoteHostContainer;
  remoteHostContainer.Create(1);
  Ptr<Node> remoteHost = remoteHostContainer.Get(0);
  InternetStackHelper internet;
  internet.Install(remoteHostContainer);

  // Create the Internet
  PointToPointHelper p2ph;
  p2ph.SetDeviceAttribute("DataRate", DataRateValue(DataRate("1Gb/s")));
  p2ph.SetDeviceAttribute("Mtu", UintegerValue(1500));
  p2ph.SetChannelAttribute("Delay", TimeValue(Seconds(0.01)));
  NetDeviceContainer internetDevices = p2ph.Install(pgw, remoteHost);

  Ipv4AddressHelper ipv4h;
  ipv4h.SetBase("1.0.0.0", "255.0.0.0");
  Ipv4InterfaceContainer internetIpIfaces = ipv4h.Assign(internetDevices);
  Ipv4Address remoteHostAddr = internetIpIfaces.GetAddress(1);
  Ipv4StaticRoutingHelper ipv4RoutingHelper;
  Ptr<Ipv4StaticRouting> remoteHostStaticRouing = ipv4RoutingHelper.GetStaticRouting(remoteHost->GetObject<Ipv4>());
  remoteHostStaticRouing->AddNetworkRouteTo(Ipv4Address("7.0.0.0"), Ipv4Mask("255.0.0.0"), 1);

  NodeContainer ueNodes;
  NodeContainer enbNodes;
  enbNodes.Create(nEnbs);
  ueNodes.Create(nUes);

  Ptr<ListPositionAllocator> positionAlloc = CreateObject<ListPositionAllocator>();
  positionAlloc->Add(Vector (0.0, 300.0, 0.0)); // The position of eNodeB 1
  positionAlloc->Add(Vector (500.0, 700.0, 0.0)); // The position of eNodeB 2
  positionAlloc->Add(Vector (900.0, 400.0, 0.0)); // The position of eNodeB 3
  positionAlloc->Add(Vector (0.0, 0.0, 0.0)); // The position of the user -> to be changed in each simulation

  MobilityHelper enbMobility;
  enbMobility.SetMobilityModel ("ns3::ConstantPositionMobilityModel"); //Used to set eNB positions which is fixed here
  enbMobility.SetPositionAllocator (positionAlloc);
  enbMobility.Install (enbNodes);

 // Install Mobility Model in UE
  MobilityHelper ueMobility;
  ueMobility.SetMobilityModel ("ns3::ConstantVelocityMobilityModel"); //See other mobility models available for UE
  ueMobility.Install (ueNodes);
  ueNodes.Get (0)->GetObject<MobilityModel> ()->SetPosition (Vector (0, yForUe, 0));
  ueNodes.Get (0)->GetObject<ConstantVelocityMobilityModel> ()->SetVelocity (Vector (speed, 0, 0));


  //MobilityHelper uemobility;
  //uemobility.SetMobilityModel("ns3::WaypointMobilityModel"); // No mobility of UE
  //uemobility.SetPositionAllocator(positionAlloc);
  //mobility.Install(enbNodes);
  //uemobility.Install(ueNodes);

  NetDeviceContainer enbLteDevs = lteHelper->InstallEnbDevice(enbNodes);
  NetDeviceContainer ueLteDevs = lteHelper->InstallUeDevice(ueNodes);

  internet.Install(ueNodes);
  Ipv4InterfaceContainer ueIpIfaces;
  ueIpIfaces = epcHelper->AssignUeIpv4Address(NetDeviceContainer(ueLteDevs));

  lteHelper->Attach(ueLteDevs.Get(0), enbLteDevs.Get(0)); // You can change the attached eNodeB of the user [Get(0) = eNodeB1, Get(1) = eNodeB 2 ...]

  NS_LOG_LOGIC("setting up applications");

  uint16_t dlPort = 10000;
  uint16_t ulPort = 20000;

  Ptr<Node> ue = ueNodes.Get(0);
  Ptr<Ipv4StaticRouting> ueStaticRouting = ipv4RoutingHelper.GetStaticRouting(ue->GetObject<Ipv4>());
  ueStaticRouting->SetDefaultRoute(epcHelper->GetUeDefaultGatewayAddress(), 1);

  for (uint32_t b = 0; b < nBearersPerUe; ++b){
      ++dlPort;
      ++ulPort;
      ApplicationContainer clientApps;
      ApplicationContainer serverApps;

      NS_LOG_LOGIC ("installing UDP DL app for UE ");
      UdpClientHelper dlClientHelper (ueIpIfaces.GetAddress (0), dlPort);
      clientApps.Add (dlClientHelper.Install (remoteHost));
      PacketSinkHelper dlPacketSinkHelper ("ns3::UdpSocketFactory",
                                           InetSocketAddress (Ipv4Address::GetAny (), dlPort));
      serverApps.Add (dlPacketSinkHelper.Install (ue));

      NS_LOG_LOGIC ("installing UDP UL app for UE ");
      UdpClientHelper ulClientHelper (remoteHostAddr, ulPort);
      clientApps.Add (ulClientHelper.Install (ue));
      PacketSinkHelper ulPacketSinkHelper ("ns3::UdpSocketFactory",
                                           InetSocketAddress (Ipv4Address::GetAny (), ulPort));
      serverApps.Add (ulPacketSinkHelper.Install (remoteHost));

      Ptr<EpcTft> tft = Create<EpcTft> ();
      EpcTft::PacketFilter dlpf;
      dlpf.localPortStart = dlPort;
      dlpf.localPortEnd = dlPort;
      tft->Add (dlpf);
      EpcTft::PacketFilter ulpf;
      ulpf.remotePortStart = ulPort;
      ulpf.remotePortEnd = ulPort;
      tft->Add (ulpf);
      EpsBearer bearer (EpsBearer::NGBR_VIDEO_TCP_DEFAULT);
      lteHelper->ActivateDedicatedEpsBearer (ueLteDevs.Get (0), bearer, tft);

      Time startTime = Seconds(0.1);
      serverApps.Start (startTime);
      clientApps.Start (startTime);
  }
  lteHelper->AddX2Interface (enbNodes);

  lteHelper->EnablePhyTraces ();
  lteHelper->EnableMacTraces ();
  lteHelper->EnableRlcTraces ();
  lteHelper->EnablePdcpTraces ();
  Ptr<RadioBearerStatsCalculator> rlcStats = lteHelper->GetRlcStats ();
  rlcStats->SetAttribute ("EpochDuration", TimeValue (Seconds (0.05)));
  Ptr<RadioBearerStatsCalculator> pdcpStats = lteHelper->GetPdcpStats ();
  pdcpStats->SetAttribute ("EpochDuration", TimeValue (Seconds (0.05)));

  Config::Connect ("/NodeList/*/DeviceList/*/LteEnbRrc/ConnectionEstablished",
                   MakeCallback (&NotifyConnectionEstablishedEnb));
  Config::Connect ("/NodeList/*/DeviceList/*/LteUeRrc/ConnectionEstablished",
                   MakeCallback (&NotifyConnectionEstablishedUe));
  Config::Connect ("/NodeList/*/DeviceList/*/LteEnbRrc/HandoverStart",
                   MakeCallback (&NotifyHandoverStartEnb));
  Config::Connect ("/NodeList/*/DeviceList/*/LteUeRrc/HandoverStart",
                   MakeCallback (&NotifyHandoverStartUe));
  Config::Connect ("/NodeList/*/DeviceList/*/LteEnbRrc/HandoverEndOk",
                   MakeCallback (&NotifyHandoverEndOkEnb));
  Config::Connect ("/NodeList/*/DeviceList/*/LteUeRrc/HandoverEndOk",
                   MakeCallback (&NotifyHandoverEndOkUe));

  Simulator::Stop (Seconds (simTime));
  Simulator::Run ();
  Simulator::Destroy ();
  return 0;

}
