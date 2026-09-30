Received: from outbound.st.icloud.com (st-2001h-snip4-11.eps.apple.com [57.103.76.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2C24BF932
	for <linux-input@vger.kernel.org>; Wed, 30 Sep 2026 20:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.76.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790799255; cv=none; b=Rd0FQs3svOcXeHQm3mwcOz3fTUR0feZ9DQIGg4WY4x5IGLQBlVvRdMN5/yMvdYONv6arn4eXk8zg2Sd0zJ1xw1IbHu+HA1WYyLToPRo0HjNLHlapQ4m9U0sLahJMp0SNKUz2wn7wGYZlj1K6vEaHCnjaFC1J8UQYUvdhObj3nKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790799255; c=relaxed/simple;
	bh=kmuwNiJn3ZyTxp/YnNiJtuvpqbvFe+TNwtju9JJIipU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PhiuWR/4QpS+avAqtIoRU18rdoBs8Ez7qCvEWBVE4tsejk7qEWGffGnOijoCDdPLA/igP3O5ritCFigNrqkYHhXzpdYMsoxO4PF+FsT0H+M5nZCRvWDY/0qCU2l5XWUD/dxmg8/1JXAxSObjqbcPhlaU+fK9PggGgOqcd8utzxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=me.com; spf=pass smtp.mailfrom=me.com; dkim=pass (2048-bit key) header.d=me.com header.i=@me.com header.b=hKiNvIq4; arc=none smtp.client-ip=57.103.76.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=me.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=me.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=me.com header.i=@me.com header.b="hKiNvIq4"
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-east-1a-10-percent-2 (Postfix) with ESMTPS id E8DC91800AC9;
	Wed, 30 Sep 2026 20:14:11 +0000 (UTC)
X-ICL-RepId: 01a0f3f4-09d1-70d2-be95-e397c3fbd430
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQFLHV8HWBxHD1YKTVIPDxYKFkFcWytfFRcbXAAXDVZNVB0dDlgGEgJaRQVNXw5eHwQXRhlVBEceXVZAGRkCURxWDVdDVARfUEkMQVBsWgBHF0gdXRlZb1BdHA4AUkVRH1RYXgRTVg5DWBkGXQFcUBQKHVBbBghRElxOUVlUClNHCRoCXlRZAUhaSgdVAVkBXghPCl0AUgtAC0AdCl4fHBYKFkFcWytfFRcbXAAJS0YJSR0OBFQHXQVd
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai; t=1790799252; x=1793391252; bh=Pi9cE/d3v5wa+kAHgpPI3GwenIK4zniVyL0HuZt0Es0=; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme; b=hKiNvIq4vgYgYhiolA0wC2SMgyvxwy6Ys7SMCwhKDl7c9FGLDsGlP+1wOw1eKiHLPavbD8F6n/1R0tMEVh0c4Bc2lXBLkGyxTNa54WxwVrszQ39wUdNYWsbdmKX2Pkfyqg5CHGfhKyUtXIo0I4fW8/eW6VFsjiCRr9XsUV+16MZ5fzIytzVjqokkOr4XlDe+PH4Erzvm2lEryFFOGKykGmyM/LOLe0PV+kIsitXRKv6BNdO0WSn6ed4lmCa1uX75MwKOJmIdXnAonj4iy6jYIT12fTkXxRYZ4YThuqovtQptqvOhVqkwLX3Tn1jt1Q4eKm5juQAqvP+k+yjz3pQBtg==
Received: from fedora.vpn.altanet.fr (unknown [17.156.216.30])
	by p00-icloudmta-asmtp-us-east-1a-10-percent-2 (Postfix) with ESMTPSA id ABEDB1800AF7;
	Wed, 30 Sep 2026 20:14:10 +0000 (UTC)
From: =?UTF-8?q?Ren=C3=A9=20Onier?= <f3nr1l@me.com>
To: Benjamin Tissoires <bentiss@kernel.org>,
	Jiri Kosina <jikos@kernel.org>
Cc: =?UTF-8?q?Ren=C3=A9=20Onier?= <f3nr1l@me.com>,
	Ivan Gorinov <linux-kernel@altimeter.info>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND 1/4] HID: winwing: factor out vendor SET_LEDX report builder
Date: Wed, 30 Sep 2026 16:13:55 -0400
Message-ID: <3aa5067bd3ec61ccbe6b4caa70b13c238c248623.1790799028.git.f3nr1l@me.com>
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
X-Proofpoint-ORIG-GUID: e4x0iCw_5Upx7ywWw_1ZAXL3JvFrezRS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA4MiBTYWx0ZWRfX8mw93EKu/4kB
 u/GxbF5nyQbxRmLzt2zYeCR+bnncsOalV+4Z61AykyyVBqNbHIWqqMD6PhH/09eBCyVFSiPp6xA
 FAP/ogBklHiuga4ZhOIT/WfXmt/a0RaWPGHUGY3/wPvb1Bq7vU2RCLelLYiKWtZ8XEjXY7VWiwU
 Wu7z8YbES0m0Xe3XofXxlsT4rKtVgylwg2jU7hjwDnqEg0oMe5ZNAxdwwnLzj37fOunBixEWB8C
 99lYpFPi9YhLNe33tUkRjoyEIh2FMeEggqiTvfnKuF0NKIEMQaTl45GZC958FfySy+ADXJRddQH
 /lFynDplhhDu1mHSxsEQSuDFxWFQcp/GC7isryI1jEoZQ50Qk7GV8ba3QyUiUc=
X-Authority-Info-Out: v=2.4 cv=ZJraWH7b c=1 sm=1 tr=0 ts=6abd6d94
 cx=c_apl:c_pps:t_out a=oyWFxbOnq+dmhQrAPgaJYA==:117
 a=oyWFxbOnq+dmhQrAPgaJYA==:17 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=M51BFTxLslgA:10 a=x7bEGLp0ZPQA:10 a=tnT-KND3AOYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=HHGDD-5mAAAA:8 a=x0iCFx657FB7-1Nh1_0A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: e4x0iCw_5Upx7ywWw_1ZAXL3JvFrezRS
X-JNJ: AAAAAAABWnMIYXQhmDdfnE9l5oVUcDqYzUw+TQqjMSHt1/+IAFqHhVKRsAb26cSN6lelxSB0C6HKSToCw/dOFZpGu12W2NyvejcR/SrvPKODz9ms26eQyuG/bxYRr69bvdp6jLoS29n6GLll6TUNRM3B5IlWhYBDMjjOa3qIdKIVtP5LaFxbaFIceXS46luGSsMTDOKLhv0QSNGirrIKHR6sx7jgK5JXgB0j76U9EkEseHB8dR1Dgofk5uLtufQTQDxML0vya5MO2Pz+t17e2+VJ+fa5zeoMs8Fe9DK0eqLdM2t3O3DkHgbM3DaGzYToSgwVybrMNJWmrmPitSzBKNH+mF9DjGsKVP7sg0CrBJ/kf7c1jX5ClyJGmpF8tTspbROWFXARqe4RakQ0DskdyFiYldfOf3FhLsCK6HbVpE2tjvDOhY5JRN50IyYN9pkWUGclQeXRxUZ1Rdo+J2gJlrDjYdg/d9dYBPJC49Qcf9jFAfck9U4FyP7ENepiCZ89uTT/rO2IqWPtEi5a9G/3T96zljMoDMqyoSTlIFDLNkC1Zj6/A1Z4/8vaCL4emv/lIZvZK2Zuct39wRkW4s+2JHUmPpKPNZ6cgdntFaK6n6pHPS4l5rD1HGLcj/35RlM2oBOQURqwIayGDzx9W/HCqyGIg01suQXSgk2JJnAeGoa5lNEI0Fgi5fkvFVT5dkXV5VHJhx97VXwwE3m7TUH+z6pSvSEq421eFC+WgRs6a12mtLlcVnbhJr9uXN/XHRrOTG2klEcPgWHSXR0vc1gWufbeGLsg7ezdZ4IPjeo=
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

