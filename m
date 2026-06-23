Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7593B38B7A1
	for <linux-input@vger.kernel.org>; Tue, 23 Jun 2026 17:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782235403; cv=none; b=s3swBJ7nPohEwWcyEA4rWsqKPOh3+zzfus/Lhm+r91WzIryOnUcTCC6+ebEg2JYQOBNKvbC0Y4FnbqXVikC/6SRteQQqOxy5m5ozr4r/aIZzbREWR1JuMqNEKHzXiP+uSdXyp5cFvyrV50Z5eF285irJRfTOKnX2iSUoDY/nqlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782235403; c=relaxed/simple;
	bh=kxP6LNpmuMPeRo/1DHYVkK9vYC25+9G+iv+jK4cri9o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fw/hsFj12okGSHaQmA6WjFZKSj0XQtgTBUIFFIvuTAEoVXEmso/2Iu4Q8OTppv28+abn0WCUlz+KKVxIKB2vSrqXfZVgIn0aN7+jjX5q6Cj3v+WawK/uNgA8cu4IpngYUXNya5R6DWw1ljVQehnsSVPqbhmJ14O0pgP1F5PKAds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qoqyKVml; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qoqyKVml"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-51788280e71so344871cf.0
        for <linux-input@vger.kernel.org>; Tue, 23 Jun 2026 10:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782235400; x=1782840200; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=toVb3XeUyvgVY5ouIuGchQv5MOZwstQQcaCF09SpULY=;
        b=qoqyKVmlZfxC4rpLv6z2MTT4gfLts6GQd4T2/WH+TZPbex03/ftpfCwSDs9tIseobU
         QpjEi8m4C97akYcFpbbGtvvwFemjHpVWcNMzOrOHOQ9I4Wk66EdwgQoUtAcg2lMxErrq
         GIATxPXtNb82cjCXey2sNPXS+z/99yqZYNAltK99Qss6HnbyvW7NWBVnFpZah4cUT5cg
         r/DzoUOpLdOqtA3JWuafWcRVD+zCWoucsLhrxfKSGTqIFAU8Ncd+5XC7q/vdp1WnXyla
         nXPzsBZsvFCZ22Zn3SlddXGLBJ5PDWC16M6lG1RVHBPP9VAiQ04joMSTa/izx/SJBcXi
         ItRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782235400; x=1782840200;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=toVb3XeUyvgVY5ouIuGchQv5MOZwstQQcaCF09SpULY=;
        b=ceRWIDV4UqF9A67frlN6fQ+RePQgw+V8eT1EBC1v/BY0Cr7TfZiHcMzavNurfBoiyS
         d7K5P0gIJR1uhcIORD8Xb8UUMa1P/f2HxmNsev00KPwGnE8Sc3N17sONvHn1yLvYsNdw
         L36KgP5gDWwN4fCavxdbrVYsUWSUlxZs19lBzINTkD1SwbVO9BLHjOC/deE0Ej3oamBy
         C4xp91E1vQ2tdpt+5oUr2ps6hQqXszChONP3VkPI3d2NKFq0PcAqs3AaCSrugGqnErbn
         iqxR1Uh6Fy/Z4ERWB9dD+09rQghI8dUm8cba9m2sqeXwYkBFgXOvBRcxlx0sLdzX4nYJ
         mDhg==
X-Gm-Message-State: AOJu0YyEeSYltA7Z7UFJeF0G7s3tNpaHl7hMHP0AWss36vcwqidUVbkW
	T7S2IT0aHenSRUQMxREp5LCnFfFKayhPkun06HOcWmXzuo4IsmjHBDIG
X-Gm-Gg: AfdE7clY3J0JiNIEJEmFR5EmZ8mwcVDnkpgGzo/rnlLWFA4QvUqX+l9mnC5zzcXpBlz
	cbj/zdQqnpvBGkMXa9Wgh48oU5OL+IU7S9Pc6mAhZ8cGsfNiYhkCixJgnBJErpW4MAFkmeRTxgC
	zf1L/mclQcwhXJtNiB9eoFrIJC7klnwj0b7sFnpGnzF+WXWOOR6GBV0j1aAk2zQBM6UoBC6js42
	FAiQKzvAiFGui/C7NDkK9vNGYUMMbd6cRnSWT5gY+F3uKZCPW1BNpTxfKYyjxf6jTrE5PlxEBjE
	O6CCtRD6uY2hCdun51PMSyPtOQ/upM2xn2Stmrio8l97SRNpDxE0hEAOov1QEvetho+XCAZ4PJe
	CwTCp7PNlfPoBFU8Y8lVlhxzXwTzHBQ5rtWmPXy/ENqLcpiaoMHSmQUNHoPMj2lD897WzDK9V+a
	8dRMXIj39xtNe3AxPeATnzl8iIcrskF+FAfcT7uCGjbgH+xySa
X-Received: by 2002:ac8:5f0b:0:b0:517:75d8:b960 with SMTP id d75a77b69052e-51a06ad95e8mr231700321cf.43.1782235400576;
        Tue, 23 Jun 2026 10:23:20 -0700 (PDT)
