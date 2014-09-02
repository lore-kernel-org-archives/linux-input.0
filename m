From: Goffredo Baroncelli <kreijack@inwind.it>
Subject: [PATCH] Driver for Logitech M560
Date: Tue, 02 Sep 2014 19:01:36 +0200
Message-ID: <5405F7F0.4070407@inwind.it>
References: <5404C6F4.1000800@inwind.it>
Reply-To: kreijack@inwind.it
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from outrelay08.libero.it ([212.52.84.112]:60177 "EHLO
	outrelay08.libero.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751764AbaIBQzO (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 2 Sep 2014 12:55:14 -0400
Received: from venice21.bhome (151.24.102.47) by outrelay08.libero.it (8.6.033) (authenticated as kreijack@inwind.it)
        id 5400368A011E40FF for linux-input@vger.kernel.org; Tue, 2 Sep 2014 18:55:10 +0200
In-Reply-To: <5404C6F4.1000800@inwind.it>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linux input ML <linux-input@vger.kernel.org>

Sorry,
I repost this email because I didn't see it in the mailing list
NR
G.Baroncelli

-------- Forwarded Message --------
Subject: Driver for Logitech M560
Date: Mon, 01 Sep 2014 21:20:20 +0200
From: Goffredo Baroncelli <kreijack@inwind.it>
Reply-To: kreijack@inwind.it
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
CC: Nestor Lopez Casado <nlopezcasad@logitech.com>, open list:HID CORE LAYER <linux-input@vger.kernel.org>

Hi Benjamin,

following the Nestor suggestion, I rewrote the driver for the 
mouse Logitech M560 on the basis of your work (branch "for-whot").

The Logitech M560 is is a mouse designed for windows 8. 
Comparing to a standard one, some buttons (the middle one and the 
two ones placed on the side) are bounded to a key combination 
instead of a classic "mouse" button.

Think this mouse as a pair of mouse and keyboard. When the middle
button is pressed the it sends a key (as keyboard) 
combination, the same for the other two side button.
Instead the left/right/wheel work correctly.
To complicate further the things, the middle button send a
key combination the odd press, and another one for the even press;
in the latter case it sends also a left click. But the worst thing 
is that no event is generated when the middle button is released.

Moreover this device is a wireless mouse which uses the unifying 
receiver.

I discovered that it is possible to re-configure the mouse
sending a command (see function m560_send_config_command()).
After this command the mouse sends some sequence when the
buttons are pressed and/or released (see comments for
an explanation of the mouse protocol).

If the mouse is "silent" (no data is sent) for more than 
PACKET_TIMEOUT seconds (currently 10), when the next packet
comes, the driver try to reconfigure it.
This because it is possible that the mouse is switched-off
and lost its setting. Se we need to reconfigure.

Benjamin, I have to highlight three things:
when the dj driver detects a disconnection, it
sends a sequence like

  0x01 0x00 0x00 0x00 0x00 0x00 0x00 ...
  0x02 0x00 0x00 0x00 0x00 0x00 0x00 ...

because the mouse is both a keyboard (0x01) and 
a mouse (0x02). But this sequence is a valid one
(when two buttons are released) due to the strangeness
of the protocol.

Can I suggest to send in these case a sequence like

  <device_type> 0xff 0xff 0xff 0xff 0xff 0xff....

? I suspect that this would be less common. 

Another thing that seemed strange to me is that report
with ID equal 0x20 and 0x21 are handled so the packet
are forwarded to the driver from the 3rd byte onward.
In the others cases (this mouse send also packet with 
ID=0x11) the report id forwarded as is (without
by-passing the first two bytes). It is the expected
behaviour, or the code was written on the basis the
assumption that the devices send ID=0x20/0x21 and the
other ID are sent only by the receiver ?

Finally I have to point out that to work, this driver
has to be inserted BEFORE the hid_logitech_dj

In fact I had to add a file /etc/modprobe.d/hid-logitech_dj.conf
as below

install hid_logitech_dj modprobe hid_logitech_m560; sleep 5s ; modprobe --ignore-install hid_logitech_dj

It is possible that the "sleep 5s" is not needed.

BR
G.Baroncelli

-- 
gpg @keyserver.linux.it: Goffredo Baroncelli (kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5


---

This driver add support for the mouse Logitech m560

Signed-off-by: Goffredo Baroncelli <kreijack@inwind.it>

diff --git a/Makefile b/Makefile
index 3016586..86157c0 100644
--- a/Makefile
+++ b/Makefile
@@ -1,6 +1,7 @@
 obj-m	+= hid-logitech-dj.o
 obj-m	+= hid-logitech-hidpp.o
 obj-m	+= hid-logitech-wtp.o
+obj-m	+= hid-logitech-m560.o
 
 KDIR := /lib/modules/$(shell uname -r)/build
 PWD := $(shell pwd)
diff --git a/hid-logitech-m560.c b/hid-logitech-m560.c
new file mode 100644
index 0000000..5758423
--- /dev/null
+++ b/hid-logitech-m560.c
@@ -0,0 +1,378 @@
+/*
+ *  HID driver for Logitech m560 mouse
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+#include <linux/device.h>
+#include <linux/hid.h>
+#include <linux/module.h>
+#include <linux/sched.h>
+#include <linux/workqueue.h>
+#include "hid-ids.h"
+#include "hid-logitech-dj.h"
+#include "hid-logitech-hidpp.h"
+
+#define DJ_DEVICE_ID_M560 0x402d
+
+/*
+ * Logitech M560 protocol overview
+ *
+ * The Logitech M560 mouse, is designed for windows 8. When the middle and/or
+ * the sides buttons are pressed, it sends some keyboard keys events
+ * instead of buttons ones.
+ * To complicate further the things, the middle button keys sequence
+ * is different from the odd press and the even press.
+ *
+ * forward button -> Super_R
+ * backward button -> Super_L+'d' (press only)
+ * middle button -> 1st time: Alt_L+SuperL+XF86TouchpadOff (press only)
+ *                  2nd time: left-click (press only)
+ * NB: press-only means that when the button is pressed, the
+ * KeyPress/ButtonPress and KeyRelease/ButtonRelease events are generated
+ * together sequentially; instead when the button is released, no event is
+ * generated !
+ *
+ * With the command
+ *	10<xx>0a 3500af03 (where <xx> is the mouse id),
+ * the mouse reacts differently:
+ * - it never send a keyboard key event
+ * - for the three mouse button it sends:
+ *	middle button               press   11<xx>0a 3500af00...
+ *	side 1 button (forward)     press   11<xx>0a 3500b000...
+ *	side 2 button (backward)    press   11<xx>0a 3500ae00...
+ *	middle/side1/side2 button   release 11<xx>0a 35000000...
+ */
+static u8 m560_config_command[] = {0x35, 0x00, 0xaf, 0x03};
+
+struct m560_private_data {
+	union {
+		struct dj_report	dj_report;
+		u8 data[sizeof(struct dj_report)];
+	};
+	bool do_config_command;
+	struct delayed_work  work;
+	struct dj_device *djdev;
+	unsigned long packet_last_time;
+};
+
+/* how the button are mapped in the report */
+#define MOUSE_BTN_LEFT		0
+#define MOUSE_BTN_RIGHT		1
+#define MOUSE_BTN_MIDDLE	2
+#define MOUSE_BTN_WHEEL_LEFT	3
+#define MOUSE_BTN_WHEEL_RIGHT	4
+#define MOUSE_BTN_FORWARD	5
+#define MOUSE_BTN_BACKWARD	6
+
+#define CONFIG_COMMAND_TIMEOUT	(3*HZ)
+#define PACKET_TIMEOUT		(10*HZ)
+
+
+/*
+ * m560_send_config_command - send the config_command to the mouse
+ *
+ * @dev: hid device where the mouse belongs
+ *
+ * @return: >0 OK, <0 error
+ */
+static int m560_send_config_command(struct hid_device *hdev)
+{
+	struct dj_report *dj_report;
+	int retval;
+	struct dj_device *dj_device = hdev->driver_data;
+	struct hid_device *djrcv_hdev = dj_device->dj_receiver_dev->hdev;
+
+	dj_report = kzalloc(sizeof(struct dj_report), GFP_KERNEL);
+	if (!dj_report)
+		return -ENOMEM;
+
+	dj_report->report_id = REPORT_ID_HIDPP_SHORT;
+	dj_report->device_index = dj_device->device_index;
+	dj_report->report_type = 0x0a;
+
+	memcpy(dj_report->report_params, m560_config_command,
+					sizeof(m560_config_command));
+	retval = hid_hw_raw_request(djrcv_hdev,
+		dj_report->report_id,
+		(void *)dj_report, HIDPP_REPORT_SHORT_LENGTH,
+		HID_OUTPUT_REPORT, HID_REQ_SET_REPORT);
+
+	kfree(dj_report);
+	return retval;
+
+}
+
+/*
+ * delayedwork_callback - handle the sending of the config_command.
+ * It schedules another sending because sometime the mouse doesn't understand
+ * the first request and returns an error. So until an ack is received, this
+ * function continue to reschedule a sending each RESET_TIMEOUT seconds
+ *
+ * @work: work_struct struct
+ */
+static void delayedwork_callback(struct work_struct *work)
+{
+	struct m560_private_data *mydata =
+		container_of(work, struct m560_private_data, work.work);
+	struct hid_device *hdev = mydata->djdev->hdev;
+
+	if (!mydata->do_config_command)
+		return;
+
+	if (schedule_delayed_work(&mydata->work, CONFIG_COMMAND_TIMEOUT) == 0) {
+		dbg_hid(
+		  "%s: did not schedule the work item, was already queued\n",
+		  __func__);
+	}
+
+	m560_send_config_command(hdev);
+}
+
+/*
+ * start_config_command - start sending config_command
+ *
+ * @mydata: pointer to private driver data
+ */
+static inline void start_config_command(struct m560_private_data *mydata)
+{
+	mydata->do_config_command = true;
+	if (schedule_delayed_work(&mydata->work, HZ/2) == 0) {
+		struct hid_device *hdev = mydata->djdev->hdev;
+		hid_err(hdev,
+		   "%s: did not schedule the work item, was already queued\n",
+		   __func__);
+	}
+}
+
+/*
+ * stop_config_command - stop sending config_command
+ *
+ * @mydata: pointer to private driver data
+ */
+static inline void stop_config_command(struct m560_private_data *mydata)
+{
+	mydata->do_config_command = false;
+}
+
+/*
+ * m560_djdevice_probe - perform the probing of the device.
+ *
+ * @hdev: hid device
+ * @id: hid device id
+ */
+static int m560_djdevice_probe(struct hid_device *hdev,
+			 const struct hid_device_id *id)
+{
+
+	int ret;
+	struct m560_private_data *mydata;
+	struct dj_device *dj_device = hdev->driver_data;
+
+	if (strcmp(hdev->name, "M560"))
+		return -ENODEV;
+
+	mydata = kzalloc(sizeof(struct m560_private_data), GFP_KERNEL);
+	if (!mydata)
+		return -ENOMEM;
+
+	mydata->djdev = dj_device;
+
+	/* force it so input_mapping doesn't pass anything */
+	mydata->do_config_command = true;
+
+	ret = hid_parse(hdev);
+	if (!ret)
+		ret = hid_hw_start(hdev, HID_CONNECT_DEFAULT);
+
+	/* we can't set before */
+	hid_set_drvdata(hdev, mydata);
+
+	if (ret) {
+		kfree(mydata);
+		return ret;
+	}
+	INIT_DELAYED_WORK(&mydata->work, delayedwork_callback);
+
+	start_config_command(mydata);
+
+	return 0;
+}
+
+static inline int mouse_btn_byte(int bit)
+{
+	return (bit / 8) & 0x01;
+}
+
+static inline int mouse_btn_bit(int bit)
+{
+	return 1 << (bit & 0x07);
+}
+
+static int m560_dj_raw_event(struct hid_device *hdev,
+			struct hid_report *report, u8 *data, int size)
+{
+	struct m560_private_data *mydata = hid_get_drvdata(hdev);
+	int i;
+
+	/* count the zeros; the for body is empty */
+	for (i = 1 ; i < size && data[i] == 0 ; i++) ;
+
+	/* check if the data is a mouse related report */
+	if (data[0] != REPORT_TYPE_MOUSE && data[2] != 0x0a)
+		return 1;
+
+	/*
+	 * Check if the last packet was older than PACKET_TIMEOUT
+	 * This may be a sign of a disconnection; in this case
+	 * we resend the config_command
+	 *
+	 * NOTE: in case of a disconnection, the receiver driver
+	 * send the sequence 0x01 0x00 ... 0x00 and
+	 * 0x02 0x00 ... 0x00, but these are possibile true packet
+	 * sent by the mouse (release of the left and the front button)
+	 */
+	if (mydata->packet_last_time &&
+	    (jiffies - mydata->packet_last_time) > PACKET_TIMEOUT) {
+		start_config_command(mydata);
+	}
+	mydata->packet_last_time = jiffies;
+
+	/* check if the report is the ack of the config_command */
+	if (data[0] == 0x11 && data[2] == 0x0a &&
+	    size >= (3+sizeof(m560_config_command)) &&
+	    !memcmp(data+3, m560_config_command,
+		sizeof(m560_config_command))) {
+
+			stop_config_command(mydata);
+			return true;
+	}
+
+	/*
+	 * check if the report is a mouse button sequence
+	 *
+	 * mydata->data[0] = type (0x02)
+	 * mydata->data[1..2] = buttons
+	 * mydata->data[3..5] = xy
+	 * mydata->data[6] = wheel
+	 * mydata->data[7] = horizontal wheel
+	 */
+	if (data[0] == 0x11 && data[2] == 0x0a && data[06] == 0x00) {
+		int btn, i, maxsize;
+
+		/* check if the event is a button */
+		btn = data[5];
+		if (btn != 0x00 && btn != 0xb0 && btn != 0xae && btn != 0xaf)
+			return true;
+
+		if (btn == 0xaf)
+			mydata->data[1+mouse_btn_byte(MOUSE_BTN_MIDDLE)] |=
+				mouse_btn_bit(MOUSE_BTN_MIDDLE);
+		else if (btn == 0xb0)
+			mydata->data[1+mouse_btn_byte(MOUSE_BTN_FORWARD)] |=
+				mouse_btn_bit(MOUSE_BTN_FORWARD);
+		else if (btn == 0xae)
+			mydata->data[1+mouse_btn_byte(MOUSE_BTN_BACKWARD)] |=
+				mouse_btn_bit(MOUSE_BTN_BACKWARD);
+
+		else if (btn == 0x00) {
+			mydata->data[1+mouse_btn_byte(MOUSE_BTN_MIDDLE)] &=
+				~mouse_btn_bit(MOUSE_BTN_MIDDLE);
+			mydata->data[1+mouse_btn_byte(MOUSE_BTN_FORWARD)] &=
+				~mouse_btn_bit(MOUSE_BTN_FORWARD);
+			mydata->data[1+mouse_btn_byte(MOUSE_BTN_BACKWARD)] &=
+				~mouse_btn_bit(MOUSE_BTN_BACKWARD);
+		}
+
+		/* replace the report with a standard one */
+		if (size > sizeof(mydata->data))
+			maxsize = sizeof(mydata->data);
+		else
+			maxsize = size;
+		for (i = 0 ; i < maxsize ; i++)
+			data[i] = mydata->data[i];
+
+		return 1;
+	}
+
+	/* check if the report is a "standard" mouse report */
+	if (data[0] == REPORT_TYPE_MOUSE) {
+		int i;
+
+		/* horizontal wheel handling */
+		if (data[1+mouse_btn_byte(MOUSE_BTN_WHEEL_LEFT)] &
+		    mouse_btn_bit(MOUSE_BTN_WHEEL_LEFT))
+			data[1+6] = -1;
+		if (data[1+mouse_btn_byte(MOUSE_BTN_WHEEL_RIGHT)] &
+		    mouse_btn_bit(MOUSE_BTN_WHEEL_RIGHT))
+			data[1+6] =  1;
+
+		data[1+mouse_btn_byte(MOUSE_BTN_WHEEL_LEFT)] &=
+		    ~mouse_btn_bit(MOUSE_BTN_WHEEL_LEFT);
+		data[1+mouse_btn_byte(MOUSE_BTN_WHEEL_RIGHT)] &=
+		    ~mouse_btn_bit(MOUSE_BTN_WHEEL_RIGHT);
+
+		/* copy the button status */
+		for (i = 0 ; i < 3 ; i++)
+			mydata->data[i] = data[i];
+	}
+
+	return 1;
+}
+
+/*
+ * This function performs the cleanup when the device is removed
+ */
+static void m560_djdevice_remove(struct hid_device *hdev)
+{
+	struct m560_private_data *mydata = hid_get_drvdata(hdev);
+
+	if (!mydata)
+		return;
+
+	cancel_delayed_work_sync(&mydata->work);
+	hid_hw_stop(hdev);
+	kfree(mydata);
+}
+
+/*
+ * This function avoids that any event different from the mouse ones
+ * goes to the upper level
+ */
+static int m560_djdevice_input_mapping(struct hid_device *hdev,
+		struct hid_input *hi, struct hid_field *field,
+		struct hid_usage *usage, unsigned long **bit, int *max)
+{
+	if (field->application != HID_GD_MOUSE)
+		return -1;
+	return 0;
+}
+
+static const struct hid_device_id m560_dj_device[] = {
+	{ HID_DEVICE(BUS_USB, HID_GROUP_LOGITECH_DJ_DEVICE_GENERIC,
+		USB_VENDOR_ID_LOGITECH, DJ_DEVICE_ID_M560)},
+	{}
+};
+
+MODULE_DEVICE_TABLE(hid, m560_dj_device);
+
+struct hid_driver hid_logitech_dj_device_driver_m560 = {
+	.name = "m560",
+	.id_table = m560_dj_device,
+	.probe = m560_djdevice_probe,
+	.remove = m560_djdevice_remove,
+	.input_mapping = m560_djdevice_input_mapping,
+	.raw_event = m560_dj_raw_event,
+};
+
+module_hid_driver(hid_logitech_dj_device_driver_m560)
+
+MODULE_AUTHOR("Goffredo Baroncelli <kreijack@inwind.it>");
+MODULE_DESCRIPTION("Logitech Wireless Mouse m560");
+MODULE_LICENSE("GPL");





