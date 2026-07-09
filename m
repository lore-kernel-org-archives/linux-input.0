Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C409438D3E5
	for <linux-input@vger.kernel.org>; Thu,  9 Jul 2026 03:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783567432; cv=none; b=tfKM7Mx3gdYPmoWcQekbF6Xok+4GkEIlq22GZOcSvk+sz/eWveGW5tDwn+YfrKYXbNsajSqPwBTZYlLAOONrar6skilqCx6NiQUzqS0PoIiLG0owCbel6GbRwSTg+xOgbqIzK55NijthkAYMwdkCVb4fWkE3UmPGudFWCupaqy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783567432; c=relaxed/simple;
	bh=Lbwx7mv4EOZDK7mv+5871SaMZ2gWoZ9Vx9bcjRVdsj0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BKyQdpiNpmyQLf0GN7vB0odkefcCRiaXGJrkGL/y2g+yYmWSL+o5wHF1k1M+JQmCXqkrPZ037lEY295MAYrsfE+uLLPPgO5WyUazyCqTqFO/lPhQOsvxuSERHFM+q7xNhTRGlYJGXmsQyCaulbuVddmqygZIdM1soIb8aZaTMC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jqCzL5VB; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jqCzL5VB"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-920f33347f5so71881985a.3
        for <linux-input@vger.kernel.org>; Wed, 08 Jul 2026 20:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783567429; x=1784172229; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BY2aMiVhvliFXemhmRQrrT3H+AG9Zjh07u6anmB9lVk=;
        b=jqCzL5VBo38H/GhPbkTC081wDzrAwFGaKGDxF4MOaP+y2j0eVeED8h0Kve0VLBm8mO
         i3Tew5u/ZiKAHMWY1bLh9xvugJflLWOPDP25X4YprNcWWE1E5XQPMCtDgQwfG9P2a04w
         LBBZbutViaHXMbSKJ3YPli5bsP42mHH9DBR4lmrTxTyHc7B7OeCSHcyPvfZFwT5FkrL5
         1ckJQxRXiD8+O9JnpMhMvN0dBGQzV3LeP105w41OLP4xOhz2FFFhYVqVhmeXnrW+aiUf
         h9lq4mCccvPNJ5N1FKTIvne1bGOS+HMwoXKlNCSoiT86N0V4uNwvzBDc2WLeXyYpp7qf
         I15w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783567429; x=1784172229;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BY2aMiVhvliFXemhmRQrrT3H+AG9Zjh07u6anmB9lVk=;
        b=K9nKTgWwhTwK7pDm2Th8XyT+zlI9J+XijuF6g11VHCwcq4h0TQ8O9Tu+t628uM2D19
         8vV2VSgMJ60MQBAHaSKjXcaCWru0Wrpa2Vsc4aMeHvM2Ou6qHjC2Ekw17ZSg7R7NEEx/
         5ZrF3HQela6CyWMrNa3OeaInXq/2IiUYRC3DVMlcq/n431dy883IkkhfrGYaIvOCbXTF
         cN1kb2sJ/rE4o02xtxct6YyvHuDS+QZzpNyiowt4Hn/8FiDqapC1+X5woZz2T90pJy/i
         4MpbkAPOKiGt7KqRcdpdIuEr0PM4S8se6uctqG3h9iQKT5Xe5w3zPiDLChmJPPi0gMqj
         9zZw==
X-Gm-Message-State: AOJu0YwAYJiVjTuJ3JE0WqYQHkLH8HPyzktaWaXEXkhPx4wZVYQnPzFL
	VfJr9dL/Xp9oGVDPym+TIKhxY+a/9qwRvXIDyIM1FBqqUVAB3B5prYM5AjhvLQ==
X-Gm-Gg: AfdE7cn4/EFsOlhyR6rT/aWztE3430Os14SWt5YlBceZfeRhlNjFGF3IP3wMmJmoqVU
	oD67kMysZH9e0KOISQvoj+Oj0f0evDxu13Jf8lvXI2lHqNlJ0IzRi7R1GG4O3SEdlBE7vtNlIxU
	SMf4RHUzUTqYQaUtwltuMHCjuDrrgIWUFBA01BZ0DA6dUBih00YkN8O5maq/kmrpNNRst2c9H5Q
	z3LGTSoQYWtQbZhO7LMNHGsH6pBSCf0x8MOpC6TTp9RQvAzD3BB5xKKRjLee42BHijTwBOw/+Hb
	bblJBBM2/Z5v6LCYnZH422r3ZM4FHC7uIle5S5SgJ4UJb9WIwAcjkF9T2dJheTkx5ekSV2dXbSb
	sVWZkQ4j7zJRVxaYWutP0qzMF9K4u52uPUeJ+O7MUCfBkRsDtmBXMrfIfjVUJVz7mjipO2CXQIP
	VJYdIGCoUwDYb8/uojM65u3i8aOT9sZdp68R6Qu2p75lCxCXK0TGWOWVbwsz+o2xlsJIc27dNwT
	VHG2FP0