Received: from achantapc.mynetworksettings.com ([2600:4040:124c:e000:ff10:313f:67f6:deeb])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51a515c72c1sm29390531cf.10.2026.06.23.10.23.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 10:23:20 -0700 (PDT)
From: Sriman Achanta <srimanachanta@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Simon Wood <simon@mungewell.org>,
	Christian Mayer <git@mayer-bgk.de>,
	Bastien Nocera <hadess@hadess.net>,
	Sriman Achanta <srimanachanta@gmail.com>
Subject: [PATCH v4 10/10] HID: steelseries: Add support for Arctis Nova 7 Gen2 family
Date: Tue, 23 Jun 2026 13:23:10 -0400
Message-ID: <20260623172310.272708-11-srimanachanta@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260623172310.272708-1-srimanachanta@gmail.com>
References: <20260623172310.272708-1-srimanachanta@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Arctis Nova 7 Gen2 headsets answer status polls, but they also send
unsolicited battery and connection updates on a second HID interface
(interface 5). Use that interface through async_interface so the driver
does not have to poll. Add request and parse helpers for the Gen2 status
format (0xb0/0xb7/0xb9/0xbb opcodes).

Add the eight USB product IDs that share this protocol:

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
 drivers/hid/hid-ids.h                |  8 ++++
 drivers/hid/hid-quirks.c             |  8 ++++
 drivers/hid/hid-steelseries-arctis.c | 63 ++++++++++++++++++++++++++++
 3 files changed, 79 insertions(+)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 915e936cbf8b..6b5be86b1bdf 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -1379,6 +1379,14 @@
 #define USB_DEVICE_ID_STEELSERIES_SRWS1	0x1410
 #define USB_DEVICE_ID_STEELSERIES_ARCTIS_1_X	0x12b6
 #define USB_DEVICE_ID_STEELSERIES_ARCTIS_9	0x12c2
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
index f546179858c2..40a761b5df91 100644
--- a/drivers/hid/hid-quirks.c
+++ b/drivers/hid/hid-quirks.c
@@ -749,6 +749,14 @@ static const struct hid_device_id hid_have_special_driver[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES, USB_DEVICE_ID_STEELSERIES_SRWS1) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES, USB_DEVICE_ID_STEELSERIES_ARCTIS_1_X) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES, USB_DEVICE_ID_STEELSERIES_ARCTIS_9) },
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
index 2208d0e4cd2a..eecd384b1a33 100644
--- a/drivers/hid/hid-steelseries-arctis.c
+++ b/drivers/hid/hid-steelseries-arctis.c
@@ -114,6 +114,13 @@ static int steelseries_arctis_9_request_status(struct hid_device *hdev)
 	return steelseries_send_feature_report(hdev, data, sizeof(data));
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
@@ -163,6 +170,30 @@ static void steelseries_arctis_9_parse_status(struct steelseries_device *sd,
 	}
 }
 
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
 /*
  * Device info definitions
  */
@@ -181,6 +212,14 @@ static const struct steelseries_device_info arctis_9_info = {
 	.parse_status = steelseries_arctis_9_parse_status,
 };
 
+static const struct steelseries_device_info arctis_nova_7_gen2_info = {
+	.sync_interface = 3,
+	.async_interface = 5,
+	.capabilities = SS_CAP_BATTERY,
+	.request_status = steelseries_arctis_nova_request_status,
+	.parse_status = steelseries_arctis_nova_7_gen2_parse_status,
+};
+
 /*
  * Headset wireless status and battery infrastructure
  */
@@ -548,6 +587,30 @@ static const struct hid_device_id steelseries_arctis_devices[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES,
 			 USB_DEVICE_ID_STEELSERIES_ARCTIS_9),
 	  .driver_data = (unsigned long)&arctis_9_info },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES,
+			 USB_DEVICE_ID_STEELSERIES_ARCTIS_NOVA_7_2026),
+	  .driver_data = (unsigned long)&arctis_nova_7_gen2_info },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES,
+			 USB_DEVICE_ID_STEELSERIES_ARCTIS_NOVA_7_P_2026),
+	  .driver_data = (unsigned long)&arctis_nova_7_gen2_info },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES,
+			 USB_DEVICE_ID_STEELSERIES_ARCTIS_NOVA_7_X_2026),
+	  .driver_data = (unsigned long)&arctis_nova_7_gen2_info },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES,
+			 USB_DEVICE_ID_STEELSERIES_ARCTIS_NOVA_7_DIABLO_2026),
+	  .driver_data = (unsigned long)&arctis_nova_7_gen2_info },
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
+			 USB_DEVICE_ID_STEELSERIES_ARCTIS_NOVA_7_X_GEN2_3),
+	  .driver_data = (unsigned long)&arctis_nova_7_gen2_info },
 	{}
 };
 MODULE_DEVICE_TABLE(hid, steelseries_arctis_devices);
-- 
2.54.0

