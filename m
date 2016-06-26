From: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 1/6] Documentation: hid: Intel ISH HID document
Date: Sun, 26 Jun 2016 19:32:52 +0100
Message-ID: <d1426136-4cd1-2df5-0aad-4bb2dd8261ff@kernel.org>
References: <1466574038-20613-1-git-send-email-srinivas.pandruvada@linux.intel.com>
 <1466574038-20613-2-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1466574038-20613-2-git-send-email-srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, jikos-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On 22/06/16 06:40, Srinivas Pandruvada wrote:
> Document explaining ISH HID operation and implementation.
>=20
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563A2t4k+OOtxA@public.gmane.org=
om>
A few really trivial point inline.  I unfortunately don't have the time=
 to
dive into this in sufficient depth to grasp every detail, but the
description seems pretty comprehensive to me.

I would however, put a blank line between paragraphs to make it a touch
easier to read...

Might even be worth taking this into a docbook file instead of straight
text...

Jonathan
> ---
>  Documentation/hid/intel-ish-hid.txt | 449 ++++++++++++++++++++++++++=
++++++++++
>  1 file changed, 449 insertions(+)
>  create mode 100644 Documentation/hid/intel-ish-hid.txt
>=20
> diff --git a/Documentation/hid/intel-ish-hid.txt b/Documentation/hid/=
intel-ish-hid.txt
> new file mode 100644
> index 0000000..8557280
> --- /dev/null
> +++ b/Documentation/hid/intel-ish-hid.txt
> @@ -0,0 +1,449 @@
> +Intel Integrated Sensor Hub (ISH)
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +A sensor hub enables the ability to offload sensor polling and algor=
ithm
> +processing to a dedicated low power co-processor. This allows the co=
re
> +processor to go into low power modes more often, resulting in the in=
creased
> +battery life.
> +There are many vendors providing external sensor hubs confirming to =
HID
> +Sensor usage tables, and used in several tablets, 2 in 1 convertible=
 laptops
> +and embedded products. Linux had this support since Linux 3.9.
> +
> +Intel=C2=AE introduced integrated sensor hubs as a part of the SoC s=
tarting from
> +Cherry Trail and now supported on multiple generations of CPU packag=
es. There
> +are many commercial devices already shipped with Integrated Sensor H=
ubs (ISH).
> +These ISH also comply to HID sensor specification, but the  differen=
ce is the
> +transport protocol used for communication. The current external sens=
or hubs
> +mainly use HID over i2C or USB. But ISH doesn't use either i2c or US=
B.
> +
> +Overview
> +Using a analogy with a usbhid implementation, the ISH follows a simi=
lar model
> +for a very high speed communication:
> +
> +	-----------------		----------------------
> +	|    USB HID	|	-->	|    ISH HID	     |
> +	-----------------		----------------------
> +	-----------------		----------------------
> +	|  USB protocol	|	-->	|    ISH Transport   |
> +	-----------------		----------------------
> +	-----------------		----------------------
> +	|  EHCI/XHCI	|	-->	|    ISH IPC	     |
> +	-----------------		----------------------
> +	      PCI				 PCI
> +	-----------------		----------------------
> +        |Host controller|	-->	|    ISH processor   |
> +	-----------------		----------------------
> +	     USB Link
> +	-----------------		----------------------
> +	| USB End points|	-->	|    ISH Clients     |
> +	-----------------		----------------------
> +
> +Like USB protocol provides a method for device enumeration, link man=
agement
> +and user data encapsulation, the ISH also provides similar services.=
 But it is
> +very light weight tailored to manage and communicate with ISH client
> +applications implemented in the firmware.
> +The ISH allows multiple sensor management applications executing in =
the
> +firmware. Like USB endpoints the messaging can be to/from a client. =
As part of
> +enumeration process, these clients are identified. These clients can=
 be simple
