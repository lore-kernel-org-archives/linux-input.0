Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD7639901F
	for <linux-input@vger.kernel.org>; Thu, 16 Apr 2026 09:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776331206; cv=none; b=R1vEC4t+So1p5GzLIt8Ld1XGABjn58wh1AbkjuWgxoarq3HMpTi9BHE+Z+AL7Aa6GLpG3lPUFKFcfQIXQukF7oESnGACKmXX+DiBd5xRxNNV7MqGIwoW6PPCwTlZdcs76wIVHdHAdJCtLTnNZ5VG567nU3YKk2lPYzyrG18CjzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776331206; c=relaxed/simple;
	bh=kSgqF/sk9EdBdub3ainGSzy1cGpcwqgH0epPSuIbvfA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=eB1qhUBGBNh7obwVm9+UiUjWTS9QeCBgAChFzgkwc5ydrs8n92a5r2qCSl4FgfOnRmJzJIj+7vq0IpxjdA4KL4PKpwpOYMJpqSGPyRc8S17qn6cM08PnBNi7Jg6cZpWtSSR//x20/sAcaptZCJFNevIl7AoXgEa2n94nzg3QfvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.at; spf=pass smtp.mailfrom=gmx.at; dkim=pass (2048-bit key) header.d=gmx.at header.i=h.judt@gmx.at header.b=uQDZqzpg; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.at header.i=h.judt@gmx.at header.b="uQDZqzpg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.at;
	s=s31663417; t=1776331202; x=1776936002; i=h.judt@gmx.at;
	bh=D8wje0vPOWWsq74usZPPnhWahBOMkEd1b5gdtMMsaFk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:From:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=uQDZqzpgtaTVfRm/mefDPuH7VRLEdm0hbybDDztY/e2wB/2ae/qckBIM1pocl9VA
	 yjmsAd1HTvbDN9872iRG3YpD10MqM7R+K48L7hA/hUNAC586/G1IRLll/5A3Lu+0B
	 73VHZrCwuAH1E4ghvpeL3REt01ARKlyZnLyCZ6fFvCWWXyx6GHnDk1Y2nx+dEe6UX
	 jTX1oZfIFuvbh33qvMyD/05q1SFxUSqXiizZM8KIKqOaUZ8IedGcTLcxE+id+3Oog
	 Qqpd65DgYUnfpwlA/2zkKzfZihxXwfQCc3GfhluiLlDwvClTH0+9/IOzaSghsV6A6
	 aEw3Fa5ywPQyQzLBag==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M59C8-1wEPLy1Ciq-00FAfX; Thu, 16
 Apr 2026 11:20:02 +0200
Message-ID: <789b8e15-c8a3-4e28-b19b-3922128661d9@gmx.at>
Date: Thu, 16 Apr 2026 11:20:01 +0200
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Harald Judt <h.judt@gmx.at>
Subject: [PATCH RESEND] HID: Add force feedback support for Speedlink Cougar
 Vibration Flightstick
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org
Content-Language: de-AT
Autocrypt: addr=h.judt@gmx.at; keydata=
 xjMEWz9DYxYJKwYBBAHaRw8BAQdAKS36MI1JSuMxtk7tkZ2/NK1C9te1XJ8bBlB9qF4blEbN
 G0hhcmFsZCBKdWR0IDxoLmp1ZHRAZ214LmF0PsKWBBMWCAA+AhsDBQsJCAcCBhUKCQgLAgQW
 AgMBAh4BAheAFiEE4HNt2P9AnPIGZRHUT/+rIbhYCr0FAmStFG8FCRLT0owACgkQT/+rIbhY
 Cr1dYwEAsT/9SLGebsLz4TIuYaDY7c4ou+i7Stae6FIb62NXw7UBAPopYK3pJuyjhvK8qb3N
 FQeZyDrHeJLvOWEoj5OYsLIIzjgEWz9DYxIKKwYBBAGXVQEFAQEHQA7/uzYBE88LdCm19AaX
 q46nMKkhxM5CZ2YAa1uC5l97AwEIB8J+BBgWCAAmAhsMFiEE4HNt2P9AnPIGZRHUT/+rIbhY
 Cr0FAmStFMkFCRLT0uYACgkQT/+rIbhYCr12kAD9HnfrVNMxwa8LWtpKCiv4+zk1ujthlZZm
 G75GoPWofXEBAMQ8kqpJDk2/DH4qT0ZneIT5SnQPt5ZtAFtpX6XOa0oB
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0dw9xVopaY27S3jZqEHuTyRpwP2RS7So+jkY4jdbtkRbrwHiU18
 Il8QoEiMwxxl+MoNeqsoK25ypTu16b+oi2QNlGG3xchlQvnpI9rgKcipriuFMzRSLaRZ5EP
 lmp5wX0iF0azxGDsRnzHqF/oVNtcbEE6W7xTU/hVrFYZHaG/lWU1zZcGUFKXoWOKWikyrCk
 xIkUq9EQOWLEiDEOV02Cw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:aDDjU7eSivU=;xNSbTNxEVga7/IyzdIzGlkYybMG
 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
 BOa4fvGYbjtWOEJVtY=

