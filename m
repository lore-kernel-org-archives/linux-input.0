Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D645C1A7264;
	Sat, 15 Aug 2026 18:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786820314; cv=none; b=anJ2KquihvHaZW9+kotF0lpzS3nvbLw9d/LAJSmemg1bjxVg1nEl1R4e1sh41iQSZbZyZ5oo2ftAFB8iGvwKN4p0AwK+yd2ml6oepYosJqtSJw/37Nvi0GCiGFXSX0ZuDnmhYALfU7d0zkbIwpDuHEFqVLmJ1VW0edri8wyd9us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786820314; c=relaxed/simple;
	bh=RF5KYuEp/SMry0QhVhI/tqRy0qbKZxEuSzByxOd4jOo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=rtphG/ZAM2ZxuitlT6TEefNkU+P5391C2B4g0l+iDcOo1J8ijcvO5RmqTzZ2Ng82zs8eC6Pb6+96JmAAOH0gyKvQOGUv8QuYuuxO7JP2lCnNfXyNxxVMUg6D85SyzHLFfLIxjdgwE7YtLyAFvbwDY6dz1YllonxgW3SM4en+fO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hurranet.com; spf=pass smtp.mailfrom=hurranet.com; dkim=pass (2048-bit key) header.d=hurranet.com header.i=@hurranet.com header.b=HthIm3Pd; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hurranet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hurranet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hurranet.com header.i=@hurranet.com header.b="HthIm3Pd"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4hMpJt5sjQzMlCd;
	Sat, 15 Aug 2026 20:58:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hurranet.com;
	s=MBO0001; t=1786820302;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=NdIGS04wGRILzDP10vKdZWSUSFSC4BZOP1WJGx2sVJc=;
	b=HthIm3PdP7m/3a+owBLBA+JzSk3mY0Uv58y83AwF8kpR5sCBb3ftFM83Ag+vUz7cp7wz0u
	Agc/FYlqtFSnrHs5zyOdJIeef1KrV1gmi4eC4LMfLt29Hs6HE7Zf4Ke8ePwcMC/t8g7pAR
	H2Dg9osrn+MPzKmPRejyZSlssBkLN+rI2VKbJcOd0FvflrQGqtpVeBYD2YFRp+8YGCYHr5
	tecO/Ha/Vyei5i0sHnD2DgYnbilY/SzqW6rdgOdRdK9oSpDQvNXi8GVTg8OZ0f0jAnYNoW
	doa/maStjD1jo9eb3Yc6ph2X0uC0ym9NbNazWj9A/BFZZSaPLKufkB+g2Koy/Q==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of aiman.najjar@hurranet.com designates 2001:67c:2050:b231:465::202 as permitted sender) smtp.mailfrom=aiman.najjar@hurranet.com
From: Aiman Najjar <aiman.najjar@hurranet.com>
Date: Sat, 15 Aug 2026 14:58:01 -0400
Subject: [PATCH] HID: nintendo: add support for PDP Afterglow controller
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260815-hid-nintendo-driver-pdp-v1-1-0f5917acb89c@hurranet.com>
X-B4-Tracking: v=1; b=H4sIALi2gGoC/yXMQQqDQAxA0atI1g2YEUV6ldJFx8QaF3HIWBHEu
 zttl2/x/wFZXCXDvTrAZdOsixXQrYJhetlbULkYQh26uqcWJ2U0tVWMF2TXTRwTJyRuKfRNZBo
 jlDq5jLr/zo/n3/kTZxnW7w7O8wJzyJuiewAAAA==
X-Change-ID: 20260815-hid-nintendo-driver-pdp-1d51283bd1fb
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 "Daniel J. Ogorchock" <djogorchock@gmail.com>, 
 Hector Zelaya <hector@hectorzelaya.dev>, 
 Joshua Peisach <jpeisach@ubuntu.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Aiman Najjar <aiman.najjar@hurranet.com>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786820299; l=4116;
 i=aiman.najjar@hurranet.com; s=20260606; h=from:subject:message-id;
 bh=RF5KYuEp/SMry0QhVhI/tqRy0qbKZxEuSzByxOd4jOo=;
 b=wGYVjRLzCCZ/NUAkTG4t2KqkprG9wkVVE0jy8rQtjbUza3v3bWXW/ZylKz9liwR4wf+IVtyw1
 VgV57F/gX3KC/nLpd8Eqy65rDDt5mzZhThJicZiRW/Jjz67GxXLuLmu
X-Developer-Key: i=aiman.najjar@hurranet.com; a=ed25519;
 pk=iKg5UkqF2CmKvQwe+Jp8Cf4JOcIHoyvApdVll0sJHu8=
X-Rspamd-Queue-Id: 4hMpJt5sjQzMlCd

Add support for the PDP Afterglow (0e6f:018c), a licensed pro controller.

