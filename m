Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E3813624BC
	for <linux-input@vger.kernel.org>; Fri, 22 May 2026 05:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779426432; cv=none; b=WUcjrDzt+NAYdELHWVx26FN6yGkBSWjTF9gYPTgiKvt0tq/AAwNoRmy0s9/eBe3EGTAlGC53mhwaFhG89JcyErWN7HCr879y9uXAYdJp7DlIrSoMTdD2V5AipHSL9TBvaklFEZeNGEOQjkmgS6Rzc3PvbhdiP8PgoO5H9GYh2nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779426432; c=relaxed/simple;
	bh=KR0AYqG8pNoH+B43HxuRCbPqD7l3WxiqDcnRoVF6Zso=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l9aDrWSm+wX6YBqi+NJo8cEQu9BQOx1sR3Y+0QMYLJL3RRiFhojbBeejlcRBDL9oWnEotVVEb4FDrLz+ctmFZLElG6wSYSeJ/qlMP/W+/C5CcrKc90W/n+NgTOLocKY6wQPp/MU8QaLgjsQV48C8qUa259TfFh8LtaLJudZD1rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-365cae89bf5so2951213a91.3
        for <linux-input@vger.kernel.org>; Thu, 21 May 2026 22:07:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779426430; x=1780031230;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2qi4QNZE3QSAMbRWNcXu7liHx2Lp06TrOvtrVJJqyZw=;
        b=RGZRQGRcbpf467EIXuJaz/0usy939oa5Yw0Zy1KbLO+lPz7oRTbHonqMc0YqlAwurz
         otD0xbKRuCPiDfyaI9BoLytApFxQufku00ozhgQCZfZAaMKySpQvlgZ2H175rC7g21B2
         XbNDLweE03+NmstLBPgOcl1YkyHdH3VEKdRod3Pmqv8IPyEd6pm3nhzFzJV9v2lRMjRf
         RLD73mfiYoOxlR24vninGEypY2VT8XVeC1mTU6sOwwJmc5WMibSz4x3IYfKkie+A0H2z
         umfA4rdH+j3fsiu3tPX/FMbb61vMy5dCFcJsz40mobLMWRDhVOeGPWjRaHZyPY+BkezE
         HLDw==
X-Forwarded-Encrypted: i=1; AFNElJ8/XYvFxHh1rpMZTPmXjbQKbGqwOikHIdf6gNp9Yb2ttpop60695O6JvQvFIhwv9e3Y+9R3pCwlz/X+ug==@vger.kernel.org
X-Gm-Message-State: AOJu0YyK0o/Rsf0L+6fkQ1F5XGeNlDFJZxB/FuefdC92dpH+fLYqjK5/
	6j8ggIoTynQEzt0L+aX2JE3vZNzlD5dOmoR/7l0xmBr1b8SEd05sMGML
X-Gm-Gg: Acq92OHBtKGDODS1HkAFtgVrKfa3GN8FXKflWuTGryM+nWLWnCF7861tsbOOH10i3+y
	tU0aQgLq8Y50zEjz+Sd7p62b61vBWwdXG8+Cvot3qJThZ5/dWqhxfiE8L4m6xcCMDQ7QFWOxUPQ
	lU+TA3Sdk7jVhVtMpZcGpayryynpL5zqXx8Etgtxj8wKS5oh/4IkbCYCJEuOzh+NiERJy+I88O7
	8U/2Q5Ur+ZLfXucg+Tj86XHPicV02tTQfBGDwl+5kmkhqk7dmeCmYMMMcJU5sorjizk3+p/p8GT
	i3lpnNCZ6j76rBhD11X2Vr3ofjnN2s1m8ZJeZQkU8OG3ADHgVuJgmJDCEtorVnxUf00EtAjkbEr
	TIzdNbzffgPhd46UvFOCfAk/XA6A5yWzOINw5szb2SKW1tiO95SGNHgLu+Iz4qIBdv09j0nAUBV
	xpZsYzufCxJzGscZNeILOJTH74EHWkJhjCqwe9YhoUVsB8wfaSlMLaBDJl
X-Received: by 2002:a05:6a21:15cf:b0:3aa:f9cb:d43c with SMTP id adf61e73a8af0-3b328e7457cmr1971084637.34.1779426429588;
        Thu, 21 May 2026 22:07:09 -0700 (PDT)
