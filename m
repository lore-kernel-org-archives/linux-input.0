From: David Herrmann <dh.herrmann@gmail.com>
Subject: [RFC 7/8] HID: add transport driver documentation
Date: Mon, 15 Jul 2013 19:10:16 +0200
Message-ID: <1373908217-16748-8-git-send-email-dh.herrmann@gmail.com>
References: <1373908217-16748-1-git-send-email-dh.herrmann@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ea0-f177.google.com ([209.85.215.177]:48032 "EHLO
	mail-ea0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751585Ab3GORKt (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 15 Jul 2013 13:10:49 -0400
Received: by mail-ea0-f177.google.com with SMTP id j14so7877031eak.22
        for <linux-input@vger.kernel.org>; Mon, 15 Jul 2013 10:10:48 -0700 (PDT)
In-Reply-To: <1373908217-16748-1-git-send-email-dh.herrmann@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jiri Kosina <jkosina@suse.cz>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, Oliver Neukum <oliver@neukum.org>, David Herrmann <dh.herrmann@gmail.com>

hid-transport.txt describes the transport driver layout which is required
by HID-core to work correctly. HID-core supports many different transport
drivers and new drivers can be added for any kind of I/O system.

The current layout doesn't really differentiate between intr and ctrl
channels, which confuses some hid-drivers and may break devices. HIDP,
USBHID and I2DHID all implement different semantics for each callback, so
our device drivers aren't really transport-driver-agnostic.

To solve that, hid-transport.txt describes the layout of transport drivers
that is required by HID core. Furthermore, it introduces some new
callbacks which replace the current hid_get_raw_report() and
hid_output_raw_report() hooks. These will be implemented in follow-up
patches.

Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
---
 Documentation/hid/hid-transport.txt | 299 ++++++++++++++++++++++++++++++++++++
 1 file changed, 299 insertions(+)
 create mode 100644 Documentation/hid/hid-transport.txt

diff --git a/Documentation/hid/hid-transport.txt b/Documentation/hid/hid-transport.txt
new file mode 100644
index 0000000..034f11d
--- /dev/null
+++ b/Documentation/hid/hid-transport.txt
@@ -0,0 +1,299 @@
+                          HID I/O Transport Drivers
+                         ===========================
+
+The HID subsystem is independent of the underlying transport driver. Initially,
+only USB was supported, but other specifications adopted the HID design and
+provided new transport drivers. The kernel includes at least support for USB,
+Bluetooth, i2c and user-space I/O drivers.
+
+1) HID Bus
+==========
+
+The HID subsystem is designed as a bus. Any I/O subsystem may provide HID
+devices and register them with the HID bus. HID core then loads generic device
+drivers on top of it. The transport drivers are responsible of raw data
+transport and device setup/management. HID core is responsible of
+report-parsing, report interpretation and the user-space API. Device specifics
+and quirks are also handled by HID core and the HID device drivers.
+
+ +-----------+  +-----------+            +-----------+  +-----------+
+ | Device #1 |  | Device #i |            | Device #j |  | Device #k |
+ +-----------+  +-----------+            +-----------+  +-----------+
+          \\      //                              \\      //
+        +------------+                          +------------+
+        | I/O Driver |                          | I/O Driver |
+        +------------+                          +------------+
+              ||                                      ||
+     +------------------+                    +------------------+
+     | Transport Driver |                    | Transport Driver |
+     +------------------+                    +------------------+
+                       \___                ___/
+                           \              /
+                          +----------------+
+                          |    HID Core    |
+                          +----------------+
+                           /  |        |  \
+                          /   |        |   \
+             ____________/    |        |    \_________________
+            /                 |        |                      \
+           /                  |        |                       \
+ +----------------+  +-----------+  +------------------+  +------------------+
+ | Generic Driver |  | MT Driver |  | Custom Driver #1 |  | Custom Driver #2 |
+ +----------------+  +-----------+  +------------------+  +------------------+
+
+Example Drivers:
+  I/O: USB, I2C, Bluetooth-l2cap
+  Transport: USB-HID, I2C-HID, BT-HIDP
+
+Normally, a transport driver is specific for a given I/O driver. But the HID
+design also allows transport drivers to work with different I/O systems at the
+same time.
+
+Everything below "HID Core" is simplified in this graph as it is only of
+interest to HID device drivers. Transport drivers do not need to know the
+specifics.
+
+1.1) Device Setup
+-----------------
+
+I/O drivers normally provide hotplug detection or device enumeration APIs to the
+transport drivers. Transport drivers use this to find any suitable HID device.
+They allocate HID device objects and register them with HID core. Transport
+drivers are not required to register themselves with HID core. HID core is never
+aware of which transport drivers are available and is not interested in it. It
+is only interested in devices.
+
+Transport drivers attach a constant "struct hid_ll_driver" object with each
+device. Once a device is registered with HID core, the callbacks provided via
+this struct are used by HID core to communicate with the device.
+
+Transport drivers are responsible of detecting device failures and unplugging.
+HID core will operate an device as long as it is registered regardless of any
+device failures. Once transport drivers detect unplug or failure events, they
+must unregister the device from HID core and HID core will stop using the
+provided callbacks.
+
+1.2) Transport Driver Requirements
+----------------------------------
+
+HID core requires transport drivers to follow a given design. A Transport
+drivers must provide two bi-directional I/O channels to each HID device. These
+channels might be multiplexed on a single physical channel, though.
+
+ - Interrupt Channel (intr): The intr channel is used for asynchronous data
+   reports. No management commands or data acknowledgements are sent on this
+   channel. Any unrequested incoming or outgoing data report must be sent on
+   this channel and is never acknowledged by the remote side. Devices usually
+   send their input events on this channel. Outgoing events are normally
+   not send via intr, except if high throughput is required.
+ - Control Channel (ctrl): The ctrl channel is used for synchronous requests and
+   device management. Unrequested data input events must not be sent on this
+   channel and are normally ignored. Instead, devices only send management
+   events or answers to host requests on this channel.
+   Outgoing reports are usually sent on the ctrl channel via synchronous
+   SET_REPORT requests.
+
+Communication between devices and HID core is mostly done via HID reports. A
+report can be of one of three types:
+
+ - INPUT Report: Input reports provide data from device to host. This
+   data may include button events, axis events, battery status or more. This
+   data is generated by the device and sent to the host without requiring
+   explicit requests. Devices can choose to send data continously or only on
+   change.
+ - OUTPUT Report: Output reports change device states. They are sent from host
+   to device and may include LED requests, rumble requests or more. Output
+   reports are never sent from device to host, except if explicitly requested.
+   Hosts may choose to send output reports either continously or only on change.
+ - FEATURE Report: Feature reports can be anything that doesn't belong into the
+   other two categories. Some of them are generic and defined by the HID spec,
+   but most of them are used as custom device extensions. For instance, they may
+   provide battery status information.
+   Feature reports are never sent without requests. A host must explicitly
+   request a device to set or send a feature report. This also means, feature
+   reports are never sent on the intr channel as this channel is asynchronous.
+
+INPUT and OUTPUT reports can be sent as pure data reports on the intr channel.
+For INPUT reports this is the usual operational mode. But for OUTPUT reports,
+this is rarely done as OUTPUT reports are normally quite rare. But devices are
+free to make excessive use of asynchronous OUTPUT reports (for instance, custom
+HID audio speakers make great use of it).
+
+Raw reports must not be sent on the ctrl channel, though. Instead, the ctrl
+channel provides synchronous GET/SET_REPORT requests.
+
+ - GET_REPORT: A GET_REPORT request has a report ID as payload and is sent
+   from host to device. The device must answer with a data report for the
+   requested report ID on the ctrl channel as a synchronous acknowledgement.
+   Only one GET_REPORT request can be pending for each device. This restriction
+   is enforced by HID core as several transport drivers don't allow multiple
+   simultaneous GET_REPORT requests.
+   Note that data reports which are sent as answer to a GET_REPORT request are
+   not handled as generic device events. That is, if a device does not operate
+   in continuous data reporting mode, an answer to GET_REPORT does not replace
+   the raw data report on the intr channel on state change.
+   GET_REPORT is only used by custom HID device drivers to query device state.
+   Normally, HID core caches any device state so this request is not necessary
+   on devices that follow the HID specs.
+   GET_REPORT requests can be sent for any of the 3 report types and shall
+   return the current report state of the device.
+ - SET_REPORT: A SET_REPORT request has a report ID plus data as payload. It is
+   sent from host to device and a device must update it's current report state
+   according to the given data. Any of the 3 report types can be used.
+   A device must answer with a synchronous acknowledgement. However, HID core
+   does not require transport drivers to forward this acknowledgement to HID
+   core.
+   Same as for GET_REPORT, only one SET_REPORT can be pending at a time. This
+   restriction is enforced by HID core as some transport drivers do not support
+   multiple synchronous SET_REPORT requests.
+
+Other ctrl-channel requests are supported by USB-HID but are not available
+(or deprecated) in most other transport level specifications:
+
+ - GET/SET_IDLE: Only used by USB-HID. Do not implement!
+ - GET/SET_PROTOCOL: Not used by HID core. Do not implement!
+
+2) HID API
+==========
+
+2.1) Initialization
+-------------------
+
+Transport drivers normally use the following procedure to register a new device
+with HID core:
+
+	struct hid_device *hid;
+	int ret;
+
+	hid = hid_allocate_device();
+	if (IS_ERR(hid)) {
+		ret = PTR_ERR(hid);
+		goto err_<...>;
+	}
+
+	strlcpy(hid->name, <device-name-src>, 127);
+	strlcpy(hid->phys, <device-phys-src>, 63);
+	strlcpy(hid->uniq, <device-uniq-src>, 63);
+
+	hid->ll_driver = &custom_ll_driver;
+	hid->bus = <device-bus>;
+	hid->vendor = <device-vendor>;
+	hid->product = <device-product>;
+	hid->version = <device-version>;
+	hid->country = <device-country>;
+	hid->dev.parent = <pointer-to-parent-device>;
+	hid->driver_data = <transport-driver-data-field>;
+
+	ret = hid_add_device(hid);
+	if (ret)
+		goto err_<...>;
+
+Once hid_add_device() is entered, HID core might use the callbacks provided in
+"custom_ll_driver". To unregister a device, use:
+
+	hid_destroy_device(hid);
+
+Once hid_destroy_device() returns, HID core will no longer make use of any
+driver callbacks.
+
+2.2) hid_ll_driver operations
+-----------------------------
+
+The available HID callbacks are:
+ - int (*start) (struct hid_device *hdev)
+   Called from HID device drivers once they want to use the device. Transport
+   drivers can choose to setup their device in this callback. However, normally
+   devices are already set up before transport drivers register them to HID core
+   so this is mostly only used by USB-HID.
+
+ - void (*stop) (struct hid_device *hdev)
+   Called from HID device drivers once they are done with a device. Transport
+   drivers can free any buffers and deinitialize the device. But note that
+   ->start() might be called again if another HID device driver is loaded on the
+   device.
+   Transport drivers are free to ignore it and deinitialize devices after they
+   destroyed them via hid_destroy_device().
+
+ - int (*open) (struct hid_device *hdev)
+   Called from HID device drivers once they are interested in data reports.
+   Usually, while user-space didn't open any input API/etc., device drivers are
+   not interested in device data and transport drivers can put devices asleep.
+   However, once ->open() is called, transport drivers must be ready for I/O.
+   ->open() calls are never nested. So in between two ->open() calls there must
+   be a call to ->close().
+
+ - void (*close) (struct hid_device *hdev)
+   Called from HID device drivers after ->open() was called but they are no
+   longer interested in device reports. (Usually if user-space closed any input
+   devices of the driver).
+   Transport drivers can put devices asleep and terminate any I/O. However,
+   ->start() may be called again if the device driver is interested in input
+   reports again.
+
+ - int (*parse) (struct hid_device *hdev)
+   Called once during device setup after ->start() has been called. Transport
+   drivers must read the HID report-descriptor from the device and tell HID core
+   about it via hid_parse_report().
+
+ - int (*power) (struct hid_device *hdev, int level)
+   Called by HID core to give PM hints to transport drivers. Usually this is
+   analogical to the ->open() and ->close() hints and redundant.
+
+ - void (*request) (struct hid_device *hdev, struct hid_report *report,
+                    int reqtype)
+   Send an HID request on the ctrl channel. "report" contains the report that
+   should be sent and "reqtype" the request type. Request-type can be
+   HID_REQ_SET_REPORT or HID_REQ_GET_REPORT.
+   This callback is optional. If not provided, HID core will assemble a raw
+   report following the HID specs and send it via the ->raw_request() callback.
+   The transport driver is free to implement this asynchronously.
+
+ - int (*wait) (struct hid_device *hdev)
+   Used by HID core before calling ->request() again. A transport driver can use
+   it to wait for any pending requests to complete if only one request is
+   allowed at a time.
+
+ - int (*raw_request) (struct hid_device *hdev, unsigned char reportnum,
+                       __u8 *buf, size_t count, unsigned char rtype,
+                       int reqtype)
+   Same as ->request() but provides the report as raw buffer. This request shall
+   be synchronous. A transport driver must not use ->wait() to complete such
+   requests.
+
+ - int (*output_report) (struct hid_device *hdev, __u8 *buf, size_t len)
+   Send raw output report via intr channel. Used by some HID device drivers
+   which require high throughput for outgoing requests on the intr channel. This
+   must not cause SET_REPORT calls! This must be implemented as asynchronous
+   output report on the intr channel!
+
+ - int (*hidinput_input_event) (struct input_dev *idev, unsigned int type,
+                                unsigned int code, int value)
+   Obsolete callback used by logitech converters. It is called when userspace
+   writes input events to the input device (eg., EV_LED). A driver can use this
+   callback to convert it into an output report and send it to the device. If
+   this callback is not provided, HID core will use ->request() or
+   ->raw_request() respectively.
+
+ - int (*idle) (struct hid_device *hdev, int report, int idle, int reqtype)
+   Perform SET/GET_IDLE request. Only used by USB-HID, do not implement!
+
+2.3) Data Path
+--------------
+
+Transport drivers are responsible of reading data from I/O devices. They must
+handle any state-tracking themselves. HID core does not implement protocol
+handshakes or other management commands which can be required by the given HID
+transport specification.
+
+Every raw data packet read from a device must be fed into HID core via
+hid_input_report(). You must specify the channel-type (intr or ctrl) and report
+type (input/output/feature). Under normal conditions, only input reports are
+provided via this API.
+
+Responses to GET_REPORT requests via ->request() must also be provided via this
+API. Responses to ->raw_request() are synchronous and must be intercepted by the
+transport driver and not passed to hid_input_report().
+Acknowledgements to SET_REPORT requests are not of interest to HID core.
+
+----------------------------------------------------
+Written 2013, David Herrmann <dh.herrmann@gmail.com>
-- 
1.8.3.2

