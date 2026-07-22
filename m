Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C23466AFA
	for <linux-input@vger.kernel.org>; Wed, 22 Jul 2026 17:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784742993; cv=none; b=Peuy9I2E7ivsTjuUZb5yp9AFYQwwaX8Ptgr2GNelSHJVILdrTuQK2+J3kjFk6s5qBL4leqOOKuMTZd31sXKRCsgeZXJF8y32uQtSsMSdgRTlJUuDf8DJUaqcSQnpJ5J7rhYHl1zsKeWYEbTnC3HRrWfgpq2usD9Zr8zBtABKeAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784742993; c=relaxed/simple;
	bh=h7pFsRMVp013elDLoFOD6NUPp2y2XXMofoysMChmQJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LFXfGsgJ0PTPaudrj4WNBg7z5g7vWO9FBZ5nQDyL3wJxKbydkTJyJF0EyVDsOcPXIk9Wcu9Cw0gSx6XWg2B8JkAd2Ot3zxzbBC9WqiphptIcVaHK575rqpWbnHaS6xAjM9d0wlbeWFOQwX6URaLxdgIlD9l3DgIhL7L/bMZggb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ENMpTzAW; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ENMpTzAW"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-84830c774a0so7336511b3a.1
        for <linux-input@vger.kernel.org>; Wed, 22 Jul 2026 10:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784742991; x=1785347791; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=j8k5kV6WSI+k1cBeImlsLuuBpzWmqeLT2rCBrhlFI80=;
        b=ENMpTzAW5yGCnJwkbX/Aca8Z7HMZHdWXA5c/YWnbGzPJip2ZPSMDjjN0OD5ff5RInd
         8lMzTcvJfAc+Zw8UfLJ/+drXxP2H4LAFa2mRbgmGG/yemJiHNSh92kN4BKxCk2kCh9cf
         AKgUp7cH9Q7yjFqioSbX1v6Md+yZlw3Bx18n2PNd4RjeZmXVPHZYzzFMZOfQXxaKrvis
         gdL+T9R7Te/4ydBGBEYQm+T6XHtBEmcvUZezZ30MN87IjGuI0HBJC9ZVZYB918T0B6ux
         cRmbIKmcS9w0luX7JeLU4c0ggIZCXXlYBY7EMZebKGekIxArci92wJczH0oaB7pkTIPC
         F+og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784742991; x=1785347791;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=j8k5kV6WSI+k1cBeImlsLuuBpzWmqeLT2rCBrhlFI80=;
        b=ez+sXMjUgeKPjw49t3RmKvYU0CINil2ee6CpCJPsaluvXaZVoZlWgSld7yjU5BgW4Z
         xKD0yNxydMXaMbG8wNeTrmPRJhjdV4a/Q1jkXsbO6kfHYeVvHjpMwUmq7TnpG61c4bIt
         sv4/5GLJJQIMRY3Irb9WIboZZheOt5hjNjfwjGHH2L+e7cgaRoF6Yp/l+EruZ4M0RYso
         vYSXR9BJlenN7ZutKvNGc6mXDVIJrqHzECRsGTGtuwXH4sRukjCjYHwb92Dp8ebEl1xf
         XjeiCu/Ddhzogtzjk5ihYLSXw4uyHyBdH+4uZujw9NmGsPRR/Kk3K0Naa1Ex4enjECtZ
         b9cw==
X-Forwarded-Encrypted: i=1; AHgh+Ro9OuWoRsk5Q3ducPEGsDXzGliq4vhYqoTPh4mmTG50YRa0UTCWIP2Y8HaxmiROX58N9lF7h1YcYmSi0Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YwobSXB+w75tGwCrkKGhYeVh2uHqk20z/qjYXGhiDRTcCYivMHo
	okdvMxEFaVqMWIn2iiVeifRcWuYKILvkHP9co0BWJJxg/HWgt4+uaaQDVgPeETEF