Commit 9146038120a6 ("HID: nintendo: add support for HORI Wireless Switch
Pad") applied X/Y button swap to all Licensed Pro controllers which caused
the North/West buttons to come up swapped for PDP Afterflow. The swapped
layout seems to be specific to HORI, so restrict the quirk to HORI devices
and use the standard mapping for all other licensed pro controllers.

Fixes: 9146038120a6 ("HID: nintendo: add support for HORI Wireless Switch Pad")
Link: https://lore.kernel.org/all/20260527-hori-support-v2-1-195c2f832112@hectorzelaya.dev/
Signed-off-by: Aiman Najjar <aiman.najjar@hurranet.com>
---
Tested on PDP Afterglow.

Tested over Bluetooth on NixOS kernel 7.1.3 and QEMU kernel 7.2.0-rc2:
 - All 14 buttons map correctly
 - Player LED sets on connect
 - Sticks report correctly with default calibration
 - IMU/gyro data streams at consistent 15ms avg delta
 - D-pad reports on ABS_HAT0X/HAT0Y

Device information:
  Bluetooth name: Lic Pro Controller
  Bluetooth HID:  0005:0E6F:018C
---
 drivers/hid/hid-ids.h      |  1 +
 drivers/hid/hid-nintendo.c | 14 ++++++++------
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 1059922baaac..f2c2183d1c8e 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -1154,6 +1154,7 @@
 #define USB_DEVICE_ID_PDP_PS4_JAGUAR	0x0173
 #define USB_DEVICE_ID_PDP_PS4_RIFFMASTER	0x024a
 #define USB_DEVICE_ID_PDP_PS5_RIFFMASTER	0x0249
+#define USB_DEVICE_ID_PDP_SWITCH_AFTERGLOW	0x018c
 
 #define USB_VENDOR_ID_PLANTRONICS	0x047f
 #define USB_DEVICE_ID_PLANTRONICS_BLACKWIRE_3210_SERIES	0xc055
diff --git a/drivers/hid/hid-nintendo.c b/drivers/hid/hid-nintendo.c
index e7302ec01ff1..edc00d01ef2b 100644
--- a/drivers/hid/hid-nintendo.c
+++ b/drivers/hid/hid-nintendo.c
@@ -434,8 +434,8 @@ static const struct joycon_ctlr_button_mapping procon_button_mappings[] = {
 	{ /* sentinel */ },
 };
 
-/* Licensed Pro Controllers (e.g. HORI) swap X/Y bits in the report */
-static const struct joycon_ctlr_button_mapping lic_procon_button_mappings[] = {
+/* HORI Licensed Pro Controllers swap X/Y bits in the report */
+static const struct joycon_ctlr_button_mapping lic_hori_procon_button_mappings[] = {
 	{ BTN_EAST,	JC_BTN_A,	},
 	{ BTN_SOUTH,	JC_BTN_B,	},
 	{ BTN_NORTH,	JC_BTN_Y,	},
@@ -1731,8 +1731,8 @@ static void joycon_parse_report(struct joycon_ctlr *ctlr,
 		joycon_report_left_stick(ctlr, rep);
 		joycon_report_right_stick(ctlr, rep);
 		joycon_report_dpad(ctlr, rep);
-		if (ctlr->ctlr_type == JOYCON_CTLR_TYPE_LIC_PRO)
-			joycon_report_buttons(ctlr, rep, lic_procon_button_mappings);
+		if (ctlr->hdev->vendor == USB_VENDOR_ID_HORI)
+			joycon_report_buttons(ctlr, rep, lic_hori_procon_button_mappings);
 		else
 			joycon_report_buttons(ctlr, rep, procon_button_mappings);
 	} else if (joycon_type_is_any_nescon(ctlr)) {
@@ -2180,8 +2180,8 @@ static int joycon_input_create(struct joycon_ctlr *ctlr)
 		joycon_config_left_stick(ctlr->input);
 		joycon_config_right_stick(ctlr->input);
 		joycon_config_dpad(ctlr->input);
-		if (ctlr->ctlr_type == JOYCON_CTLR_TYPE_LIC_PRO)
-			joycon_config_buttons(ctlr->input, lic_procon_button_mappings);
+		if (ctlr->hdev->vendor == USB_VENDOR_ID_HORI)
+			joycon_config_buttons(ctlr->input, lic_hori_procon_button_mappings);
 		else
 			joycon_config_buttons(ctlr->input, procon_button_mappings);
 	} else if (joycon_type_is_any_nescon(ctlr)) {
@@ -2863,6 +2863,8 @@ static const struct hid_device_id nintendo_hid_devices[] = {
 			 USB_DEVICE_ID_NINTENDO_N64CON) },
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_HORI,
 			 USB_DEVICE_ID_HORI_WIRELESS_SWITCH_PAD) },
+	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_PDP,
+			 USB_DEVICE_ID_PDP_SWITCH_AFTERGLOW) },
 	{ }
 };
 MODULE_DEVICE_TABLE(hid, nintendo_hid_devices);

---
base-commit: f63ddb2a5deb1cf2175a4aaccf55dbe728486280
change-id: 20260815-hid-nintendo-driver-pdp-1d51283bd1fb

Best regards,
--  
Aiman Najjar <aiman.najjar@hurranet.com>

