From: David Herrmann <dh.herrmann@gmail.com>
Subject: [PATCH 12/12] HID: uhid: update documentation
Date: Tue, 29 Jul 2014 17:14:26 +0200
Message-ID: <1406646866-999-13-git-send-email-dh.herrmann@gmail.com>
References: <1406646866-999-1-git-send-email-dh.herrmann@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-we0-f175.google.com ([74.125.82.175]:34216 "EHLO
	mail-we0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754099AbaG2PPH (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 29 Jul 2014 11:15:07 -0400
Received: by mail-we0-f175.google.com with SMTP id t60so9067441wes.6
        for <linux-input@vger.kernel.org>; Tue, 29 Jul 2014 08:15:06 -0700 (PDT)
In-Reply-To: <1406646866-999-1-git-send-email-dh.herrmann@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jiri Kosina <jkosina@suse.cz>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, David Herrmann <dh.herrmann@gmail.com>

Remove legacy bits, refer people to hid-transport.txt and add descriptions
for all new features.

Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
---
 Documentation/hid/uhid.txt | 179 +++++++++++++++++++++++----------------------
 1 file changed, 92 insertions(+), 87 deletions(-)

diff --git a/Documentation/hid/uhid.txt b/Documentation/hid/uhid.txt
index 54c8f97..c8656dd 100644
--- a/Documentation/hid/uhid.txt
+++ b/Documentation/hid/uhid.txt
@@ -1,28 +1,13 @@
       UHID - User-space I/O driver support for HID subsystem
      ========================================================
 
-The HID subsystem needs two kinds of drivers. In this document we call them:
+UHID allows user-space to implement HID transport drivers. Please see
+hid-transport.txt for an introduction into HID transport drivers. This document
+relies heavily on the definitions declared there.
 
- 1. The "HID I/O Driver" is the driver that performs raw data I/O to the
-    low-level device. Internally, they register an hid_ll_driver structure with
-    the HID core. They perform device setup, read raw data from the device and
-    push it into the HID subsystem and they provide a callback so the HID
-    subsystem can send data to the device.
-
- 2. The "HID Device Driver" is the driver that parses HID reports and reacts on
-    them. There are generic drivers like "generic-usb" and "generic-bluetooth"
-    which adhere to the HID specification and provide the standardizes features.
-    But there may be special drivers and quirks for each non-standard device out
-    there. Internally, they use the hid_driver structure.
-
-Historically, the USB stack was the first subsystem to provide an HID I/O
-Driver. However, other standards like Bluetooth have adopted the HID specs and
-may provide HID I/O Drivers, too. The UHID driver allows to implement HID I/O
-Drivers in user-space and feed the data into the kernel HID-subsystem.
-
-This allows user-space to operate on the same level as USB-HID, Bluetooth-HID
-and similar. It does not provide a way to write HID Device Drivers, though. Use
-hidraw for this purpose.
+With UHID, a user-space transport driver can create kernel hid-devices for each
+device connected to the user-space controlled bus. The UHID API defines the I/O
+events provided from the kernel to user-space and vice versa.
 
 There is an example user-space application in ./samples/uhid/uhid-example.c
 
@@ -42,8 +27,9 @@ by setting O_NONBLOCK.
 struct uhid_event {
         __u32 type;
         union {
-                struct uhid_create_req create;
-                struct uhid_data_req data;
+                struct uhid_create2_req create2;
+                struct uhid_output_req output;
+                struct uhid_input2_req input2;
                 ...
         } u;
 };
@@ -54,8 +40,11 @@ multiple write()'s. A single event must always be sent as a whole. Furthermore,
 only a single event can be sent per read() or write(). Pending data is ignored.
 If you want to handle multiple events in a single syscall, then use vectored
 I/O with readv()/writev().
+The "type" field defines the payload. For each type, there is a
+payload-structure available in the union "u" (except for empty payloads). This
+payload contains management and/or device data.
 
-The first thing you should do is sending an UHID_CREATE event. This will
+The first thing you should do is sending an UHID_CREATE2 event. This will
 register the device. UHID will respond with an UHID_START event. You can now
 start sending data to and reading data from UHID. However, unless UHID sends the
 UHID_OPEN event, the internally attached HID Device Driver has no user attached.
@@ -69,12 +58,20 @@ ref-counting for you.
 You may decide to ignore UHID_OPEN/UHID_CLOSE, though. I/O is allowed even
 though the device may have no users.
 
-If you want to send data to the HID subsystem, you send an HID_INPUT event with
-your raw data payload. If the kernel wants to send data to the device, you will
-read an UHID_OUTPUT or UHID_OUTPUT_EV event.
+If you want to send data on the interrupt channel to the HID subsystem, you send
+an HID_INPUT2 event with your raw data payload. If the kernel wants to send data
+on the interrupt channel to the device, you will read an UHID_OUTPUT event.
+Data requests on the control channel are currently limited to GET_REPORT and
+SET_REPORT (no other data reports on the control channel are defined so far).
+Those requests are always synchronous. That means, the kernel sends
+UHID_GET_REPORT and UHID_SET_REPORT events and requires you to forward them to
+the device on the control channel. Once the device responds, you must forward
+the response via UHID_GET_REPORT_REPLY and UHID_SET_REPORT_REPLY to the kernel.
+The kernel blocks internal driver-execution during such round-trips (times out
+after a hard-coded period).
 
 If your device disconnects, you should send an UHID_DESTROY event. This will
-unregister the device. You can now send UHID_CREATE again to register a new
+unregister the device. You can now send UHID_CREATE2 again to register a new
 device.
 If you close() the fd, the device is automatically unregistered and destroyed
 internally.
@@ -82,73 +79,79 @@ internally.
 write()
 -------
 write() allows you to modify the state of the device and feed input data into
-the kernel. The following types are supported: UHID_CREATE, UHID_DESTROY and
-UHID_INPUT. The kernel will parse the event immediately and if the event ID is
+the kernel. The kernel will parse the event immediately and if the event ID is
 not supported, it will return -EOPNOTSUPP. If the payload is invalid, then
 -EINVAL is returned, otherwise, the amount of data that was read is returned and
-the request was handled successfully.
+the request was handled successfully. O_NONBLOCK does not affect write() as
+writes are always handled immediately in a non-blocking fashion. Future requests
+might make use of O_NONBLOCK, though.
 
-  UHID_CREATE:
+  UHID_CREATE2:
   This creates the internal HID device. No I/O is possible until you send this
-  event to the kernel. The payload is of type struct uhid_create_req and
+  event to the kernel. The payload is of type struct uhid_create2_req and
   contains information about your device. You can start I/O now.
 
-  UHID_CREATE2:
-  Same as UHID_CREATE, but the HID report descriptor data (rd_data) is an array
-  inside struct uhid_create2_req, instead of a pointer to a separate array.
-  Enables use from languages that don't support pointers, e.g. Python.
-
   UHID_DESTROY:
   This destroys the internal HID device. No further I/O will be accepted. There
   may still be pending messages that you can receive with read() but no further
   UHID_INPUT events can be sent to the kernel.
-  You can create a new device by sending UHID_CREATE again. There is no need to
+  You can create a new device by sending UHID_CREATE2 again. There is no need to
   reopen the character device.
 
-  UHID_INPUT:
-  You must send UHID_CREATE before sending input to the kernel! This event
-  contains a data-payload. This is the raw data that you read from your device.
-  The kernel will parse the HID reports and react on it.
-
   UHID_INPUT2:
-  Same as UHID_INPUT, but the data array is the last field of uhid_input2_req.
-  Enables userspace to write only the required bytes to kernel (ev.type +
-  ev.u.input2.size + the part of the data array that matters), instead of
-  the entire struct uhid_input2_req.
-
-  UHID_FEATURE_ANSWER:
-  If you receive a UHID_FEATURE request you must answer with this request. You
-  must copy the "id" field from the request into the answer. Set the "err" field
-  to 0 if no error occurred or to EIO if an I/O error occurred.
+  You must send UHID_CREATE2 before sending input to the kernel! This event
+  contains a data-payload. This is the raw data that you read from your device
+  on the interrupt channel. The kernel will parse the HID reports.
+
+  UHID_GET_REPORT_REPLY:
+  If you receive a UHID_GET_REPORT request you must answer with this request.
+  You  must copy the "id" field from the request into the answer. Set the "err"
+  field to 0 if no error occurred or to EIO if an I/O error occurred.
   If "err" is 0 then you should fill the buffer of the answer with the results
-  of the feature request and set "size" correspondingly.
+  of the GET_REPORT request and set "size" correspondingly.
+
+  UHID_SET_REPORT_REPLY:
+  This is the SET_REPORT equivalent of UHID_GET_REPORT_REPLY. Unlike GET_REPORT,
+  SET_REPORT never returns a data buffer, therefore, it's sufficient to set the
+  "id" and "err" fields correctly.
 
 read()
 ------
-read() will return a queued output report. These output reports can be of type
-UHID_START, UHID_STOP, UHID_OPEN, UHID_CLOSE, UHID_OUTPUT or UHID_OUTPUT_EV. No
-reaction is required to any of them but you should handle them according to your
-needs. Only UHID_OUTPUT and UHID_OUTPUT_EV have payloads.
+read() will return a queued output report. No reaction is required to any of
+them but you should handle them according to your needs.
 
   UHID_START:
   This is sent when the HID device is started. Consider this as an answer to
-  UHID_CREATE. This is always the first event that is sent.
+  UHID_CREATE2. This is always the first event that is sent. Note that this
+  event might not be available immediately after write(UHID_CREATE2) returns.
+  Device drivers might required delayed setups.
+  This event contains a payload of type uhid_start_req. The "dev_flags" field
+  describes special behaviors of a device. The following flags are defined:
+      UHID_DEV_NUMBERED_FEATURE_REPORTS:
+      UHID_DEV_NUMBERED_OUTPUT_REPORTS:
+      UHID_DEV_NUMBERED_INPUT_REPORTS:
+          Each of these flags defines whether a given report-type uses numbered
+          reports. If numbered reports are used for a type, all messages from
+          the kernel already have the report-number as prefix. Otherwise, no
+          prefix is added by the kernel.
+          For messages sent by user-space to the kernel, you must adjust the
+          prefixes according to these flags.
 
   UHID_STOP:
   This is sent when the HID device is stopped. Consider this as an answer to
   UHID_DESTROY.
-  If the kernel HID device driver closes the device manually (that is, you
-  didn't send UHID_DESTROY) then you should consider this device closed and send
-  an UHID_DESTROY event. You may want to reregister your device, though. This is
-  always the last message that is sent to you unless you reopen the device with
-  UHID_CREATE.
+  If you didn't destroy your device via UHID_DESTROY, but the kernel sends an
+  UHID_STOP event, this should usually be ignored. It means that the kernel
+  reloaded/changed the device driver loaded on your HID device (or some other
+  maintenance actions happened).
+  You can usually ignored any UHID_STOP events safely.
 
   UHID_OPEN:
   This is sent when the HID device is opened. That is, the data that the HID
   device provides is read by some other process. You may ignore this event but
   it is useful for power-management. As long as you haven't received this event
   there is actually no other process that reads your data so there is no need to
-  send UHID_INPUT events to the kernel.
+  send UHID_INPUT2 events to the kernel.
 
   UHID_CLOSE:
   This is sent when there are no more processes which read the HID data. It is
@@ -156,27 +159,29 @@ needs. Only UHID_OUTPUT and UHID_OUTPUT_EV have payloads.
 
   UHID_OUTPUT:
   This is sent if the HID device driver wants to send raw data to the I/O
-  device. You should read the payload and forward it to the device. The payload
-  is of type "struct uhid_data_req".
+  device on the interrupt channel. You should read the payload and forward it to
+  the device. The payload is of type "struct uhid_data_req".
   This may be received even though you haven't received UHID_OPEN, yet.
 
-  UHID_OUTPUT_EV (obsolete):
-  Same as UHID_OUTPUT but this contains a "struct input_event" as payload. This
-  is called for force-feedback, LED or similar events which are received through
-  an input device by the HID subsystem. You should convert this into raw reports
-  and send them to your device similar to events of type UHID_OUTPUT.
-  This is no longer sent by newer kernels. Instead, HID core converts it into a
-  raw output report and sends it via UHID_OUTPUT.
-
-  UHID_FEATURE:
-  This event is sent if the kernel driver wants to perform a feature request as
-  described in the HID specs. The report-type and report-number are available in
-  the payload.
-  The kernel serializes feature requests so there will never be two in parallel.
-  However, if you fail to respond with a UHID_FEATURE_ANSWER in a time-span of 5
-  seconds, then the requests will be dropped and a new one might be sent.
-  Therefore, the payload also contains an "id" field that identifies every
-  request.
-
-Document by:
-  David Herrmann <dh.herrmann@googlemail.com>
+  UHID_GET_REPORT:
+  This event is sent if the kernel driver wants to perform a GET_REPORT request
+  on the control channeld as described in the HID specs. The report-type and
+  report-number are available in the payload.
+  The kernel serializes GET_REPORT requests so there will never be two in
+  parallel. However, if you fail to respond with a UHID_GET_REPORT_REPLY, the
+  request might silently time out.
+  Once you read a GET_REPORT request, you shall forward it to the hid device and
+  remember the "id" field in the payload. Once your hid device responds to the
+  GET_REPORT (or if it fails), you must send a UHID_GET_REPORT_REPLY to the
+  kernel with the exact same "id" as in the request. If the request already
+  timed out, the kernel will ignore the response silently. The "id" field is
+  never re-used, so conflicts cannot happen.
+
+  UHID_SET_REPORT:
+  This is the SET_REPORT equivalent of UHID_GET_REPORT. On receipt, you shall
+  send a SET_REPORT request to your hid device. Once it replies, you must tell
+  the kernel about it via UHID_SET_REPORT_REPLY.
+  The same restrictions as for UHID_GET_REPORT apply.
+
+----------------------------------------------------
+Written 2012, David Herrmann <dh.herrmann@gmail.com>
-- 
2.0.3