X-Received: by 2002:a05:620a:a00d:b0:92e:d2d4:2d07 with SMTP id af79cd13be357-92ed2d4358fmr408263885a.50.1783567428607;
        Wed, 08 Jul 2026 20:23:48 -0700 (PDT)
Received: from achantapc.mynetworksettings.com ([2600:4040:122a:dd00:da6a:a6e4:2464:e6a1])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e9c0f7de9sm1336872185a.26.2026.07.08.20.23.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 20:23:48 -0700 (PDT)
From: Sriman Achanta <srimanachanta@gmail.com>
X-Google-Original-From: Sriman Achanta <68172138+srimanachanta@users.noreply.github.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bastien Nocera <hadess@hadess.net>,
	Simon Wood <simon@mungewell.org>,
	Christian Mayer <git@mayer-bgk.de>,
	Sriman Achanta <srimanachanta@gmail.com>
Subject: [PATCH v6 9/9] HID: steelseries: Add support for Arctis Nova 5X and Nova 7 families
Date: Wed,  8 Jul 2026 23:23:16 -0400
Message-ID: <20260709032316.1908460-10-68172138+srimanachanta@users.noreply.github.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260709032316.1908460-1-68172138+srimanachanta@users.noreply.github.com>
References: <20260709032316.1908460-1-68172138+srimanachanta@users.noreply.github.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sriman Achanta <srimanachanta@gmail.com>

The Arctis Nova 5X, Nova 7 Gen2, and Nova 7 2026 refresh headsets answer
status polls, but also send unsolicited battery and connection updates
on a second HID interface (interface 5). Use that interface through
async_interface so the driver does not have to poll. Add request and
parse helpers for the Nova status format (0xb0/0xb7/0xb9/0xbb opcodes).

The original (pre-Gen2) Arctis Nova 7 family answers the same status
opcodes on the same interfaces, but reports battery capacity as a
discrete 0-4 level instead of a raw percentage. Add a second parse
function that maps that level through steelseries_map_capacity(), and a
separate device_info so the two capacity encodings cannot get mixed up.

Add the fourteen USB product IDs that share these protocols:

  0x2253  Arctis Nova 5X
  0x2202  Arctis Nova 7
  0x2206  Arctis Nova 7X
  0x22a4  Arctis Nova 7X (alternate PID)
  0x223a  Arctis Nova 7 Diablo
  0x227a  Arctis Nova 7 World of Warcraft Edition
  0x22a1  Arctis Nova 7 2026
  0x22a7  Arctis Nova 7P 2026
  0x22a5  Arctis Nova 7X 2026
  0x22a9  Arctis Nova 7 Diablo 2026
  0x227e  Arctis Nova 7 Gen 2
  0x2258  Arctis Nova 7X Gen 2
  0x229e  Arctis Nova 7X Gen 2 (alternate PID)
  0x22ad  Arctis Nova 7X Gen 2 (alternate PID)

Signed-off-by: Sriman Achanta <srimanachanta@gmail.com>
---
 drivers/hid/hid-ids.h                |  14 ++++
 drivers/hid/hid-quirks.c             |  14 ++++
 drivers/hid/hid-steelseries-arctis.c | 117 +++++++++++++++++++++++++++
 3 files changed, 145 insertions(+)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 915e936cbf8b..92c685a6d3e5 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -1379,6 +1379,20 @@
 #define USB_DEVICE_ID_STEELSERIES_SRWS1	0x1410
 #define USB_DEVICE_ID_STEELSERIES_ARCTIS_1_X	0x12b6
 #define USB_DEVICE_ID_STEELSERIES_ARCTIS_9	0x12c2
