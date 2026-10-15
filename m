Received: from mail.teplosmart.kz (mail.teplosmart.kz [109.248.152.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DBC6493D29;
	Thu, 15 Oct 2026 10:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.248.152.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792060420; cv=none; b=SKHiYwtfNcTpe4xjjNrku/oQDnJyctD6FYdjooUZewLL4+uJLd4+bAkb/jy7owpyudGMWalxtubLvUEHxgJ9STFW7WV0LZK40JlNaDqo+gvrLTGMJ8oc3jMZ5pE8cyuyrfq26uqz7p6+Ahtr7RPflN2CxTU+xd1TJAwQBHpmsBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792060420; c=relaxed/simple;
	bh=x4j1MyhbT+c7+HAuHRvQK/5M5CfjgRnbi3oXyr1fFQc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DE2eUjR9kfdr0B+hjUTMFQXwu4N0cQ9v45c9IoyCR4zHmfEf++AOWDvdLjxcv3nNo9XoEIxB0remNsk0UI9Ir/DoxfrG7Fpy4tt95QBI2rSh9ns9TjtYb3dhE1tWLd3busqhxEtjDiTqhhgRido9E24piQoCd6kfPt/IVX0vP+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=teplosmart.kz; dkim=pass (2048-bit key) header.d=teplosmart.kz header.i=@teplosmart.kz header.b=15Twt2zl; arc=none smtp.client-ip=109.248.152.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=teplosmart.kz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=teplosmart.kz header.i=@teplosmart.kz header.b="15Twt2zl"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BE3576654B0;
	Thu, 15 Oct 2026 15:26:01 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=teplosmart.kz;
	s=dkim; t=1792059962; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=eigKfEJaMCURfst9+qumadUfklLLvkmWswsRO/BSs7Q=;
	b=15Twt2zl99pCuLTWLzFUpaoEfxwR1OWU2Q+UabrtDujhyh90KVsxZWay4S+zaSUs4Y1siw
	pL95CcO8TTNMMeWhy37zzVdi25MNiFGkhaI8+DMg2iosiIOHD4z7PPLdajlvHEcVP98vwV
	w6RLFlMBOCF0FagywwIcw9t7sfaqlBOfvHyz2HMZJfZwV4LlioNGUslEZAb8o/oALyEaCH
	hQdiguRszlfuLxyYaKlOMfFV/+oTY5S5niMcsvs7xH4jEIiEpq9SfG6P7sV9nDvFIR277F
	sRmGLRY87iWX8sO+cXUp4i7/K8zVnyVzpvjc0qJAFjF+jhI7yByX+hgR/UJPOQ==
From: Fedor Gubenkov <writesfaster@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	writesfaster@gmail.com
Subject: [PATCH] HID: usbhid: add HID_QUIRK_SKIP_FEATURE_REPORT_ID
Date: Thu, 15 Oct 2026 15:26:01 +0500
Message-ID: <20261015102601.1235724-1-writesfaster@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Some HID dongles implement a stateful challenge/response over HID
feature reports: a SET_REPORT(Feature) carrying the challenge,
immediately followed by a GET_REPORT(Feature) returning the response.

One such dongle (3689:8762, reporting itself as "USBKey"; used by
several automotive key-programming tools) rejects SET_REPORT(Feature)
when the report ID byte is present in the payload. For a numbered
feature report usbhid puts the report ID both into the control-transfer
wValue and as the first byte of the data, i.e. it sends 21 bytes for a
20-byte report. The device then STALLs (EPIPE) the following
GET_REPORT(Feature), which breaks the challenge/response and makes the
dongle unusable - also for Wine applications relying on it.

A raw transfer that keeps the report ID only in wValue and omits it
from the SET_REPORT(Feature) payload (20 bytes) works: the device
accepts the challenge and returns the response. Confirmed with usbmon:

  usbhid: Co .. 0302 0000 0015 21 = 02 11 ..  -> GET: C -32 (STALL)
  libusb: Co .. 0302 0000 0014 20 = 10 11 ..  -> GET: C 0   (response)

Mirror the existing HID_QUIRK_SKIP_OUTPUT_REPORT_ID handling for feature
reports via a new HID_QUIRK_SKIP_FEATURE_REPORT_ID quirk and apply it to
the 3689:8762 dongle.

Signed-off-by: Fedor Gubenkov <writesfaster@gmail.com>
---
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -408,6 +408,7 @@
 #define HID_QUIRK_X_INVERT			BIT(12)
 #define HID_QUIRK_Y_INVERT			BIT(13)
 #define HID_QUIRK_IGNORE_MOUSE			BIT(14)
+#define HID_QUIRK_SKIP_FEATURE_REPORT_ID	BIT(15)
 #define HID_QUIRK_SKIP_OUTPUT_REPORTS		BIT(16)
 #define HID_QUIRK_SKIP_OUTPUT_REPORT_ID		BIT(17)
 #define HID_QUIRK_NO_OUTPUT_REPORTS_ON_INTR_EP	BIT(18)
--- a/drivers/hid/usbhid/hid-core.c
+++ b/drivers/hid/usbhid/hid-core.c
@@ -914,8 +914,10 @@
 	int ret, skipped_report_id = 0;
 
 	/* Byte 0 is the report number. Report data starts at byte 1.*/
-	if ((rtype == HID_OUTPUT_REPORT) &&
-	    (hid->quirks & HID_QUIRK_SKIP_OUTPUT_REPORT_ID))
+	if (((rtype == HID_OUTPUT_REPORT) &&
+	     (hid->quirks & HID_QUIRK_SKIP_OUTPUT_REPORT_ID)) ||
+	    ((rtype == HID_FEATURE_REPORT) &&
+	     (hid->quirks & HID_QUIRK_SKIP_FEATURE_REPORT_ID)))
 		buf[0] = 0;
 	else
 		buf[0] = reportnum;
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -1623,6 +1623,9 @@
 #define USB_DEVICE_ID_RAPHNET_2NES2SNES	0x0002
 #define USB_DEVICE_ID_RAPHNET_4NES4SNES	0x0003
 
+#define USB_VENDOR_ID_USBKEY		0x3689
+#define USB_DEVICE_ID_USBKEY_DONGLE	0x8762
+
 #define USB_VENDOR_ID_UGTIZER			0x2179
 #define USB_DEVICE_ID_UGTIZER_TABLET_GP0610	0x0053
 #define USB_DEVICE_ID_UGTIZER_TABLET_GT5040	0x0077
--- a/drivers/hid/hid-quirks.c
+++ b/drivers/hid/hid-quirks.c
@@ -211,6 +211,7 @@
 	{ HID_USB_DEVICE(USB_VENDOR_ID_UCLOGIC, USB_DEVICE_ID_UCLOGIC_TABLET_KNA5), HID_QUIRK_MULTI_INPUT },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_UCLOGIC, USB_DEVICE_ID_UCLOGIC_TABLET_TWA60), HID_QUIRK_MULTI_INPUT },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_UGTIZER, USB_DEVICE_ID_UGTIZER_TABLET_WP5540), HID_QUIRK_MULTI_INPUT },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_USBKEY, USB_DEVICE_ID_USBKEY_DONGLE), HID_QUIRK_SKIP_FEATURE_REPORT_ID },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_VRS, USB_DEVICE_ID_VRS_R295), HID_QUIRK_ALWAYS_POLL },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_WALTOP, USB_DEVICE_ID_WALTOP_MEDIA_TABLET_10_6_INCH), HID_QUIRK_MULTI_INPUT },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_WALTOP, USB_DEVICE_ID_WALTOP_MEDIA_TABLET_14_1_INCH), HID_QUIRK_MULTI_INPUT },
