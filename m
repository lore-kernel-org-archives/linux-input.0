Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397DF22D7A1;
	Tue,  7 Apr 2026 19:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775591668; cv=none; b=ZQcEadrQO9QTlG0ZcsPxoxUSuFL7etYCQrU4nrHru6Xau5O0YfR23H8y/3nDd0nI3rkNXIF9IjN3aDoeForMkqt9/I3Fj/VnaaL4RC+3H5U2Bh01pNvzFJABCDoo0X1ea0MDkE2u63DSgiClf+CriCIpyVhHTYjJrtQr6fjh98s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775591668; c=relaxed/simple;
	bh=2/kKpFUnaqzjcbovXq+VQVXNhYOQzJkqUNcqzdQGrUg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G3l06fi5cbFBqtZ6dX10ShjbxwVaWiUvWbuT1NftcJ9tifkQYfMBoTuHixEbxd84wQlqNd+9iUHgZNkg8jrvdBy5tY8Q7gAB+d5QQA27J/n1DTnzKjw+vUrBXrsLdIpBVR1zcNBSzfDRymZvBPB1xcvxyzQyQpYTYa7uX2RgTys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=BAO351g8; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=re2DW877; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="BAO351g8";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="re2DW877"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4fqxjP0NFlz9vD7;
	Tue,  7 Apr 2026 21:54:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1775591657;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=x86pVHQR/svNC0yaZHLdvmGrMwT9asrVKDYoDYKjc6o=;
	b=BAO351g88AbYX1pEiR2FveP+Y3N6Cf2SDn/mfp3VlDfaQMuFz0MBvsHDIoT8PQQkr63met
	rRXZUXUmvqB7TXb48IIcx2N2JSWpfGtSO6bMlIjf/leBPMcaKNv2HFI8EMxARfu+te7KYX
	3GmzndUOZSRtGaOLZWIxQisMH4GDeI1JYEXb5mFD1Co+0gwNnz7i+NnjRg7lwguS6VDuWy
	5mNCm7kIC/w/g2XMBP2n5YDAXO09h4tDp1boeiCwSzSkQ3gJ0ZeJxjmo8VjAOmEONFJMK+
	rP3M+aspV+20MkBnXHlxGA9uBcWFiOKPVFo/rVd5eatFDVEmFJv7pd+Jt2dlew==
From: Rosalie Wanders <rosalie@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1775591655;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=x86pVHQR/svNC0yaZHLdvmGrMwT9asrVKDYoDYKjc6o=;
	b=re2DW877fQEOjjDoP9KvsQ0uVNPw89fcb20E+EvnFbuBvGU00cYdorGdJe80SCUOwzT/Ue
	veHTSslGsoeQ592KX1M7FzPb9Vg3lY0b2l8X3IG3UnAKSMn1o1n2GlTN+mjnzLpFJi/Mvq
	XJ5TyOU0ZygcM1n8sY2uIh/esLWYU6SQi3hGrKBzAu36EPT7H86ODUVGXHDzjyIAI6FN1Q
	2UlnXoWFIBvBXqq9Ig5qj2RZwxygQr8O6PUpH0DeXur/biueg+/StjZ74DCkZ95pmVjPpx
	nZtGC8rJvUklVeDwNetfP0y0yafPKa3DSj9y+hL3TtYK34thB6TaoxjTXe3jFg==
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: Rosalie Wanders <rosalie@mailbox.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] HID: quirks: update hid-sony supported devices
Date: Tue,  7 Apr 2026 21:53:28 +0200
Message-ID: <20260407195327.10698-3-rosalie@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: irazssqmyqe5w54fcgti6ega5g7cukkt
X-MBO-RS-ID: dda892efeedc98b95fe

hid-sony has been updated with new device support, update the
hid_have_special_driver list accordingly.

Signed-off-by: Rosalie Wanders <rosalie@mailbox.org>
---
changes:
v2: rebase on v2 of 'HID: sony: add support for more instruments'

 drivers/hid/hid-quirks.c | 46 ++++++++++++++++++++++++++++++++++------
 1 file changed, 39 insertions(+), 7 deletions(-)

diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
index edc4339adb50..7c411e59fa6b 100644
--- a/drivers/hid/hid-quirks.c
+++ b/drivers/hid/hid-quirks.c
@@ -690,22 +690,54 @@ static const struct hid_device_id hid_have_special_driver[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_WISEGROUP_LTD, USB_DEVICE_ID_SUPER_JOY_BOX_5_PRO) },
 #endif
 #if IS_ENABLED(CONFIG_HID_SONY)