+#define USB_DEVICE_ID_STEELSERIES_ARCTIS_NOVA_5_X	0x2253
+#define USB_DEVICE_ID_STEELSERIES_ARCTIS_NOVA_7	0x2202
+#define USB_DEVICE_ID_STEELSERIES_ARCTIS_NOVA_7_X	0x2206
+#define USB_DEVICE_ID_STEELSERIES_ARCTIS_NOVA_7_X_2	0x22a4
+#define USB_DEVICE_ID_STEELSERIES_ARCTIS_NOVA_7_DIABLO	0x223a
+#define USB_DEVICE_ID_STEELSERIES_ARCTIS_NOVA_7_WOW	0x227a
+#define USB_DEVICE_ID_STEELSERIES_ARCTIS_NOVA_7_2026	0x22a1
+#define USB_DEVICE_ID_STEELSERIES_ARCTIS_NOVA_7_P_2026	0x22a7
+#define USB_DEVICE_ID_STEELSERIES_ARCTIS_NOVA_7_X_2026	0x22a5
+#define USB_DEVICE_ID_STEELSERIES_ARCTIS_NOVA_7_DIABLO_2026	0x22a9
+#define USB_DEVICE_ID_STEELSERIES_ARCTIS_NOVA_7_GEN2	0x227e
+#define USB_DEVICE_ID_STEELSERIES_ARCTIS_NOVA_7_X_GEN2	0x2258
+#define USB_DEVICE_ID_STEELSERIES_ARCTIS_NOVA_7_X_GEN2_2	0x229e
+#define USB_DEVICE_ID_STEELSERIES_ARCTIS_NOVA_7_X_GEN2_3	0x22ad
 
 #define USB_VENDOR_ID_SUN		0x0430
 #define USB_DEVICE_ID_RARITAN_KVM_DONGLE	0xcdab
diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
index f546179858c2..eef2c2106dd7 100644
--- a/drivers/hid/hid-quirks.c
+++ b/drivers/hid/hid-quirks.c
@@ -749,6 +749,20 @@ static const struct hid_device_id hid_have_special_driver[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES, USB_DEVICE_ID_STEELSERIES_SRWS1) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES, USB_DEVICE_ID_STEELSERIES_ARCTIS_1_X) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES, USB_DEVICE_ID_STEELSERIES_ARCTIS_9) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES, USB_DEVICE_ID_STEELSERIES_ARCTIS_NOVA_5_X) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES, USB_DEVICE_ID_STEELSERIES_ARCTIS_NOVA_7) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES, USB_DEVICE_ID_STEELSERIES_ARCTIS_NOVA_7_X) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES, USB_DEVICE_ID_STEELSERIES_ARCTIS_NOVA_7_X_2) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES, USB_DEVICE_ID_STEELSERIES_ARCTIS_NOVA_7_DIABLO) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES, USB_DEVICE_ID_STEELSERIES_ARCTIS_NOVA_7_WOW) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES, USB_DEVICE_ID_STEELSERIES_ARCTIS_NOVA_7_2026) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES, USB_DEVICE_ID_STEELSERIES_ARCTIS_NOVA_7_P_2026) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES, USB_DEVICE_ID_STEELSERIES_ARCTIS_NOVA_7_X_2026) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES, USB_DEVICE_ID_STEELSERIES_ARCTIS_NOVA_7_DIABLO_2026) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES, USB_DEVICE_ID_STEELSERIES_ARCTIS_NOVA_7_GEN2) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES, USB_DEVICE_ID_STEELSERIES_ARCTIS_NOVA_7_X_GEN2) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES, USB_DEVICE_ID_STEELSERIES_ARCTIS_NOVA_7_X_GEN2_2) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES, USB_DEVICE_ID_STEELSERIES_ARCTIS_NOVA_7_X_GEN2_3) },
 #endif
 #if IS_ENABLED(CONFIG_HID_SUNPLUS)
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SUNPLUS, USB_DEVICE_ID_SUNPLUS_WDESKTOP) },
diff --git a/drivers/hid/hid-steelseries-arctis.c b/drivers/hid/hid-steelseries-arctis.c
index 9960c0ec512b..23fb0cebd72a 100644
--- a/drivers/hid/hid-steelseries-arctis.c
+++ b/drivers/hid/hid-steelseries-arctis.c
@@ -108,6 +108,13 @@ static int steelseries_arctis_9_request_status(struct hid_device *hdev)
 	return steelseries_send_output_report(hdev, data, sizeof(data));
 }
 
+static int steelseries_arctis_nova_request_status(struct hid_device *hdev)
+{
+	const u8 data[] = { 0x00, 0xb0 };
+
+	return steelseries_send_output_report(hdev, data, sizeof(data));
+}
+
 /*
  * Headset battery helpers
  */
@@ -162,6 +169,58 @@ static void steelseries_arctis_9_parse_status(struct steelseries_device *sd,
 	}
 }
 