X-Gm-Gg: AR+sD101unhYhh0vRmi0eSsmQc5PF+d8QMpuBl2CZ+mDTuYt5do9X59tBkHPE9Ljx89
	k57PTRALwqYiI2iccqVkiVRGc9hif7TolTIHNNbGfOS0hbmsnjLTXzKVEHN3GVtks90RT9xwp2U
	wFKPkLY0QCggj/SJiq4xWU489Q5ftf2++wW/4FNyEItRfJ8MucLvIOEroL2udpf1Vb4j//WXTWW
	hQ2OVi0qYGFLQ7muncoLJxaLwcZBi/bSchSsBJHpWs+1Jx1zMIeqgjrK6gwUR6KNkvshWWQPPpO
	c8RZidrLn/K4Hi4Ws/cSJqkAYY5YM8FVNUcD/ypBNEG+t6Ouex3JLT81YY4ibnHX25YOL+/kECy
	augdjSFVWF5+ZCRZAN3m8SOk4jzVKgqg4wtHncG2oF0AdyI7VSB/AdwjGZtJeZnrSPDOr/UIfmA
	tOj2vA95a8BwEMsQ==
X-Received: by 2002:a05:6a00:bd89:b0:847:86d8:5937 with SMTP id d2e1a72fcca58-84c2945cd8emr24282305b3a.50.1784742990533;
        Wed, 22 Jul 2026 10:56:30 -0700 (PDT)
Received: from Colorful-P15 ([2408:8249:8009:7350:c32e:1b72:66d:665d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e175a3a83sm1687136b3a.43.2026.07.22.10.56.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 10:56:30 -0700 (PDT)
From: Yuxiang Lin <mclyxfdw@gmail.com>
To: jikos@kernel.org
Cc: Yuxiang Lin <mclyxfdw@gmail.com>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] HID: quirks: add ALWAYS_POLL quirk for AULA Mini 60 HE Pro Dongle
Date: Thu, 23 Jul 2026 01:56:02 +0800
Message-ID: <20260722175602.22773-1-mclyxfdw@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The AULA Mini 60 HE Pro wireless keyboard dongle (USB ID
0c45:fefe) becomes unresponsive after roughly one minute of idle.
No error appears in dmesg; the only recovery is physically
replugging the dongle.

This has been reproduced across kernels 6.8, 6.14 and 7.1.3.

Testing shows HID_QUIRK_ALWAYS_POLL alone resolves the issue,
verified via usbhid.quirks=0x0c45:0xfefe:0x400.

Signed-off-by: Yuxiang Lin <mclyxfdw@gmail.com>
---
 drivers/hid/hid-ids.h    | 1 +
 drivers/hid/hid-quirks.c | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 1059922ba..489535002 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -775,6 +775,7 @@
 #define USB_DEVICE_ID_JESS_YUREX	0x1010
 #define USB_DEVICE_ID_ASUS_MD_5112	0x5112
 #define USB_DEVICE_ID_REDRAGON_ASURA	0x760b
+#define USB_DEVICE_ID_AULA_MINI_60_HE_PRO 0xfefe
 
 #define USB_VENDOR_ID_JESS2		0x0f30
 #define USB_DEVICE_ID_JESS2_COLOR_RUMBLE_PAD 0x0111
diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
index 57d8efdd9..b0ea8171f 100644
--- a/drivers/hid/hid-quirks.c
+++ b/drivers/hid/hid-quirks.c
@@ -112,6 +112,8 @@ static const struct hid_device_id hid_quirks[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_HP, USB_PRODUCT_ID_HP_PIXART_OEM_USB_OPTICAL_MOUSE_1f4a), HID_QUIRK_ALWAYS_POLL },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_IDEACOM, USB_DEVICE_ID_IDEACOM_IDC6680), HID_QUIRK_MULTI_INPUT },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_INNOMEDIA, USB_DEVICE_ID_INNEX_GENESIS_ATARI), HID_QUIRK_MULTI_INPUT },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_JESS, USB_DEVICE_ID_AULA_MINI_60_HE_PRO),
+		HID_QUIRK_ALWAYS_POLL },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_KYE, USB_DEVICE_ID_PIXART_USB_OPTICAL_MOUSE_ID2), HID_QUIRK_ALWAYS_POLL },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_KYE, USB_DEVICE_ID_KYE_EASYPEN_M406), HID_QUIRK_MULTI_INPUT },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_KYE, USB_DEVICE_ID_KYE_EASYPEN_M506), HID_QUIRK_MULTI_INPUT },
-- 
2.55.0

