Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7482B33C53F
	for <linux-input@vger.kernel.org>; Fri, 27 Feb 2026 23:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772236253; cv=none; b=jajC4tNdBa6a2tYc3nossLQQvFrQCK0VCDErcOiZWYbEWiJ2YvazMaGGQm8r+eWnfi0HTeZeY6CdlapK6KwlDfTsKpHk7eXCcsuPhilHWEGEaSe+3vPUi4TUQa6CHvE6fPkCD8Z5tOyG6tjPOGBJWrNLSyVwJSmVdmBpYovhHAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772236253; c=relaxed/simple;
	bh=kOkif7+fE4TYzKo1+TOGZXA3p0qj7Keq7jj98H8lqZY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IaFXwnlJPZGVexHqTp+t5DxQ44lN241x3lxJTo7BZxGwKB11u0Mdr37NYMJ4gy1Fa63ttCoX+CIAkoDUNTzBlH/bCJ6wj8nZs/U7uWKZKPGDpCc+oVjuk7ARTGUCDFAFOgpwuaNnOw5Dchty0H/wO3e4WC2ohVtDSD6oKyIQehQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CfvmJgXx; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CfvmJgXx"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-896f632d206so45050236d6.0
        for <linux-input@vger.kernel.org>; Fri, 27 Feb 2026 15:50:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772236249; x=1772841049; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V+jo6LHfaDJ8jIHPSyQKeG3Pw+NKLGAR5lYiLVb37oI=;
        b=CfvmJgXxcNJq2a8y3kuG82GjHmwHmQ6Ok58bS/8JS+dr3ihmik8FXFlAIvZ7v5GPpr
         VMdiFirlEX2oX5RsnADHz40CQvKOBr9UypoRzKuiEBjlPNjaxgtE/fcd+zW1V1ym3y7a
         O3Mp3dZQ5tXVD1+cLk6QQ8sGx2THknEiR3hkzR3/U5UZrMbd4hpi3Cf9SX3C83Tvw0Py
         VFR9ZG5KYabA5Dk2eVQjat0/QDEykAb5syqBoU8FdSrgtO7+TTbvBbz3y5rtTkYAppAq
         0cR4kuEimwVwVaadpvFlmvQ/JT1etUu0nmpAGE473ObZvJgDRRZuTBKEdg8Nc5BcGK17
         NH5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772236249; x=1772841049;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=V+jo6LHfaDJ8jIHPSyQKeG3Pw+NKLGAR5lYiLVb37oI=;
        b=d6SFzC10zZDdZNbWNw2PwHJqs1UpQgDNUR4bs70l2eTahlD5QNuw+6NebDZ3CdO5/d
         ryyp7sGa/Kt2ydRrh5iUNz2zS96WiH7oSdx1+J48zG5JHkGGO6+z5JNZm5VcePp9gDy8
         SVGvCOR6RMcn1Uy9E3khdjAovBm9XponARq9NwcKhrOM31P8ouugo04X9RVnHdwdhuON
         TufU4Pz5k+xIHzNeddTW0YrRHMKWvS9tKGMJsDIAZctxRqWPUQnmo6TcwTlV4TVAWa04
         8Ul/yqJWUqoSnqEVe/Ipq4GsGmtNRjx88qQRy3c7Zfbk0t2teLGK3lR375sFvJPIV2P3
         Y0kw==
X-Gm-Message-State: AOJu0YzxsI96AETqKr7JLUiGninV75bzjs2u8hC8k8Ev5Zig3JlHEb1p
	WkDxdq16d8Fxc7/DpEwrixKybiqa9Rv0vGXUnrvhc5J6T6ePUebddpr0
X-Gm-Gg: ATEYQzxcn57DqgYlvimteSMfLY1Qn9vRJwNyDuSnGSFSP6Lu+kQgSDqLWqKsMId4KEM
	klQMm8oGQxJ1RcW2afkyki2C47QOLI1dH/FfMrfTXuEoDTZHUMoyKlgi0ac79Ea3vDsohcw727B
	8PB+NR6J4UM811FSYREtLGtwFkd7cLBN5fcCQS575w2jmSXheVNiAtLONCXqf8CoASV5EHRQzvF
	BLgTgtNu3NFYFrxIuqwDGvonPNkGc4vp5v09x/Pw+Bl47LSgMvdUh8BP/vDBG2HejZ8p8bM1CKa
	zntnIG9Oq0hdI6ybcwaDn9papoTIFk40vJ79jXDkdxJ+KA8zYSXHf+o4kXTLTwBX9+RjHjh5IjL
	D8hA95xa4z/w2j7ThNTwTaanhKNZK0XsS+xViRN836sAnEP6DJXv8OmTP1sjyBgASw6iSZEBQrJ
	RL0XKmzhz0EOgWY/HyMp+/vFi/Uc5xSyMz3h+taJtKfZ6vQ+v5Xw==
X-Received: by 2002:ad4:5d67:0:b0:896:fa81:5652 with SMTP id 6a1803df08f44-899c6834181mr115269446d6.34.1772236249372;
        Fri, 27 Feb 2026 15:50:49 -0800 (PST)
Received: from achantapc.tail227c81.ts.net ([128.172.224.28])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-899c715a87esm52397446d6.4.2026.02.27.15.50.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 15:50:48 -0800 (PST)
From: Sriman Achanta <srimanachanta@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bastien Nocera <hadess@hadess.net>,
	Simon Wood <simon@mungewell.org>,
	Christian Mayer <git@mayer-bgk.de>,
	Sriman Achanta <srimanachanta@gmail.com>
Subject: [PATCH v3 04/18] HID: steelseries: Add async support and unify device definitions
Date: Fri, 27 Feb 2026 18:50:28 -0500
Message-ID: <20260227235042.410062-5-srimanachanta@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260227235042.410062-1-srimanachanta@gmail.com>
References: <20260227235042.410062-1-srimanachanta@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Refactor the SteelSeries driver to improve scalability and support the
modern Arctis Nova headset lineup along with legacy models.

- Replace the bitmap-based quirk system with `struct
  steelseries_device_info` to encapsulate device-specific traits
  (product ID, name, capabilities, interfaces).
- Implement asynchronous battery monitoring. Devices that support async
  updates (like the Nova series) now rely on interrupt events rather
  than periodic polling, reducing overhead.