+static void steelseries_arctis_nova_parse_status(struct steelseries_device *sd,
+						 u8 *data, int size)
+{
+	if (size < 2)
+		return;
+
+	switch (data[0]) {
+	case 0xb0:
+		if (size < 4)
+			return;
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
+static void steelseries_arctis_nova_7_parse_status(struct steelseries_device *sd,
+						   u8 *data, int size)
+{
+	if (size < 2)
+		return;
+
+	switch (data[0]) {
+	case 0xb0:
+		if (size < 4)
+			return;
+		sd->headset_connected = (data[1] == 0x03);
+		sd->battery_capacity = steelseries_map_capacity(data[2], 0, 4);
+		sd->battery_charging = (data[3] == 0x01);
+		break;
+	case 0xb7:
+		sd->battery_capacity = steelseries_map_capacity(data[1], 0, 4);
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
 /*
  * Device info definitions
  */
@@ -180,6 +239,22 @@ static const struct steelseries_device_info arctis_9_info = {
 	.parse_status = steelseries_arctis_9_parse_status,
 };
 
+static const struct steelseries_device_info arctis_nova_info = {
+	.sync_interface = 3,
+	.async_interface = 5,
+	.capabilities = SS_CAP_BATTERY,
+	.request_status = steelseries_arctis_nova_request_status,
+	.parse_status = steelseries_arctis_nova_parse_status,
+};
+
+static const struct steelseries_device_info arctis_nova_7_info = {
+	.sync_interface = 3,
+	.async_interface = 5,
+	.capabilities = SS_CAP_BATTERY,
+	.request_status = steelseries_arctis_nova_request_status,
+	.parse_status = steelseries_arctis_nova_7_parse_status,
+};
+
 /*
  * Headset wireless status and battery infrastructure
  */
@@ -581,6 +656,48 @@ static const struct hid_device_id steelseries_arctis_devices[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES,
 			 USB_DEVICE_ID_STEELSERIES_ARCTIS_9),
 	  .driver_data = (unsigned long)&arctis_9_info },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES,
+			 USB_DEVICE_ID_STEELSERIES_ARCTIS_NOVA_5_X),
+	  .driver_data = (unsigned long)&arctis_nova_info },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES,
+			 USB_DEVICE_ID_STEELSERIES_ARCTIS_NOVA_7),
+	  .driver_data = (unsigned long)&arctis_nova_7_info },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES,
+			 USB_DEVICE_ID_STEELSERIES_ARCTIS_NOVA_7_X),
+	  .driver_data = (unsigned long)&arctis_nova_7_info },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES,
+			 USB_DEVICE_ID_STEELSERIES_ARCTIS_NOVA_7_X_2),
+	  .driver_data = (unsigned long)&arctis_nova_7_info },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES,
+			 USB_DEVICE_ID_STEELSERIES_ARCTIS_NOVA_7_DIABLO),
+	  .driver_data = (unsigned long)&arctis_nova_7_info },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES,
+			 USB_DEVICE_ID_STEELSERIES_ARCTIS_NOVA_7_WOW),
+	  .driver_data = (unsigned long)&arctis_nova_7_info },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES,
+			 USB_DEVICE_ID_STEELSERIES_ARCTIS_NOVA_7_2026),
+	  .driver_data = (unsigned long)&arctis_nova_info },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES,
+			 USB_DEVICE_ID_STEELSERIES_ARCTIS_NOVA_7_P_2026),
+	  .driver_data = (unsigned long)&arctis_nova_info },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES,
+			 USB_DEVICE_ID_STEELSERIES_ARCTIS_NOVA_7_X_2026),
+	  .driver_data = (unsigned long)&arctis_nova_info },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES,
+			 USB_DEVICE_ID_STEELSERIES_ARCTIS_NOVA_7_DIABLO_2026),
+	  .driver_data = (unsigned long)&arctis_nova_info },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES,
+			 USB_DEVICE_ID_STEELSERIES_ARCTIS_NOVA_7_GEN2),
+	  .driver_data = (unsigned long)&arctis_nova_info },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES,
+			 USB_DEVICE_ID_STEELSERIES_ARCTIS_NOVA_7_X_GEN2),
+	  .driver_data = (unsigned long)&arctis_nova_info },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES,
+			 USB_DEVICE_ID_STEELSERIES_ARCTIS_NOVA_7_X_GEN2_2),
+	  .driver_data = (unsigned long)&arctis_nova_info },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES,
+			 USB_DEVICE_ID_STEELSERIES_ARCTIS_NOVA_7_X_GEN2_3),
+	  .driver_data = (unsigned long)&arctis_nova_info },
 	{}
 };
 MODULE_DEVICE_TABLE(hid, steelseries_arctis_devices);
-- 
2.55.0

