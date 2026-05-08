Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1843242D8
	for <linux-input@vger.kernel.org>; Fri,  8 May 2026 17:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778262890; cv=none; b=bQsDKqMsmLqBT2TPuJcoebInBTwqvnN3UNJgs2VnlSi+gDRBJp1B6GkG3oV+7n9dIqo443yEfbzJ2QJ7bon0WAIBHPBn8RPH2lZ/7NXnWe57umCvaqPcToPsORSSTm9NNpmwt5a6/9cgBU78tRJWYKu46M/8OagQRpDD8jb2Zfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778262890; c=relaxed/simple;
	bh=kSgqF/sk9EdBdub3ainGSzy1cGpcwqgH0epPSuIbvfA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=dF7qh39Jg6Nhy7//hZINLINglS1lLqld4mG0LQjIMG55IYh/fpOYxMAGhvBYaE+MdvF+n7aUdwQ0snUpm2f8nVCbvfqOnUoa9+zkFloJMkjzqDUyEV4pD2f7RtS02RM1gXAeC0qSNY7gfjDfLM39T68Cm64EuA4IdmYfCJhKz1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.at; spf=pass smtp.mailfrom=gmx.at; dkim=pass (2048-bit key) header.d=gmx.at header.i=h.judt@gmx.at header.b=leV4+0H/; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.at header.i=h.judt@gmx.at header.b="leV4+0H/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.at;
	s=s31663417; t=1778262886; x=1778867686; i=h.judt@gmx.at;
	bh=D8wje0vPOWWsq74usZPPnhWahBOMkEd1b5gdtMMsaFk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:From:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=leV4+0H/8adhin4pd2URlzSeyQidSixBTUQFKiEWmhUUp0VMHUTQ72XTIZ9dVOfi
	 Oxpj9+72QqGt7ckzhP/26UwHvpAulOtj8R5MPJRRARVPQmeRlBwq6XbC1cmHutyhN
	 V+3TrHEpY6RqHmLzbCaz2wOGWgka4r7gmkca9zVHbqxBHya1cPFsXhCjMuzJv44PW
	 40sB2RRHYZ46xSvI/8hNVILCp9tUN8T4w5WxuUF6GYwnK+WzGTHfeczDFYYsGYx47
	 NvEBz+nOXrTIvlSBDnwKj0C7xCmuVmH21Gq/26E+k8SwOKY4NedkmP1pukTT9TyZy
	 FxGGjrQcqG9/mWdbCg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MqJm5-1vYr2c44W3-00fJGd; Fri, 08
 May 2026 19:54:46 +0200
Message-ID: <b3bfa73b-0547-45f9-b6ae-f28815e6c632@gmx.at>
Date: Fri, 8 May 2026 19:54:45 +0200
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Harald Judt <h.judt@gmx.at>
Subject: [PATCH RESEND 2] HID: Add force feedback support for Speedlink Cougar
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
X-Provags-ID: V03:K1:TmUcqNV8QmlsqvUvk1JsPX+n/nJJxtyGlEuGgLxCHMufXBczMCl
 i/txUkbyMy3bjP1+xsKLkvxuvTZh9/XM/TzjbIgQlaVQbmt3Z/nxih4YrKpMQTMPL2sTJ22
 n4arrECoNsW/nl65WCmeD24Vo/srVzRZQHAzFiFxY7YAX7VSRybLgJMasRio3BECrr1D5Ad
 G4S/2hQ8vQdcuDwMiv+4g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:4T9WVt0/lGU=;rYp3HLhspt15eSQvS5fLnBPWSKs
 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

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
