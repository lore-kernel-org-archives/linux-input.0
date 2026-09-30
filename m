Received: from outbound.ci.icloud.com (ci-2005a-snip4-11.eps.apple.com [57.103.89.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13CBE3DFC8F
	for <linux-input@vger.kernel.org>; Wed, 30 Sep 2026 19:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.89.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790798185; cv=none; b=lQqlo7KNcljSQQeqIWLn0NXpffRpNfttV2eiBjQqohPuaze9oHGJd3IdVmea/6b2qiBhoYWyf+qmjn69SFxEVbJN4yKa/nfsNO6qoBzu8RPPymGlcn5JvMmyCrBLK6yUh48VagqGVFOZIGvAxi45jBiSoBFaQ4FAr+IwnLQhtew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790798185; c=relaxed/simple;
	bh=FylAniorHMlsOLB18+DfWM08WqD+I0iZWuxR/Zyg5i4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UJ2/wSVBxANGUHZwV8NmwMWadhHU+A0UZh2P47zioO5VsB9416mM1UhkTZ4MMm32K5Mt2Rtx3UksUiAOyiZRQp1m+jceg0IIuUU1h783kYuxQ9ybXQLERJoPJx8q0LyLiQ0hhicZaHQbJDcXRmW0JyL90UT20AOFVSMgRodwry8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=me.com; spf=pass smtp.mailfrom=me.com; dkim=pass (2048-bit key) header.d=me.com header.i=@me.com header.b=CIoar4ly; arc=none smtp.client-ip=57.103.89.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=me.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=me.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=me.com header.i=@me.com header.b="CIoar4ly"
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-central-1k-60-percent-1 (Postfix) with ESMTPS id B335E18002FF;
	Wed, 30 Sep 2026 19:56:21 +0000 (UTC)
X-ICL-RepId: 01a0f3e3-b534-74de-9e67-2b05e09419b8
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQFLHV8HWBxHD1YKTVIPDxYKFkFcWytfFRcbXAAXDVZNVB0dDlgGEgJaRQVNXw5eHwQXRhlVBEceXVZQBBkCURxWDVdDVARfUEkMQVBsWgBHF0gdXRlZb1BdHA4AUkVRH1RYXgRTVg4WXxwGXQIKBENaHFdVUg4HFVhKUFhUU1FEDE5VWwFSAxZfGgFeBFoLXghPCl0AUgdHC04dCl4fHBYKFkFcWytfFRcbXAAJS0YJSR0OBFQHXQVd
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai; t=1790798183; x=1793390183; bh=fpRyjS3+nFbyMghKSXBZCh9+3JyVCsE1S+K5csnzqIk=; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme; b=CIoar4lya23Kr4EKOEhFBMbItSEVUfQo6N6qh89s4PGdg6k+ZmbVNREVGo88m3tf+2eo55Y53T0RTcATYe0iszUMy6wTo+nAczR4Aj/d44DVmVS+K2CPv9C7FxzQZr2crWlNE0u4oz1Q37zcHQpvDbSp1X4CaZ/2GLnbNp3EjsDVdjf32CzKYT2+N0Gkiy6FoEMS97KuQT6yYTKhSJmR1giFEfnzJv+qNaDLF7gwFKpALHfEeOSAUNdHQSgT+Z5/kBpyxjjiyjc4Xn2AxK1QH/6GtZa3Ked3nUUVjRw/SpnmnB40UXbDIzZ5eugj86DcT04N7saHiE3uK/FzgUWR2Q==
Received: from fedora.vpn.altanet.fr (unknown [17.57.156.36])
	by p00-icloudmta-asmtp-us-central-1k-60-percent-1 (Postfix) with ESMTPSA id 3C9EE180010E;
	Wed, 30 Sep 2026 19:56:20 +0000 (UTC)
From: =?UTF-8?q?Ren=C3=A9=20Onier?= <f3nr1l@me.com>
To: Benjamin Tissoires <bentiss@kernel.org>,
	Jiri Kosina <jikos@kernel.org>
Cc: =?UTF-8?q?Ren=C3=A9=20Onier?= <f3nr1l@me.com>,
	Ivan Gorinov <linux-kernel@altimeter.info>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] HID: winwing: add URSA MINOR sticks
Date: Wed, 30 Sep 2026 15:55:59 -0400
Message-ID: <ffd505a63cdd8ee5ea2c5c8c456f6691ffb23319.1790795726.git.f3nr1l@me.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1790795726.git.f3nr1l@me.com>
References: <cover.1790795726.git.f3nr1l@me.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=SomdKfO0 c=1 sm=1 tr=0 ts=6abd6966
 cx=c_apl:c_pps:t_out a=2G65uMN5HjSv0sBfM2Yj2w==:117
 a=2G65uMN5HjSv0sBfM2Yj2w==:17 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=M51BFTxLslgA:10 a=x7bEGLp0ZPQA:10 a=tnT-KND3AOYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=HHGDD-5mAAAA:8 a=glSO5LrR8QfL-eKqMXQA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 7Pg6vc5JGyBZdSfUWgtHBO3iYEuVRKwk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA4MSBTYWx0ZWRfX6SHE6lpEQscQ
 h8tL9KsyzokEYc3vGG8uY3rGQv/saNrc6sTh43FlJVkPOpc/ZKp2N9lkpsuTIhgig0qEoxDt8gr
 0CRdPFDLzwOAtfwlyCk5zqK7sCE4v32gBSoNICfOCLY6ogzaBwL/LxtwQeIiwgQH/4fVOt2ehjg
 MDe+WfeBHOL2cOfa0xRqOiC2GLppOZLZqysdiwhnTFASUT8fiKIM1bFUJ8c31Y9IAROEh+ZsJp7
 tJaglYIpESTsa0l4JXDfjSPFmsEuoe9SjTCeSo1uOVrsnZ1O63vryNvhBuBpUDLsScoCH0Z5OVK
 jIT1v/pIPRV9PV30TPpD2d4OLyi6C/tbn6NWv87AwrTBYraiQpYhDqMfo6okTc=
X-Proofpoint-ORIG-GUID: 7Pg6vc5JGyBZdSfUWgtHBO3iYEuVRKwk
X-JNJ: AAAAAAABjjcBhG1Umjft4jt9FYAkMYbJbg1w+nzrVztKWwc010PWOMlNOG1QLCSCW6pS1/0qNXALPqpwmOraP2azVmcZxsno46RkhPTGtkxwY72h/I0D78agwMSGoXWnHVg0w0AN17hIf4Q/XRJG613KEnAzHyB7o1n4d2H4ii41SivkcFCGIVeoer5vf73vFioNpHqtv79fxTJETJk1A9sd1ytUiOKsUuhNUxjJU93p94XyyeIv4n7W4mmu5iH513kRC1BWyObLPYkAUyYWC2tz7zneKYQ+GVnVtEQVnm8B8C92uyaCyFItLuF5zfdCeE6ZS8IPvRCnaTe545NbdSScI0ZKIqhZDiEstH0yapoeHJou6zOQFeO9HNYKWsnt+nrciFELEbA0ivdVEmT4HtzoS+SsBdf1pGR0kMGgzVxi7iOhCjJl6KLTINagMktqTQBSvQVoHz5ZCuOKx15+b6qhoc6bt40b8+J4E4zXxueMQUhcrmgU9vgVDPq/Dvu3GuasJp5SDE09kmdJFhBS4/oRjfF2i+BeYF/3aKo846y3ylhYwM1Fb5oKx0+Kcjp1flT3dEgURrb41TtlS1RlUGzYkToKTXw8Ww/nGXUyIhnOPavvi9bKyaTd+/y7oAWJH8H0FciZAp+heiWvo0FHFc5sW22Q6RfKhsciTewTgZv2WXm0WeScFSJycaJNMY8UlCUEztvsnP/W1hRqlodsy4onud2NLTIEQMvjMNdNMvo9XDPmdHNZZxM8a6Gm1qSFyBO4oaSfh6HG51qnPHQqt7/ogVXPUETD00oldeU=
X-Apple-Category-Label: MjczODQ1OTkzOiRjYXRlZ29yeSRfUGVyc29uYWws

The URSA MINOR is a single-handed stick sold as a left/right pair, each
hand enumerating as its own USB device. It speaks the same vendor
protocol as the Orion 2 throttle, so reuse the LED code for it.

A stick exposes two controllers on the same endpoint, both named by the
vendor software: the base, J5_BASE, which answers on device 0x20, family
0xbb, and drives a single backlight, and the grip, JGRIP_F1_L or
JGRIP_F1_R, which carries the rumble motor. The a-a and a-g indicators of
the Orion 2 belong to an F/A-18 throttle panel and have no counterpart on
a stick, so give the sticks their own LED table.

The grips carry more than 32 buttons and so take the extended button
mapping as well. Their rumble motor is driven by a report the two-motor
throttle path does not send, and is added separately.

Signed-off-by: René Onier <f3nr1l@me.com>
---
 drivers/hid/hid-winwing.c | 54 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 47 insertions(+), 7 deletions(-)

diff --git a/drivers/hid/hid-winwing.c b/drivers/hid/hid-winwing.c
index 9ec0d2cf53..a52e7efece 100644
--- a/drivers/hid/hid-winwing.c
+++ b/drivers/hid/hid-winwing.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 
 /*
- * HID driver for WinWing Orion 2 throttle
+ * HID driver for WinWing Orion 2 throttle and URSA MINOR sticks
  *
  * Copyright (c) 2023 Ivan Gorinov
  */
@@ -35,6 +35,16 @@
 #define ORION2_LIGHT_DEVICE	0x60
 #define ORION2_LIGHT_FAMILY	0xbe
 
+/*
+ * Each URSA MINOR stick exposes two controllers on the same endpoint. The
+ * vendor software names them J5_BASE (0xbb20), the base, which carries the
+ * backlight, and JGRIP_F1_L and JGRIP_F1_R (0xbf09 and 0xbf0a), the grips,
+ * which carry the rumble motor. Each of these ids is the family byte followed
+ * by the device byte. The base answers on the same id on either hand.
+ */
+#define URSA_LIGHT_DEVICE	0x20
+#define URSA_LIGHT_FAMILY	0xbb
+
 /* Rumble motors of the TGRIP-15 grips, one report each */
 #define WINWING_STICK_FAMILY		0xbf
 #define WINWING_RUMBLE_LEFT_DEVICE	0x01
@@ -42,6 +52,8 @@
 
 /* Grip with a rumble motor and more than 32 buttons */
 #define WINWING_GRIP15		BIT(0)
+/* URSA MINOR stick, one USB device per hand */
+#define WINWING_URSA_MINOR	BIT(1)
 
 struct winwing_led {
 	struct led_classdev cdev;
@@ -61,6 +73,17 @@ static const struct winwing_led_info orion2_led_info[] = {
 	{ 2, 1, "a-g" },
 };
 
+/*
+ * The URSA MINOR sticks have a single monochrome backlight. The a-a and a-g
+ * indicators of the Orion 2 belong to an F/A-18 throttle panel and have no
+ * counterpart here.
+ */
+static const struct winwing_led_info ursa_led_info[] = {
+	{ 0, 255, "backlight" },
+};
+
+#define WINWING_MAX_LEDS	ARRAY_SIZE(orion2_led_info)
+
 struct winwing_drv_data {
 	struct hid_device *hdev;
 	struct mutex lights_lock;
@@ -140,10 +163,17 @@ static int winwing_init_led(struct hid_device *hdev,
 	if (!data->report_lights)
 		return -ENOMEM;
 
-	table = orion2_led_info;
-	data->num_leds = ARRAY_SIZE(orion2_led_info);
-	data->led_device = ORION2_LIGHT_DEVICE;
-	data->led_family = ORION2_LIGHT_FAMILY;
+	if (data->quirks & WINWING_URSA_MINOR) {
+		table = ursa_led_info;
+		data->num_leds = ARRAY_SIZE(ursa_led_info);
+		data->led_device = URSA_LIGHT_DEVICE;
+		data->led_family = URSA_LIGHT_FAMILY;
+	} else {
+		table = orion2_led_info;
+		data->num_leds = ARRAY_SIZE(orion2_led_info);
+		data->led_device = ORION2_LIGHT_DEVICE;
+		data->led_family = ORION2_LIGHT_FAMILY;
+	}
 
 	for (i = 0; i < data->num_leds; i += 1) {
 		const struct winwing_led_info *info = &table[i];
@@ -368,7 +398,7 @@ static int winwing_probe(struct hid_device *hdev,
 		const struct hid_device_id *id)
 {
 	struct winwing_drv_data *data;
-	size_t data_size = struct_size(data, leds, 3);
+	size_t data_size = struct_size(data, leds, WINWING_MAX_LEDS);
 	int ret;
 
 	ret = hid_parse(hdev);
@@ -444,6 +474,16 @@ static const struct hid_device_id winwing_devices[] = {
 	  .driver_data = 0 },
 	{ HID_USB_DEVICE(0x4098, 0xbe62),      /* TGRIP-18   */
 	  .driver_data = 0 },
+	/*
+	 * The Fighter and Space variants are electrically identical and share
+	 * these product ids; only the stick tilt accessory differs. The Civil
+	 * variant, which has fewer buttons, is likely compatible, but its
+	 * product ids have not been verified on hardware.
+	 */
+	{ HID_USB_DEVICE(0x4098, 0xbc2a),      /* URSA MINOR R */
+	  .driver_data = WINWING_GRIP15 | WINWING_URSA_MINOR },
+	{ HID_USB_DEVICE(0x4098, 0xbc29),      /* URSA MINOR L */
+	  .driver_data = WINWING_GRIP15 | WINWING_URSA_MINOR },
 	{}
 };
 
@@ -459,5 +499,5 @@ static struct hid_driver winwing_driver = {
 };
 module_hid_driver(winwing_driver);
 
-MODULE_DESCRIPTION("HID driver for WinWing Orion 2 throttle");
+MODULE_DESCRIPTION("HID driver for WinWing Orion 2 throttle and URSA MINOR sticks");
 MODULE_LICENSE("GPL");
-- 
2.55.0

