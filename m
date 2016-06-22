From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v2 1/6] Documentation: hid: Intel ISH HID document
Date: Tue, 21 Jun 2016 22:40:33 -0700
Message-ID: <1466574038-20613-2-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1466574038-20613-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=a
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1466574038-20613-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: jikos@kernel.org, jic23@kernel.org, benjamin.tissoires@redhat.com
Cc: linux-input@vger.kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
List-Id: linux-input@vger.kernel.org

Document explaining ISH HID operation and implementation.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com=
>
---
 Documentation/hid/intel-ish-hid.txt | 449 ++++++++++++++++++++++++++++=
++++++++
 1 file changed, 449 insertions(+)
 create mode 100644 Documentation/hid/intel-ish-hid.txt

diff --git a/Documentation/hid/intel-ish-hid.txt b/Documentation/hid/in=
tel-ish-hid.txt
new file mode 100644
index 0000000..8557280
--- /dev/null
+++ b/Documentation/hid/intel-ish-hid.txt
@@ -0,0 +1,449 @@
+Intel Integrated Sensor Hub (ISH)
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
+
+A sensor hub enables the ability to offload sensor polling and algorit=
hm
+processing to a dedicated low power co-processor. This allows the core
+processor to go into low power modes more often, resulting in the incr=
eased
+battery life.
+There are many vendors providing external sensor hubs confirming to HI=
D
+Sensor usage tables, and used in several tablets, 2 in 1 convertible l=
aptops
+and embedded products. Linux had this support since Linux 3.9.
+
+Intel=C2=AE introduced integrated sensor hubs as a part of the SoC sta=
rting from
+Cherry Trail and now supported on multiple generations of CPU packages=
=2E There
+are many commercial devices already shipped with Integrated Sensor Hub=
s (ISH).
+These ISH also comply to HID sensor specification, but the  difference=
 is the
+transport protocol used for communication. The current external sensor=
 hubs
+mainly use HID over i2C or USB. But ISH doesn't use either i2c or USB.
+
+Overview
+Using a analogy with a usbhid implementation, the ISH follows a simila=
r model
+for a very high speed communication:
+
+	-----------------		----------------------
+	|    USB HID	|	-->	|    ISH HID	     |
+	-----------------		----------------------
+	-----------------		----------------------
+	|  USB protocol	|	-->	|    ISH Transport   |
+	-----------------		----------------------
+	-----------------		----------------------
+	|  EHCI/XHCI	|	-->	|    ISH IPC	     |
+	-----------------		----------------------
+	      PCI				 PCI
+	-----------------		----------------------
+        |Host controller|	-->	|    ISH processor   |
+	-----------------		----------------------
+	     USB Link
+	-----------------		----------------------
+	| USB End points|	-->	|    ISH Clients     |
+	-----------------		----------------------
+
+Like USB protocol provides a method for device enumeration, link manag=
ement
+and user data encapsulation, the ISH also provides similar services. B=
ut it is
+very light weight tailored to manage and communicate with ISH client
+applications implemented in the firmware.
+The ISH allows multiple sensor management applications executing in th=
e
+firmware. Like USB endpoints the messaging can be to/from a client. As=
 part of
+enumeration process, these clients are identified. These clients can b=
e simple
+HID sensor applications, sensor calibration application or senor firmw=
are
+update application.
+The implementation model is similar, like usb bus, ISH transport is al=
so
+implemented as a bus. Each client application executing in the ISH pro=
cessor
+is registered as a device on this bus. The driver, which binds each de=
vice
+(ISH HID driver) identifies the device type and registers with the hid=
 core.