- Add support for complex multi-interface devices (e.g., Nova 7) where
  battery events arrive on a separate asynchronous interface.
- Consolidate battery request and report parsing logic. New helpers
  `steelseries_send_feature_report` and `steelseries_send_output_report`
  simplify command dispatch.
- Add support for over 20 new devices including the entire Arctis Nova
  series (3, 5, 7, Pro) and various Arctis 7/9/Pro variants.
- Clean up naming conventions (e.g., removing `_headset_` prefix from
  general functions) and improve locking in the battery timer.

Signed-off-by: Sriman Achanta <srimanachanta@gmail.com>
---
 drivers/hid/hid-steelseries.c | 894 +++++++++++++++++++++++++---------
 1 file changed, 653 insertions(+), 241 deletions(-)

diff --git a/drivers/hid/hid-steelseries.c b/drivers/hid/hid-steelseries.c
index d3711022bf86..d8ece8449255 100644
--- a/drivers/hid/hid-steelseries.c
+++ b/drivers/hid/hid-steelseries.c
@@ -4,37 +4,54 @@
  *
  *  Copyright (c) 2013 Simon Wood
  *  Copyright (c) 2023 Bastien Nocera
+ *  Copyright (c) 2025 Sriman Achanta
  */
 
-/*
- */
-
+#include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/hid.h>
 #include <linux/module.h>
 #include <linux/usb.h>
 #include <linux/leds.h>
+#include <linux/power_supply.h>
+#include <linux/workqueue.h>
+#include <linux/spinlock.h>
 
 #include "hid-ids.h"
 
-#define STEELSERIES_SRWS1		BIT(0)
-#define STEELSERIES_ARCTIS_1		BIT(1)
-#define STEELSERIES_ARCTIS_1_X		BIT(2)
-#define STEELSERIES_ARCTIS_9		BIT(3)
+#define SS_CAP_BATTERY			BIT(0)
+
+#define SS_QUIRK_STATUS_SYNC_POLL	BIT(0)
+
+struct steelseries_device;
+
+struct steelseries_device_info {
+	unsigned long capabilities;
+	unsigned long quirks;
+
+	u8 sync_interface;
+	u8 async_interface;
+
+	int (*request_status)(struct hid_device *hdev);
+	void (*parse_status)(struct steelseries_device *sd, u8 *data, int size);
+};
 
 struct steelseries_device {
 	struct hid_device *hdev;
-	unsigned long quirks;
+	const struct steelseries_device_info *info;
 
-	struct delayed_work battery_work;
-	spinlock_t lock;
-	bool removed;
+	bool use_async_protocol;
+
+	struct delayed_work status_work;
 
 	struct power_supply_desc battery_desc;
 	struct power_supply *battery;
-	uint8_t battery_capacity;
 	bool headset_connected;
+	u8 battery_capacity;
 	bool battery_charging;
+
+	spinlock_t lock;
+	bool removed;
 };
 
 #if IS_BUILTIN(CONFIG_LEDS_CLASS) || \
@@ -341,53 +358,118 @@ static int steelseries_srws1_probe(struct hid_device *hdev,
 }
 #endif
 
-#define STEELSERIES_HEADSET_BATTERY_TIMEOUT_MS	3000
+static const __u8 *steelseries_srws1_report_fixup(struct hid_device *hdev,
+		__u8 *rdesc, unsigned int *rsize)
+{
+	if (hdev->vendor != USB_VENDOR_ID_STEELSERIES ||
+	    hdev->product != USB_DEVICE_ID_STEELSERIES_SRWS1)
+		return rdesc;
 
-#define ARCTIS_1_BATTERY_RESPONSE_LEN		8
-#define ARCTIS_9_BATTERY_RESPONSE_LEN		64
-static const char arctis_1_battery_request[] = { 0x06, 0x12 };
-static const char arctis_9_battery_request[] = { 0x00, 0x20 };
+	if (*rsize >= 115 && rdesc[11] == 0x02 && rdesc[13] == 0xc8
+			&& rdesc[29] == 0xbb && rdesc[40] == 0xc5) {
+		hid_info(hdev, "Fixing up Steelseries SRW-S1 report descriptor\n");
+		*rsize = sizeof(steelseries_srws1_rdesc_fixed);
+		return steelseries_srws1_rdesc_fixed;
+	}
+	return rdesc;
+}
 
-static int steelseries_headset_request_battery(struct hid_device *hdev,
-	const char *request, size_t len)
+/*
+ * Headset report helpers
+ */
+
+static int steelseries_send_report(struct hid_device *hdev, const u8 *data,
+				    int len, enum hid_report_type type)
 {
-	u8 *write_buf;
+	u8 *buf;
 	int ret;
 
-	/* Request battery information */
-	write_buf = kmemdup(request, len, GFP_KERNEL);
-	if (!write_buf)
+	buf = kmemdup(data, len, GFP_KERNEL);
+	if (!buf)
 		return -ENOMEM;
 
-	hid_dbg(hdev, "Sending battery request report");
-	ret = hid_hw_raw_request(hdev, request[0], write_buf, len,
-				 HID_OUTPUT_REPORT, HID_REQ_SET_REPORT);
-	if (ret < (int)len) {
-		hid_err(hdev, "hid_hw_raw_request() failed with %d\n", ret);
-		ret = -ENODATA;
-	}
+	ret = hid_hw_raw_request(hdev, data[0], buf, len, type,
+				 HID_REQ_SET_REPORT);
+	kfree(buf);
 
-	kfree(write_buf);
-	return ret;
+	if (ret < 0)
+		return ret;
+	if (ret < len)
+		return -EIO;
+
+	return 0;
 }
 
-static void steelseries_headset_fetch_battery(struct hid_device *hdev)
+static inline int steelseries_send_feature_report(struct hid_device *hdev,
+						   const u8 *data, int len)
 {
-	int ret = 0;
+	return steelseries_send_report(hdev, data, len, HID_FEATURE_REPORT);
+}
 