+	{ HID_USB_DEVICE(USB_VENDOR_ID_CRKD, USB_DEVICE_ID_CRKD_PS4_GIBSON_SG) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_CRKD, USB_DEVICE_ID_CRKD_PS4_GIBSON_SG_DONGLE) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_CRKD, USB_DEVICE_ID_CRKD_PS5_GIBSON_SG) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_CRKD, USB_DEVICE_ID_CRKD_PS5_GIBSON_SG_DONGLE) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_HARMONIX, USB_DEVICE_ID_HARMONIX_WII_RB1_DRUMS) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_HARMONIX, USB_DEVICE_ID_HARMONIX_WII_RB1_GUITAR) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_HARMONIX, USB_DEVICE_ID_HARMONIX_WII_RB2_DRUMS) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_HARMONIX, USB_DEVICE_ID_HARMONIX_WII_RB2_GUITAR) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_HARMONIX, USB_DEVICE_ID_HARMONIX_WII_RB3_KEYBOARD) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_HARMONIX, USB_DEVICE_ID_HARMONIX_WII_RB3_MPA_DRUMS_MODE) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_HARMONIX, USB_DEVICE_ID_HARMONIX_WII_RB3_MPA_KEYBOARD_MODE) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_HARMONIX, USB_DEVICE_ID_HARMONIX_WII_RB3_MPA_MUSTANG_MODE) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_HARMONIX, USB_DEVICE_ID_HARMONIX_WII_RB3_MPA_SQUIER_MODE) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_HARMONIX, USB_DEVICE_ID_HARMONIX_WII_RB3_MUSTANG_GUITAR) },
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_HARMONY_PS3) },
-	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SMK, USB_DEVICE_ID_SMK_PS3_BDREMOTE) },
+	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_MADCATZ, USB_DEVICE_ID_MADCATZ_PS4_STRATOCASTER) },
+	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_PDP, USB_DEVICE_ID_PDP_PS4_JAGUAR) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_PDP, USB_DEVICE_ID_PDP_PS4_RIFFMASTER) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_PDP, USB_DEVICE_ID_PDP_PS5_RIFFMASTER) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_REDOCTANE, USB_DEVICE_ID_REDOCTANE_GUITAR_DONGLE) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_REDOCTANE, USB_DEVICE_ID_REDOCTANE_PS4_GHLIVE_DONGLE) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_SINO_LITE, USB_DEVICE_ID_SINO_LITE_CONTROLLER) },
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SMK, USB_DEVICE_ID_SMK_NSG_MR5U_REMOTE) },
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SMK, USB_DEVICE_ID_SMK_NSG_MR7U_REMOTE) },
+	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SMK, USB_DEVICE_ID_SMK_PS3_BDREMOTE) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_BUZZ_CONTROLLER) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_WIRELESS_BUZZ_CONTROLLER) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_MOTION_CONTROLLER) },
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_MOTION_CONTROLLER) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_NAVIGATION_CONTROLLER) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_MOTION_CONTROLLER) },
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_NAVIGATION_CONTROLLER) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_NAVIGATION_CONTROLLER) },
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS3_BDREMOTE) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS3_CONTROLLER) },
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS3_CONTROLLER) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_VAIO_VGX_MOUSE) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS3_CONTROLLER) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_VAIO_VGP_MOUSE) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_SINO_LITE, USB_DEVICE_ID_SINO_LITE_CONTROLLER) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_VAIO_VGX_MOUSE) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_WIRELESS_BUZZ_CONTROLLER) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY_RHYTHM, USB_DEVICE_ID_SONY_PS3WIIU_GHLIVE) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY_RHYTHM, USB_DEVICE_ID_SONY_PS3_DJH_TURNTABLE) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY_RHYTHM, USB_DEVICE_ID_SONY_PS3_GH_DRUMS) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY_RHYTHM, USB_DEVICE_ID_SONY_PS3_GH_GUITAR) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY_RHYTHM, USB_DEVICE_ID_SONY_PS3_RB3_KEYBOARD) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY_RHYTHM, USB_DEVICE_ID_SONY_PS3_RB3_MPA_DRUMS_MODE) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY_RHYTHM, USB_DEVICE_ID_SONY_PS3_RB3_MPA_KEYBOARD_MODE) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY_RHYTHM, USB_DEVICE_ID_SONY_PS3_RB3_MPA_MUSTANG_MODE) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY_RHYTHM, USB_DEVICE_ID_SONY_PS3_RB3_MPA_SQUIER_MODE) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY_RHYTHM, USB_DEVICE_ID_SONY_PS3_RB3_MUSTANG_GUITAR) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY_RHYTHM, USB_DEVICE_ID_SONY_PS3_RB_DRUMS) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY_RHYTHM, USB_DEVICE_ID_SONY_PS3_RB_GUITAR) },
 #endif
 #if IS_ENABLED(CONFIG_HID_SPEEDLINK)
 	{ HID_USB_DEVICE(USB_VENDOR_ID_X_TENSIONS, USB_DEVICE_ID_SPEEDLINK_VAD_CEZANNE) },
-- 
2.53.0

