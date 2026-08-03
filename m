Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89618427A06
	for <linux-input@vger.kernel.org>; Mon,  3 Aug 2026 19:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785784560; cv=none; b=s0ohhw7VDizzHPcxDg6DHjJCAyrwVLf5djweyVgEsC3ahqoQxvqxQAhITnmkwwB2I9zi0TUFoxc370jlY0X9HbQhtP82irqLG48vVeFcMVwTdc5nRwIqVzTOciw8o0sRGJAN9UajtG8nM35J+tDpLDp9BGkiIqQsaUQkMBVyOZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785784560; c=relaxed/simple;
	bh=PZWvz1oiGO+EiDzGefrVoSQrphvSc4XUZ+9vkyTuOLA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PTomaTzw8IAXqUrTlSaClIxgNPiOnyJUYPR9gfBPcfTEpCUVsoB2LD3ghIjQx35AhEjKi/r6U6scd232QdpxpMpUIaOPYXMMDtHrm1nq1J959D9mjr2VkKzrYOY5le6OygzNQ9u6DtWE0i0S3z0TcQsmvCa46KczHyR/f7XCOmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gtEaeE6e; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gtEaeE6e"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-527e352a167so24008731cf.1
        for <linux-input@vger.kernel.org>; Mon, 03 Aug 2026 12:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785784557; x=1786389357; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rFCxfeOgVEQCpE619CeSJ8Vcr/viRMH26O07kTeRsnw=;
        b=gtEaeE6eEm9zAxxENzophgkmw1xIV23LMnAXXcvHMOSaOkuO8NskCmRXAkU8Uxs0T+
         YXC0Kguu1FF/nvk/rvANCdbYZ7AP7vfQk4Dra9nCdYYgcFxKKWv1STZWREYIewNdkTzx
         fC2PMIYKTFYrzmvXtD1g257js5Zu0ezZo7n3EspE8QH45G2nwc/3f/u8N9oiVqmmWfqL
         o90yPsKx4EJjEGsht8JNgClTooZxdQc1P4CaifhXf7VNACWClitVMKqJVbuzDsqlny+U
         OXjZeqq6mzSwz54hCg01XUqeH059d+W+Qn8dDs2g7iZmgRG3NU0z3gcO7P6dmXXeVvhM
         wSkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785784557; x=1786389357;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rFCxfeOgVEQCpE619CeSJ8Vcr/viRMH26O07kTeRsnw=;
        b=PZoBdNQ0EUtTtwFVwJwJBJZf5XsJS+litPQXqA8rH1fmz+Otbo8xulBfT8/hws5fCf
         YfKJQ7O2ANpEEWaxOPAKg7VLWaSKti5xsMu7Z/Q/76w4c7M6okXELkBE6BZVx8PBSuF6
         Ecn4G3YufQ/LF2vUX1Ltd5xoGp0mGQs4HgrgXG1bT3YzK3uhGrB4SvXQj1UUGE+CHpS3
         AwfQ/BHhJkb6w+7FeC/jvePoqCCvCNhJ8sK8ilDl1HYNufACu9L3Ci1/w+YYkG8Ab9t9
         vAaQTyzuvqXwm+QkQbI+bcSQ2p1yVjRCBpEtuYqfNJIWkZcicBFPAB/lXXzloGVovgKn
         lIQA==
X-Gm-Message-State: AOJu0YzxM4XJ0H14/5cKbSPikf9qY8fIfvlqKcEILu6KfrYKLMAq+ZCQ
	gN2yPCNvXNfdTav+hptig+rVpnNE2x+QIAMam7FrG4QTaRX8DQh2q4N2