-	if (hdev->product == USB_DEVICE_ID_STEELSERIES_ARCTIS_1 ||
-	    hdev->product == USB_DEVICE_ID_STEELSERIES_ARCTIS_1_X)
-		ret = steelseries_headset_request_battery(hdev,
-			arctis_1_battery_request, sizeof(arctis_1_battery_request));
-	else if (hdev->product == USB_DEVICE_ID_STEELSERIES_ARCTIS_9)
-		ret = steelseries_headset_request_battery(hdev,
-			arctis_9_battery_request, sizeof(arctis_9_battery_request));
+static inline int steelseries_send_output_report(struct hid_device *hdev,
+						  const u8 *data, int len)
+{
+	return steelseries_send_report(hdev, data, len, HID_OUTPUT_REPORT);
+}
 
-	if (ret < 0)
-		hid_dbg(hdev,
-			"Battery query failed (err: %d)\n", ret);
+/*
+ * Headset status request functions
+ */
+
+static int steelseries_arctis_1_request_status(struct hid_device *hdev)
+{
+	const u8 data[] = { 0x06, 0x12 };
+
+	return steelseries_send_feature_report(hdev, data, sizeof(data));
+}
+
+static int steelseries_arctis_7_request_status(struct hid_device *hdev)
+{
+	int ret;
+	const u8 connection_data[] = { 0x06, 0x14 };
+	const u8 battery_data[] = { 0x06, 0x18 };
+
+	ret = steelseries_send_feature_report(hdev, connection_data, sizeof(connection_data));
+	if (ret)
+		return ret;
+
+	msleep(10);
+
+	return steelseries_send_feature_report(hdev, battery_data, sizeof(battery_data));
+}
+
+static int steelseries_arctis_9_request_status(struct hid_device *hdev)
+{
+	const u8 data[] = { 0x00, 0x20 };
+
+	return steelseries_send_feature_report(hdev, data, sizeof(data));
 }
 
+static int steelseries_arctis_nova_request_status(struct hid_device *hdev)
+{
+	const u8 data[] = { 0x00, 0xb0 };
+
+	return steelseries_send_output_report(hdev, data, sizeof(data));
+}
+
+static int steelseries_arctis_nova_3p_request_status(struct hid_device *hdev)
+{
+	const u8 data[] = { 0xb0 };
+
+	return steelseries_send_output_report(hdev, data, sizeof(data));
+}
+
+static int steelseries_arctis_nova_pro_request_status(struct hid_device *hdev)
+{
+	const u8 data[] = { 0x06, 0xb0 };
+
+	return steelseries_send_output_report(hdev, data, sizeof(data));
+}
+
+/*
+ * Headset battery helpers
+ */
+
 static int battery_capacity_to_level(int capacity)
 {
 	if (capacity >= 50)
@@ -397,19 +479,247 @@ static int battery_capacity_to_level(int capacity)
 	return POWER_SUPPLY_CAPACITY_LEVEL_CRITICAL;
 }
 