+
+ISH Implementation: Block Diagram
+----------------------------------------
+	 ---------------------------
+	|  User Space Applications  |
+	 ---------------------------
+
+----------------IIO ABI----------------
+	 --------------------------
+	|  IIO Sensor Drivers	  |
+	 --------------------------
+	 --------------------------
+	|	 IIO core	  |
+	 --------------------------
+	 --------------------------
+	|   HID Sensor Hub MFD	  |
+	 --------------------------
+	 --------------------------
+	|       HID Core	  |
+	 --------------------------
+	 --------------------------
+	|   HID over ISH Client   |
+	 --------------------------
+	 --------------------------
+	|   ISH Transport (ISHTP) |
+	 --------------------------
+	 --------------------------
+	|      IPC Drivers	  |
+	 --------------------------
+OS
+----------------   PCI -----------------
+Hardware + Firmware
+	 ----------------------------
+	| ISH Hardware/Firmware(FW) |
+	 ----------------------------
+
+------------------------------------------
+
+High level processing in above blocks:
+
+---
+Hardware Interface
+The ISH is exposed as "Non-VGA unclassified PCI device" to the host. T=
he PCI
+product and vendor IDs are changed from different generations of proce=
ssors. So
+the source code which enumerate drivers needs to update from generatio=
n to
+generation.
+
+---
+Inter Processor Communication (IPC) driver:
+Location: drivers/hid/intel-ish-hid/ipc
+
+The IPC message used memory mapped I/O. The registers are defined in
+hw-ish-regs.h.
+
+IPC/FW message types
+There are two types of messages, one for management of link and other =
messages
+are to and from transport layers.
+
+TX and RX of Transport messages:
+A set of memory mapped register offers support of multi byte messages =
TX and
+RX (E.g.IPC_REG_ISH2HOST_MSG, IPC_REG_HOST2ISH_MSG). The IPC layer mai=
ntains
+internal queues to sequence messages and send them in order to the FW.
+Optionally the caller can register handler to get notification of comp=
letion.
+A door bell mechanism is used in messaging to trigger processing in ho=
st and
+client firmware side. When ISH interrupt handler is called, the ISH2HO=
ST
+doorbell register is used by host drivers to determine that the interr=
upt
+is for ISH.
+Each side has 32 32-bit message registers and a 32-bit doorbell. Doorb=
ell
+register has the following format:
+Bits 0..6: fragment length (7 bits are used)
+Bits 10..13: encapsulated protocol
+Bits 16..19: management command (for IPC management protocol)
+Bit 31: doorbell trigger (signal H/W interrupt to the other side)
+Other bits are reserved, should be 0.
+
+Transport layer interface
+To abstract HW level IPC communication, a set of callbacks are registe=
red.
+The transport layer uses them to send and receive messages.
+Refer to  struct ishtp_hw_ops for callbacks.
+
+---
+ISH Transport layer
+Location: drivers/hid/intel-ish-hid/ishtp/
+
+A Generic Transport Layer
+The transport layer is a bi-directional protocol, which defines:
+- Set of commands to start, stop, connect, disconnect and flow control
+(ishtp/hbm.h) for details
+- A flow control mechanism to avoid buffer overflows
+
+This protocol resembles bus messages described in the following docume=
nt:
+http://www.intel.com/content/dam/www/public/us/en/documents/technical-=
\
+specifications/dcmi-hi-1-0-spec.pdf
+Chater 7: Bus Message Layer
+
+Connection and Flow Control Mechanism
+Each FW client and a protocol is identified by an UUID. In order to co=
mmunicate
+to a FW client, a connection must be established using connect request=
 and
+response bus messages. If successful, a pair (host_client_id and fw_cl=
ient_id)
+will identify the connection.
+Once connection is established, peers send each other flow control bus=
 messages
+independently. Every peer may send a message only if it has received a
+flow-control credit before. Once it sent a message, it may not send an=
other one
+before receiving the next FC credit.
+Either side can send disconnect request bus message to end communicati=
on. Also
+the link will be dropped if major FW reset occurs.
+
+Peer to Peer data transfer
+The host allocates TX and RX buffers. Each side (host and FW) manages =
its DMA
+transfer memory independently. When an ISHTP client from either host o=
r FW side
+wants to send something, it decides whether to send over IPC or over D=
MA;
+for each transfer the decision is independent. The sending side sends =
DMA_XFER
+message when the message is in the respective host buffer (TX when hos=
t client
+sends, RX when FW client sends). The recipient of DMA message responds=
 with
+DMA_XFER_ACK, indicating the sender that the memory region for that me=
ssage
+may be reused.
+DMA initialization is started with host sending DMA_ALLOC_NOTIFY bus m=
essage
+(that includes RX buffer) and FW responds with DMA_ALLOC_NOTIFY_ACK.
+Additionally to DMA address communication, this sequence checks capabi=
lities:
+if thw host doesn't support DMA, then it won't send DMA allocation, so=
 FW can't