X-Gm-Gg: AR+sD11FLNz7BXSrpmfJnC/nLLM0Pt7NsD38veEv43P3kLwoLbj5Tsw80Dw3VhCi/KG
	5cZiYWzUXPvpKhvNaZ3MqYN/Wz2JjS6L5fW403Baxk58YSQznssRTlaEsofkZM3ZtkvahEVnum9
	4yCVDIRi13iF7EhRoSXjJKLIKuSLXS6g26LOMNiSJorKteKDeg+uncPOW1EallhAdsh3lfc0HNO
	rhrfjtNu3x8wnUKX2j4d8g2RqQs7RvRxfk5Au47jCLuhmEDsHWgDs6LrGS5E1YfzogpNRgePoqG
	fxLL5kzQrSEiqR/B+G8ScMgt2h/vhMFnX7Bl6bNBXrSEBISXJ9CRxHlqNfVcrirrfy3SXaJZMFn
	1bNbVMzwhs3hERKd2GAbY7jTfipt5SSvHyTNXmlXmE0EMrd5gxkzgvf7KybAiFhiy6XZLQ4HfU1
	6gseImk0Ze+S0W28MqFq8aellS0KPbekN/IqININLuYBtzE7Boi79Lrm0ySGocwXJv2mI8ahLBV
	h4t0kq/Im/+M2p/5OE=
X-Received: by 2002:ac8:5c85:0:b0:51c:61a:50e6 with SMTP id d75a77b69052e-52b566f6d04mr218681631cf.3.1785784557192;
        Mon, 03 Aug 2026 12:15:57 -0700 (PDT)
Received: from achantapc.tail227c81.ts.net ([2600:4040:122e:7d00:f04d:e0df:fe04:e789])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52b4e64df9bsm67803541cf.0.2026.08.03.12.15.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 12:15:56 -0700 (PDT)
From: Sriman Achanta <srimanachanta@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bastien Nocera <hadess@hadess.net>,
	Simon Wood <simon@mungewell.org>,
	Christian Mayer <git@mayer-bgk.de>,
	Sriman Achanta <srimanachanta@gmail.com>
Subject: [PATCH v7 1/8] HID: steelseries: Fix ARCTIS_1_X device mislabeling
Date: Mon,  3 Aug 2026 15:15:46 -0400
Message-ID: <20260803191553.66368-2-srimanachanta@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260803191553.66368-1-srimanachanta@gmail.com>
References: <20260803191553.66368-1-srimanachanta@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The SteelSeries Arctis 1 Wireless for Xbox (0x12b6) was labelled as the
plain Arctis 1 Wireless. Rename USB_DEVICE_ID_STEELSERIES_ARCTIS_1 to
USB_DEVICE_ID_STEELSERIES_ARCTIS_1_X, along with the matching quirk flag
and device table entry. The device ID value is unchanged.

Signed-off-by: Sriman Achanta <srimanachanta@gmail.com>
---
 drivers/hid/hid-ids.h         |  4 ++--
 drivers/hid/hid-quirks.c      |  2 +-
 drivers/hid/hid-steelseries.c | 14 +++++++-------
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index b70f719b3b07..70b30e13b96f 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -1377,8 +1377,8 @@
 
 #define USB_VENDOR_ID_STEELSERIES	0x1038
 #define USB_DEVICE_ID_STEELSERIES_SRWS1	0x1410
-#define USB_DEVICE_ID_STEELSERIES_ARCTIS_1  0x12b6
-#define USB_DEVICE_ID_STEELSERIES_ARCTIS_9  0x12c2
+#define USB_DEVICE_ID_STEELSERIES_ARCTIS_1_X	0x12b6
+#define USB_DEVICE_ID_STEELSERIES_ARCTIS_9	0x12c2
 #define USB_DEVICE_ID_STEELSERIES_MSI_KLC   0x1122
 #define USB_DEVICE_ID_STEELSERIES_MSI_ALC   0x1161
 
diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
index 57d8efdd9b89..f546179858c2 100644
--- a/drivers/hid/hid-quirks.c
+++ b/drivers/hid/hid-quirks.c
@@ -747,7 +747,7 @@ static const struct hid_device_id hid_have_special_driver[] = {
 #endif
 #if IS_ENABLED(CONFIG_HID_STEELSERIES)
 	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES, USB_DEVICE_ID_STEELSERIES_SRWS1) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES, USB_DEVICE_ID_STEELSERIES_ARCTIS_1) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES, USB_DEVICE_ID_STEELSERIES_ARCTIS_1_X) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES, USB_DEVICE_ID_STEELSERIES_ARCTIS_9) },
 #endif
 #if IS_ENABLED(CONFIG_HID_SUNPLUS)