-static void steelseries_headset_battery_timer_tick(struct work_struct *work)
+static u8 steelseries_map_capacity(u8 capacity, u8 min_in, u8 max_in)
+{
+	if (capacity >= max_in)
+		return 100;
+	if (capacity <= min_in)
+		return 0;
+	return (capacity - min_in) * 100 / (max_in - min_in);
+}
+
+/*
+ * Headset status parse functions
+ */
+
+static void steelseries_arctis_1_parse_status(struct steelseries_device *sd,
+					      u8 *data, int size)
+{
+	if (size < 4)
+		return;
+
+	sd->headset_connected = (data[2] != 0x01);
+	sd->battery_capacity = data[3];
+}
+
+static void steelseries_arctis_7_parse_status(struct steelseries_device *sd,
+					      u8 *data, int size)
+{
+	if (size < 3)
+		return;
+
+	if (data[0] == 0x06) {
+		if (data[1] == 0x14)
+			sd->headset_connected = (data[2] == 0x03);
+		else if (data[1] == 0x18)
+			sd->battery_capacity = data[2];
+	}
+}
+
+static void steelseries_arctis_7_plus_parse_status(struct steelseries_device *sd,
+						   u8 *data, int size)
+{
+	if (size < 4)
+		return;
+
+	if (data[0] == 0xb0) {
+		sd->headset_connected = !(data[1] == 0x01);
+		sd->battery_capacity = steelseries_map_capacity(data[2], 0x00, 0x04);
+		sd->battery_charging = (data[3] == 0x01);
+	}
+}
+
+static void steelseries_arctis_9_parse_status(struct steelseries_device *sd,
+					      u8 *data, int size)
+{
+	if (size < 5)
+		return;
+
+	if (data[0] == 0xaa) {
+		sd->headset_connected = (data[1] == 0x01);
+		sd->battery_charging = (data[4] == 0x01);
+		sd->battery_capacity = steelseries_map_capacity(data[3], 0x64, 0x9A);
+	}
+}
+
+static void steelseries_arctis_nova_3p_parse_status(struct steelseries_device *sd,
+						   u8 *data, int size)
+{
+	if (size < 4)
+		return;
+
+	if (data[0] == 0xb0) {
+		sd->headset_connected = !(data[1] == 0x02);
+		sd->battery_capacity = steelseries_map_capacity(data[3], 0x00, 0x64);
+	}
+}
+
+static void steelseries_arctis_nova_5_parse_status(struct steelseries_device *sd,
+						   u8 *data, int size)
+{
+	if (size < 5)
+		return;
+
+	if (data[0] == 0xb0) {
+		sd->headset_connected = !(data[1] == 0x02);
+		sd->battery_capacity = data[3];
+		sd->battery_charging = (data[4] == 0x01);
+	}
+}
+
+static void steelseries_arctis_nova_7_parse_status(struct steelseries_device *sd,
+						   u8 *data, int size)
+{
+	if (size < 4)
+		return;
+
+	if (data[0] == 0xb0) {
+		sd->headset_connected = (data[1] == 0x03);
+		sd->battery_capacity = steelseries_map_capacity(data[2], 0x00, 0x04);
+		sd->battery_charging = (data[3] == 0x01);
+	}
+}
+
+static void steelseries_arctis_nova_7_gen2_parse_status(struct steelseries_device *sd,
+							u8 *data, int size)
+{
+	if (size < 4)
+		return;
+
+	switch (data[0]) {
+	case 0xb0:
+		sd->headset_connected = (data[1] == 0x03);
+		sd->battery_capacity = data[2];
+		sd->battery_charging = (data[3] == 0x01);
+		break;
+	case 0xb7:
+		sd->battery_capacity = data[1];
+		break;
+	case 0xb9:
+		sd->headset_connected = (data[1] == 0x03);
+		break;
+	case 0xbb:
+		sd->battery_charging = (data[1] == 0x01);
+		break;
+	}
+}
+
+static void steelseries_arctis_nova_pro_parse_status(struct steelseries_device *sd,
+						     u8 *data, int size)
+{
+	if (size < 16)
+		return;
+
+	if (data[0] == 0x06 && data[1] == 0xb0) {
+		sd->headset_connected = (data[15] == 0x08 || data[15] == 0x02);
+		sd->battery_capacity = steelseries_map_capacity(data[6], 0x00, 0x08);
+		sd->battery_charging = (data[15] == 0x02);
+	}
+}
+
+/*
+ * Device info definitions
+ */
+
+static const struct steelseries_device_info srws1_info = { };
+
+static const struct steelseries_device_info arctis_1_info = {
+	.sync_interface = 3,
+	.capabilities = SS_CAP_BATTERY,
+	.quirks = SS_QUIRK_STATUS_SYNC_POLL,
+	.request_status = steelseries_arctis_1_request_status,
+	.parse_status = steelseries_arctis_1_parse_status,
+};
+
+static const struct steelseries_device_info arctis_7_info = {
+	.sync_interface = 5,
+	.capabilities = SS_CAP_BATTERY,
+	.quirks = SS_QUIRK_STATUS_SYNC_POLL,
+	.request_status = steelseries_arctis_7_request_status,
+	.parse_status = steelseries_arctis_7_parse_status,
+};
+
+static const struct steelseries_device_info arctis_7_plus_info = {
+	.sync_interface = 3,
+	.capabilities = SS_CAP_BATTERY,
+	.quirks = SS_QUIRK_STATUS_SYNC_POLL,
+	.request_status = steelseries_arctis_nova_request_status,
+	.parse_status = steelseries_arctis_7_plus_parse_status,
+};
+
+static const struct steelseries_device_info arctis_9_info = {
+	.sync_interface = 0,
+	.capabilities = SS_CAP_BATTERY,
+	.quirks = SS_QUIRK_STATUS_SYNC_POLL,
+	.request_status = steelseries_arctis_9_request_status,
+	.parse_status = steelseries_arctis_9_parse_status,
+};
+
+static const struct steelseries_device_info arctis_nova_3p_info = {
+	.sync_interface = 4,
+	.capabilities = SS_CAP_BATTERY,
+	.quirks = SS_QUIRK_STATUS_SYNC_POLL,
+	.request_status = steelseries_arctis_nova_3p_request_status,
+	.parse_status = steelseries_arctis_nova_3p_parse_status,
+};
+
+static const struct steelseries_device_info arctis_nova_5_info = {
+	.sync_interface = 3,
+	.capabilities = SS_CAP_BATTERY,
+	.quirks = SS_QUIRK_STATUS_SYNC_POLL,
+	.request_status = steelseries_arctis_nova_request_status,
+	.parse_status = steelseries_arctis_nova_5_parse_status,
+};
+
+static const struct steelseries_device_info arctis_nova_7_info = {
+	.sync_interface = 3,
+	.capabilities = SS_CAP_BATTERY,
+	.quirks = SS_QUIRK_STATUS_SYNC_POLL,
+	.request_status = steelseries_arctis_nova_request_status,
+	.parse_status = steelseries_arctis_nova_7_parse_status,
+};
+
+static const struct steelseries_device_info arctis_nova_7_gen2_info = {
+	.sync_interface = 3,
+	.async_interface = 5,
+	.capabilities = SS_CAP_BATTERY,
+	.request_status = steelseries_arctis_nova_request_status,
+	.parse_status = steelseries_arctis_nova_7_gen2_parse_status,
+};
+
+static const struct steelseries_device_info arctis_nova_pro_info = {
+	.sync_interface = 4,
+	.capabilities = SS_CAP_BATTERY,
+	.quirks = SS_QUIRK_STATUS_SYNC_POLL,
+	.request_status = steelseries_arctis_nova_pro_request_status,
+	.parse_status = steelseries_arctis_nova_pro_parse_status,
+};
+
+/*
+ * Headset wireless status and battery infrastructure
+ */
+
+#define STEELSERIES_HEADSET_STATUS_TIMEOUT_MS	3000
+
+static void
+steelseries_headset_set_wireless_status(struct hid_device *hdev,
+					bool connected)
 {
-	struct steelseries_device *sd = container_of(work,
-		struct steelseries_device, battery_work.work);
-	struct hid_device *hdev = sd->hdev;
+	struct usb_interface *intf;
+
+	if (!hid_is_usb(hdev))
+		return;
 
-	steelseries_headset_fetch_battery(hdev);
+	intf = to_usb_interface(hdev->dev.parent);
+	usb_set_wireless_status(intf, connected ?
+				USB_WIRELESS_STATUS_CONNECTED :
+				USB_WIRELESS_STATUS_DISCONNECTED);
 }
 
 #define STEELSERIES_PREFIX "SteelSeries "
 #define STEELSERIES_PREFIX_LEN strlen(STEELSERIES_PREFIX)
 