Received: from fedora.lenovo.com (zz20234032476F6CA7C5.userreverse.dion.ne.jp. [111.108.167.197])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85205855dasm367615a12.31.2026.05.21.22.07.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 22:07:08 -0700 (PDT)
From: Vishnu Sankar vishnuocv@gmail.com
To: jikos@kernel.org,
	bentiss@kernel.org,
	derekjohn.clark@gmail.com,
	mpearson-lenovo@squebb.ca
Cc: vsankar@lenovo.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vishnu Sankar <vishnuocv@gmail.com>
Subject: [PATCH 1/2] HID: lenovo: Add support for ThinkPad X13 Folio keyboard
Date: Fri, 22 May 2026 14:06:31 +0900
Message-ID: <20260522050632.8079-1-vishnuocv@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vishnu Sankar <vishnuocv@gmail.com>

Add USB ID support for the ThinkPad X13 detachable keyboard.
The Keyboard uses the same HID raw event protocol as the ThinkPad
X12 Gen 2. The functionality stays the same with X12 Gen 2 Keyboards.

Also declare KEY_PERFORMANCE capability in lenovo_input_configured()
for X13 detachable, allowing userspace to discover the key via evdev
capability bits.

Signed-off-by: Vishnu Sankar <vishnuocv@gmail.com>
---
 drivers/hid/hid-ids.h    |  1 +
 drivers/hid/hid-lenovo.c | 21 +++++++++++++++++----
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 4657d96fb083..064be2333a00 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -874,6 +874,7 @@
 #define USB_DEVICE_ID_LENOVO_X1_TAB3	0x60b5
 #define USB_DEVICE_ID_LENOVO_X12_TAB	0x60fe
 #define USB_DEVICE_ID_LENOVO_X12_TAB2	0x61ae
+#define USB_DEVICE_ID_LENOVO_X13_TAB	0x62af
 #define USB_DEVICE_ID_LENOVO_YOGABOOK9I	0x6161
 #define USB_DEVICE_ID_LENOVO_OPTICAL_USB_MOUSE_600E	0x600e
 #define USB_DEVICE_ID_LENOVO_PIXART_USB_MOUSE_608D	0x608d
diff --git a/drivers/hid/hid-lenovo.c b/drivers/hid/hid-lenovo.c
index a6b73e03c16b..35b00619f045 100644
--- a/drivers/hid/hid-lenovo.c
+++ b/drivers/hid/hid-lenovo.c
@@ -504,6 +504,7 @@ static int lenovo_input_mapping(struct hid_device *hdev,
 							       usage, bit, max);
 	case USB_DEVICE_ID_LENOVO_X12_TAB:
 	case USB_DEVICE_ID_LENOVO_X12_TAB2:
+	case USB_DEVICE_ID_LENOVO_X13_TAB:
 	case USB_DEVICE_ID_LENOVO_X1_TAB:
 	case USB_DEVICE_ID_LENOVO_X1_TAB2:
 	case USB_DEVICE_ID_LENOVO_X1_TAB3:
@@ -620,6 +621,7 @@ static ssize_t attr_fn_lock_store(struct device *dev,
 		break;
 	case USB_DEVICE_ID_LENOVO_X12_TAB:
 	case USB_DEVICE_ID_LENOVO_X12_TAB2:
+	case USB_DEVICE_ID_LENOVO_X13_TAB:
 	case USB_DEVICE_ID_LENOVO_TP10UBKBD:
 	case USB_DEVICE_ID_LENOVO_X1_TAB:
 	case USB_DEVICE_ID_LENOVO_X1_TAB2:
@@ -791,9 +793,10 @@ static int lenovo_raw_event(struct hid_device *hdev,
 	 * Lenovo TP X12 Tab KBD's Fn+XX is HID raw data defined. Report ID is 0x03
 	 * e.g.: Raw data received for MIC mute is 0x00020003.
 	 */
-	if (unlikely((hdev->product == USB_DEVICE_ID_LENOVO_X12_TAB
-			|| hdev->product == USB_DEVICE_ID_LENOVO_X12_TAB2)
-			&& size >= 3 && report->id == 0x03))
+	if (unlikely((hdev->product == USB_DEVICE_ID_LENOVO_X12_TAB ||
+		      hdev->product == USB_DEVICE_ID_LENOVO_X12_TAB2 ||
+		      hdev->product == USB_DEVICE_ID_LENOVO_X13_TAB) &&
+		      size >= 3 && report->id == 0x03))
 		return lenovo_raw_event_TP_X12_tab(hdev, le32_to_cpu(*(__le32 *)data));
 
 	return 0;
@@ -877,6 +880,7 @@ static int lenovo_event(struct hid_device *hdev, struct hid_field *field,
 		return lenovo_event_cptkbd(hdev, field, usage, value);
 	case USB_DEVICE_ID_LENOVO_X12_TAB:
 	case USB_DEVICE_ID_LENOVO_X12_TAB2:
+	case USB_DEVICE_ID_LENOVO_X13_TAB:
 	case USB_DEVICE_ID_LENOVO_TP10UBKBD:
 	case USB_DEVICE_ID_LENOVO_X1_TAB:
 	case USB_DEVICE_ID_LENOVO_X1_TAB2:
@@ -1161,6 +1165,7 @@ static int lenovo_led_brightness_set(struct led_classdev *led_cdev,
 		break;
 	case USB_DEVICE_ID_LENOVO_X12_TAB:
 	case USB_DEVICE_ID_LENOVO_X12_TAB2:
+	case USB_DEVICE_ID_LENOVO_X13_TAB:
 	case USB_DEVICE_ID_LENOVO_TP10UBKBD:
 	case USB_DEVICE_ID_LENOVO_X1_TAB:
 	case USB_DEVICE_ID_LENOVO_X1_TAB2:
@@ -1355,7 +1360,8 @@ static int lenovo_probe_tp10ubkbd(struct hid_device *hdev)
 	 */
 
 	data->fn_lock = !(hdev->product == USB_DEVICE_ID_LENOVO_X12_TAB ||
-			hdev->product == USB_DEVICE_ID_LENOVO_X12_TAB2);
+			hdev->product == USB_DEVICE_ID_LENOVO_X12_TAB2 ||
+			hdev->product == USB_DEVICE_ID_LENOVO_X13_TAB);
 
 	lenovo_led_set_tp10ubkbd(hdev, TP10UBKBD_FN_LOCK_LED, data->fn_lock);
 
@@ -1402,6 +1408,7 @@ static int lenovo_probe(struct hid_device *hdev,
 		break;
 	case USB_DEVICE_ID_LENOVO_X12_TAB:
 	case USB_DEVICE_ID_LENOVO_X12_TAB2:
+	case USB_DEVICE_ID_LENOVO_X13_TAB:
 	case USB_DEVICE_ID_LENOVO_TP10UBKBD:
 	case USB_DEVICE_ID_LENOVO_X1_TAB:
 	case USB_DEVICE_ID_LENOVO_X1_TAB2:
@@ -1490,6 +1497,7 @@ static void lenovo_remove(struct hid_device *hdev)
 		break;
 	case USB_DEVICE_ID_LENOVO_X12_TAB:
 	case USB_DEVICE_ID_LENOVO_X12_TAB2:
+	case USB_DEVICE_ID_LENOVO_X13_TAB:
 	case USB_DEVICE_ID_LENOVO_TP10UBKBD:
 	case USB_DEVICE_ID_LENOVO_X1_TAB:
 	case USB_DEVICE_ID_LENOVO_X1_TAB2:
@@ -1517,6 +1525,9 @@ static int lenovo_input_configured(struct hid_device *hdev,
 						hi->input->propbit);
 			}
 			break;
+		case USB_DEVICE_ID_LENOVO_X13_TAB:
+			input_set_capability(hi->input, EV_KEY, KEY_PERFORMANCE);
+			break;
 	}
 
 	return 0;
@@ -1551,6 +1562,8 @@ static const struct hid_device_id lenovo_devices[] = {
 		     USB_VENDOR_ID_LENOVO, USB_DEVICE_ID_LENOVO_X12_TAB) },
 	{ HID_DEVICE(BUS_USB, HID_GROUP_GENERIC,
 		     USB_VENDOR_ID_LENOVO, USB_DEVICE_ID_LENOVO_X12_TAB2) },
+	{ HID_DEVICE(BUS_USB, HID_GROUP_GENERIC,
+		     USB_VENDOR_ID_LENOVO, USB_DEVICE_ID_LENOVO_X13_TAB) },
 	{ HID_DEVICE(BUS_I2C, HID_GROUP_GENERIC,
 		     USB_VENDOR_ID_ITE, I2C_DEVICE_ID_ITE_LENOVO_YOGA_SLIM_7X_KEYBOARD) },
 	{ }
-- 
2.54.0