diff --git a/drivers/hid/hid-steelseries.c b/drivers/hid/hid-steelseries.c
index 73f77dd07110..54efa70d128d 100644
--- a/drivers/hid/hid-steelseries.c
+++ b/drivers/hid/hid-steelseries.c
@@ -21,7 +21,7 @@
 #include "hid-ids.h"
 
 #define STEELSERIES_SRWS1		BIT(0)
-#define STEELSERIES_ARCTIS_1		BIT(1)
+#define STEELSERIES_ARCTIS_1_X		BIT(1)
 #define STEELSERIES_ARCTIS_9		BIT(2)
 #define STEELSERIES_MSI_RGB		BIT(3)
 
@@ -396,7 +396,7 @@ static void steelseries_headset_fetch_battery(struct hid_device *hdev)
 {
 	int ret = 0;
 
-	if (hdev->product == USB_DEVICE_ID_STEELSERIES_ARCTIS_1)
+	if (hdev->product == USB_DEVICE_ID_STEELSERIES_ARCTIS_1_X)
 		ret = steelseries_headset_request_battery(hdev,
 			arctis_1_battery_request, sizeof(arctis_1_battery_request));
 	else if (hdev->product == USB_DEVICE_ID_STEELSERIES_ARCTIS_9)
@@ -829,7 +829,7 @@ static int steelseries_probe(struct hid_device *hdev, const struct hid_device_id
 		return 0;
 	}
 
-	if ((sd->quirks & (STEELSERIES_ARCTIS_1 | STEELSERIES_ARCTIS_9)) &&
+	if ((sd->quirks & (STEELSERIES_ARCTIS_1_X | STEELSERIES_ARCTIS_9)) &&
 	    steelseries_headset_battery_register(sd) < 0)
 		hid_err(sd->hdev,
 			"Failed to register battery for headset\n");
@@ -897,7 +897,7 @@ static uint8_t steelseries_headset_map_capacity(uint8_t capacity, uint8_t min_in
 
 static bool steelseries_is_headset(struct hid_device *hdev)
 {
-	return hdev->product == USB_DEVICE_ID_STEELSERIES_ARCTIS_1 ||
+	return hdev->product == USB_DEVICE_ID_STEELSERIES_ARCTIS_1_X ||
 	       hdev->product == USB_DEVICE_ID_STEELSERIES_ARCTIS_9;
 }
 
@@ -923,7 +923,7 @@ static int steelseries_headset_raw_event(struct hid_device *hdev,
 	connected = sd->headset_connected;
 	charging = sd->battery_charging;
 
-	if (hdev->product == USB_DEVICE_ID_STEELSERIES_ARCTIS_1) {
+	if (hdev->product == USB_DEVICE_ID_STEELSERIES_ARCTIS_1_X) {
 		hid_dbg(sd->hdev,
 			"Parsing raw event for Arctis 1 headset (%*ph)\n", size, read_buf);
 		if (size < ARCTIS_1_BATTERY_RESPONSE_LEN ||
@@ -1010,8 +1010,8 @@ static const struct hid_device_id steelseries_devices[] = {
 	  .driver_data = STEELSERIES_SRWS1 },
 
 	{ /* SteelSeries Arctis 1 Wireless for XBox */
-	  HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES, USB_DEVICE_ID_STEELSERIES_ARCTIS_1),
-	  .driver_data = STEELSERIES_ARCTIS_1 },
+	  HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES, USB_DEVICE_ID_STEELSERIES_ARCTIS_1_X),
+	  .driver_data = STEELSERIES_ARCTIS_1_X },
 
 	{ /* SteelSeries Arctis 9 Wireless for XBox */
 	  HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES, USB_DEVICE_ID_STEELSERIES_ARCTIS_9),
-- 
2.55.0

