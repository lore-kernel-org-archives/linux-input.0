Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE1C03E0C51
	for <linux-input@vger.kernel.org>; Tue, 30 Jun 2026 17:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782840589; cv=none; b=PbdayZUj3KTaJw1rrzaWyKMTcjmNUzHu7c7cE3UuKsKSnl/8MccqWInr0rFLxro7DWhcl449UYn4nskXxpma4eEvlIn0knTsU9u4+pwpntHGVNUWo9ZGJtbHUW1nfMF/mghKatK1qR/JjHn5jYlANRHeaHmTHy9u3Wi+arm2B/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782840589; c=relaxed/simple;
	bh=MPuubMH9J+pDoxqT7b8Gw8WGCK3ZvRXGhILrBlvNXy8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kdhlA6RMFjHbiZZhbmg2H4sI9LrBojVXcyAYcsJxiyYpeymzPLsdP4ruroWA4l4fa1Z8g8c05Ugc4UCXhvPT1dDtGsH3I7MqAKuxRfoIa3JZuw9SnKB0xCkmqpyyhyNGkuRAdObY3k94vN/oUNK+Y4X5RRl/PTCli3r+94XCLiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iGurEPaO; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iGurEPaO"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-51bf2479349so24245631cf.2
        for <linux-input@vger.kernel.org>; Tue, 30 Jun 2026 10:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782840587; x=1783445387; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dZoRaVR2MVFzoC5JdGzTsIrPrpLP/ptFAeu8Dgut+Ek=;
        b=iGurEPaOHS7u7yex+16OqU5dgsvKWHfYARt+uz3K7sdrVsMrgvO05zPU51EErcBaf/
         1wChLRygz19Bgqy4Eil8j9SZ3RHzGNNe2MkDrjRysZOR5RK5YDgGADsbJWxKavWlDJIs
         3tSJvzJDvuMQhAw+tuOYFqhw4/ioeTHshzQRKuxBpwXKsd3DIC5py/NLXc1Oa9SW5iLU
         XKG1KbtVFX9IzQqV69u2tWCJNL7l3u/Hd/xl5Z+bO9kjBcGLGTYmy0TkBBu+rFxA85g+
         Kimz6WcO20GemoGS0G4jl5Z6lDmi/LJc3Th/3m6IWB0aNcqCe2j1ztOqCCFNK5XkGgln
         fnYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782840587; x=1783445387;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dZoRaVR2MVFzoC5JdGzTsIrPrpLP/ptFAeu8Dgut+Ek=;
        b=CIKMWm4gtWj/FGAIYtMsKS3NmoB+ZN+8xLYDZZimZBcMXhxRpC+D0ilNYrP58bbE7Q
         UFd47oV/mkTnM1ezZogok2bHuQVNPlpWklvOKEVgjJkaBXcPoRqP4JK4SAQK9r2WSzyR
         HEjbjFkIGc3byXPyjDlYt+JXmWdFQgaSugjve0yYgynZ1Cxq4/3kFagCNmw7S5ML/qmy
         RkgUH69La2XqWY/VngFmzQ55BKxNPm8gi2gWorc6UrHo6i7k21WcCewSz9N/QalfDXaw
         qTdt1OoYY6si1LUp062dCr68AwnzvxzOFckOCd4jKhbdxxF0BEO1fIWVt4nKoNhQcD0g
         bkNw==
X-Gm-Message-State: AOJu0YwLL3vKAFBZX1Oi23l7fkeorls25Gs3yQZh3z5hLv7JOcs1ewfb
	MDgzfUj3QAS3SZmUWjkp/6QcAQvVghYUnd3UgsmxdceuiYWajKJ2Epzf
X-Gm-Gg: AfdE7cnA4ce3BZDgaFGt8C6mFvdt3mTBvcZOWpOheOqtpvZj9jWJxaHp7RCtmYSgf2q
	uOMetyLbJX2jvPInr9j7OdrlPVALBEg0vvwC4pMKREzqD0h2A5IKxvOCz44L3NmgXaX2lZmLJyB
	HYJe5tg/iw9rAqiEIrhbQdRfpQjIxSc7CYt5SYvb7kwnL6qH9fsF4WJ3rwCBuFUmqYbpG8Q0O+z
	OmIOUIa3XkQGNhGoViYg6caL2z/Ah973DMYx45142h2vLZL94UpeMVVm0QsIvpgCH5nU0oXq7F9
	9HsboaufoHeEQaVJneCXDHiCD7a/DZtWzGIbEJy4/LXpC+7/FmiRUB8MLNeTlTEdKgzTBQzl3dD
	qlO4m1rBniQsaciTd4hN6DIwpoUJjh8j7TjFUqxh2D7eOjXl0k7da+HM7f5WLQyh4P3H3TtvoGe
	R5w4BFRg0rq34SkJv7vK+3Z3llHC/jeBIZk3Rq28TJSzxbHZmxMgEAW7Q9ZdY=
X-Received: by 2002:a05:622a:2309:b0:51a:8945:3141 with SMTP id d75a77b69052e-51c10881a88mr56740411cf.55.1782840586411;
        Tue, 30 Jun 2026 10:29:46 -0700 (PDT)
Received: from achantapc.mynetworksettings.com ([2600:4040:122a:dd00:da6a:a6e4:2464:e6a1])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f1a69c32cdsm29822906d6.31.2026.06.30.10.29.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 10:29:45 -0700 (PDT)
From: Sriman Achanta <srimanachanta@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bastien Nocera <hadess@hadess.net>,
	Simon Wood <simon@mungewell.org>,
	Christian Mayer <git@mayer-bgk.de>,
	Sriman Achanta <srimanachanta@gmail.com>
Subject: [PATCH v5 9/9] HID: steelseries: Add support for Arctis Nova 7 Gen2 family
Date: Tue, 30 Jun 2026 13:29:30 -0400
Message-ID: <8d6f139f082f2b985bad0cb3f60f260e60a7f2e9.1782840133.git.srimanachanta@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1782840133.git.srimanachanta@gmail.com>
References: <cover.1782840133.git.srimanachanta@gmail.com>
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
index 689435c60ecb..31d31f3f4b0e 100644
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
@@ -162,6 +169,30 @@ static void steelseries_arctis_9_parse_status(struct steelseries_device *sd,
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
@@ -180,6 +211,14 @@ static const struct steelseries_device_info arctis_9_info = {
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
@@ -560,6 +599,30 @@ static const struct hid_device_id steelseries_arctis_devices[] = {
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

