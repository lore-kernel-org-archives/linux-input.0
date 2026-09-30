Received: from outbound.st.icloud.com (st-2001j-snip4-3.eps.apple.com [57.103.76.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E324BFE77
	for <linux-input@vger.kernel.org>; Wed, 30 Sep 2026 20:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.76.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790799262; cv=none; b=hy8QbyTvfGX/QBp1q8B4B+Rr40uERulezAJWnTJeQ5JE/2Uzz0HJ8M0+ts927AD1TGFUWahEBKEcXvKksx+0wlYItGO10Rrar+bW/YGZ6wMSmNr5L4W3G9zL88V11QW9/ZZLD62OiBOH3MCmiVjCrNOzOywPvRwFjrRrhrSyyGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790799262; c=relaxed/simple;
	bh=FylAniorHMlsOLB18+DfWM08WqD+I0iZWuxR/Zyg5i4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nGr6Z9dhx4nF51GB30XUKy/xgpVzB2Fog8eU4NnHqfD8FELpZzMj7Wn6C9Enzqo0HxX5LMRLXqhSoQ3UrtrOZRtzGK09nqYaTGbIs0MAdc5D9/SdY6Vw+EAXskrYcQWgQsxMKlxIEJVJzRXChDOwFwbN9HxAlYikX+F+B6qCfoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=me.com; spf=pass smtp.mailfrom=me.com; dkim=pass (2048-bit key) header.d=me.com header.i=@me.com header.b=UWIcWVyR; arc=none smtp.client-ip=57.103.76.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=me.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=me.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=me.com header.i=@me.com header.b="UWIcWVyR"
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-east-1a-10-percent-2 (Postfix) with ESMTPS id 5B01A1800AEF;
	Wed, 30 Sep 2026 20:14:19 +0000 (UTC)
X-ICL-RepId: 01a0f3f4-26d7-7c0d-9196-1bca16c869eb
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQFLHV8HWBxHD1YKTVIPDxYKFkFcWytfFRcbXAAXDVZNVB0dDlgGEgJaRQVNXw5eHwQXRhlVBEceXVZAGRkCURxWDVdDVARfUEkMQVBsWgBHF0gdXRlZb1BdHA4AUkVRH1RYXgRTVg4WXxwGXQIKBENaHFdVUg4HFVhKUFhUU1FEDE5VWwFSAxZfGgFeBFoLXghPCl0AUgtAC0AdCl4fHBYKFkFcWytfFRcbXAAJS0YJSR0OBFQHXQVd
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai; t=1790799260; x=1793391260; bh=fpRyjS3+nFbyMghKSXBZCh9+3JyVCsE1S+K5csnzqIk=; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme; b=UWIcWVyRsXaRHkTKUrJEn5yN9h9Zv33H3dSiyCAjnLtLPrtoZf5EodTH5zCUNd02v+UudFs7z+/5yrrxWsBIWDNfYvMQrTK7D8FNoh+sF9o+sbSDR/OLzPsl/fn5MJmhfJvwc9jwU63TWxLbGSNBsihsBpxhnSxp0HCLJZCE00FJMdAw1g/uTCrVLEMtbEolSU/UlM8Hk+zeoo34ac+qd5ZyXLePYXHmDyZXX71HkdfPA9AcQ6qUx8c3TBCgfD3Jd66t4tYdpZ/TleVdlrTf3QYXDmgRQsb/HDjs0ZgS7ni24JnbMy/yn7Eon8AVsDGRaRVwu9ut4VOHrHgXxDXKIQ==
Received: from fedora.vpn.altanet.fr (unknown [17.156.216.30])
	by p00-icloudmta-asmtp-us-east-1a-10-percent-2 (Postfix) with ESMTPSA id 1F8431802FD0;
	Wed, 30 Sep 2026 20:14:17 +0000 (UTC)
From: =?UTF-8?q?Ren=C3=A9=20Onier?= <f3nr1l@me.com>
To: Benjamin Tissoires <bentiss@kernel.org>,
	Jiri Kosina <jikos@kernel.org>
Cc: =?UTF-8?q?Ren=C3=A9=20Onier?= <f3nr1l@me.com>,
	Ivan Gorinov <linux-kernel@altimeter.info>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND 3/4] HID: winwing: add URSA MINOR sticks
Date: Wed, 30 Sep 2026 16:13:57 -0400
Message-ID: <ffd505a63cdd8ee5ea2c5c8c456f6691ffb23319.1790799028.git.f3nr1l@me.com>
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
X-Proofpoint-GUID: xdMxW3gjMeq2KSLNqKnwnLH8SDAHRGzd
X-Proofpoint-ORIG-GUID: xdMxW3gjMeq2KSLNqKnwnLH8SDAHRGzd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA4MiBTYWx0ZWRfX1bigrRr7LJE3
 1kPt1HZGEsp2OfeV6K9WcOOm8E9OnYvB1qFQom27lKVukFeYiZrFdv7sU8KvTmTtrhoobGGF16H
 FA2hZzX+ETkntg21Mp8p3C72+SL2CqMhwYe0HfKB82xUqVecapXmlsPu0eGVPT9CQLtLvCTc+mV
 BEEXwggzlzIK9jyBLAF5vUjiJWgmPjf7AD3gqhfARyOy/oShjQ4i20zGPD4hrLH6A27iHt6FlP+
 kH/brjmwRsSKWPeGUJf3J7HLTwR6Ix6SnXLccOkoNv50tU0Fj2hsaxR1Y1m2XO+856gn7VoU9HA
 MJDf906PHydteibV5q9x0Ao0vThNc2rkpGc7bczluv743r5rA7vxHRGGz/DzBU=
X-Authority-Info-Out: v=2.4 cv=N+Uk1m9B c=1 sm=1 tr=0 ts=6abd6d9b
 cx=c_apl:c_pps:t_out a=oyWFxbOnq+dmhQrAPgaJYA==:117
 a=oyWFxbOnq+dmhQrAPgaJYA==:17 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=M51BFTxLslgA:10 a=x7bEGLp0ZPQA:10 a=tnT-KND3AOYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=HHGDD-5mAAAA:8 a=glSO5LrR8QfL-eKqMXQA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-JNJ: AAAAAAAB44XOjD+3ZRKOFSYO89q5A7ztyjTlAtedS9R6SnAljC5BXzxrtUHHOHA6xlnvJHKfxQrM7osOegXvqS/IFExDfHHZUmSsalm6rDg9U9OCEKO3PQlR4YtoAPt4GqdDbFu6Y2XCoe1rfX0gm6NGlw3M76+cTB7zss1IcxJzpcK1yjIIyIlc13tNRr0VLIpIPcEkqB3q4ZRWCbbF6qvSUAWJzJAV2XT9AWGMVU2IqwQ2S2ukjhD5SMPFXIKrSHBASJcbXfdwl+3od9qaH1uDH4u9/7fBMUfNN1LqaDNcrPXw0WJeVyehfVSqLhVD7V0EVxLIjm0VVL4jbYreKVqfCM6NhEHOIjdHmdIA7RmdG68HyLjuTx48G1FWs7zF0mHwCFcirqS5C2sZDyZfF/e89SFbCSPh+yr9rQJgmj1MF8q3ocULgHDNfg/VvsZA3q6f9IgtGPg5wtddEAuX5Mp4pQ5AWO4MCXvvG5pH1UQr2tOQJ3sRsRLwK93JrHUZWo3pBMlWis1lEr0HNhAw4AEd4w1Tj/r4f4SS9zDb55hbmXoMMEL/OEvPjI5pN90WtgJO7cvC4xUF1GrAAyMalJK7fIjnbZ345ErtcnXUkdq5aq8AbEpplLFnA8ZPAB/coiALrHR1bXjRSfYepIBoRunuGxa1U5onOOZrP6PhaaPVlqZUixP6tyAX9EzibiCx8KwpFjKQN9kyxWWoX7wRNphWx8fMpQsM14123pthp5GFvp8yISaj7V8lq67ok6s8hxV0rj5qZYJcldH3siQL9+2ipYXoUk0edGLxceqJQw==
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

