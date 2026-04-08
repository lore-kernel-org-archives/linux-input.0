Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C98329E6F;
	Wed,  8 Apr 2026 21:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775685161; cv=none; b=bwe6+FI9rb+sOcoGklyV9PdPaggvLwV2ONJMTsiahZmNQxQ2q6avkldAr00rzzuBKnlQws+mhShyBdqH8fSURzGkQCixgeAodLMkvaYkDe506R2VuFQLzAS64q8yUSJfT9pWd3k5/5WMd8imgD1zhWaxwP1CF9COubIsj2aH7/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775685161; c=relaxed/simple;
	bh=hZVKPYCQ0G8FrdI52+JlWMKGaCMufsVXNLOdf+iTt5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HDhpTXovlDBMr3x5f+r6Y3cvYINl8hcokhhPYUU0GZZmEGEvl+/qQ7lQvh2147miu5ieFvihDp/wojI5fVLMPQ4fSSDikuG5LpOXSU6kQHzoKsbYdBzO6hOzXu6m2uu1NM5KjJBta2qrNCyhl26H90IqijyKFTuunkNfrMz8gOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=IJZujYV+; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=j891vhat; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="IJZujYV+";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="j891vhat"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4frcHL1V2dz9thx;
	Wed,  8 Apr 2026 23:52:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1775685150;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=sReEuzpHyYzQzMLuwO02/q8vMUPRUuXr8rp7MWrYOeo=;
	b=IJZujYV+pOkZwLvjQ0zWDV+KIQmk72iZUl/aArwLCFDAMzre0/sXPssrEalMj61LklxzZE
	J/X9mvtSjf8x9GPe9TB1g3MlrrlM828gP6epgktOWLOnNj5PV40h8rjK6EGkfQj+GtZczT
	EWOc9v71ENzIaSF/X8REBnCUc/m3knZ+HQiP8HAftQwitadDLFj+s3JW3hJIZiqkvX/BwJ
	52fBIBf3xbmtfsC8dwaaM2T9Ug95F5vfRdRp1jCF41zEojj+Zc/c37/KXczGmYmHy1NobJ
	2VnpTJFh96i403TrGs05FjDioUtK6Uqewf+2FDBtYxx1ULtgXJptwbUydghE/Q==
From: Rosalie Wanders <rosalie@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1775685148;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=sReEuzpHyYzQzMLuwO02/q8vMUPRUuXr8rp7MWrYOeo=;
	b=j891vhatbr0OFnPbt9YzuSnC5adGeiUVyvi76sFQIkChVTaASFcYY3e0pj9QDESiggvImW
	g9GxTpyPif+ZaH05PK86RgninEbx3OMMqbmKT/HFLrHGdysZxTEmaU+MeZTHCdeOrTxBzu
	l/BplIVlvrFn9CjDH9t6acrITpiTfqbr/Ct86LiZs0WoIbvFFN7AsG79kmd8vrLRto+Fwk
	HViBket3sMX+lJQswq0dN+uA4prx0zrcltE4joNLwZMNfqYKL5oRdFtV1USX5EkePJXou4
	4IikKYwtgCHS2qQFuqSQsD1hEmVp4a5mFwnuTDu19HvI/9ibRGEw105TAwkAYA==
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: Rosalie Wanders <rosalie@mailbox.org>,
	Sanjay Govind <sanjay.govind9@gmail.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] HID: sony: fix incorrect Squier name and remove non-existent device
Date: Wed,  8 Apr 2026 23:51:55 +0200
Message-ID: <20260408215155.7262-2-rosalie@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 3yy34dip8mauggrckt9n7s5r4bp5nwwx
X-MBO-RS-ID: 9be32d2497f51c0372c

This patch fixes the Squier device name and removes a non-existent
device from hid-sony.

Co-developed-by: Sanjay Govind <sanjay.govind9@gmail.com>
Signed-off-by: Sanjay Govind <sanjay.govind9@gmail.com>
Signed-off-by: Rosalie Wanders <rosalie@mailbox.org>
---
 drivers/hid/hid-ids.h  | 6 ++----
 drivers/hid/hid-sony.c | 8 ++------
 2 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 0d78904ee802..f3946932dd95 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -671,9 +671,8 @@
 #define USB_DEVICE_ID_HARMONIX_WII_RB2_DRUMS	    0x3110
 #define USB_DEVICE_ID_HARMONIX_WII_RB3_MPA_DRUMS_MODE	0x3138
 #define USB_DEVICE_ID_HARMONIX_WII_RB3_MUSTANG_GUITAR	0x3430