-static int steelseries_headset_battery_get_property(struct power_supply *psy,
+static int steelseries_battery_get_property(struct power_supply *psy,
 				enum power_supply_property psp,
 				union power_supply_propval *val)
 {
@@ -452,22 +762,7 @@ static int steelseries_headset_battery_get_property(struct power_supply *psy,
 	return ret;
 }
 
-static void
-steelseries_headset_set_wireless_status(struct hid_device *hdev,
-					bool connected)
-{
-	struct usb_interface *intf;
-
-	if (!hid_is_usb(hdev))
-		return;
-
-	intf = to_usb_interface(hdev->dev.parent);
-	usb_set_wireless_status(intf, connected ?
-				USB_WIRELESS_STATUS_CONNECTED :
-				USB_WIRELESS_STATUS_DISCONNECTED);
-}
-
-static enum power_supply_property steelseries_headset_battery_props[] = {
+static enum power_supply_property steelseries_battery_props[] = {
 	POWER_SUPPLY_PROP_MODEL_NAME,
 	POWER_SUPPLY_PROP_MANUFACTURER,
 	POWER_SUPPLY_PROP_PRESENT,
@@ -477,7 +772,26 @@ static enum power_supply_property steelseries_headset_battery_props[] = {
 	POWER_SUPPLY_PROP_CAPACITY_LEVEL,
 };
 
-static int steelseries_headset_battery_register(struct steelseries_device *sd)
+/*
+ * Delayed work handlers for status polling and settings requests
+ */
+
+static void steelseries_status_timer_work_handler(struct work_struct *work)
+{
+	struct steelseries_device *sd = container_of(
+		work, struct steelseries_device, status_work.work);
+	unsigned long flags;
+
+	sd->info->request_status(sd->hdev);
+
+	spin_lock_irqsave(&sd->lock, flags);
+	if (!sd->removed && !sd->use_async_protocol)
+		schedule_delayed_work(&sd->status_work,
+				msecs_to_jiffies(STEELSERIES_HEADSET_STATUS_TIMEOUT_MS));
+	spin_unlock_irqrestore(&sd->lock, flags);
+}
+
+static int steelseries_battery_register(struct steelseries_device *sd)
 {
 	static atomic_t battery_no = ATOMIC_INIT(0);
 	struct power_supply_config battery_cfg = { .drv_data = sd, };
@@ -485,9 +799,9 @@ static int steelseries_headset_battery_register(struct steelseries_device *sd)
 	int ret;
 
 	sd->battery_desc.type = POWER_SUPPLY_TYPE_BATTERY;
-	sd->battery_desc.properties = steelseries_headset_battery_props;
-	sd->battery_desc.num_properties = ARRAY_SIZE(steelseries_headset_battery_props);
-	sd->battery_desc.get_property = steelseries_headset_battery_get_property;
+	sd->battery_desc.properties = steelseries_battery_props;
+	sd->battery_desc.num_properties = ARRAY_SIZE(steelseries_battery_props);
+	sd->battery_desc.get_property = steelseries_battery_get_property;
 	sd->battery_desc.use_for_apm = 0;
 	n = atomic_inc_return(&battery_no) - 1;
 	sd->battery_desc.name = devm_kasprintf(&sd->hdev->dev, GFP_KERNEL,
@@ -496,14 +810,16 @@ static int steelseries_headset_battery_register(struct steelseries_device *sd)
 		return -ENOMEM;
 
 	/* avoid the warning of 0% battery while waiting for the first info */
-	steelseries_headset_set_wireless_status(sd->hdev, false);
 	sd->battery_capacity = 100;
 	sd->battery_charging = false;
+	sd->headset_connected = false;
+	steelseries_headset_set_wireless_status(sd->hdev, false);
 
 	sd->battery = devm_power_supply_register(&sd->hdev->dev,
 			&sd->battery_desc, &battery_cfg);
 	if (IS_ERR(sd->battery)) {
 		ret = PTR_ERR(sd->battery);
+		sd->battery = NULL;
 		hid_err(sd->hdev,
 				"%s:power_supply_register failed with error %d\n",
 				__func__, ret);
@@ -511,68 +827,185 @@ static int steelseries_headset_battery_register(struct steelseries_device *sd)
 	}
 	power_supply_powers(sd->battery, &sd->hdev->dev);
 
-	INIT_DELAYED_WORK(&sd->battery_work, steelseries_headset_battery_timer_tick);
-	steelseries_headset_fetch_battery(sd->hdev);
+	return 0;
+}
+
+static int steelseries_raw_event(struct hid_device *hdev,
+				 struct hid_report *report, u8 *data, int size)
+{
+	struct steelseries_device *sd = hid_get_drvdata(hdev);
+	u8 old_capacity;
+	bool old_connected;
+	bool old_charging;
+	bool is_async_interface = false;
+
+	if (hdev->product == USB_DEVICE_ID_STEELSERIES_SRWS1)
+		return 0;
+
+	if (!sd)
+		return 0;
+
+	old_capacity = sd->battery_capacity;
+	old_connected = sd->headset_connected;
+	old_charging = sd->battery_charging;
+
+	if (hid_is_usb(hdev)) {
+		struct usb_interface *intf = to_usb_interface(hdev->dev.parent);
+
+		is_async_interface = (intf->cur_altsetting->desc.bInterfaceNumber ==
+				      sd->info->async_interface);
+	}
+
+	sd->info->parse_status(sd, data, size);
+
+	if (sd->headset_connected != old_connected) {
+		hid_dbg(hdev,
+			"Connected status changed from %sconnected to %sconnected\n",
+			old_connected ? "" : "not ",
+			sd->headset_connected ? "" : "not ");
+
+		if (sd->headset_connected && !old_connected &&
+		    sd->use_async_protocol && is_async_interface) {
+			schedule_delayed_work(&sd->status_work, 0);
+		}
 
-	if (sd->quirks & STEELSERIES_ARCTIS_9) {
-		/* The first fetch_battery request can remain unanswered in some cases */
-		schedule_delayed_work(&sd->battery_work,
-				msecs_to_jiffies(STEELSERIES_HEADSET_BATTERY_TIMEOUT_MS));
+		if (sd->battery) {
+			steelseries_headset_set_wireless_status(sd->hdev,
+							       sd->headset_connected);
+			power_supply_changed(sd->battery);
+		}
+	}
+
+	if (sd->battery_capacity != old_capacity) {
+		hid_dbg(hdev, "Battery capacity changed from %d%% to %d%%\n",
+			old_capacity, sd->battery_capacity);
+		if (sd->battery)
+			power_supply_changed(sd->battery);
+	}
+
+	if (sd->battery_charging != old_charging) {
+		hid_dbg(hdev,
+			"Battery charging status changed from %scharging to %scharging\n",
+			old_charging ? "" : "not ",
+			sd->battery_charging ? "" : "not ");
+		if (sd->battery)
+			power_supply_changed(sd->battery);
 	}
 
 	return 0;
 }
 
-static bool steelseries_is_vendor_usage_page(struct hid_device *hdev, uint8_t usage_page)
+static struct hid_device *steelseries_get_sibling_hdev(struct hid_device *hdev,
+						       int interface_num)
 {
-	return hdev->rdesc[0] == 0x06 &&
-		hdev->rdesc[1] == usage_page &&
-		hdev->rdesc[2] == 0xff;
+	struct usb_interface *intf = to_usb_interface(hdev->dev.parent);
+	struct usb_device *usb_dev = interface_to_usbdev(intf);
+	struct usb_interface *sibling_intf;
+	struct hid_device *sibling_hdev;
+
+	sibling_intf = usb_ifnum_to_if(usb_dev, interface_num);
+	if (!sibling_intf)
+		return NULL;
+
+	sibling_hdev = usb_get_intfdata(sibling_intf);
+
+	return sibling_hdev;
 }
 
-static int steelseries_probe(struct hid_device *hdev, const struct hid_device_id *id)
+static int steelseries_probe(struct hid_device *hdev,
+			     const struct hid_device_id *id)
 {
+	const struct steelseries_device_info *info =
+		(const struct steelseries_device_info *)id->driver_data;
 	struct steelseries_device *sd;
+	struct usb_interface *intf;
+	struct hid_device *master_hdev;
+	u8 interface_num;
 	int ret;
 
 	if (hdev->product == USB_DEVICE_ID_STEELSERIES_SRWS1) {
 #if IS_BUILTIN(CONFIG_LEDS_CLASS) || \
-    (IS_MODULE(CONFIG_LEDS_CLASS) && IS_MODULE(CONFIG_HID_STEELSERIES))
+	(IS_MODULE(CONFIG_LEDS_CLASS) && IS_MODULE(CONFIG_HID_STEELSERIES))
 		return steelseries_srws1_probe(hdev, id);
 #else
 		return -ENODEV;
 #endif
 	}
 
-	sd = devm_kzalloc(&hdev->dev, sizeof(*sd), GFP_KERNEL);
-	if (!sd)
-		return -ENOMEM;
-	hid_set_drvdata(hdev, sd);
-	sd->hdev = hdev;
-	sd->quirks = id->driver_data;
+	if (hid_is_usb(hdev)) {
+		intf = to_usb_interface(hdev->dev.parent);
+		interface_num = intf->cur_altsetting->desc.bInterfaceNumber;
+	} else {
+		return -ENODEV;
+	}
 
 	ret = hid_parse(hdev);
 	if (ret)
 		return ret;
 
-	if (sd->quirks & STEELSERIES_ARCTIS_9 &&
-			!steelseries_is_vendor_usage_page(hdev, 0xc0))
-		return -ENODEV;
+	/* Let hid-generic handle non-vendor or unknown interfaces */
+	if (interface_num != info->sync_interface &&
+	    (!info->async_interface || interface_num != info->async_interface))
+		return hid_hw_start(hdev, HID_CONNECT_DEFAULT);
 
-	spin_lock_init(&sd->lock);
+	if (interface_num == info->sync_interface) {
+		sd = devm_kzalloc(&hdev->dev, sizeof(*sd), GFP_KERNEL);
+		if (!sd)
+			return -ENOMEM;
 
-	ret = hid_hw_start(hdev, HID_CONNECT_DEFAULT);
-	if (ret)
-		return ret;
+		sd->hdev = hdev;
+		sd->info = info;
+		spin_lock_init(&sd->lock);
 
-	ret = hid_hw_open(hdev);
-	if (ret)
-		return ret;
+		hid_set_drvdata(hdev, sd);
 
-	if (steelseries_headset_battery_register(sd) < 0)
-		hid_err(sd->hdev,
-			"Failed to register battery for headset\n");
+		ret = hid_hw_start(hdev, HID_CONNECT_DEFAULT);
+		if (ret)
+			return ret;
+
+		ret = hid_hw_open(hdev);
+		if (ret)
+			goto err_stop;
+
+		sd->use_async_protocol = !(info->quirks & SS_QUIRK_STATUS_SYNC_POLL);
+
+		if (info->capabilities & SS_CAP_BATTERY) {
+			ret = steelseries_battery_register(sd);
+			if (ret < 0)
+				hid_warn(hdev, "Failed to register battery: %d\n", ret);
+		}
+
+		INIT_DELAYED_WORK(&sd->status_work, steelseries_status_timer_work_handler);
+		schedule_delayed_work(&sd->status_work, msecs_to_jiffies(100));
+
+		return 0;
+	}
+
+	if (info->async_interface && interface_num == info->async_interface) {
+		master_hdev = steelseries_get_sibling_hdev(hdev, info->sync_interface);
 
+		if (!master_hdev || !hid_get_drvdata(master_hdev))
+			return -EPROBE_DEFER;
+
+		sd = hid_get_drvdata(master_hdev);
+		hid_set_drvdata(hdev, sd);
+
+		ret = hid_hw_start(hdev, HID_CONNECT_DEFAULT);
+		if (ret)
+			return ret;
+
+		ret = hid_hw_open(hdev);
+		if (ret) {
+			hid_hw_stop(hdev);
+			return ret;
+		}
+		return 0;
+	}
+
+	return -ENODEV;
+
+err_stop:
+	hid_hw_stop(hdev);
 	return ret;
 }
 
@@ -580,166 +1013,144 @@ static void steelseries_remove(struct hid_device *hdev)
 {
 	struct steelseries_device *sd;
 	unsigned long flags;
+	struct usb_interface *intf;
+	u8 interface_num;
 
 	if (hdev->product == USB_DEVICE_ID_STEELSERIES_SRWS1) {
 #if IS_BUILTIN(CONFIG_LEDS_CLASS) || \
-    (IS_MODULE(CONFIG_LEDS_CLASS) && IS_MODULE(CONFIG_HID_STEELSERIES))
+	(IS_MODULE(CONFIG_LEDS_CLASS) && IS_MODULE(CONFIG_HID_STEELSERIES))
 		hid_hw_stop(hdev);
 #endif
 		return;
 	}
 
-	sd = hid_get_drvdata(hdev);
-
-	spin_lock_irqsave(&sd->lock, flags);
-	sd->removed = true;
-	spin_unlock_irqrestore(&sd->lock, flags);
-
-	cancel_delayed_work_sync(&sd->battery_work);
-
-	hid_hw_close(hdev);
-	hid_hw_stop(hdev);
-}
-
-static const __u8 *steelseries_srws1_report_fixup(struct hid_device *hdev,
-		__u8 *rdesc, unsigned int *rsize)
-{
-	if (hdev->vendor != USB_VENDOR_ID_STEELSERIES ||
-	    hdev->product != USB_DEVICE_ID_STEELSERIES_SRWS1)
-		return rdesc;
-
-	if (*rsize >= 115 && rdesc[11] == 0x02 && rdesc[13] == 0xc8
-			&& rdesc[29] == 0xbb && rdesc[40] == 0xc5) {
-		hid_info(hdev, "Fixing up Steelseries SRW-S1 report descriptor\n");
-		*rsize = sizeof(steelseries_srws1_rdesc_fixed);
-		return steelseries_srws1_rdesc_fixed;
+	if (hid_is_usb(hdev)) {
+		intf = to_usb_interface(hdev->dev.parent);
+		interface_num = intf->cur_altsetting->desc.bInterfaceNumber;
+	} else {
+		return;
 	}
-	return rdesc;
-}
 
-static uint8_t steelseries_headset_map_capacity(uint8_t capacity, uint8_t min_in, uint8_t max_in)
-{
-	if (capacity >= max_in)
-		return 100;
-	if (capacity <= min_in)
-		return 0;
-	return (capacity - min_in) * 100 / (max_in - min_in);
-}
-
-static int steelseries_headset_raw_event(struct hid_device *hdev,
-					struct hid_report *report, u8 *read_buf,
-					int size)
-{
-	struct steelseries_device *sd = hid_get_drvdata(hdev);
-	int capacity = sd->battery_capacity;
-	bool connected = sd->headset_connected;
-	bool charging = sd->battery_charging;
-	unsigned long flags;
-
-	/* Not a headset */
-	if (hdev->product == USB_DEVICE_ID_STEELSERIES_SRWS1)
-		return 0;
+	sd = hid_get_drvdata(hdev);
 
-	if (hdev->product == USB_DEVICE_ID_STEELSERIES_ARCTIS_1 ||
-	    hdev->product == USB_DEVICE_ID_STEELSERIES_ARCTIS_1_X) {
-		hid_dbg(sd->hdev,
-			"Parsing raw event for Arctis 1 headset (%*ph)\n", size, read_buf);
-		if (size < ARCTIS_1_BATTERY_RESPONSE_LEN ||
-		    memcmp(read_buf, arctis_1_battery_request, sizeof(arctis_1_battery_request))) {
-			if (!delayed_work_pending(&sd->battery_work))
-				goto request_battery;
-			return 0;
-		}
-		if (read_buf[2] == 0x01) {
-			connected = false;
-			capacity = 100;
-		} else {
-			connected = true;
-			capacity = read_buf[3];
-		}
+	if (!sd) {
+		hid_hw_stop(hdev);
+		return;
 	}
 
-	if (hdev->product == USB_DEVICE_ID_STEELSERIES_ARCTIS_9) {
-		hid_dbg(sd->hdev,
-			"Parsing raw event for Arctis 9 headset (%*ph)\n", size, read_buf);
-		if (size < ARCTIS_9_BATTERY_RESPONSE_LEN) {
-			if (!delayed_work_pending(&sd->battery_work))
-				goto request_battery;
-			return 0;
-		}
+	if (interface_num == sd->info->sync_interface) {
+		if (sd->info->async_interface) {
+			struct hid_device *sibling;
 
-		if (read_buf[0] == 0xaa && read_buf[1] == 0x01) {
-			connected = true;
-			charging = read_buf[4] == 0x01;
-
-			/*
-			 * Found no official documentation about min and max.
-			 * Values defined by testing.
-			 */
-			capacity = steelseries_headset_map_capacity(read_buf[3], 0x68, 0x9d);
-		} else {
-			/*
-			 * Device is off and sends the last known status read_buf[1] == 0x03 or
-			 * there is no known status of the device read_buf[0] == 0x55
-			 */
-			connected = false;
-			charging = false;
+			sibling = steelseries_get_sibling_hdev(hdev,
+							       sd->info->async_interface);
+			if (sibling)
+				hid_set_drvdata(sibling, NULL);
 		}
-	}
 
-	if (connected != sd->headset_connected) {
-		hid_dbg(sd->hdev,
-			"Connected status changed from %sconnected to %sconnected\n",
-			sd->headset_connected ? "" : "not ",
-			connected ? "" : "not ");
-		sd->headset_connected = connected;
-		steelseries_headset_set_wireless_status(hdev, connected);
-	}
+		spin_lock_irqsave(&sd->lock, flags);
+		sd->removed = true;
+		spin_unlock_irqrestore(&sd->lock, flags);
 
-	if (capacity != sd->battery_capacity) {
-		hid_dbg(sd->hdev,
-			"Battery capacity changed from %d%% to %d%%\n",
-			sd->battery_capacity, capacity);
-		sd->battery_capacity = capacity;
-		power_supply_changed(sd->battery);
-	}
-
-	if (charging != sd->battery_charging) {
-		hid_dbg(sd->hdev,
-			"Battery charging status changed from %scharging to %scharging\n",
-			sd->battery_charging ? "" : "not ",
-			charging ? "" : "not ");
-		sd->battery_charging = charging;
-		power_supply_changed(sd->battery);
+		cancel_delayed_work_sync(&sd->status_work);
 	}
 
-request_battery:
-	spin_lock_irqsave(&sd->lock, flags);
-	if (!sd->removed)
-		schedule_delayed_work(&sd->battery_work,
-				msecs_to_jiffies(STEELSERIES_HEADSET_BATTERY_TIMEOUT_MS));
-	spin_unlock_irqrestore(&sd->lock, flags);
-
-	return 0;
+	hid_hw_close(hdev);
+	hid_hw_stop(hdev);
 }
 
 static const struct hid_device_id steelseries_devices[] = {
-	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES, USB_DEVICE_ID_STEELSERIES_SRWS1),
-	  .driver_data = STEELSERIES_SRWS1 },
-
-	{ /* SteelSeries Arctis 1 Wireless */
-	  HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES, USB_DEVICE_ID_STEELSERIES_ARCTIS_1),
-	  .driver_data = STEELSERIES_ARCTIS_1 },
-
-	{ /* SteelSeries Arctis 1 Wireless for XBox */
-	  HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES, USB_DEVICE_ID_STEELSERIES_ARCTIS_1_X),
-	  .driver_data = STEELSERIES_ARCTIS_1_X },
-
-	{ /* SteelSeries Arctis 9 Wireless for XBox */
-	  HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES, USB_DEVICE_ID_STEELSERIES_ARCTIS_9),
-	  .driver_data = STEELSERIES_ARCTIS_9 },
-
-	{ }
+	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES,
+			 USB_DEVICE_ID_STEELSERIES_SRWS1),
+	  .driver_data = (unsigned long)&srws1_info },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES,
+			 USB_DEVICE_ID_STEELSERIES_ARCTIS_1),
+	  .driver_data = (unsigned long)&arctis_1_info },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES,
+			 USB_DEVICE_ID_STEELSERIES_ARCTIS_1_X),
+	  .driver_data = (unsigned long)&arctis_1_info },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES,
+			 USB_DEVICE_ID_STEELSERIES_ARCTIS_7),
+	  .driver_data = (unsigned long)&arctis_7_info },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES,
+			 USB_DEVICE_ID_STEELSERIES_ARCTIS_7_P),
+	  .driver_data = (unsigned long)&arctis_1_info },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES,
+			 USB_DEVICE_ID_STEELSERIES_ARCTIS_7_X),
+	  .driver_data = (unsigned long)&arctis_1_info },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES,
+			 USB_DEVICE_ID_STEELSERIES_ARCTIS_7_GEN2),
+	  .driver_data = (unsigned long)&arctis_7_info },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES,
+			 USB_DEVICE_ID_STEELSERIES_ARCTIS_7_PLUS),
+	  .driver_data = (unsigned long)&arctis_7_plus_info },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES,
+			 USB_DEVICE_ID_STEELSERIES_ARCTIS_7_PLUS_P),
+	  .driver_data = (unsigned long)&arctis_7_plus_info },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES,
+			 USB_DEVICE_ID_STEELSERIES_ARCTIS_7_PLUS_X),
+	  .driver_data = (unsigned long)&arctis_7_plus_info },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES,
+			 USB_DEVICE_ID_STEELSERIES_ARCTIS_7_PLUS_DESTINY),
+	  .driver_data = (unsigned long)&arctis_7_plus_info },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES,
+			 USB_DEVICE_ID_STEELSERIES_ARCTIS_9),
+	  .driver_data = (unsigned long)&arctis_9_info },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES,
+			 USB_DEVICE_ID_STEELSERIES_ARCTIS_NOVA_3_P),
+	  .driver_data = (unsigned long)&arctis_nova_3p_info },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES,
+			 USB_DEVICE_ID_STEELSERIES_ARCTIS_NOVA_3_X),
+	  .driver_data = (unsigned long)&arctis_nova_3p_info },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES,
+			 USB_DEVICE_ID_STEELSERIES_ARCTIS_NOVA_5),
+	  .driver_data = (unsigned long)&arctis_nova_5_info },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES,
+			 USB_DEVICE_ID_STEELSERIES_ARCTIS_NOVA_5_X),
+	  .driver_data = (unsigned long)&arctis_nova_5_info },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES,
+			 USB_DEVICE_ID_STEELSERIES_ARCTIS_NOVA_7),
+	  .driver_data = (unsigned long)&arctis_nova_7_info },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES,
+			 USB_DEVICE_ID_STEELSERIES_ARCTIS_NOVA_7_2),
+	  .driver_data = (unsigned long)&arctis_nova_7_gen2_info },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES,
+			 USB_DEVICE_ID_STEELSERIES_ARCTIS_NOVA_7_P),
+	  .driver_data = (unsigned long)&arctis_nova_7_info },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES,
+			 USB_DEVICE_ID_STEELSERIES_ARCTIS_NOVA_7_X),
+	  .driver_data = (unsigned long)&arctis_nova_7_info },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES,
+			 USB_DEVICE_ID_STEELSERIES_ARCTIS_NOVA_7_X_2),
+	  .driver_data = (unsigned long)&arctis_nova_7_info },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES,
+			 USB_DEVICE_ID_STEELSERIES_ARCTIS_NOVA_7_X_3),
+	  .driver_data = (unsigned long)&arctis_nova_7_gen2_info },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES,
+			 USB_DEVICE_ID_STEELSERIES_ARCTIS_NOVA_7_DIABLO),
+	  .driver_data = (unsigned long)&arctis_nova_7_info },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES,
+			 USB_DEVICE_ID_STEELSERIES_ARCTIS_NOVA_7_DIABLO_2),
+	  .driver_data = (unsigned long)&arctis_nova_7_gen2_info },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES,
+			 USB_DEVICE_ID_STEELSERIES_ARCTIS_NOVA_7_WOW),
+	  .driver_data = (unsigned long)&arctis_nova_7_info },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES,
+			 USB_DEVICE_ID_STEELSERIES_ARCTIS_NOVA_7_GEN2),
+	  .driver_data = (unsigned long)&arctis_nova_7_gen2_info },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES,
+			 USB_DEVICE_ID_STEELSERIES_ARCTIS_NOVA_7_X_GEN2),
+	  .driver_data = (unsigned long)&arctis_nova_7_gen2_info },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES,
+			 USB_DEVICE_ID_STEELSERIES_ARCTIS_NOVA_7_X_GEN2_2),
+	  .driver_data = (unsigned long)&arctis_nova_7_gen2_info },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES,
+			 USB_DEVICE_ID_STEELSERIES_ARCTIS_NOVA_PRO),
+	  .driver_data = (unsigned long)&arctis_nova_pro_info },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES,
+			 USB_DEVICE_ID_STEELSERIES_ARCTIS_NOVA_PRO_X),
+	  .driver_data = (unsigned long)&arctis_nova_pro_info },
+	{}
 };
 MODULE_DEVICE_TABLE(hid, steelseries_devices);
 
@@ -749,7 +1160,7 @@ static struct hid_driver steelseries_driver = {
 	.probe = steelseries_probe,
 	.remove = steelseries_remove,
 	.report_fixup = steelseries_srws1_report_fixup,
-	.raw_event = steelseries_headset_raw_event,
+	.raw_event = steelseries_raw_event,
 };
 
 module_hid_driver(steelseries_driver);
@@ -758,3 +1169,4 @@ MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Bastien Nocera <hadess@hadess.net>");
 MODULE_AUTHOR("Simon Wood <simon@mungewell.org>");
 MODULE_AUTHOR("Christian Mayer <git@mayer-bgk.de>");
+MODULE_AUTHOR("Sriman Achanta <srimanachanta@gmail.com>");
-- 
2.53.0