Hi,

I have implemented force feedback/rumble support for the Speedlink
Cougar Vibration Flightstick joystick. While I am not quite sure about
the correctness of my approach regarding the strong and weak motors, it
seems to work as expected; I ran the fftest samples and also tested it
successfully with SuperTuxKart.

Here is the code, hopefully I have set up thunderbird mail correctly to
not mangle the patch...


=46rom 48d8512fbe49ae7b940dc5869fe50aa905d3d5fb Mon Sep 17 00:00:00 2001
From: Harald Judt <h.judt@gmx.at>
Date: Sun, 18 Jan 2026 02:47:20 +0100
Subject: [PATCH] HID: Add force feedback support for Gembird based joystic=
k

This commit adds force feedback support for a Gembird based joystick, name=
ly
the SpeedLink Cougar Vibration Flightstick (SL-6630), which sports vibrati=
on
motors for rumble effects. Though it is not easy to determine, it seems to=
 have
one motor in the base and the other in the stick, both are of equal
strength. The implementation tries to take this into account for realising=
 weak
and strong rumble effects and has been tested using fftest and SuperTuxKar=
t.

Signed-off-by: Harald Judt <h.judt@gmx.at>
=2D--
 drivers/hid/Kconfig           |   8 ++
 drivers/hid/Makefile          |   1 +
 drivers/hid/hid-gembird-joy.c | 178 ++++++++++++++++++++++++++++++++++
 drivers/hid/hid-ids.h         |   3 +
 drivers/hid/hid-quirks.c      |   3 +
 5 files changed, 193 insertions(+)
 create mode 100644 drivers/hid/hid-gembird-joy.c

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 04420a713be0..b4e2c8f67728 100644
=2D-- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -406,6 +406,14 @@ config HID_GEMBIRD
 	help
 	Support for Gembird JPD-DualForce 2.
=20
+config HID_GEMBIRD_JOY_FF
+	tristate "Gembird Joysticks force feedback support"
+	depends on USB_HID
+	select INPUT_FF_MEMLESS
+	help
+	Force feedback support for Gembird (Vendor ID 0x12bd) based devices:
+	  - Speed Link Cougar Vibration Flightstick (SL-6630)
+
 config HID_GFRM
 	tristate "Google Fiber TV Box remote control support"
 	help
diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
index 361a7daedeb8..593a429661ed 100644
=2D-- a/drivers/hid/Makefile
+++ b/drivers/hid/Makefile
@@ -54,6 +54,7 @@ obj-$(CONFIG_HID_EVISION)	+=3D hid-evision.o
 obj-$(CONFIG_HID_EZKEY)		+=3D hid-ezkey.o
 obj-$(CONFIG_HID_FT260)		+=3D hid-ft260.o
 obj-$(CONFIG_HID_GEMBIRD)	+=3D hid-gembird.o
+obj-$(CONFIG_HID_GEMBIRD_JOY_FF)	+=3D hid-gembird-joy.o
 obj-$(CONFIG_HID_GFRM)		+=3D hid-gfrm.o
 obj-$(CONFIG_HID_GLORIOUS)  +=3D hid-glorious.o
 obj-$(CONFIG_HID_VIVALDI_COMMON) +=3D hid-vivaldi-common.o
