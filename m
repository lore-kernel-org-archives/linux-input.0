Received: from outbound.st.icloud.com (st-2001h-snip4-11.eps.apple.com [57.103.76.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0314D797D
	for <linux-input@vger.kernel.org>; Wed, 30 Sep 2026 20:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.76.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790799259; cv=none; b=KozGNyOqFsUHST0sYMfnBpaRYRRFHSxlKwMo3TfgBjOkFu5cvfbvJ9aPEHFbxtZ/gNNWTshKbjBdgyUpefgrRi3/LfftjM3wGLIDOzm91oig4hClMGYs0dIxA3J+O463/WNGHp3OFoWOG2/gKNSv0poNl3+cDMJFnnrdwNNiY7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790799259; c=relaxed/simple;
	bh=oGmUFB/MpMNafUA0RMVHIXMbgM0ez4iK/6QDiyjYEcA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sjCLsJW6+iQ+ANQ7WBvgrwqie/3ML6Ig397Txuec5mvIN/DgRFqRV2JTIM01c0TMOWz/QTKI1sxzgdzUqLkXSL/laTEW/nt3j6Z0MnQkqxI1RLNSxL3HaV8Q+ylvkOBVAh47FBBeWIFW6PX5WGWY56LU3752LcSU9XIvmEQFe5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=me.com; spf=pass smtp.mailfrom=me.com; dkim=pass (2048-bit key) header.d=me.com header.i=@me.com header.b=SgMwctvm; arc=none smtp.client-ip=57.103.76.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=me.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=me.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=me.com header.i=@me.com header.b="SgMwctvm"
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-east-1a-10-percent-2 (Postfix) with ESMTPS id B795218000B1;
	Wed, 30 Sep 2026 20:14:15 +0000 (UTC)
X-ICL-RepId: 01a0f3f4-18b1-72cd-8ce1-193cd39d8f39
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQFLHV8HWBxHD1YKTVIPDxYKFkFcWytfFRcbXAAXDVZNVB0dDlgGEgJaRQVNXw5eHwQXRhlVBEceXVZAGRkCURxWDVdDVARfUEkMQVBsWgBHF0gdXRlZb1BdHA4AUkVRH1RYXgRTVg4VXRkHDgZdB0QJSgUPD10DRFxAUVQDWQRHCkFRCwRaBRILHgNaU1lUXghPCl0AUgtAC0AdCl4fHBYKFkFcWytfFRcbXAAJS0YJSR0OBFQHXQVd
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai; t=1790799256; x=1793391256; bh=RMVcVOjzi/nkuaQxubHVcQZHoaKYAiWgakLvYkQNjr4=; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme; b=SgMwctvmDSF1LGoMRbLf+mtGRePeMGQv9MR0qQddEKboDf7f6SOOCCA2rgJDXmi+vLGCdoqLD4kOGK8hhinz0X7f4+2XC8n/sc8q88ql3I1TMekdwPnsAHyhHBz208KI/8UC61JLLhEocHdqwrEXeC0gj2Hb3PD/1fLR08zPIQ2unp+gxQFUtonaz7TpzxFF+50l3mWa30/x/kd/J1kMjRgfqzDQH0vvzAnOsVsQM16r5ByYSLt+BqTCkM5ITkk2FphRDJAgqbb1xLEo5T8nKfdfg+E5dNGrItkiTYB/hTB+E7sXXDEahvXDOgDFAIe9V2qW1Ep9i90mSyNFKlJv6g==
Received: from fedora.vpn.altanet.fr (unknown [17.156.216.30])
	by p00-icloudmta-asmtp-us-east-1a-10-percent-2 (Postfix) with ESMTPSA id 7F95218023EC;
	Wed, 30 Sep 2026 20:14:14 +0000 (UTC)
From: =?UTF-8?q?Ren=C3=A9=20Onier?= <f3nr1l@me.com>
To: Benjamin Tissoires <bentiss@kernel.org>,
	Jiri Kosina <jikos@kernel.org>
Cc: =?UTF-8?q?Ren=C3=A9=20Onier?= <f3nr1l@me.com>,
	Ivan Gorinov <linux-kernel@altimeter.info>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND 2/4] HID: winwing: make the LED set and lighting controller model-dependent
Date: Wed, 30 Sep 2026 16:13:56 -0400
Message-ID: <eda4c1654026b8614e8b9426739bf317b2f07d2f.1790799028.git.f3nr1l@me.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1790799028.git.f3nr1l@me.com>
References: <cover.1790799028.git.f3nr1l@me.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: jr6IE0AUbLc9KMgzRgilhxGZ8sIkU3Cl
X-Authority-Info-Out: v=2.4 cv=YbKwJgRf c=1 sm=1 tr=0 ts=6abd6d97
 cx=c_apl:c_pps:t_out a=oyWFxbOnq+dmhQrAPgaJYA==:117
 a=oyWFxbOnq+dmhQrAPgaJYA==:17 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=M51BFTxLslgA:10 a=x7bEGLp0ZPQA:10 a=tnT-KND3AOYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=HHGDD-5mAAAA:8 a=3PAn0j2qTEdplpVEXuoA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA4MiBTYWx0ZWRfX/eLAhiA4eJL4
 PySfm3176nbGuR6+JnENO0gJA1G/MJ7DEdeQDHyfigmW3WIqStum0/pbL1Uebnmesui932DZVFw
 kuU9xoc+zIOpQ0ygvnTcwSTrJdNtDVM+/O6kqTHSwIXfTL+coqI3UZwMQKYTtOPyQOH2oWA4Nx+
 gARJjoA3X4AEn2GImUwO7HfzVeICCuYYWSydR9D8Ucb8IT07LnGJX1j0WBJYUEVJ2aNYrJ9/vO6
 GilTNyZAjCWBn3SET6aIj64XyWo5l2TV59K0YFhBfW8JOZJPVQCsuDG2ts2jITGbD6+7laf/OC4
 f2p59fONPM41k95tmt0gmovBW1Xb21ACFeBP+Z8N4FVhN8fPLN8X807VUMhiVQ=
X-Proofpoint-GUID: jr6IE0AUbLc9KMgzRgilhxGZ8sIkU3Cl
X-JNJ: AAAAAAABeV5SWYa6oxv+bLS3kGUgIp6NnC2g2p9vsEnYo3XpQvV+gs6RIxtltYI3a5a28ebMbRROp9Xi+ipT2yqOmZFr1lrIgMtWU4c2AuFJA+Iw/phrZMj1gQbz3o1rx+lo/w19Ba7WS9dhuSZgxJCzjV+rtJYWaVxrLfzF9D0nuLKrK/UBqyYm7BSSlquFcEb9fUM7RV+MyPI37rcP685kCpb3B3RZxY+RViI9NEOZ7M5eQ9rEly746qky5M9OuViEta43HAdabkqqSZmAm1hi7oCAKehDLSpRckqn9kgts8O7LDmhIifdxuHT7MVoVR9CokZ4Kpo3CwSfHcLC0WwiJBJhX4TeqdfMtKNt5+w59Bw8Tkv7wq5K0AOMf2+yID59xT179dkMFczAypRTI0Ieow0rzr/HpQ+zddZaP4m79PNl+OqLyZF0yA+8ZO1K7bgFfdKH8JS/Jf8wPp7iQz6vRG6MkatcKIsVuPEOrAh6/uQw1kSRJzVdZA6m0acIzcRbusDtzRJZkNS+z3nk1uwpOMelMcJ6Uqw53hdLhA3vUIDMhU7pRcngwHsNVjh3oUKlfCx1xcHUr86+joruUahI5zz8NQBKoLuLQGkFHIFbKV7q8HJxrXn/Uu0gHMKKB2b8cgP5QzBOqoj3uWn7vV1OPUHHrwlMVGmAFL5ByrDTcSP/qPFcUJ388HQhfbca6fETjCDlpZRXHyjyoRoa2NYkiiOXmQvTVCOs+uhznS/FkdJYPyCz9UaKxSdCJIqOg8K+DMTS2X4aymVs9iwWpPfImdMEgLlVr7xOyQ==
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

