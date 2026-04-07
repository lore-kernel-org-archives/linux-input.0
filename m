Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46B422DFA4;
	Tue,  7 Apr 2026 14:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775573025; cv=none; b=rpiKgW7r7i8RtqctoKgOnDqj7OUnZ2VCBrEaQQE8GWGH+a9b59pDl8bnnldpCNzso5UU06c+CSV78g8rxzIx+DdXKBux4+ZqTAa5qgOI7f2hgoQP0Ky7PpN18lkEFq7au+j52jH3F42568hPLlYBe/LhdQxTbA3Fy4JIY0empPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775573025; c=relaxed/simple;
	bh=ZWQZkB5fL2jhom5Ev8sclKjxQBPOPMo69UQQ+wJrLgM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VFJvojIibL/5BKBc9cm9IWtA8OhRD00FVtlBD9bredOU9MTy1icC9nu00XyUf79AywrWV79GNW2Nl4osezMmSEqVtEUGaHKwMl0VQUFi7GEZIUN2DcbF5kST61rXlC5LV2f3xTvgGbywp2m0vw59KZCIr0CKzuBAi4Z2vFmeE20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=CuwdhuJQ; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=relcAJo0; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="CuwdhuJQ";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="relcAJo0"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4fqppw1jmjz9v0X;
	Tue,  7 Apr 2026 16:43:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1775573016;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1XWzvWAUkGN++QKroI/b4jcpPSjnYK6PwADhbIi07oI=;
	b=CuwdhuJQgSIG1Lijl1ar3MiXj/e9LLJz8zY2y6toqrJ8BUcvw7gd6hKiobT8a8j5nNOsqK
	Va2PABeuGIAVjUcafsqS+XspwdJVu+1nXYp2ZUNto5tDPWE8SsrtWAtDYv9e9MJAlCytX3
	bW7iKkDSBeWl9lsurKBhC16YeQVgZGH7hfiTlypZ8c1MG1Jws9+F2uT11au+rhuP+wYrDZ
	QtnLW5NGY8KzFeO9Fh9YZJkmb5UeCuyLXHDoM5b+i/PpDcm5ili4q30qogthA6NMUs1R+s
	zPh+fyZIJACSX/gV49FvDZ+oXPBaeCTIz9h+u3q60MNUFsbvnqDFMKI7TPJLqg==
From: Rosalie Wanders <rosalie@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1775573014;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1XWzvWAUkGN++QKroI/b4jcpPSjnYK6PwADhbIi07oI=;
	b=relcAJo0uaVqR4mL/BtaNGDVSzPk3Rq/WiEm9s7YkelfyKl7ea/6MWUsTnsR9Bk42iX98f
	zCezMDXhSE7/Aust2kuClY9aNPuJcoFBm2huAKdruSNgDkmnQQnXf4ifxSljqntwJDjUOD
	XJ0oPLyEhBMzhEYgJeqP8y2+Hxa/lNsIypkh0FkY4BH4OTlzmRSlYeM+h/u0HtCiAshdd1
	+iuC/YromP9GtTLmCcajqW0nuknubJSDUjBeCHZpdal/yIJ3AeooL7Ex0Z3D9wPmL/hFHc
	hH+pC4zqsJTlN93TEjxPuRjtu4eBUNqY7D/ayCXdVmLgxywoMtrZLAjWHROgLw==
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: Rosalie Wanders <rosalie@mailbox.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] HID: quirks: update hid-sony supported devices
Date: Tue,  7 Apr 2026 16:42:47 +0200
Message-ID: <20260407144247.368567-2-rosalie@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 2ab0f46691e981e6764
X-MBO-RS-META: 1fb4eysyy7xfyihc8ugiu6sfboce8mzg

hid-sony has been updated with new device support, update the
hid_have_special_driver table accordingly.

Signed-off-by: Rosalie Wanders <rosalie@mailbox.org>
---
 drivers/hid/hid-quirks.c | 48 ++++++++++++++++++++++++++++++++++------
 1 file changed, 41 insertions(+), 7 deletions(-)

diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
index edc4339adb50..17639d340efc 100644
--- a/drivers/hid/hid-quirks.c
+++ b/drivers/hid/hid-quirks.c
@@ -690,22 +690,56 @@ static const struct hid_device_id hid_have_special_driver[] = {
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
+	{ HID_USB_DEVICE(USB_VENDOR_ID_HARMONIX, USB_DEVICE_ID_HARMONIX_WII_RB3_MPA_SQUIRE_MODE) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_HARMONIX, USB_DEVICE_ID_HARMONIX_WII_RB3_MUSTANG_GUITAR) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_HARMONIX, USB_DEVICE_ID_HARMONIX_WII_RB3_SQUIRE_GUITAR) },
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
+	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY_RHYTHM, USB_DEVICE_ID_SONY_PS3_RB3_MPA_SQUIRE_MODE) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY_RHYTHM, USB_DEVICE_ID_SONY_PS3_RB3_MUSTANG_GUITAR) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY_RHYTHM, USB_DEVICE_ID_SONY_PS3_RB3_SQUIRE_GUITAR) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY_RHYTHM, USB_DEVICE_ID_SONY_PS3_RB_DRUMS) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY_RHYTHM, USB_DEVICE_ID_SONY_PS3_RB_GUITAR) },
 #endif
 #if IS_ENABLED(CONFIG_HID_SPEEDLINK)
 	{ HID_USB_DEVICE(USB_VENDOR_ID_X_TENSIONS, USB_DEVICE_ID_SPEEDLINK_VAD_CEZANNE) },
-- 
2.53.0

