Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2046B3AC0C9
	for <linux-input@vger.kernel.org>; Mon,  7 Sep 2026 18:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788806989; cv=none; b=FRw4JLqOnYHYBR7hw0QSgPsxxQSfqAA6Xc5FUk4yzlhtgurtDaw5x1FtdIjgrVy1+FJrEExYWaocMNVKoP1mQlAvqvKUWkseYk26wUI4xZo8iBEL2YVEXYVWgfK61vaxslSKcUqYUF5uGcNRdH7Fo+G/4JEs6WyHFclWQv/e0m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788806989; c=relaxed/simple;
	bh=ZodpAMAOO7mx9Mr85gC+RHAPNg28jdl9sB2SgtEr+m0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mRAmYN09sk8Ed8F2rbkJSuy3Ida2mCUD3YFZFZRNXXh4sBP0vD7HRddXWjyw5e68d7Zu8ssaPqadKeze2zNMPWJ5J2Kc1SjaZ9PqvZz240PgD/ZVPkKTSy74aslpuwleaww81v4mObgHNowZuZ1UTEkI2l+wqM/WUVSnrjbgMN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NZMUlvEU; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NZMUlvEU"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2ce98cb8165so37053265ad.1
        for <linux-input@vger.kernel.org>; Mon, 07 Sep 2026 11:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788806978; x=1789411778; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ft7Aoft2D1ri5AKkzjC8MkTf0nQ/c5VUMxblaqJZWQA=;
        b=NZMUlvEUTScp1kG8G4glfGADwfmmLxbh563OEo+mJI4f0/7+08U/JTolaACBnB9lL6
         8SLcYEu8R1OCSvQIXvieuYCZzqf0Xh4gg/3LJO1q2QzBOy0McHJyqXDF84+d3YdP7C9N
         hMs6cxM9CmDx/toLlH139tolaAbdhVPS2JEg4fQgSObwO90Q1agAK97+iTaEr6OfQrWC
         NejSQ6T7rMyOuDyVpSnP5Y3oRBEiIRdadSAsn2KmPTxCavviZKlZo5xNzBjYNjzsGsOL
         gxDMxfwwMr0lLsSSGaPthzAIQePyqm3RLdtpb5leGG7HunouK61fokpYOfXXwnP69vTR
         CFhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788806978; x=1789411778;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ft7Aoft2D1ri5AKkzjC8MkTf0nQ/c5VUMxblaqJZWQA=;
        b=qaHox4ECgFbjrW0AkjiiTkEfQZYt3Sf0oxyTBQQMC+8usDQV0ztKW4EPMCMDkiCPIi
         8Pmx5hPlOaQ4dVdWlbjTW2l20uN6piPmHg3NgKTh01B6jyWLY5y+MwyuiU/Krx/cqKLX
         bKh5XSKWyuwRdeCL4KeoC/Od+80S1biGaExpQ4nu/PsEV6CrA8xRig8dS/f8iPb6pOky
         EIdlmpHyw2pn5orN0QMK1PtiTCA6tQDN1iUmuwB+hF3DH5UT/WiK2BmIq6Iz+m+yoxRm
         HdO1pL9CE53wpC8pQYakaTgjUMSZcRiswUN83Jm9yqUuk3uTCnFGn8/ywJbEg0U2FQGj
         ZO+w==
X-Gm-Message-State: AFuF++mf9D4SgzjQCrqc7S1qs4XS7dKCWmBI5wPVi1Lh38N8H++IsTHe
	bUhmuSTJcmz1pmfHtDgA5NDUzxydG6mnHx6FQvNnMe+W0ag+7g4xUJFU
X-Gm-Gg: AYBFou2DlOrAbYWVKhB2Z0ymRsb8RYjLR5EPchQupHOPrCnOm7pvVtf1lqVULCLsao9
	ywqOy+v1FYtRd8xB7OHP2g8JxecDj9KOJwhBTvb/X77ki3vnp6eAqOt0Xj2e+1mg/BvYQmvkZHS
	FG90pgqSYqLjFZLr4hKLjw34ZwFOHwfsF9gAoo3ojiyozpr8s+sKgF0IAjxAsecknRUUh1Oc6EV
	hn74X8kRnWr1bxyOiFp2hcND2iixA+7YXCC0W2HjLv+Hw+TUvLee/s+6zIs10LjpqlnE1Jy/Krx
	G5x/rs3KaKuzE+sekA+h04W8OBPvn++0RPOLTuJOMZiQz7M6j4It8jhT0b4Xj5Vj4Nln4HSvuUT
	/8lc0J2/6vpaSr3r1cME2iRniKyAVjnGQKv3GBweoS5I0mTIyXxyk9YiDukIXjATze9+F8fsydN
	E5V/tXPzsDwA/eVCufPe62znquSrD3uiBFLDH3u/YC3k/iZuTSRvv7AayuZbD+0PtEzEk2pZFCO
	ROHMvhRxLHKl713XDlyklVPhO+0E14eR60VPRk=
X-Received: by 2002:a17:902:f707:b0:2cf:6e5d:23e9 with SMTP id d9443c01a7336-2dafb0b191cmr286883345ad.14.1788806978362;
        Mon, 07 Sep 2026 11:49:38 -0700 (PDT)
