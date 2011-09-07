From: David Michael <fedora.dm0@gmail.com>
Subject: [RFC] [BUG?] Sixaxis Value Ranges
Date: Wed, 7 Sep 2011 12:50:42 -0400
Message-ID: <CAEvUa7=KWnSFhWeOYf7wagRLODMNNKmdN_tpOnD1fuiwxN7aEg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qw0-f42.google.com ([209.85.216.42]:57559 "EHLO
	mail-qw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753582Ab1IGQuo (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 7 Sep 2011 12:50:44 -0400
Received: by qwi4 with SMTP id 4so492242qwi.1
        for <linux-input@vger.kernel.org>; Wed, 07 Sep 2011 09:50:43 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hi,

The sixaxis accelerometers/gyroscope from the joystick interface use a
"flat" value that causes an input range of length ~128 of 1024 to be
mapped to zero.  This loses a lot of orientation information; for
example, it is possible to position the device diagonally such that
all three accelerometers are zero--meaning there is no force of
gravity.

I'm not sure if this warrants a bug report:  Is it the intended
behavior, or a bad side-effect of the default settings?

For demonstration purposes, the following is a patch that attempts to
set the "flat" and "fuzz" values, but it is not very clean.  These
values are reset to defaults AFTER the input_mapped function is
called, so it returns a negative value to bypass the rest of
hidinput_configure_usage().  (I am not very familiar with the input
subsystem, so maybe someone can suggest a more correct way to
accomplish this.)  It should at least allow you to see the difference
in reported values.

Thanks for any suggestions on the issue.

David


--- a/drivers/hid/hid-sony.c	2011-09-02 19:34:52.833614001 -0400
+++ b/drivers/hid/hid-sony.c	2011-09-06 20:49:04.576358380 -0400
@@ -209,6 +209,36 @@ static void sony_remove(struct hid_devic
 	kfree(hid_get_drvdata(hdev));
 }

+/*
+ * The default axis flat value for gamepads is [range length] >> 4 which, in
+ * the case of the 10-bit sixaxis accelerometers/gyroscope, loses too much
+ * information.
+ */
+static int sony_input_mapped(struct hid_device *hdev, struct hid_input *hi,
+			     struct hid_field *field, struct hid_usage *usage,
+			     unsigned long **bit, int *max)
+{
+	int a = field->logical_minimum;
+	int b = field->logical_maximum;
+
+	/* The 10-bit range identifies the accelerometers/gyroscope uniquely */
+	if (usage->hid == HID_GD_POINTER && a == 0x0000 && b == 0x03FF) {
+
+		/* This repeats hid-input.c code that had to be skipped */
+		set_bit(usage->type, hi->input->evbit);
+		while (usage->code <= *max && test_and_set_bit(usage->code, *bit))
+			usage->code = find_next_zero_bit(*bit, *max + 1, usage->code);
+
+		/* Specify a new fuzz and flat value */
+		input_set_abs_params(hi->input, usage->code, a, b, 4, 4);
+
+		/* Skip past the default post-mapping changes */
+		return -1;
+	}
+
+	return 0;
+}
+
 static const struct hid_device_id sony_devices[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS3_CONTROLLER),
 		.driver_data = SIXAXIS_CONTROLLER_USB },
@@ -228,7 +258,8 @@ static struct hid_driver sony_driver = {
 	.probe = sony_probe,
 	.remove = sony_remove,
 	.report_fixup = sony_report_fixup,
-	.raw_event = sony_raw_event
+	.raw_event = sony_raw_event,
+	.input_mapped = sony_input_mapped
 };

 static int __init sony_init(void)
