Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F39438004
	for <linux-input@vger.kernel.org>; Mon,  3 Aug 2026 19:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785784566; cv=none; b=GCzqBktNc/ehWALW/AVpD97OKUhc+qNBPboZkRjm7riVqCBQFAcn6sfElTWcRjD+pYDZAkp+RYWggD9hwtNRoVBj7xOcHF+pqEZdNrksrc/87covnSOFUn+XNC0ULreD2lCtJFDdIVxChTijRlLm4bQlOUpXPqefh/62NGAtlCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785784566; c=relaxed/simple;
	bh=QTQxcVxUIPL/FxO3Igds3n66KlBgW2V/hK7DCccTnCg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FaiYAsq/PS6pPOTNyF3fF7HasPIn5816Xg45VFaVXRk3wvLIlMdju/j2Vt3WKv9XtccoeaMfOaqxsIRsM6XPDOnNKyfy3LY7+OMOSpxg7D0OQylFTmMXcwo5Pgrf87Scv1TxE6ChybS4YFrRHr4+m+Wu6E378BbkYqxpNOHh6mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gy8Vv0yh; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gy8Vv0yh"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-51c0ecfaee7so22925711cf.0
        for <linux-input@vger.kernel.org>; Mon, 03 Aug 2026 12:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785784562; x=1786389362; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=g1Xz+YpJmjqRPPiLSgL2+YLZomKTtVA5e6orURiQ6Hk=;
        b=gy8Vv0yh+kfaV0bDTfhgRCfWiXhwOilv9EpK4SiT8M/2q7NN+r5cQq3wqK/oD5UccV
         uC32iQBnYRCULFovoZnY8r8YRP8/p9h9QOBBHLLKpQFr5dJMTH8wJVv3V0LW1EUVVtsE
         iWRqf+5T6qXasVNF7Sb76KQ+x69sDz9xhtXlcDprXRQRHwWnHDF+B5617VHjjQhNJQ26
         g3dSVxLRYPtVG0625HZfxvv/5YP2JnNpRCI/sEdAtyGg9d9y0SHoolAWkJ2dA9okagxe
         ESMRx3UttEZptAxPVXoQimFgDk62lEI3z1IqaRs3ifnX7ymTTtDvdHGmni6DASJJrBp3
         zIAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785784562; x=1786389362;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=g1Xz+YpJmjqRPPiLSgL2+YLZomKTtVA5e6orURiQ6Hk=;
        b=Iyay6lR/sF/+pi40XZN/S8iyU4uLXtPO4KJttqztD3LcW7QKHTo/8GvzAu9UtduiDI
         3iBIhHR4OL7/xLJUl4xJVqnR+0pqWO4UjUW16bUY08qZbN6BuUMEcI7IFd2zubMZ4A6X
         +vr5ZXDFhcsGvyDhRsxuvJLNDTvIAaHFxcfHHUwravOOSDu2qtgfiyV3I07jV2IDKkeX
         LVOZ2LoScy4M5/hc93zLhJ1AHigmJ4O9MeJwacgbex4AAki0PVSVMPPIn2PAU3Okncsz
         MLd6ZwB6QzxCNG760geRr/ItstYPvUz2P7lM09I15dMpTP/6NRbcWdn/LiMNc8l7/GEi
         tFDw==
X-Gm-Message-State: AOJu0YzG/i6XV3Z29u6/TpjZtDgxeNov1Fwbn5U2bvkNMOAdMfBNch30
	FUag+PhxEuS5DqtNsdDbXjno8/ULydR5bUAZt/O+N3UiMFHT/PEBjohpI3SnQQ==
X-Gm-Gg: AR+sD11UZkX6iHoprjmmwXWRrGtLKenykt/wyya96f0fY/AiEdoYTbEemrEmC/TrEr3
	X5iBDd/dnsStOO5btHx0u4erd6MXD4KI075IvvmOWXpD+n9bWtcdMbamTUj++W6gBD6D5vCT+uK
	+SjZ9sy/g9bCL+alMlB+zwBuFnJ+2lKiuvmWPNtgqiPY0kppiCgjhdgATzX7de2zEZzC8SbZ7rA
	/TZquRtwQ4BtNdXhoaxkLXglsrx4Uso3YdhsH3OswCnAxNMu8g2PjVXMHYknu1LdPGV3aAhivZ6
	SQtmpBkTZ7VU3NPNLwSzZX86DRXzoMaXPP+Pud7+PqSsyV1tNfMH2qddhFRSs15nDeGZLydRs36
	RShNJadRuafC9Rr2o8pK0nP5cfWvLoFyf1+lP3Jaff2ALsrORdT2xl1bn4qFgxbCEMmCIokjrkL
	5eBeEbjNS5YZcScMmw5tIVUiW4+ndgj+yZouDfAgRC/Yh/xn+IMTw921+sWjeD3zdSKglU49s4I
	sHCa9Svp7wlATHsI+rRxjubECEE9w==
X-Received: by 2002:ac8:7f8e:0:b0:51b:ecbb:206f with SMTP id d75a77b69052e-52b567bff85mr203992041cf.32.1785784562464;
        Mon, 03 Aug 2026 12:16:02 -0700 (PDT)
Received: from achantapc.tail227c81.ts.net ([2600:4040:122e:7d00:f04d:e0df:fe04:e789])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52b4e64df9bsm67803541cf.0.2026.08.03.12.16.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 12:16:02 -0700 (PDT)
From: Sriman Achanta <srimanachanta@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bastien Nocera <hadess@hadess.net>,
	Simon Wood <simon@mungewell.org>,
	Christian Mayer <git@mayer-bgk.de>,
	Sriman Achanta <srimanachanta@gmail.com>
Subject: [PATCH v7 8/8] HID: steelseries: Add support for Arctis Nova 5X and Nova 7 families
Date: Mon,  3 Aug 2026 15:15:53 -0400
Message-ID: <20260803191553.66368-9-srimanachanta@gmail.com>
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
index 70b30e13b96f..5586a03d00a3 100644
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
 #define USB_DEVICE_ID_STEELSERIES_MSI_KLC   0x1122
 #define USB_DEVICE_ID_STEELSERIES_MSI_ALC   0x1161
 
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