Received: from localhost.localdomain (S0106bc4dfb582cc3.vn.shawcable.net. [50.68.124.218])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2db149c3b80sm48545385ad.63.2026.09.07.11.49.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 11:49:37 -0700 (PDT)
From: Berke Durak <berke.durak@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Berke Durak <berke.durak@gmail.com>
Subject: [PATCH] HID: elecom: Add support for ELECOM M-XT4DRBK (018E)
Date: Mon,  7 Sep 2026 11:47:19 -0700
Message-ID: <20260907184719.25042-1-berke.durak@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The 2025 revision of the left-handed EX-G wireless trackball
(M-XT4DRBK-G) reports USB ID 056e:018e instead of 056e:00fd. Its report
descriptor declares an 8-bit button field (Report Count 8) but only five
usages (Usage Maximum 5), so the sixth (Fn) button ends up as a
duplicate of button 5 and is unusable.

The report descriptor has the same layout as the M-XT3DRBK 018C
(button usage maximum at offset 16, button report count at 22, button
report size at 24, padding report size at 30), so reuse that fixup.

Rename the existing M_XT4DRBK define to M_XT4DRBK_00FD to match the
convention used for the other EX-G revisions.

Tested on a Raspberry Pi 5 with the same fixup in an         
out-of-tree module on 6.12 (6.12.96+rpt-rpi-2712);
all six buttons are reported after the fix, and they
work (tested with xev as well).

Report descriptor as sent by the device, pre-fix (056e:018e,
215 bytes):

 05 01 09 02 A1 01 09 01 A1 00 85 01 05 09 19 01
 29 05 15 00 25 01 95 08 75 01 81 02 95 01 75 00
 81 01 05 01 09 30 09 31 16 00 80 26 FF 7F 75 10
 95 02 81 06 C0 A1 00 05 01 09 38 15 81 25 7F 75
 08 95 01 81 06 C0 A1 00 05 0C 0A 38 02 95 01 75
 08 15 81 25 7F 81 06 C0 C0 06 01 FF 09 00 A1 01
 85 02 09 00 15 00 26 FF 00 75 08 95 07 81 02 C0
 05 0C 09 01 A1 01 85 05 15 00 26 3C 02 19 00 2A
 3C 02 75 10 95 01 81 00 C0 05 01 09 80 A1 01 85
 03 19 81 29 83 15 00 25 01 95 03 75 01 81 02 95
 01 75 05 81 01 C0 06 BC FF 09 88 A1 01 85 04 95
 01 75 08 15 00 26 FF 00 19 00 2A FF 00 81 00 C0
 06 02 FF 09 02 A1 01 85 06 09 02 15 00 26 FF 00
 75 08 95 07 B1 02 C0

Assisted-by: LLM
Signed-off-by: Berke Durak <berke.durak@gmail.com>
---
diff -urN a/drivers/hid/hid-elecom.c b/drivers/hid/hid-elecom.c
--- a/drivers/hid/hid-elecom.c
+++ b/drivers/hid/hid-elecom.c
@@ -79,7 +79,7 @@
 	case USB_DEVICE_ID_ELECOM_M_XT3URBK_00FB:
 	case USB_DEVICE_ID_ELECOM_M_XT3URBK_018F:
 	case USB_DEVICE_ID_ELECOM_M_XT3DRBK_00FC:
-	case USB_DEVICE_ID_ELECOM_M_XT4DRBK:
+	case USB_DEVICE_ID_ELECOM_M_XT4DRBK_00FD:
 		/*
 		 * Report descriptor format:
 		 * 12: button bit count
@@ -104,6 +104,7 @@
 		mouse_button_fixup(hdev, rdesc, *rsize, 12, 30, 14, 20, 8);
 		break;
 	case USB_DEVICE_ID_ELECOM_M_XT3DRBK_018C:
+	case USB_DEVICE_ID_ELECOM_M_XT4DRBK_018E:
 		/*
 		 * Report descriptor format:
 		 * 22: button bit count
@@ -148,7 +149,8 @@
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_M_XT3URBK_018F) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_M_XT3DRBK_00FC) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_M_XT3DRBK_018C) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_M_XT4DRBK) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_M_XT4DRBK_00FD) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_M_XT4DRBK_018E) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_M_DT1URBK) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_M_DT1DRBK) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_M_DT2DRBK) },
diff -urN a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -477,7 +477,8 @@
 #define USB_DEVICE_ID_ELECOM_M_XT3URBK_018F	0x018f
 #define USB_DEVICE_ID_ELECOM_M_XT3DRBK_00FC	0x00fc
 #define USB_DEVICE_ID_ELECOM_M_XT3DRBK_018C	0x018c
-#define USB_DEVICE_ID_ELECOM_M_XT4DRBK	0x00fd
+#define USB_DEVICE_ID_ELECOM_M_XT4DRBK_00FD	0x00fd
+#define USB_DEVICE_ID_ELECOM_M_XT4DRBK_018E	0x018e
 #define USB_DEVICE_ID_ELECOM_M_DT1URBK	0x00fe
 #define USB_DEVICE_ID_ELECOM_M_DT1DRBK	0x00ff
 #define USB_DEVICE_ID_ELECOM_M_DT2DRBK	0x018d
diff -urN a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
--- a/drivers/hid/hid-quirks.c
+++ b/drivers/hid/hid-quirks.c
@@ -431,7 +431,8 @@
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_M_XT3URBK_018F) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_M_XT3DRBK_00FC) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_M_XT3DRBK_018C) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_M_XT4DRBK) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_M_XT4DRBK_00FD) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_M_XT4DRBK_018E) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_M_DT1URBK) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_M_DT1DRBK) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_M_DT2DRBK) },
