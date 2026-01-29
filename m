Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813702BD0B
	for <linux-input@vger.kernel.org>; Thu, 29 Jan 2026 13:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769691620; cv=none; b=WGNyI79mtKLHCvxVTD58I1uZushe9Oq6Pa77psBb+UMa4KIDY7XwuEK1yXg2fYyWTtDd8cAKyy8YR02DRlhY+1wmk0OugPRMgXrVllUEubcYUgBYpTCdC6Grivk7tT9xvo5hwG8LgIddfKs2uhyEnkbn+RJ/0VtsrwFik+s6V/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769691620; c=relaxed/simple;
	bh=kSgqF/sk9EdBdub3ainGSzy1cGpcwqgH0epPSuIbvfA=;
	h=Message-ID:Date:MIME-Version:From:Subject:Cc:To:Content-Type; b=kNxEE/s4rS2QRAyPymTgM99K/+GOh8CjMzRGJlpKgUOQIDMoXLLjXR4g/wU4ifMJxxj6O87bA5HSoQBm07nWUL0H2VYoHBv0FZPaaD5eFn07CQ3C+GnkebFe2qMKDa22g56xFIHO29KoozSZc6n6fRSyMZiDokYiIt5u8w+6SLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.at; spf=pass smtp.mailfrom=gmx.at; dkim=pass (2048-bit key) header.d=gmx.at header.i=h.judt@gmx.at header.b=m1NshfEv; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.at header.i=h.judt@gmx.at header.b="m1NshfEv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.at;
	s=s31663417; t=1769691616; x=1770296416; i=h.judt@gmx.at;
	bh=D8wje0vPOWWsq74usZPPnhWahBOMkEd1b5gdtMMsaFk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:From:Subject:Cc:
	 To:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=m1NshfEvfF1kG3/YFCvPIzVsgyuBvjwHntey6fANutRNaB4DJWhpMqn2MyWplfVE
	 hDx1ddJZRAzxJf9PmFNQk/324xWVnB4+alqJfS4fZVlTaJQJyEH0xVYRcbWdp41+X
	 WE1NwBjgj3PT9skVl8tSP1Vv5bQCanC+Vm9MfAdmfcJOM6M4nEWhaJjx0yG2TUI5z
	 4H4CDxnt+cFTz8ExcUVzNH14414+2mVEzmlSTb3xiXALrKDbG8QFlqM83zs/B8xMV
	 o3ZG8RB2Eye1c+D5JQn8QDceqHiPiALBkcwCCqhRsxDS2WM+7oxvVEnGyknV8C4YO
	 hFeYGE6OYTHrNV6jIQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [131.130.2.239] ([131.130.2.239]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MLQxX-1vSx8t2E0R-00MptI; Thu, 29
 Jan 2026 14:00:16 +0100
Message-ID: <8c2d3d0d-ff68-4e39-97a0-c6a397142455@gmx.at>
Date: Thu, 29 Jan 2026 14:00:16 +0100
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Harald Judt <h.judt@gmx.at>
Subject: [PATCH] HID: Add force feedback support for Speedlink Cougar
 Vibration Flightstick
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
Cc: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5gcteF9JM10kgYCTh6qcG/iybLQYwQJDGT3QmCWzkLPGyOSeDOu
 sj0ireX3iuPqfQm5P7YiQ67SYhwetNRad6Ft4GoDvAICVMpX1+I55I08Kcgj9UU2Ts5CVsC
 8b5q79tnuklfvf4cKCeLi7J9qkXMuGJ57cRVLn4yN+80V/bUuM6BwmgHWmrA9d6vam2w9TS
 fI4aIJmmu9Or6g9Ss72rQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:EPVb+GscdSU=;i9qTDZXPbT4j+ZrpwU9KFU71J+G
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
