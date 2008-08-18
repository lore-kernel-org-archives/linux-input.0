From: "=?UTF-8?B?0KHQtdGA0LPQtdC5INCR0LXQu9GP0YjQvtCy?="
	<sergey.belyashov@gmail.com>
Subject: [PATCH] Autocentering support for Logitech MOMO Racing Wheel (force feedback)
Date: Mon, 18 Aug 2008 13:17:48 +0400
Message-ID: <bb829a0b0808180217t2bd3ed49q4cf5734dcc756311@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from qb-out-0506.google.com ([72.14.204.238]:36864 "EHLO
	qb-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751149AbYHRJRu (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 18 Aug 2008 05:17:50 -0400
Received: by qb-out-0506.google.com with SMTP id a16so2512110qbd.17
        for <linux-input@vger.kernel.org>; Mon, 18 Aug 2008 02:17:49 -0700 (PDT)
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hello.
  Current kernel has no support for autocentering for Logitech wheels.
By default autocentering enabled in wheel and constant effect does not
work properly. Using USB sniffer I found command which change
autocentering settings: 0xFE, 0x0D, 0x0R, 0x0L, 0x80, 0x00, 0x00,
where R - clockwise force, L - counter-clockwise (0x0-0xF, 0xC =
100%). I write patch for my current kernel (2.6.25), but I think git
version also supported, because I do not found any changes in it.
Currently kernel interface has no support for separate autocenter
control and so I do not implement it.
  And some interesting command 0xF3 (or 0xF5 - I do not understand
difference) which makes wheel very easy to rotate (a-la wheel booster
- no any resistance). Effect of that command can be disabled by
setting any (zero too) autocentering strength. I do not found in
kernel interface any standart command for this feature.

===================================================================================

--- linux-source-2.6.24/drivers/hid/usbhid/hid-lgff.c	2008-02-11
08:51:11.000000000 +0300
+++ linux-source-2.6.24.n/drivers/hid/usbhid/hid-lgff.c	2008-08-15
14:00:39.000000000 +0400
@@ -48,6 +48,12 @@
 	-1
 };

+static const signed short ff_momo_wheel[] = {
+	FF_CONSTANT,
+	FF_AUTOCENTER,
+	-1
+};
+
 static const struct dev_type devices[] = {
 	{ 0x046d, 0xc211, ff_rumble },
 	{ 0x046d, 0xc219, ff_rumble },
@@ -55,7 +61,7 @@
 	{ 0x046d, 0xc286, ff_joystick },
 	{ 0x046d, 0xc294, ff_joystick },
 	{ 0x046d, 0xc295, ff_joystick },
-	{ 0x046d, 0xca03, ff_joystick },
+	{ 0x046d, 0xca03, ff_momo_wheel },
 };

 static int hid_lgff_play(struct input_dev *dev, void *data, struct
ff_effect *effect)
@@ -100,6 +106,23 @@
 	return 0;
 }

+static void hid_lgff_set_autocenter(struct input_dev *dev, u16 magnitude)
+{
+	struct hid_device *hid = input_get_drvdata(dev);
+	struct list_head *report_list =
&hid->report_enum[HID_OUTPUT_REPORT].report_list;
+	struct hid_report *report = list_entry(report_list->next, struct
hid_report, list);
+	__s32 *value = report->field[0]->value;
+	magnitude = (magnitude >> 12) & 0xf;
+	*value++ = 0xfe;
+	*value++ = 0x0d;
+	*value++ = magnitude;	/* clockwise strength */
+	*value++ = magnitude;	/* counter-clockwise strength */
+	*value++ = 0x80;
+	*value++ = 0x00;
+	*value++ = 0x00;
+	usbhid_submit_report(hid, report, USB_DIR_OUT);
+}
+
 int hid_lgff_init(struct hid_device* hid)
 {
 	struct hid_input *hidinput = list_entry(hid->inputs.next, struct
hid_input, list);
@@ -110,6 +133,7 @@
 	const signed short *ff_bits = ff_joystick;
 	int error;
 	int i;
+	int autocenter = 0;

 	/* Find the report to use */
 	if (list_empty(report_list)) {
@@ -138,13 +162,19 @@
 		}
 	}

-	for (i = 0; ff_bits[i] >= 0; i++)
+	for (i = 0; ff_bits[i] >= 0; i++) {
 		set_bit(ff_bits[i], dev->ffbit);
+		if (ff_bits[i] == FF_AUTOCENTER)
+		    autocenter = 1;
+	}

 	error = input_ff_create_memless(dev, NULL, hid_lgff_play);
 	if (error)
 		return error;

+	if (autocenter && dev->ff && (!dev->ff->set_autocenter))
+		dev->ff->set_autocenter = hid_lgff_set_autocenter;
+
 	printk(KERN_INFO "Force feedback for Logitech force feedback devices
by Johann Deneux <johann.deneux@it.uu.se>\n");

 	return 0;

========================================================================
Changes in this patch only for MOMO Racing wheels. But some other
wheels (G25, for example) may be also understand this protocol, but I
cannot check it.
