Received: from outbound.ci.icloud.com (ci-2005g-snip4-4.eps.apple.com [57.103.89.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46210457E64
	for <linux-input@vger.kernel.org>; Wed, 30 Sep 2026 19:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.89.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790798183; cv=none; b=aCqOz1INUBYAU8vjAI7pzb8YGrXfkJNlLmruNmY/bM/7gaanxpAkcn3KJIXw+/cWGTu1JqaeqLeGSP+k4hy0FctLxG0cpcZMm9gE4TABJL0r565WgBn+cKM0YQ5Xv9CBvdOiQUXm1wNnde/14DVEwWqL+9N+X/izXpttXN5qPdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790798183; c=relaxed/simple;
	bh=oGmUFB/MpMNafUA0RMVHIXMbgM0ez4iK/6QDiyjYEcA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k09MJLLHXef2mouV3OmwtYe5yzRMaQes6ifAxzdfiT/YYtEwJgmOy8J5GaFebvOF0MZGXzf9a7a26k9R+vYp3lQKEDkICmKOt85VKUiKixsaKrUuWOz+xDHXS1f8zrKGcLFQ0aXG6UFRX6FJx6SGiu3kVyJ9NWXJ2/HmDkWybCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=me.com; spf=pass smtp.mailfrom=me.com; dkim=pass (2048-bit key) header.d=me.com header.i=@me.com header.b=oN4r9Sfn; arc=none smtp.client-ip=57.103.89.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=me.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=me.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=me.com header.i=@me.com header.b="oN4r9Sfn"
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-central-1k-60-percent-1 (Postfix) with ESMTPS id 5890118000D9;
	Wed, 30 Sep 2026 19:56:20 +0000 (UTC)
X-ICL-RepId: 01a0f3e3-afd2-70eb-bc1f-08ca77af964f
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQFLHV8HWBxHD1YKTVIPDxYKFkFcWytfFRcbXAAXDVZNVB0dDlgGEgJaRQVNXw5eHwQXRhlVBEceXVZQBBkCURxWDVdDVARfUEkMQVBsWgBHF0gdXRlZb1BdHA4AUkVRH1RYXgRTVg4VXRkHDgZdB0QJSgUPD10DRFxAUVQDWQRHCkFRCwRaBRILHgNaU1lUXghPCl0AUgdHC04dCl4fHBYKFkFcWytfFRcbXAAJS0YJSR0OBFQHXQVd
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai; t=1790798181; x=1793390181; bh=RMVcVOjzi/nkuaQxubHVcQZHoaKYAiWgakLvYkQNjr4=; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme; b=oN4r9Sfn+jBRFQ/+5I/HmoFF2j7m/qpSy52gxmM1EVyQp7EauZCOfRSZJTYF40pxEKyJnZPWmCZdhbfly3wX3rU7LEW1AdzjOfQyRYychqZrUwjVmSrCQ/M8Na9K2O3KrG4DWRPBGxBBtH/q0aaVP1StYeW1s9AS0aw07LHtzY5U0j4GzIjrj/ozKWKQ3oOjoriQFIFtZGRkj31vupk0Z0HMTDgAbok/2XySf8GQosPnqkBXt8taO36X+m3fRJWHR3vpkOFrV+ix+EF7R6yKREzekmJAPvzJsNgaQPt6p7WuPm8a8jU8KVIzOUs9vIurQj+S078yZyth857vCqGy5A==
Received: from fedora.vpn.altanet.fr (unknown [17.57.156.36])
	by p00-icloudmta-asmtp-us-central-1k-60-percent-1 (Postfix) with ESMTPSA id D91C5180013B;
	Wed, 30 Sep 2026 19:56:18 +0000 (UTC)
From: =?UTF-8?q?Ren=C3=A9=20Onier?= <f3nr1l@me.com>
To: Benjamin Tissoires <bentiss@kernel.org>,
	Jiri Kosina <jikos@kernel.org>
Cc: =?UTF-8?q?Ren=C3=A9=20Onier?= <f3nr1l@me.com>,
	Ivan Gorinov <linux-kernel@altimeter.info>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] HID: winwing: make the LED set and lighting controller model-dependent
Date: Wed, 30 Sep 2026 15:55:58 -0400
Message-ID: <eda4c1654026b8614e8b9426739bf317b2f07d2f.1790795726.git.f3nr1l@me.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA4MSBTYWx0ZWRfX5vLQqlmM8Lix
 uuqfT5QbZaXKynZ65eXcKdJj1KvYozOyccK8JdyXnSBicmVij6b17DCHVjBcGvm5jXiN3YyfQjq
 j1KQ5+/4bnIuCQZoeZh5GGnk6RJtGQhdORteQjy3u4vGeXdqMPJTB4L7QGXEu76F1Rvo/wq3FeT
 FvVxrnXUifPSbLWb+WvHlfQ585BZVxZBFLE+ab7ff6AyDtsZaCul7s0p7OvchK90gI23rTzyuzF
 zUrdeKC+nOWbd4ff2Fl51S7weYICDWHtixAHI1Vo4rGpHeMAnhQvj4GqjC2X1ndAPRS5uH5POeY
 IpxJyLSzpUaYzyktlFNiDnUmCVOc3hrYNLTKtt+pZ83nHaadb/gIod+E7uDe7Y=
X-Proofpoint-ORIG-GUID: n93gFiBoQ6X3h7vuGo3rhQUnMHGsnn0b
X-Proofpoint-GUID: n93gFiBoQ6X3h7vuGo3rhQUnMHGsnn0b
X-Authority-Info-Out: v=2.4 cv=TembdBQh c=1 sm=1 tr=0 ts=6abd6964
 cx=c_apl:c_pps:t_out a=2G65uMN5HjSv0sBfM2Yj2w==:117
 a=2G65uMN5HjSv0sBfM2Yj2w==:17 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=M51BFTxLslgA:10 a=x7bEGLp0ZPQA:10 a=tnT-KND3AOYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=HHGDD-5mAAAA:8 a=3PAn0j2qTEdplpVEXuoA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-JNJ: AAAAAAABiLpizMv7Ihz2xLrsik15WQsBqtmFkDXOSNpch38hmk5E81Pi2XVnzPc6cfQkSVsYoMiii1jsbKOjSqc8xM0ME9Lux6f29M7T/xwUvxoTXmxlmqZomCoTVc1nD5IMIaptHd6/TiJF0wqbomS8DXEgBQKxBpL+jbA2XynU/wm3ZXXV6GFQOx8IAxnGJieEpn/zEfxJ/SBjU1uMVGLF3KwM4Ljaf2YA08Vk54CbOh5jDCXEFXlDPxl14s7NKW1jHyU+hqhmoDCT1I1UE24CB2NFA5n8yensez/8dVEK41t+lPY1dnVAJYYoIl9IQlU/PLre0AEpoDhyoLD+hyszWb1Gfr2+l0U40yznZhi5rB5tNDVAVQr3Huf2J+f6WqOqib7ekNMpo3J3tDfB0BJ8L7ex2I8FLFxs2AGKrI7LxUPlEcwvMB+VFOFX8rZ/2gE7nysfwfPkOfeLXiU7mDapaWJmGIYBhvoru30fLyiTxFOQ9xs02CzR8Z+dCAMcd/khHBGWH8rRSfDlTz5LNYc70zALsdNlg/9gGwyz/2b2EV3L/TEGhPRmuJIFC0viHtZnj48VG32lvEsCOkJEnHN0EtsCxm2rksIGJz/4G/A32/OC28QSg/HO91gu+afDIU7/kTwasFZA0RmoIjeXU9QmidzT2XuvHCizPJmGk3Kh+puFFFAfxbEoA9ONxvq3DFz+X743Eds1BZV32n7RE5fTBpW5uXmnvreiT+4gFgsDPWE+e6Gu+k6Ky98ARy+w4l7IuXOyusVjs4putEwi0ZqB9a3Osg6siI7E6Tp3TQ==
X-Apple-Category-Label: MjczODQ1OTkzOiRjYXRlZ29yeSRfUGVyc29uYWws

The driver hardcodes the three LEDs of the Orion 2 throttle base and the
lighting controller they are addressed to. Other WinWing devices speaking
this protocol carry a different LED set on a different controller, so
move both to the per-device data and select them once at init time.

Turn has_grip15 into a quirk mask at the same time, so that a model can
be described by more than one bit.

No functional change: the Orion 2 keeps its three LEDs on device 0x60,
family 0xbe, and the same button mapping.

Signed-off-by: René Onier <f3nr1l@me.com>
---
 drivers/hid/hid-winwing.c | 52 ++++++++++++++++++++++++++-------------
 1 file changed, 35 insertions(+), 17 deletions(-)

diff --git a/drivers/hid/hid-winwing.c b/drivers/hid/hid-winwing.c
index a9bf81c19f..9ec0d2cf53 100644
--- a/drivers/hid/hid-winwing.c
+++ b/drivers/hid/hid-winwing.c
@@ -40,6 +40,9 @@
 #define WINWING_RUMBLE_LEFT_DEVICE	0x01
 #define WINWING_RUMBLE_RIGHT_DEVICE	0x03
 
+/* Grip with a rumble motor and more than 32 buttons */
+#define WINWING_GRIP15		BIT(0)
+
 struct winwing_led {
 	struct led_classdev cdev;
 	struct hid_device *hdev;
@@ -52,7 +55,7 @@ struct winwing_led_info {
 	const char *led_name;
 };
 
-static const struct winwing_led_info led_info[3] = {
+static const struct winwing_led_info orion2_led_info[] = {
 	{ 0, 255, "backlight" },
 	{ 1, 1, "a-a" },
 	{ 2, 1, "a-g" },
@@ -67,7 +70,13 @@ struct winwing_drv_data {
 	struct ff_rumble_effect rumble;
 	int rumble_left;
 	int rumble_right;
-	int has_grip15;
+	unsigned long quirks;
+
+	/* Lighting controller and LED set of this model */
+	unsigned int num_leds;
+	__u8 led_device;
+	__u8 led_family;
+
 	struct winwing_led leds[];
 };
 
@@ -104,7 +113,7 @@ static int winwing_led_write(struct led_classdev *cdev,
 	mutex_lock(&data->lights_lock);
 
 	ret = winwing_send_set_ledx(led->hdev, data->report_lights,
-			ORION2_LIGHT_DEVICE, ORION2_LIGHT_FAMILY,
+			data->led_device, data->led_family,
 			led->number, br);
 
 	mutex_unlock(&data->lights_lock);
@@ -115,10 +124,11 @@ static int winwing_led_write(struct led_classdev *cdev,
 static int winwing_init_led(struct hid_device *hdev,
 		struct input_dev *input)
 {
+	const struct winwing_led_info *table;
 	struct winwing_drv_data *data;
 	struct winwing_led *led;
-	int ret;
-	int i;
+	int ret = 0;
+	unsigned int i;
 
 	data = hid_get_drvdata(hdev);
 
@@ -130,8 +140,13 @@ static int winwing_init_led(struct hid_device *hdev,
 	if (!data->report_lights)
 		return -ENOMEM;
 
-	for (i = 0; i < 3; i += 1) {
-		const struct winwing_led_info *info = &led_info[i];
+	table = orion2_led_info;
+	data->num_leds = ARRAY_SIZE(orion2_led_info);
+	data->led_device = ORION2_LIGHT_DEVICE;
+	data->led_family = ORION2_LIGHT_FAMILY;
+
+	for (i = 0; i < data->num_leds; i += 1) {
+		const struct winwing_led_info *info = &table[i];
 
 		led = &data->leds[i];
 		led->hdev = hdev;
@@ -155,7 +170,7 @@ static int winwing_init_led(struct hid_device *hdev,
 	return ret;
 }
 
-static int winwing_map_button(int button, int has_grip15)
+static int winwing_map_button(int button, int map_more_buttons)
 {
 	if (button < 1)
 		return KEY_RESERVED;
@@ -179,7 +194,7 @@ static int winwing_map_button(int button, int has_grip15)
 		return (button - 65) + BTN_TRIGGER_HAPPY17;
 	}
 
-	if (!has_grip15) {
+	if (!map_more_buttons) {
 		/*
 		 * Not mapping numbers [33 .. 64] which
 		 * are not assigned to any real buttons
@@ -232,7 +247,7 @@ static int winwing_input_mapping(struct hid_device *hdev,
 	/* Button numbers start with 1 */
 	button = usage->hid & HID_USAGE;
 
-	code = winwing_map_button(button, data->has_grip15);
+	code = winwing_map_button(button, data->quirks & WINWING_GRIP15);
 
 	hid_map_usage(hi, usage, bit, max, EV_KEY, code);
 
@@ -368,7 +383,7 @@ static int winwing_probe(struct hid_device *hdev,
 		return -ENOMEM;
 
 	data->hdev = hdev;
-	data->has_grip15 = id->driver_data;
+	data->quirks = id->driver_data;
 	hid_set_drvdata(hdev, data);
 
 	mutex_init(&data->lights_lock);
@@ -414,18 +429,21 @@ static int winwing_input_configured(struct hid_device *hdev,
 	if (ret)
 		hid_err(hdev, "led init failed\n");
 
-	if (data->has_grip15)
+	if (data->quirks & WINWING_GRIP15)
 		winwing_init_ff(hdev, hidinput);
 
 	return ret;
 }
 
-/* Set driver_data to 1 for grips with rumble motor and more than 32 buttons */
 static const struct hid_device_id winwing_devices[] = {
-	{ HID_USB_DEVICE(0x4098, 0xbd65), .driver_data = 1 },  /* TGRIP-15E  */
-	{ HID_USB_DEVICE(0x4098, 0xbd64), .driver_data = 1 },  /* TGRIP-15EX */
-	{ HID_USB_DEVICE(0x4098, 0xbe68), .driver_data = 0 },  /* TGRIP-16EX */
-	{ HID_USB_DEVICE(0x4098, 0xbe62), .driver_data = 0 },  /* TGRIP-18   */
+	{ HID_USB_DEVICE(0x4098, 0xbd65),      /* TGRIP-15E  */
+	  .driver_data = WINWING_GRIP15 },
+	{ HID_USB_DEVICE(0x4098, 0xbd64),      /* TGRIP-15EX */
+	  .driver_data = WINWING_GRIP15 },
+	{ HID_USB_DEVICE(0x4098, 0xbe68),      /* TGRIP-16EX */
+	  .driver_data = 0 },
+	{ HID_USB_DEVICE(0x4098, 0xbe62),      /* TGRIP-18   */
+	  .driver_data = 0 },
 	{}
 };
 
-- 
2.55.0