-#define USB_DEVICE_ID_HARMONIX_WII_RB3_SQUIRE_GUITAR	0x3530
 #define USB_DEVICE_ID_HARMONIX_WII_RB3_MPA_MUSTANG_MODE	0x3438
-#define USB_DEVICE_ID_HARMONIX_WII_RB3_MPA_SQUIRE_MODE	0x3538
+#define USB_DEVICE_ID_HARMONIX_WII_RB3_MPA_SQUIER_MODE	0x3538
 #define USB_DEVICE_ID_HARMONIX_WII_RB3_KEYBOARD	        0x3330
 #define USB_DEVICE_ID_HARMONIX_WII_RB3_MPA_KEYBOARD_MODE	0x3338
 
@@ -1331,9 +1330,8 @@
 #define USB_DEVICE_ID_SONY_PS3_RB_DRUMS		0x0210
 #define USB_DEVICE_ID_SONY_PS3_RB3_MPA_DRUMS_MODE	0x0218
 #define USB_DEVICE_ID_SONY_PS3_RB3_MUSTANG_GUITAR	0x2430
-#define USB_DEVICE_ID_SONY_PS3_RB3_SQUIRE_GUITAR	0x2530
 #define USB_DEVICE_ID_SONY_PS3_RB3_MPA_MUSTANG_MODE	0x2438
-#define USB_DEVICE_ID_SONY_PS3_RB3_MPA_SQUIRE_MODE	0x2538
+#define USB_DEVICE_ID_SONY_PS3_RB3_MPA_SQUIER_MODE	0x2538
 #define USB_DEVICE_ID_SONY_PS3_RB3_KEYBOARD	        0x2330
 #define USB_DEVICE_ID_SONY_PS3_RB3_MPA_KEYBOARD_MODE	0x2338
 
diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index f72201b30ac6..74a160ec4d08 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -2571,11 +2571,9 @@ static const struct hid_device_id sony_devices[] = {
 		.driver_data = INSTRUMENT },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_HARMONIX, USB_DEVICE_ID_HARMONIX_WII_RB3_MUSTANG_GUITAR),
 		.driver_data = INSTRUMENT },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_HARMONIX, USB_DEVICE_ID_HARMONIX_WII_RB3_SQUIRE_GUITAR),
-		.driver_data = INSTRUMENT },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_HARMONIX, USB_DEVICE_ID_HARMONIX_WII_RB3_MPA_MUSTANG_MODE),
 		.driver_data = INSTRUMENT },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_HARMONIX, USB_DEVICE_ID_HARMONIX_WII_RB3_MPA_SQUIRE_MODE),
+	{ HID_USB_DEVICE(USB_VENDOR_ID_HARMONIX, USB_DEVICE_ID_HARMONIX_WII_RB3_MPA_SQUIER_MODE),
 		.driver_data = INSTRUMENT },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_HARMONIX, USB_DEVICE_ID_HARMONIX_WII_RB3_KEYBOARD),
 		.driver_data = INSTRUMENT },
@@ -2591,11 +2589,9 @@ static const struct hid_device_id sony_devices[] = {
 	/* Rock Band 3 PS3 Pro instruments */
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY_RHYTHM, USB_DEVICE_ID_SONY_PS3_RB3_MUSTANG_GUITAR),
 		.driver_data = INSTRUMENT | RB3_PS3_PRO_INSTRUMENT },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY_RHYTHM, USB_DEVICE_ID_SONY_PS3_RB3_SQUIRE_GUITAR),
-		.driver_data = INSTRUMENT | RB3_PS3_PRO_INSTRUMENT },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY_RHYTHM, USB_DEVICE_ID_SONY_PS3_RB3_MPA_MUSTANG_MODE),
 		.driver_data = INSTRUMENT | RB3_PS3_PRO_INSTRUMENT },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY_RHYTHM, USB_DEVICE_ID_SONY_PS3_RB3_MPA_SQUIRE_MODE),
+	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY_RHYTHM, USB_DEVICE_ID_SONY_PS3_RB3_MPA_SQUIER_MODE),
 		.driver_data = INSTRUMENT | RB3_PS3_PRO_INSTRUMENT },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY_RHYTHM, USB_DEVICE_ID_SONY_PS3_RB3_KEYBOARD),
 		.driver_data = INSTRUMENT | RB3_PS3_PRO_INSTRUMENT },
-- 
2.53.0