> +HID sensor applications, sensor calibration application or senor fir=
mware
> +update application.
> +The implementation model is similar, like usb bus, ISH transport is =
also
> +implemented as a bus. Each client application executing in the ISH p=
rocessor
> +is registered as a device on this bus. The driver, which binds each =
device
> +(ISH HID driver) identifies the device type and registers with the h=
id core.
> +
> +ISH Implementation: Block Diagram
> +----------------------------------------
> +	 ---------------------------
> +	|  User Space Applications  |
> +	 ---------------------------
> +
> +----------------IIO ABI----------------
> +	 --------------------------
> +	|  IIO Sensor Drivers	  |
> +	 --------------------------
> +	 --------------------------
> +	|	 IIO core	  |
> +	 --------------------------
> +	 --------------------------
> +	|   HID Sensor Hub MFD	  |
> +	 --------------------------
> +	 --------------------------
> +	|       HID Core	  |
> +	 --------------------------
> +	 --------------------------
> +	|   HID over ISH Client   |
> +	 --------------------------
> +	 --------------------------
> +	|   ISH Transport (ISHTP) |
> +	 --------------------------
> +	 --------------------------
> +	|      IPC Drivers	  |
> +	 --------------------------
> +OS
> +----------------   PCI -----------------
> +Hardware + Firmware
> +	 ----------------------------
> +	| ISH Hardware/Firmware(FW) |
> +	 ----------------------------
> +
> +------------------------------------------
> +
> +High level processing in above blocks:
> +
> +---
> +Hardware Interface
> +The ISH is exposed as "Non-VGA unclassified PCI device" to the host.=
 The PCI
> +product and vendor IDs are changed from different generations of pro=
cessors. So
> +the source code which enumerate drivers needs to update from generat=
ion to
> +generation.
> +
> +---
> +Inter Processor Communication (IPC) driver:
> +Location: drivers/hid/intel-ish-hid/ipc
> +
> +The IPC message used memory mapped I/O. The registers are defined in
> +hw-ish-regs.h.
> +
> +IPC/FW message types
> +There are two types of messages, one for management of link and othe=
r messages
> +are to and from transport layers.
> +
> +TX and RX of Transport messages:
> +A set of memory mapped register offers support of multi byte message=
s TX and
> +RX (E.g.IPC_REG_ISH2HOST_MSG, IPC_REG_HOST2ISH_MSG). The IPC layer m=
aintains
> +internal queues to sequence messages and send them in order to the F=
W.
> +Optionally the caller can register handler to get notification of co=
mpletion.
> +A door bell mechanism is used in messaging to trigger processing in =
host and
> +client firmware side. When ISH interrupt handler is called, the ISH2=
HOST
> +doorbell register is used by host drivers to determine that the inte=
rrupt
> +is for ISH.
> +Each side has 32 32-bit message registers and a 32-bit doorbell. Doo=
rbell
> +register has the following format:
> +Bits 0..6: fragment length (7 bits are used)
> +Bits 10..13: encapsulated protocol
> +Bits 16..19: management command (for IPC management protocol)
> +Bit 31: doorbell trigger (signal H/W interrupt to the other side)
> +Other bits are reserved, should be 0.
> +
> +Transport layer interface
> +To abstract HW level IPC communication, a set of callbacks are regis=
tered.
> +The transport layer uses them to send and receive messages.
> +Refer to  struct ishtp_hw_ops for callbacks.
> +
> +---
> +ISH Transport layer
> +Location: drivers/hid/intel-ish-hid/ishtp/
> +
> +A Generic Transport Layer
> +The transport layer is a bi-directional protocol, which defines:
> +- Set of commands to start, stop, connect, disconnect and flow contr=
ol
> +(ishtp/hbm.h) for details
> +- A flow control mechanism to avoid buffer overflows
> +
> +This protocol resembles bus messages described in the following docu=
ment:
> +http://www.intel.com/content/dam/www/public/us/en/documents/technica=
l-\
> +specifications/dcmi-hi-1-0-spec.pdf
blank line.
> +Chater 7: Bus Message Layer
Chapter.
> +
> +Connection and Flow Control Mechanism
> +Each FW client and a protocol is identified by an UUID. In order to =
communicate
> +to a FW client, a connection must be established using connect reque=
st and
> +response bus messages. If successful, a pair (host_client_id and fw_=
client_id)
> +will identify the connection.
> +Once connection is established, peers send each other flow control b=
us messages
> +independently. Every peer may send a message only if it has received=
 a