diff --git a/drivers/hid/hid-gembird-joy.c b/drivers/hid/hid-gembird-joy.c
new file mode 100644
index 000000000000..5a5afa02f840
=2D-- /dev/null
+++ b/drivers/hid/hid-gembird-joy.c
@@ -0,0 +1,178 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *  HID driver for Gembird based Joysticks
+ *
+ *  Currently supported devices:
+ *    - 12bd:a02f Speed Link Cougar Vibration Flightstick (SL-6630)
+ *
+ *  Copyright (c) 2026 Harald Judt <h.judt@gmx.at>
+ */
+
+
+#include <linux/device.h>
+#include <linux/hid.h>
+#include <linux/module.h>
+
+#include "hid-ids.h"
+
+
+struct gembird_joy_device {
+	struct hid_report *report;
+};
+
+static int hid_gembird_joy_play(struct input_dev *dev, void *data,
+				struct ff_effect *effect)
+{
+	struct hid_device *hid =3D input_get_drvdata(dev);
+	struct gembird_joy_device *joy =3D data;
+	int strong, weak;
+
+	strong =3D effect->u.rumble.strong_magnitude;
+	weak =3D effect->u.rumble.weak_magnitude;
+
+	hid_dbg(hid, "called with 0x%04x 0x%04x\n", strong, weak);
+
+	/* Likely there are two motors, one in the base and the other in an uppe=
r
+	 * part of the stick, yet they are not different in strength, and honest=
ly
+	 * it is hard to determine which motor is active or correlates to value =
0
+	 * or 1 of the report field. However, the third value does not have any
+	 * function, thus it will always be set to 0.
+	 *
+	 * The windows drivers want to make believe the first value in the repor=
t
+	 * field should be influenced by horizontal axis movement, and the secon=
d
+	 * by vertical axis movement, but this might just be some arbitrary gimm=
ick
+	 * of the configuration dialog, which describes the motors as left and
+	 * right.
+	 *
+	 * Ranges are the same for both motors, weak and strong (0 to 31), so sc=
ale
+	 * down the magnitudes accordingly...
+	 */
+	strong =3D (strong / 0xff) * 0x1f / 0xff;
+	weak =3D (weak / 0xff) * 0x1f / 0xff;
+
+	/* ... and to support the notions of strong vs weak rumble effects,
+	 * increase the magnitude for the strong rumble effect if it is below th=
e
+	 * half of the maximum value, as the strong motor has the same strength =
as
+	 * the weak one. Likewise, decrease the magnitude for the weak effect.
+	 */
+	if (strong < 0x10 && !weak)         /* fftest effect 4 strong rumble */
+		strong *=3D 2;
+	else if (!strong && weak >=3D 0x10)   /* fftest effect 5 weak rumble */
+		weak /=3D 2;
+
+	/* Use unmodified values if both magnitudes have been set. */
+	joy->report->field[0]->value[0] =3D strong;
+	joy->report->field[0]->value[1] =3D weak;
+	joy->report->field[0]->value[2] =3D 0;
+
+	hid_dbg(hid, "running with 0x%02x, 0x%02x\n", strong, weak);
+	hid_hw_request(hid, joy->report, HID_REQ_SET_REPORT);
+
+	return 0;
+}
+
+static int gembird_joy_init(struct hid_device *hid)
+{
+	struct gembird_joy_device *joy;
+	struct hid_report *report;
+	struct hid_input *hidinput;
+	struct list_head *report_list =3D
+			&hid->report_enum[HID_OUTPUT_REPORT].report_list;
+	struct list_head *report_ptr =3D report_list;
+	struct input_dev *dev;
+	int error;
+
+	if (list_empty(&hid->inputs)) {
+		hid_err(hid, "no inputs found\n");
+		return -ENODEV;
+	}
+	hidinput =3D list_first_entry(&hid->inputs, struct hid_input, list);
+	dev =3D hidinput->input;
+
+	if (list_empty(report_list)) {
+		hid_err(hid, "no output reports found\n");
+		return -ENODEV;
+	}
+
+	list_for_each_entry(hidinput, &hid->inputs, list) {
+		report_ptr =3D report_ptr->next;
+
+		if (report_ptr =3D=3D report_list) {
+			hid_err(hid, "required output report is missing\n");
+			return -ENODEV;
+		}
+
+		report =3D list_entry(report_ptr, struct hid_report, list);
+		if (report->maxfield < 1) {
+			hid_err(hid, "no fields in the report\n");
+			return -ENODEV;
+		}
+
+		if (report->field[0]->report_count < 3) {
+			hid_err(hid, "not enough values in the field\n");
+			return -ENODEV;
+		}
+
+		joy =3D kzalloc(sizeof(struct gembird_joy_device), GFP_KERNEL);
+		if (!joy)
+			return -ENOMEM;
+
+		dev =3D hidinput->input;
+
+		set_bit(FF_RUMBLE, dev->ffbit);
+
+		error =3D input_ff_create_memless(dev, joy, hid_gembird_joy_play);
+		if (error) {
+			kfree(joy);
+			return error;
+		}
+
+		joy->report =3D report;
+		joy->report->field[0]->value[0] =3D 0x00;
+		joy->report->field[0]->value[1] =3D 0x00;
+		joy->report->field[0]->value[2] =3D 0x00;
+		hid_hw_request(hid, joy->report, HID_REQ_SET_REPORT);
+	}
+
+	hid_info(hid, "Force Feedback for Gembird Joystick devices by Harald Jud=
t <h.judt@gmx.at>\n");
+
+	return 0;
+}
+
+static int gembird_joy_probe(struct hid_device *hdev, const struct hid_de=
vice_id *id)
+{
+	int ret;
+
+	ret =3D hid_parse(hdev);
+	if (ret) {
+		hid_err(hdev, "parse failed\n");
+		return ret;
+	}
+
+	ret =3D hid_hw_start(hdev, HID_CONNECT_DEFAULT & ~HID_CONNECT_FF);
+	if (ret) {
+		hid_err(hdev, "hw start failed\n");
+		return ret;
+	}
+
+	gembird_joy_init(hdev);
+
+	return 0;
+}
+
+static const struct hid_device_id gembird_joy_devices[] =3D {
+	{ HID_USB_DEVICE(USB_VENDOR_ID_GEMBIRD_JOY, USB_DEVICE_ID_GEMBIRD_JOY_SL=
_6630) },
+	{ }
+};
+MODULE_DEVICE_TABLE(hid, gembird_joy_devices);
+
+static struct hid_driver gembird_joy_driver =3D {
+	.name =3D "gembird_joy",
+	.id_table =3D gembird_joy_devices,
+	.probe =3D gembird_joy_probe,
+};
+module_hid_driver(gembird_joy_driver);
+
+MODULE_AUTHOR("Harald Judt <h.judt@gmx.at>");
+MODULE_DESCRIPTION("Force feedback support for HID Gembird joysticks");
+MODULE_LICENSE("GPL");
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index c4589075a5ed..1bdd9b879152 100644
=2D-- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -528,6 +528,9 @@
 #define USB_VENDOR_ID_GEMBIRD			0x11ff
 #define USB_DEVICE_ID_GEMBIRD_JPD_DUALFORCE2	0x3331
=20
+#define USB_VENDOR_ID_GEMBIRD_JOY		0x12bd
+#define USB_DEVICE_ID_GEMBIRD_JOY_SL_6630	0xa02f
+
 #define USB_VENDOR_ID_GENERAL_TOUCH	0x0dfc
 #define USB_DEVICE_ID_GENERAL_TOUCH_WIN7_TWOFINGERS 0x0003
 #define USB_DEVICE_ID_GENERAL_TOUCH_WIN8_PWT_TENFINGERS 0x0100
diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
index 6a8a7ca3d804..835070491da7 100644
=2D-- a/drivers/hid/hid-quirks.c
+++ b/drivers/hid/hid-quirks.c
@@ -444,6 +444,9 @@ static const struct hid_device_id hid_have_special_dri=
ver[] =3D {
 #if IS_ENABLED(CONFIG_HID_GEMBIRD)
 	{ HID_USB_DEVICE(USB_VENDOR_ID_GEMBIRD, USB_DEVICE_ID_GEMBIRD_JPD_DUALFO=
RCE2) },
 #endif
+#if IS_ENABLED(CONFIG_HID_GEMBIRD_JOY_FF)
+	{ HID_USB_DEVICE(USB_VENDOR_ID_GEMBIRD_JOY, USB_DEVICE_ID_GEMBIRD_JOY_SL=
_6630) },
+#endif
 #if IS_ENABLED(CONFIG_HID_GFRM)
 	{ HID_BLUETOOTH_DEVICE(0x58, 0x2000) },
 	{ HID_BLUETOOTH_DEVICE(0x471, 0x2210) },
=2D-=20
2.52.0



=2D-=20
`Experience is the best teacher.'

PGP Key ID: 4FFFAB21B8580ABD
Fingerprint: E073 6DD8 FF40 9CF2 0665 11D4 4FFF AB21 B858 0ABD