+send DMA; if FW doesn't support DMA then it won't respond with
+DMA_ALLOC_NOTIFY_ACK, in which case host will not use DMA transfers.
+Here ISH acts as busmaster DMA controller. Hence when host sends DMA_X=
=46ER,
+it's request to do host->ISH DMA transfer; when FW sends DMA_XFER, it =
means
+that it already did DMA and the message resides at host. Thus, DMA_XFE=
R
+and DMA_XFER_ACK act as ownership indicators.
+At initial state all outgoing memory belongs to the sender (TX to host=
, RX to
+FW), DMA_XFER transfers ownership on the region that contains ISHTP me=
ssage to
+the receiving side, DMA_XFER_ACK returns ownership to the sender. A se=
nder
+needs not wait for previous DMA_XFER to be ack'ed, and may send anothe=
r message
+as long as remaining continuous memory in its ownership is enough.
+In principle, multiple DMA_XFER and DMA_XFER_ACK messages may be sent =
at once
+(up to IPC MTU), thus allowing for interrupt throttling.
+Currently, ISH FW decides to send over DMA if ISHTP message is more th=
an 3 IPC
+fragments and via IPC otherwise. Host right now never decides to send =
over DMA
+because at this time there is no streaming case for larger messages.
+
+Ring Buffers
+When a client initiate a connection, a ring or RX and TX buffers are a=
llocated.
+The size of ring can be specified by the client. HID client set 16 and=
 32 for
+TX and RX buffers respectively. On send request from client, the data =
to be
+sent is copied to one of the send ring buffer and scheduled to be sent=
 using
+bus message protocol. These buffers are required because the FW may ha=
ve not
+processed last message and may not have enough flow control credits to=
 send.
+Same thing holds true on receive side and flow control is required.
+
+Host Enumeration
+The host enumeration bus command allow discovery of clients present in
+the FW. There can be multiple sensor clients and clients for calibrati=
on
+function.
+To ease in implantation and allow independent driver handle each clien=
t
+this transport layer takes advantage of Linux Bus driver model. Each
+client is registered as device on the the transport bus (ishtp bus).
+Enumeration sequence of messages:
+- Host sends HOST_START_REQ_CMD, indicating that host ISHTP layer is u=
p.
+- FW responds with HOST_START_RES_CMD
+- Host sends HOST_ENUM_REQ_CMD (enumerate FW clients)
+- FW responds with HOST_ENUM_RES_CMD that includes bitmap of available=
 FW
+client IDs
+- For each FW ID found in that bitmap host sends
+HOST_CLIENT_PROPERTIES_REQ_CMD
+- FW responds with HOST_CLIENT_PROPERTIES_RES_CMD. Properties include =
UUID,
+max ISHTP message size, etc.
+- Once host received properties for that last discovered client, it co=
nsiders
+ISHTP device fully functional (and allocates DMA buffers)
+
+---
+HID over ISH Client
+Location: drivers/hid/intel-ish-hid
+
+This implanted as ISHTP client driver, which
+- enumerate HID devices under FW ISH client
+- Get Report descriptor
+- Register with HID core as a LL driver
+- Process Get/Set feature request
+- Get input reports
+
+----
+HID Sensor Hub MFD and IIO sensor drivers
+
+The functionality in these drivers is the same as an external sensor h=
ub.
+Refer to
+Documentation/hid/hid-sensor.txt for HID sensor
+Documentation/ABI/testing/sysfs-bus-iio for IIO ABIs to user space
+
+----
+
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+End to End HID transport Sequence Diagram
+
+HID-ISH-CLN			ISHTP			IPC				HW
+	|			|			|				|
+	|			|			|-----WAKE UP------------------>|
+	|			|			|				|
+	|			|			|-----HOST READY--------------->|
+	|			|			|				|
+	|			|			|<----MNG_RESET_NOTIFY_ACK----- |
+	|			|			|				|
+	|			|<----ISHTP_START------ |				|
+	|			|			|				|
+	|			|<-----------------HOST_START_RES_CMD-------------------|
+	|			|			|				|
+	|			|------------------QUERY_SUBSCRIBER-------------------->|
+	|			|			|				|
+	|			|------------------HOST_ENUM_REQ_CMD------------------->|
+	|			|			|				|
+	|			|<-----------------HOST_ENUM_RES_CMD--------------------|
+	|			|			|				|
+	|			|------------------HOST_CLIENT_PROPERTIES_REQ_CMD------>|
+	|			|			|				|
+	|			|<-----------------HOST_CLIENT_PROPERTIES_RES_CMD-------|
+	|	Create new device on in ishtp bus	|				|
+	|			|			|				|
+	|			|------------------HOST_CLIENT_PROPERTIES_REQ_CMD------>|
+	|			|			|				|
+	|			|<-----------------HOST_CLIENT_PROPERTIES_RES_CMD-------|
+	|	Create new device on in ishtp bus	|				|
+	|			|			|				|
+	|			|--Repeat HOST_CLIENT_PROPERTIES_REQ_CMD-till last one--|
+	|			|			|				|
+     probed()
+	|----ishtp_cl_connect-->|----------------- CLIENT_CONNECT_REQ_CMD----=
---------->|
+	|			|			|				|
+	|			|<----------------CLIENT_CONNECT_RES_CMD----------------|
+	|			|			|				|
+	|register event callback|			|				|
+	|			|			|				|
+	|ishtp_cl_send(
+	HOSTIF_DM_ENUM_DEVICES) |----------fill ishtp_msg_hdr struct write to=
 HW-----  >|