> +flow-control credit before. Once it sent a message, it may not send =
another one
> +before receiving the next FC credit.
> +Either side can send disconnect request bus message to end communica=
tion. Also
> +the link will be dropped if major FW reset occurs.
> +
> +Peer to Peer data transfer
> +The host allocates TX and RX buffers. Each side (host and FW) manage=
s its DMA
> +transfer memory independently. When an ISHTP client from either host=
 or FW side
> +wants to send something, it decides whether to send over IPC or over=
 DMA;
> +for each transfer the decision is independent. The sending side send=
s DMA_XFER
> +message when the message is in the respective host buffer (TX when h=
ost client
> +sends, RX when FW client sends). The recipient of DMA message respon=
ds with
> +DMA_XFER_ACK, indicating the sender that the memory region for that =
message
> +may be reused.
> +DMA initialization is started with host sending DMA_ALLOC_NOTIFY bus=
 message
> +(that includes RX buffer) and FW responds with DMA_ALLOC_NOTIFY_ACK.
> +Additionally to DMA address communication, this sequence checks capa=
bilities:
> +if thw host doesn't support DMA, then it won't send DMA allocation, =
so FW can't
> +send DMA; if FW doesn't support DMA then it won't respond with
> +DMA_ALLOC_NOTIFY_ACK, in which case host will not use DMA transfers.
> +Here ISH acts as busmaster DMA controller. Hence when host sends DMA=
_XFER,
> +it's request to do host->ISH DMA transfer; when FW sends DMA_XFER, i=
t means
> +that it already did DMA and the message resides at host. Thus, DMA_X=
=46ER
> +and DMA_XFER_ACK act as ownership indicators.
> +At initial state all outgoing memory belongs to the sender (TX to ho=
st, RX to
> +FW), DMA_XFER transfers ownership on the region that contains ISHTP =
message to
> +the receiving side, DMA_XFER_ACK returns ownership to the sender. A =
sender
> +needs not wait for previous DMA_XFER to be ack'ed, and may send anot=
her message
> +as long as remaining continuous memory in its ownership is enough.
> +In principle, multiple DMA_XFER and DMA_XFER_ACK messages may be sen=
t at once
> +(up to IPC MTU), thus allowing for interrupt throttling.
> +Currently, ISH FW decides to send over DMA if ISHTP message is more =
than 3 IPC
> +fragments and via IPC otherwise. Host right now never decides to sen=
d over DMA
> +because at this time there is no streaming case for larger messages.
> +
> +Ring Buffers
> +When a client initiate a connection, a ring or RX and TX buffers are=
 allocated.
> +The size of ring can be specified by the client. HID client set 16 a=
nd 32 for
> +TX and RX buffers respectively. On send request from client, the dat=
a to be
> +sent is copied to one of the send ring buffer and scheduled to be se=
nt using
> +bus message protocol. These buffers are required because the FW may =
have not
> +processed last message and may not have enough flow control credits =
to send.
> +Same thing holds true on receive side and flow control is required.
> +
> +Host Enumeration
> +The host enumeration bus command allow discovery of clients present =
in
> +the FW. There can be multiple sensor clients and clients for calibra=
tion
> +function.
> +To ease in implantation and allow independent driver handle each cli=
ent
> +this transport layer takes advantage of Linux Bus driver model. Each
> +client is registered as device on the the transport bus (ishtp bus).
> +Enumeration sequence of messages:
> +- Host sends HOST_START_REQ_CMD, indicating that host ISHTP layer is=
 up.
