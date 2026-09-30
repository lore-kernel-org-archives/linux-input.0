Received: from outbound.ci.icloud.com (ci-2005b-snip4-11.eps.apple.com [57.103.89.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79AED408629
	for <linux-input@vger.kernel.org>; Wed, 30 Sep 2026 19:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.89.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790798181; cv=none; b=XsHG6TjeIkLi1gwZCfSVbjU9lQhyl7o6e/gDF9lOYQ5lkOr3CJQTEq4epb8cKP8X/Gzkca2WJquNPxAlOXHZ36C7q8c4J2UDkzsaiJpwBNYNAAOzI7UWsaDEnSO+tdP8YP/VlpKkRXRMwG+lfssu/HrcE3TwwpHG1oVKLneT/JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790798181; c=relaxed/simple;
	bh=kmuwNiJn3ZyTxp/YnNiJtuvpqbvFe+TNwtju9JJIipU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PofKWhsVdyn6PyIO18KAJk4kN+Rd7xHk+79VGwb9O3P2D/FjOb2Lf11IdGIbb7Pp3peDxghBQ3pVjstHrdddeZk1O6MnLJ0qX6HZ3+oTinWg41skwgHAnTMrufyqFpjHT4CpjGikvAZEArhXq3OrF2WP3YBQ7LjufC5J5EsmEzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=me.com; spf=pass smtp.mailfrom=me.com; dkim=pass (2048-bit key) header.d=me.com header.i=@me.com header.b=keTFjK7E; arc=none smtp.client-ip=57.103.89.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=me.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=me.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=me.com header.i=@me.com header.b="keTFjK7E"
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-central-1k-60-percent-1 (Postfix) with ESMTPS id D867818000CB;
	Wed, 30 Sep 2026 19:56:18 +0000 (UTC)
X-ICL-RepId: 01a0f3e3-aa20-75ef-ba7d-ad5422319efd
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQFLHV8HWBxHD1YKTVIPDxYKFkFcWytfFRcbXAAXDVZNVB0dDlgGEgJaRQVNXw5eHwQXRhlVBEceXVZQBBkCURxWDVdDVARfUEkMQVBsWgBHF0gdXRlZb1BdHA4AUkVRH1RYXgRTVg5DWBkGXQFcUBQKHVBbBghRElxOUVlUClNHCRoCXlRZAUhaSgdVAVkBXghPCl0AUgdHC04dCl4fHBYKFkFcWytfFRcbXAAJS0YJSR0OBFQHXQVd
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai; t=1790798179; x=1793390179; bh=Pi9cE/d3v5wa+kAHgpPI3GwenIK4zniVyL0HuZt0Es0=; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme; b=keTFjK7ELNNuijZpnpDj4Rbs7bkJy22AfcaefKY/y8Cda8vyvV71zfCyK/IX5CVlgX8VD5VbQgZzJsYuhOhhEv5fzKQRXCm+QTcMq1OQLwkR+lSU6w3uR6yvrdOuuspYdtjlU4rHwMcgsc2t7LCWnYvvjHa9ToAo5SLVHcXllrNWnxSUFDiSN95b7Aqzs41lEfzk80ZuWQFSfnurfA5s8gKbf/Zj/ahiX7HDxqiqW4MjqdcdMD3WZOSe5WImTItDv72mH6mVdbIq9ElP6jfEywBwQu1WlPgVeFyEhGSkOgGRqFJfF5BcSLDTagF4l9YQriejrpebHB+bcYg0oEWnaA==
Received: from fedora.vpn.altanet.fr (unknown [17.57.156.36])
	by p00-icloudmta-asmtp-us-central-1k-60-percent-1 (Postfix) with ESMTPSA id 82371180011D;
	Wed, 30 Sep 2026 19:56:17 +0000 (UTC)
From: =?UTF-8?q?Ren=C3=A9=20Onier?= <f3nr1l@me.com>
To: Benjamin Tissoires <bentiss@kernel.org>,
	Jiri Kosina <jikos@kernel.org>
Cc: =?UTF-8?q?Ren=C3=A9=20Onier?= <f3nr1l@me.com>,
	Ivan Gorinov <linux-kernel@altimeter.info>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] HID: winwing: factor out vendor SET_LEDX report builder
Date: Wed, 30 Sep 2026 15:55:57 -0400
Message-ID: <3aa5067bd3ec61ccbe6b4caa70b13c238c248623.1790795726.git.f3nr1l@me.com>
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
X-Authority-Info-Out: v=2.4 cv=BKa+bVQG c=1 sm=1 tr=0 ts=6abd6963
 cx=c_apl:c_pps:t_out a=2G65uMN5HjSv0sBfM2Yj2w==:117
 a=2G65uMN5HjSv0sBfM2Yj2w==:17 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=M51BFTxLslgA:10 a=x7bEGLp0ZPQA:10 a=tnT-KND3AOYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=HHGDD-5mAAAA:8 a=x0iCFx657FB7-1Nh1_0A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA4MSBTYWx0ZWRfXwKOqaHLHXW/7
 Qgbe6LabokONfN6S24j6Az/hjKSEIkODQC17n2S1wYSMbWagJpDdyTM8p1yoi61VEQGfGgS1bqT
 wz/fLqcYWWYAqotuHWnzEpycn5j/jkLmTAm575t51u4iavCSN031D+f4lpND1/kZq5yUZxYfAje
 7kirAYecd6F2YiYad/EacbbdrM9bLBge/U4tCuC8vF54i62HF04IesByZMm6/yDW/3ze8d9hMYY
 LaJA3fmQx/78EBpPyqXO7idaV0u1aqYQYc1FLkACYnEQ4LbGmVQ9HRuxSjX7jmUDcTc5VOUTmDL
 xx2uDsmdSgVBcP5wp0fucjeOMtTMV5ssmzWG4txfUInxg28yvA4dj3PMWEbY+s=
X-Proofpoint-GUID: pA5qtLaTWrOAwG4MMDnvEgg0l8Fo8QWT
X-Proofpoint-ORIG-GUID: pA5qtLaTWrOAwG4MMDnvEgg0l8Fo8QWT
X-JNJ: AAAAAAABQu7QGbv3lQc59PiTXfIEuptCHlq0/wI5la4dOECURPapZ9bzhNKOqPmR7VpvfXXcmowEXboqMYmK/3LEI8S6FljkGdLEsQEEDpu7ncRs1mplYrzglbJANPIIXWROFg/fhz+wwEBX7QtDUTVx06d9WJA5RcQjmOxzYBzs3n2Lb27v8DzoMPWh00he3UfsspRUYL9CziADTpWgszoVqih88DSIiXepwqjEQgN3HBH+jl2Xq3xVz+APllJh0VacyybjW93dhcMOi4qW/YqNomtUbhxusEbqi8iWS1iKKbqLXFMPlemTm7LWsBidl9+4hMb5bzHmjqLptixNnmG3elie9eMw+kfL5Gc+D/PWIBQd114c18IKB6YFF6P9AbD7Fza2veD6LvQ+87AA5IiWKr+jCBClyvxtwEZMMQfZ72j5L2zxcfwMET/l796vGZFICqmjTmMtYxz0fnlIxBBT/q6wLdy3B2ou/8bp+5V1URYpBP5nQXzJQwLtpN1l8NMQzC2YKSfRAKWsxIpuqxYNHcjfBiFfRw/pJhwiV4WkSQ8oTLrnJZ7PID9Z4TkLUJ5pHUce6K4GCgkbSBMkW0pOICV1AwFhqhcorI+L2sQMuf31XBX5OMJi8PbmM/tGA+PrPSQSOzZUma9aXJcNNxcvuEjxuAkXe210Befj5FR4KW58HIUOQD8vTWkJ3wobnwBq88M5gFcBBTHMpXo77PQkO9ff0JGv8x5CQRpshUjOEvCVaFBf45Jn0pzZntEs5Hj1o+7ZhPMhNyjREwglBQiK1Jo55MA=
X-Apple-Category-Label: MjczODQ1OTkzOiRjYXRlZ29yeSRfUGVyc29uYWws

The LED and the rumble paths each open-code the same 14-byte vendor
report byte by byte, leaving the meaning of every field to the reader.
Name the fields and build the report in one place.

A report is addressed to one of the controllers making up the product by
a (device, family) pair: the Orion 2 lighting controller answers on
0x60/0xbe, the two grip rumble motors on 0x01/0xbf and 0x03/0xbf.

No functional change: the bytes put on the wire are identical.

Signed-off-by: René Onier <f3nr1l@me.com>
---
 drivers/hid/hid-winwing.c | 123 +++++++++++++++++++-------------------
 1 file changed, 60 insertions(+), 63 deletions(-)

diff --git a/drivers/hid/hid-winwing.c b/drivers/hid/hid-winwing.c
index cbfdb9c66e..a9bf81c19f 100644
--- a/drivers/hid/hid-winwing.c
+++ b/drivers/hid/hid-winwing.c
@@ -16,6 +16,30 @@
 
 #define MAX_REPORT 16
 
+/*
+ * Vendor output report (report ID 2, 14 bytes):
+ *
+ *	[0] report ID	[1] device	[2] family	[3..4] zero
+ *	[5] payload length	[6] opcode	[7..] arguments
+ *
+ * The device and family bytes select which of the controllers making up the
+ * product the report is addressed to; unknown reports are silently dropped.
+ */
+#define WINWING_REPORT_ID	0x02
+#define WINWING_REPORT_LEN	14
+
+#define WINWING_OP_SET_LEDX	0x49	/* arguments: LED index, value */
+#define WINWING_SET_LEDX_LEN	3
+
+/* Lighting controller of the Orion 2 throttle base */
+#define ORION2_LIGHT_DEVICE	0x60
+#define ORION2_LIGHT_FAMILY	0xbe
+
+/* Rumble motors of the TGRIP-15 grips, one report each */
+#define WINWING_STICK_FAMILY		0xbf
+#define WINWING_RUMBLE_LEFT_DEVICE	0x01
+#define WINWING_RUMBLE_RIGHT_DEVICE	0x03
+
 struct winwing_led {
 	struct led_classdev cdev;
 	struct hid_device *hdev;
@@ -47,36 +71,41 @@ struct winwing_drv_data {
 	struct winwing_led leds[];
 };
 
+/*
+ * Build a vendor report addressed to one controller and send it. The caller
+ * owns @buf and any serialization it needs.
+ *
+ * Mimicking requests captured by usbmon when the LEDs and the rumble motors
+ * are controlled by the vendor's app in a VM.
+ */
+static int winwing_send_set_ledx(struct hid_device *hdev, __u8 *buf,
+		__u8 device, __u8 family, __u8 index, __u8 value)
+{
+	memset(buf, 0, WINWING_REPORT_LEN);
+
+	buf[0] = WINWING_REPORT_ID;
+	buf[1] = device;
+	buf[2] = family;
+	buf[5] = WINWING_SET_LEDX_LEN;
+	buf[6] = WINWING_OP_SET_LEDX;
+	buf[7] = index;
+	buf[8] = value;
+
+	return hid_hw_output_report(hdev, buf, WINWING_REPORT_LEN);
+}
+
 static int winwing_led_write(struct led_classdev *cdev,
 		enum led_brightness br)
 {
 	struct winwing_led *led = (struct winwing_led *) cdev;
 	struct winwing_drv_data *data = hid_get_drvdata(led->hdev);
-	__u8 *buf = data->report_lights;
 	int ret;
 
 	mutex_lock(&data->lights_lock);
 
-	/*
-	 * Mimicking requests captured by usbmon when LEDs
-	 * are controlled by the vendor's app in a VM.
-	 */
-	buf[0] = 0x02;
-	buf[1] = 0x60;
-	buf[2] = 0xbe;
-	buf[3] = 0x00;
-	buf[4] = 0x00;
-	buf[5] = 0x03;
-	buf[6] = 0x49;
-	buf[7] = led->number;
-	buf[8] = br;
-	buf[9] = 0x00;
-	buf[10] = 0;
-	buf[11] = 0;
-	buf[12] = 0;
-	buf[13] = 0;
-
-	ret = hid_hw_output_report(led->hdev, buf, 14);
+	ret = winwing_send_set_ledx(led->hdev, data->report_lights,
+			ORION2_LIGHT_DEVICE, ORION2_LIGHT_FAMILY,
+			led->number, br);
 
 	mutex_unlock(&data->lights_lock);
 
@@ -242,28 +271,12 @@ static int winwing_haptic_rumble(struct winwing_drv_data *data)
 	if (m != data->rumble_left) {
 		int ret;
 
-		/*
-		 * Mimicking requests captured by usbmon when rumble
-		 * is activated by the vendor's app in a VM.
-		 */
-		buf[0] = 0x02;
-		buf[1] = 0x01;
-		buf[2] = 0xbf;
-		buf[3] = 0x00;
-		buf[4] = 0x00;
-		buf[5] = 0x03;
-		buf[6] = 0x49;
-		buf[7] = 0x00;
-		buf[8] = m;
-		buf[9] = 0x00;
-		buf[10] = 0;
-		buf[11] = 0;
-		buf[12] = 0;
-		buf[13] = 0;
-
-		ret = hid_hw_output_report(data->hdev, buf, 14);
+		ret = winwing_send_set_ledx(data->hdev, buf,
+				WINWING_RUMBLE_LEFT_DEVICE,
+				WINWING_STICK_FAMILY, 0, m);
 		if (ret < 0) {
-			hid_err(data->hdev, "error %d (%*ph)\n", ret, 14, buf);
+			hid_err(data->hdev, "error %d (%*ph)\n", ret,
+					WINWING_REPORT_LEN, buf);
 			return ret;
 		}
 		data->rumble_left = m;
@@ -273,28 +286,12 @@ static int winwing_haptic_rumble(struct winwing_drv_data *data)
 	if (m != data->rumble_right) {
 		int ret;
 
-		/*
-		 * Mimicking requests captured by usbmon when rumble
-		 * is activated by the vendor's app in a VM.
-		 */
-		buf[0] = 0x02;
-		buf[1] = 0x03;
-		buf[2] = 0xbf;
-		buf[3] = 0x00;
-		buf[4] = 0x00;
-		buf[5] = 0x03;
-		buf[6] = 0x49;
-		buf[7] = 0x00;
-		buf[8] = m;
-		buf[9] = 0x00;
-		buf[10] = 0;
-		buf[11] = 0;
-		buf[12] = 0;
-		buf[13] = 0;
-
-		ret = hid_hw_output_report(data->hdev, buf, 14);
+		ret = winwing_send_set_ledx(data->hdev, buf,
+				WINWING_RUMBLE_RIGHT_DEVICE,
+				WINWING_STICK_FAMILY, 0, m);
 		if (ret < 0) {
-			hid_err(data->hdev, "error %d (%*ph)\n", ret, 14, buf);
+			hid_err(data->hdev, "error %d (%*ph)\n", ret,
+					WINWING_REPORT_LEN, buf);
 			return ret;
 		}
 		data->rumble_right = m;
-- 
2.55.0

