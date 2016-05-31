From: Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [RFC 1/4] Documentation: hid: Intel ISH HID document
Date: Mon, 30 May 2016 21:27:55 -0700
Message-ID: <1464668878-17113-2-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1464668878-17113-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1464668878-17113-1-git-send-email-srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: jikos-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, chaya.golan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, daniel.drubin-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Document explaining ISH HID operation and implementation.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org=
>
---
 Documentation/hid/intel-ish-hid.txt | 375 ++++++++++++++++++++++++++++=
++++++++
 1 file changed, 375 insertions(+)
 create mode 100644 Documentation/hid/intel-ish-hid.txt

diff --git a/Documentation/hid/intel-ish-hid.txt b/Documentation/hid/in=
tel-ish-hid.txt
new file mode 100644
index 0000000..83a636e
--- /dev/null
+++ b/Documentation/hid/intel-ish-hid.txt
@@ -0,0 +1,375 @@
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
+This document provides an overview of transport protocol and how it is
+implemented.
+
+
+ISH Implementation: Block Diagram
+----------------------------------------
+	 ---------------------------
+	|  User Space Applications  |
+	 ---------------------------
+
+----------------IIO ABI----------------
+	 --------------------------
+	|  IIO Sensor Drivers 	  |
+	 --------------------------
+	 --------------------------
+	|   	 IIO core 	  |
+	 --------------------------
+	 --------------------------
+	|   HID Sensor Hub MFD 	  |
+	 --------------------------
+	 --------------------------
+	|       HID Core 	  |
+	 --------------------------
+ 	 --------------------------
+	|   HID over ISH Client   |
+	 --------------------------
+	 --------------------------
+	|   ISH Client over ISHTP |
+	 --------------------------
+	 --------------------------
+	|   ISH Transport (ISHTP) |
+	 --------------------------
+	 --------------------------
+	|      IPC Drivers  	  |
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
+RX (E.g.IPC_REG_ISH2HOST_MSG, IPC_REG_HOST2ISH_MSG). The messaging use=
s
+doorbell register to trigger processing on client and server side.
+The IPC layer maintains internal queues to sequence messages and send =
them in
+order to the FW. Optionally the caller can register handler to get not=
ification
+of completion.
+
+Transport layer interface
+To abstract HW level IPC communication a set of callbacks are register=
ed.
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
+DMA
+The transport layer allocate 1 MB TX and 1 MB RX buffer. This buffer i=
s divided
+into slots of 4K buffer. This buffer is shared among all connected cli=
ents.
+So when a message is to be sent or received by a client, it finds an e=
mpty
+slot and either fill for TX or send DMA address to FW for RX.
+By default all RX messages uses DMA as there is more upstream data for=
 sensors
+than downstream. For TX client send interface has flag to send via DMA=
, which
+is not set by default as there is less TX data other setting some feat=
ure
+reports by HID sensor hub driver.
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
+
+ISH Client over generic transport layer
+The ISH client defines interface to send and receive HID style command
+and responses. Refer to ishtp-hid.h.
+These commands are for"
+- Get HID descriptor
+- Get report descriptor
+- Get/Set feature report
+- Get input reports
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
+These drivers don't require changes to handle ISH other than some
+optimizations.
+----
+
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+End to End Startup HID transport Sequence Diagram
+
+HID-ISH-CLN			ISHTP			IPC				HW
+	|			|			|				|
+	|	   		|			|-----WAKE UP------------------>|
+	|			|			|				|
+	|	   		|			|-----HOST READY--------------->|
+	|			|			|				|
+	|	   		|			|<----MNG_RESET_NOTIFY_ACK----- |
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
+
--=20
1.9.1