+	|			|			|				|
+	|			|			|<-----IRQ(IPC_PROTOCOL_ISHTP---|
+	|			|			|				|
+	|			|<------------ DMA_XFER---------------------------------|
+	|<--ENUM_DEVICE RSP-----|			|				|
+	|			|------------ DMA_XFER_ACK----------------------------->|
+	|			|			|				|
+for each enumerated device
+	|ishtp_cl_send(
+	HOSTIF_GET_HID_DESCRIPTOR |----------fill ishtp_msg_hdr struct write =
to HW---  >|
+	|			|			|				|
+	...Response
+	|			|			|				|
+for each enumerated device
+	|ishtp_cl_send(
+	HOSTIF_GET_REPORT_DESCRIPTOR |----------fill ishtp_msg_hdr struct wri=
te to HW- >|
+	|			|			|				|
+	|			|			|				|
+ hid_allocate_device
+	|			|			|				|
+ hid_add_device			|			|				|
+	|			|			|				|
+
+
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+ISH Debugging
+
+To debug ISH, event tracing mechanism is used. To enable debug logs
+echo 1 > /sys/kernel/debug/tracing/events/intel_ish/enable
+cat sys/kernel/debug/tracing/trace
+
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+ISH IIO sysfs Example on Lenovo thinkpad Yoga 260
+
+root@otcpl-ThinkPad-Yoga-260:~# tree -l /sys/bus/iio/devices/
+/sys/bus/iio/devices/
+=E2=94=9C=E2=94=80=E2=94=80 iio:device0 -> ../../../devices/0044:8086:=
22D8.0001/HID-SENSOR-200073.9.auto/iio:device0
+=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 buffer
+=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80=
 enable
+=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80=
 length
+=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=94=E2=94=80=E2=94=80=
 watermark
+...
+=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 in_accel_hysteresis
+=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 in_accel_offset
+=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 in_accel_sampling_fr=
equency
+=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 in_accel_scale
+=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 in_accel_x_raw
+=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 in_accel_y_raw
+=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 in_accel_z_raw
+=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 name
+=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 scan_elements
+=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80=
 in_accel_x_en
+=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80=
 in_accel_x_index
+=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80=
 in_accel_x_type
+=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80=
 in_accel_y_en
+=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80=
 in_accel_y_index
+=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80=
 in_accel_y_type
+=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80=
 in_accel_z_en
+=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80=
 in_accel_z_index
+=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=94=E2=94=80=E2=94=80=
 in_accel_z_type
+...
+=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80=
 devices
+=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=
=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 buffer
+=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=
=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 enabl=
e
+=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=
=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 lengt=
h
+=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=
=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=94=E2=94=80=E2=94=80 water=
mark
+=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=
=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 dev
+=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=
=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 in_intensity_both_raw
+=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=
=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 in_intensity_hysteresis
+=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=
=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 in_intensity_offset
+=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=
=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 in_intensity_sampling_frequ=
ency
+=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=
=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 in_intensity_scale
+=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=
=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 name
+=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=
=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 scan_elements
+=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=
=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 in_in=
tensity_both_en
+=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=
=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 in_in=
tensity_both_index
+=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=
=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=94=E2=94=80=E2=94=80 in_in=
tensity_both_type
+=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=
=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 trigger
+=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=
=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=94=E2=94=80=E2=94=80 curre=
nt_trigger
+...
+=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=
=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 buffer
+=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=
=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 enabl=
e
+=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=
=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 lengt=
h
+=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=
=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=94=E2=94=80=E2=94=80 water=
mark
+=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=
=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 dev
+=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=
=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 in_magn_hysteresis
+=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=
=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 in_magn_offset
+=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=
=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 in_magn_sampling_frequency
+=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=
=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 in_magn_scale
+=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=
=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 in_magn_x_raw
+=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=
=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 in_magn_y_raw
+=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=
=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 in_magn_z_raw
+=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=
=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 in_rot_from_north_magnetic_=
tilt_comp_raw
+=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=
=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 in_rot_hysteresis
+=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=
=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 in_rot_offset
+=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=
=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 in_rot_sampling_frequency
+=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=
=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 in_rot_scale
+=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=
=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 name
+...
+=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=
=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 scan_elements
+=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=
=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 in_ma=
gn_x_en
+=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=
=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 in_ma=
gn_x_index
+=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=
=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 in_ma=
gn_x_type
+=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=
=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 in_ma=
gn_y_en
+=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=
=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 in_ma=
gn_y_index
+=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=
=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 in_ma=
gn_y_type
+=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=
=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 in_ma=
gn_z_en
+=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=
=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 in_ma=
gn_z_index
+=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=
=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 in_ma=
gn_z_type
+=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=
=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 in_ro=
t_from_north_magnetic_tilt_comp_en
+=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=
=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 in_ro=
t_from_north_magnetic_tilt_comp_index
+=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=
=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=94=E2=94=80=E2=94=80 in_ro=
t_from_north_magnetic_tilt_comp_type
+=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=
=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 trigger
+=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=
=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=94=E2=94=80=E2=94=80 curre=
nt_trigger
+...
+=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=
=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 buffer
+=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=
=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 enabl=
e
+=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=
=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 lengt=
h
+=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=
=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=94=E2=94=80=E2=94=80 water=
mark
+=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=
=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 dev
+=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=
=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 in_anglvel_hysteresis
+=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=
=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 in_anglvel_offset
+=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=
=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 in_anglvel_sampling_frequen=
cy
+=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=
=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 in_anglvel_scale
+=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=
=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 in_anglvel_x_raw
+=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=
=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 in_anglvel_y_raw
+=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=
=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 in_anglvel_z_raw
+=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=
=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 name
+=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=
=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 scan_elements
+=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=
=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 in_an=
glvel_x_en
+=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=
=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 in_an=
glvel_x_index
+=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=
=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 in_an=
glvel_x_type
+=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=
=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 in_an=
glvel_y_en
+=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=
=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 in_an=
glvel_y_index
+=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=
=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 in_an=
glvel_y_type
+=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=
=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 in_an=
glvel_z_en
+=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=
=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 in_an=
glvel_z_index
+=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=
=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=94=E2=94=80=E2=94=80 in_an=
glvel_z_type
+=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=
=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 trigger
+=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=
=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=94=E2=94=80=E2=94=80 curre=
nt_trigger
+...
+=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=
=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 buffer
+=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=
=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 enabl=
e
+=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=
=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 lengt=
h
+=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=
=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=94=E2=94=80=E2=94=80 water=
mark
+=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=
=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 dev
+=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=
=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 in_anglvel_hysteresis
+=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=
=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 in_anglvel_offset
+=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=
=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 in_anglvel_sampling_frequen=
cy
+=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=
=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 in_anglvel_scale
+=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=
=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 in_anglvel_x_raw
+=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=
=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 in_anglvel_y_raw
+=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=
=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 in_anglvel_z_raw
+=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=
=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 name
+=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=
=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 scan_elements
+=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=
=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 in_an=
glvel_x_en
+=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=
=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 in_an=
glvel_x_index
+=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=
=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 in_an=
glvel_x_type
+=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=
=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 in_an=
glvel_y_en
+=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=
=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 in_an=
glvel_y_index
+=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=
=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 in_an=
glvel_y_type
+=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=
=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 in_an=
glvel_z_en
+=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=
=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 in_an=
glvel_z_index
+=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=
=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=94=E2=94=80=E2=94=80 in_an=
glvel_z_type
+=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=
=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 trigger
+=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=
=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=94=E2=94=80=E2=94=80 curre=
nt_trigger
+...
--=20
2.5.5