> +- FW responds with HOST_START_RES_CMD
> +- Host sends HOST_ENUM_REQ_CMD (enumerate FW clients)
> +- FW responds with HOST_ENUM_RES_CMD that includes bitmap of availab=
le FW
> +client IDs
> +- For each FW ID found in that bitmap host sends
> +HOST_CLIENT_PROPERTIES_REQ_CMD
> +- FW responds with HOST_CLIENT_PROPERTIES_RES_CMD. Properties includ=
e UUID,
> +max ISHTP message size, etc.
> +- Once host received properties for that last discovered client, it =
considers
> +ISHTP device fully functional (and allocates DMA buffers)
> +
> +---
> +HID over ISH Client
> +Location: drivers/hid/intel-ish-hid
> +
> +This implanted as ISHTP client driver, which
implanted is an odd word choice...

> +- enumerate HID devices under FW ISH client
> +- Get Report descriptor
> +- Register with HID core as a LL driver
> +- Process Get/Set feature request
> +- Get input reports
> +
> +----
> +HID Sensor Hub MFD and IIO sensor drivers
> +
> +The functionality in these drivers is the same as an external sensor=
 hub.
> +Refer to
> +Documentation/hid/hid-sensor.txt for HID sensor
> +Documentation/ABI/testing/sysfs-bus-iio for IIO ABIs to user space
> +
> +----
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +End to End HID transport Sequence Diagram
> +
> +HID-ISH-CLN			ISHTP			IPC				HW
> +	|			|			|				|
> +	|			|			|-----WAKE UP------------------>|
> +	|			|			|				|
> +	|			|			|-----HOST READY--------------->|
> +	|			|			|				|
> +	|			|			|<----MNG_RESET_NOTIFY_ACK----- |
> +	|			|			|				|
> +	|			|<----ISHTP_START------ |				|
> +	|			|			|				|
> +	|			|<-----------------HOST_START_RES_CMD-------------------|
> +	|			|			|				|
> +	|			|------------------QUERY_SUBSCRIBER-------------------->|
> +	|			|			|				|
> +	|			|------------------HOST_ENUM_REQ_CMD------------------->|
> +	|			|			|				|
> +	|			|<-----------------HOST_ENUM_RES_CMD--------------------|
> +	|			|			|				|
> +	|			|------------------HOST_CLIENT_PROPERTIES_REQ_CMD------>|
> +	|			|			|				|
> +	|			|<-----------------HOST_CLIENT_PROPERTIES_RES_CMD-------|
> +	|	Create new device on in ishtp bus	|				|
> +	|			|			|				|
> +	|			|------------------HOST_CLIENT_PROPERTIES_REQ_CMD------>|
> +	|			|			|				|
> +	|			|<-----------------HOST_CLIENT_PROPERTIES_RES_CMD-------|
> +	|	Create new device on in ishtp bus	|				|
> +	|			|			|				|
> +	|			|--Repeat HOST_CLIENT_PROPERTIES_REQ_CMD-till last one--|
> +	|			|			|				|
> +     probed()
> +	|----ishtp_cl_connect-->|----------------- CLIENT_CONNECT_REQ_CMD--=
------------>|
> +	|			|			|				|
> +	|			|<----------------CLIENT_CONNECT_RES_CMD----------------|
> +	|			|			|				|
> +	|register event callback|			|				|
> +	|			|			|				|
> +	|ishtp_cl_send(
> +	HOSTIF_DM_ENUM_DEVICES) |----------fill ishtp_msg_hdr struct write =
to HW-----  >|
> +	|			|			|				|
> +	|			|			|<-----IRQ(IPC_PROTOCOL_ISHTP---|
> +	|			|			|				|
> +	|			|<------------ DMA_XFER---------------------------------|
> +	|<--ENUM_DEVICE RSP-----|			|				|
> +	|			|------------ DMA_XFER_ACK----------------------------->|
> +	|			|			|				|
> +for each enumerated device
> +	|ishtp_cl_send(
> +	HOSTIF_GET_HID_DESCRIPTOR |----------fill ishtp_msg_hdr struct writ=
e to HW---  >|
> +	|			|			|				|
> +	...Response
> +	|			|			|				|
> +for each enumerated device
> +	|ishtp_cl_send(
> +	HOSTIF_GET_REPORT_DESCRIPTOR |----------fill ishtp_msg_hdr struct w=
rite to HW- >|
> +	|			|			|				|
> +	|			|			|				|
> + hid_allocate_device
> +	|			|			|				|
> + hid_add_device			|			|				|
> +	|			|			|				|
> +
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +ISH Debugging
> +
> +To debug ISH, event tracing mechanism is used. To enable debug logs
> +echo 1 > /sys/kernel/debug/tracing/events/intel_ish/enable
> +cat sys/kernel/debug/tracing/trace
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +ISH IIO sysfs Example on Lenovo thinkpad Yoga 260
> +
> +root@otcpl-ThinkPad-Yoga-260:~# tree -l /sys/bus/iio/devices/
> +/sys/bus/iio/devices/
> +=E2=94=9C=E2=94=80=E2=94=80 iio:device0 -> ../../../devices/0044:808=
6:22D8.0001/HID-SENSOR-200073.9.auto/iio:device0
> +=E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 buffer
> +=E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 enable
> +=E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 length
> +=E2=94=82   =E2=94=82   =E2=94=94=E2=94=80=E2=94=80 watermark
> +...
> +=E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 in_accel_hysteresis
> +=E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 in_accel_offset
> +=E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 in_accel_sampling_frequency
> +=E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 in_accel_scale
> +=E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 in_accel_x_raw
> +=E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 in_accel_y_raw
> +=E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 in_accel_z_raw
> +=E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 name
> +=E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 scan_elements
> +=E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 in_accel_x_en
> +=E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 in_accel_x_index
> +=E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 in_accel_x_type
> +=E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 in_accel_y_en
> +=E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 in_accel_y_index
> +=E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 in_accel_y_type
> +=E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 in_accel_z_en
> +=E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 in_accel_z_index
> +=E2=94=82   =E2=94=82   =E2=94=94=E2=94=80=E2=94=80 in_accel_z_type
> +...
> +=E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 devices
> +=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=
=94=80 buffer
> +=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=
=E2=94=80=E2=94=80 enable
> +=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=
=E2=94=80=E2=94=80 length
> +=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=94=
=E2=94=80=E2=94=80 watermark
> +=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=
=94=80 dev
> +=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=
=94=80 in_intensity_both_raw
> +=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=
=94=80 in_intensity_hysteresis
> +=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=
=94=80 in_intensity_offset
> +=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=
=94=80 in_intensity_sampling_frequency
> +=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=
=94=80 in_intensity_scale
> +=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=
=94=80 name
> +=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=
=94=80 scan_elements
> +=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=
=E2=94=80=E2=94=80 in_intensity_both_en
> +=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=
=E2=94=80=E2=94=80 in_intensity_both_index
> +=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=94=
=E2=94=80=E2=94=80 in_intensity_both_type
> +=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=
=94=80 trigger
> +=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=94=
=E2=94=80=E2=94=80 current_trigger
> +...
> +=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=
=94=80 buffer
> +=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=
=E2=94=80=E2=94=80 enable
> +=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=
=E2=94=80=E2=94=80 length
> +=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=94=
=E2=94=80=E2=94=80 watermark
> +=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=
=94=80 dev
> +=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=
=94=80 in_magn_hysteresis
> +=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=
=94=80 in_magn_offset
> +=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=
=94=80 in_magn_sampling_frequency
> +=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=
=94=80 in_magn_scale
> +=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=
=94=80 in_magn_x_raw
> +=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=
=94=80 in_magn_y_raw
> +=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=
=94=80 in_magn_z_raw
> +=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=
=94=80 in_rot_from_north_magnetic_tilt_comp_raw
> +=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=
=94=80 in_rot_hysteresis
> +=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=
=94=80 in_rot_offset
> +=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=
=94=80 in_rot_sampling_frequency
> +=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=
=94=80 in_rot_scale
> +=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=
=94=80 name
> +...
> +=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=
=94=80 scan_elements
> +=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=
=E2=94=80=E2=94=80 in_magn_x_en
> +=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=
=E2=94=80=E2=94=80 in_magn_x_index
> +=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=
=E2=94=80=E2=94=80 in_magn_x_type
> +=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=
=E2=94=80=E2=94=80 in_magn_y_en
> +=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=
=E2=94=80=E2=94=80 in_magn_y_index
> +=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=
=E2=94=80=E2=94=80 in_magn_y_type
> +=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=
=E2=94=80=E2=94=80 in_magn_z_en
> +=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=
=E2=94=80=E2=94=80 in_magn_z_index
> +=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=
=E2=94=80=E2=94=80 in_magn_z_type
> +=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=
=E2=94=80=E2=94=80 in_rot_from_north_magnetic_tilt_comp_en
> +=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=
=E2=94=80=E2=94=80 in_rot_from_north_magnetic_tilt_comp_index
> +=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=94=
=E2=94=80=E2=94=80 in_rot_from_north_magnetic_tilt_comp_type
> +=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=
=94=80 trigger
> +=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=94=
=E2=94=80=E2=94=80 current_trigger
> +...
> +=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=
=94=80 buffer
> +=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=
=E2=94=80=E2=94=80 enable
> +=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=
=E2=94=80=E2=94=80 length
> +=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=94=
=E2=94=80=E2=94=80 watermark
> +=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=
=94=80 dev
> +=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=
=94=80 in_anglvel_hysteresis
> +=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=
=94=80 in_anglvel_offset
> +=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=
=94=80 in_anglvel_sampling_frequency
> +=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=
=94=80 in_anglvel_scale
> +=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=
=94=80 in_anglvel_x_raw
> +=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=
=94=80 in_anglvel_y_raw
> +=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=
=94=80 in_anglvel_z_raw
> +=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=
=94=80 name
> +=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=
=94=80 scan_elements
> +=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=
=E2=94=80=E2=94=80 in_anglvel_x_en
> +=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=
=E2=94=80=E2=94=80 in_anglvel_x_index
> +=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=
=E2=94=80=E2=94=80 in_anglvel_x_type
> +=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=
=E2=94=80=E2=94=80 in_anglvel_y_en
> +=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=
=E2=94=80=E2=94=80 in_anglvel_y_index
> +=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=
=E2=94=80=E2=94=80 in_anglvel_y_type
> +=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=
=E2=94=80=E2=94=80 in_anglvel_z_en
> +=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=
=E2=94=80=E2=94=80 in_anglvel_z_index
> +=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=94=
=E2=94=80=E2=94=80 in_anglvel_z_type
> +=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=
=94=80 trigger
> +=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=94=
=E2=94=80=E2=94=80 current_trigger
> +...
> +=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=
=94=80 buffer
> +=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=
=E2=94=80=E2=94=80 enable
> +=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=
=E2=94=80=E2=94=80 length
> +=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=94=
=E2=94=80=E2=94=80 watermark
> +=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=
=94=80 dev
> +=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=
=94=80 in_anglvel_hysteresis
> +=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=
=94=80 in_anglvel_offset
> +=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=
=94=80 in_anglvel_sampling_frequency
> +=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=
=94=80 in_anglvel_scale
> +=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=
=94=80 in_anglvel_x_raw
> +=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=
=94=80 in_anglvel_y_raw
> +=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=
=94=80 in_anglvel_z_raw
> +=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=
=94=80 name
> +=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=
=94=80 scan_elements
> +=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=
=E2=94=80=E2=94=80 in_anglvel_x_en
> +=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=
=E2=94=80=E2=94=80 in_anglvel_x_index
> +=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=
=E2=94=80=E2=94=80 in_anglvel_x_type
> +=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=
=E2=94=80=E2=94=80 in_anglvel_y_en
> +=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=
=E2=94=80=E2=94=80 in_anglvel_y_index
> +=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=
=E2=94=80=E2=94=80 in_anglvel_y_type
> +=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=
=E2=94=80=E2=94=80 in_anglvel_z_en
> +=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=
=E2=94=80=E2=94=80 in_anglvel_z_index
> +=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=94=
=E2=94=80=E2=94=80 in_anglvel_z_type
> +=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=
=94=80 trigger
> +=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=94=
=E2=94=80=E2=94=80 current_trigger
> +...
>=20
