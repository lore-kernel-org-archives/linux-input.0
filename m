Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6DE238166;
	Thu, 29 Jan 2026 07:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769670770; cv=none; b=p3sF8XTA/G7c+gb7X46K1Hw+id8iSbfSX5ouubYTzBQ9KRZzZx8s/x391vxheystumuC2dcb4yR+YiMhtuoMkq8zRrLCCrP9XNN3tiA6jTLTrGpIUJn70WCfg3XijeF+CEP6aWxtIkVU/5Vk1jaBJxQqglThcT6Gqi88lfUdo2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769670770; c=relaxed/simple;
	bh=+5nhlvLDqJjtm9IF7h/4PBBEYMhyqBjrWqPcXCTrBXg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eVpd2qjDRIP2zMz2YadP2yyVDyA/qOPq6UZnr6vNQ7musgOK2KtpPmDxdod1dl0BXoB2sXN46LctQvhy2Lilbxi7mOSzwhxDejkhSD79sqUi6MdZ7CNzCgGSefxfnnqHFsUgh3lh3HpgJ/cI/cnCkCv5gOlpZt/Fkt++CHC+Q0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=mJJHKzpT; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=Fbwx0/b/; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="mJJHKzpT";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Fbwx0/b/"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4f1r2070SQz9t6b;
	Thu, 29 Jan 2026 08:12:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1769670761;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Q89xRfljC98J/m4lxKrE93iVtWGJzlUjOxCst2I3CPs=;
	b=mJJHKzpT1SD/HtnVhluNZS4V3QM30VjQB7TEoaKiapnNoc/C8g6RUR2Jjf4goPCyeIfHat
	PMLUvPN4XscE8O+9nD2i7Oz48tfbVPNg/RgUisQMDAwecOSYTz983ViyuZ03hMOo/1Tbji
	Njx/may7LfHPXeVKlPIABXUokGVqHT0r99Z3mbgHjhAlKjb/qcOX2YHf5JAJqH2zy9uRLB
	04+kvkchSYcSnWHxxO6jx1Jr+hbloZo7Wa3RESJex10fxcgm2vPuvX1wc47wT8wiTCziSV
	9WT5U9pHsTJlWhOFj1wlOQpRhCjv0waPEyFhkla5pzxIHJTu1zGDdSfwei/6fA==
Authentication-Results: outgoing_mbo_mout;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b="Fbwx0/b/";
	spf=pass (outgoing_mbo_mout: domain of rosalie@mailbox.org designates 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=rosalie@mailbox.org
From: Rosalie Wanders <rosalie@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1769670759;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Q89xRfljC98J/m4lxKrE93iVtWGJzlUjOxCst2I3CPs=;
	b=Fbwx0/b/IF24qJoZpZvbi3RL71ifNRbIuShQuGnv7jOShetn8P8YBi/smHff0mX/R76w4r
	7S935A/sioWFPa2SbjwjMcP5p9ONEBsoiWJMPBicsIpcLFqCOBZUvVZkFThblXVMUUwHUa
	yDii8DVd6HmMIfdL+QZF6ghfiAeFl4eOocy6nx+81W3PW2kgS6OsdPw0tddqyTiNvsUFx+
	5Jg51cqIW53rUKO45yPKmvxoZCXqwLDFQFucwiYyXqaIqbg1UAWoPqOWJxiv/QaZiP3tvb
	AU4dPW4nQJ5phMahjKiOHAfRxt+o0TCQFKu7z28dB3TJef/708V7JJtUXy5N/A==
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: Rosalie Wanders <rosalie@mailbox.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] HID: sony: add second device IDs to CRKD Gibson SG
Date: Thu, 29 Jan 2026 08:12:25 +0100
Message-ID: <20260129071227.5533-1-rosalie@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 8c136cf2d5b272755c4
X-MBO-RS-META: cburpbfwh69n7ktijfx9hrqjtquteykw
X-Rspamd-Queue-Id: 4f1r2070SQz9t6b

CRKD changed the product IDs in a firmware revision, yet the dongle
doesn't have these ID changes included yet but will have them included
in a future firmware revision.

CRKD also doesn't allow the firmware to be updated on Linux so having
both the old and new product IDs is necessary.

Signed-off-by: Rosalie Wanders <rosalie@mailbox.org>
---
 drivers/hid/hid-ids.h  | 6 ++++--
 drivers/hid/hid-sony.c | 8 ++++++--
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 43f86061cab2..cdf69ce86d99 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -364,8 +364,10 @@
 #define USB_DEVICE_ID_CREATIVE_SB0540	0x3100
 
 #define USB_VENDOR_ID_CRKD	0x3651
-#define USB_DEVICE_ID_CRKD_PS4_GIBSON_SG	0x1500
-#define USB_DEVICE_ID_CRKD_PS5_GIBSON_SG	0x1600
+#define USB_DEVICE_ID_CRKD_PS4_GIBSON_SG_1	0x5500
+#define USB_DEVICE_ID_CRKD_PS4_GIBSON_SG_2	0x1500
+#define USB_DEVICE_ID_CRKD_PS5_GIBSON_SG_1	0x5600
+#define USB_DEVICE_ID_CRKD_PS5_GIBSON_SG_2	0x1600
 
 #define USB_VENDOR_ID_CVTOUCH		0x1ff7
 #define USB_DEVICE_ID_CVTOUCH_SCREEN	0x0013
diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index d0270ffec4f4..ad73de5cb627 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -2381,7 +2381,9 @@ static const struct hid_device_id sony_devices[] = {
 	/* Rock Band 4 PS4 guitars */
 	{ HID_USB_DEVICE(USB_VENDOR_ID_PDP, USB_DEVICE_ID_PDP_PS4_RIFFMASTER),
 		.driver_data = RB4_GUITAR_PS4_USB },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_CRKD, USB_DEVICE_ID_CRKD_PS4_GIBSON_SG),
+	{ HID_USB_DEVICE(USB_VENDOR_ID_CRKD, USB_DEVICE_ID_CRKD_PS4_GIBSON_SG_1),
+		.driver_data = RB4_GUITAR_PS4_USB },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_CRKD, USB_DEVICE_ID_CRKD_PS4_GIBSON_SG_2),
 		.driver_data = RB4_GUITAR_PS4_USB },
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_PDP, USB_DEVICE_ID_PDP_PS4_JAGUAR),
 		.driver_data = RB4_GUITAR_PS4_BT },
@@ -2390,7 +2392,9 @@ static const struct hid_device_id sony_devices[] = {
 	/* Rock Band 4 PS5 guitars */
 	{ HID_USB_DEVICE(USB_VENDOR_ID_PDP, USB_DEVICE_ID_PDP_PS5_RIFFMASTER),
 		.driver_data = RB4_GUITAR_PS5 },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_CRKD, USB_DEVICE_ID_CRKD_PS5_GIBSON_SG),
+	{ HID_USB_DEVICE(USB_VENDOR_ID_CRKD, USB_DEVICE_ID_CRKD_PS5_GIBSON_SG_1),
+		.driver_data = RB4_GUITAR_PS5 },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_CRKD, USB_DEVICE_ID_CRKD_PS5_GIBSON_SG_2),
 		.driver_data = RB4_GUITAR_PS5 },
 	{ }
 };
-- 
2.52.0

