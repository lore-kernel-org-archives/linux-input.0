Received: from relay15.grserver.gr (relay15.grserver.gr [46.62.234.254])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6AE43D411B;
	Thu, 22 Jan 2026 07:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.62.234.254
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769068274; cv=none; b=MJqW2XPwrX9fXfvR06bRI98xzH2Zt4Plp7NHqpTN1S6QK7qT37i2QKahlBuvM/KruzDL07ySNce6/yo4xB4SZXJxHdEKHguOAeNKufrdNWevFwbhZKuO+7DgzgGRPL8IUkDKRQiihEUfk72LQqm+9yLiScOXWFJRvWF4KBoyvR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769068274; c=relaxed/simple;
	bh=uFjTi0Kvj4LYyfb4c/kAh3J58DpO2Z2E6cn4t8r2/VI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nxrT9rIpGpCI7yKmiVjx1f/OjxVkxnzju/D0bvt4sjusZvzkiM86p1v9VqHThN0aOpa5+H6WOAYBC6xpAqDq7kA2qruOSrAWGTo8upLX4p9vv2L9fRpYS/QrrREz7cfl0nB+stcH+qHj4UChetL841i7mQRIQzU+G3jVK9XNvAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=Yl49phjZ; arc=none smtp.client-ip=46.62.234.254
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="Yl49phjZ"
Received: from relay15 (localhost [127.0.0.1])
	by relay15.grserver.gr (Proxmox) with ESMTP id B396D40A56;
	Thu, 22 Jan 2026 07:51:01 +0000 (UTC)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay15.grserver.gr (Proxmox) with ESMTPS id 2ACC940980;
	Thu, 22 Jan 2026 07:51:01 +0000 (UTC)
Received: from antheas-z13 (unknown [IPv6:2a05:f6c3:fefd:0:42c:a43d:2848:c282])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id 002B01FDB07;
	Thu, 22 Jan 2026 09:50:55 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1769068260;
	bh=MEs/XBWAPfv9b2W5N7TYQ+94TqqTSyRIKMCnFaXB1d0=; h=From:To:Subject;
	b=Yl49phjZcaC8npIkrRDpoGAVm63L9QnKfQMygF1NY0fWC4QqaBgGOB+uYn9HbynoB
	 qBSM0SBwPJvFmXXCntU01ikbRBnTIA6yUaqANIkrEPvEh2Um29X6mWAi+wfghdM9xG
	 +QVyARh/WlgOw/qDB/5wHoCe3Cl1eJd/ixfsOxAetKj6TNHuIMvRt0vKfGSI3wN0K6
	 8Hgs68V/xNWWjdeFCOCzpIFgOHysluQ2gs9PPlvd6JQZwJrgbezFRWBZtg/YG+sgqP
	 305scY5Z6Xe8Ez2/nNvm5ZqdpsSwHoQGmIuEFVV7yfM4GiBN7ubIbueJLgh9T10Jrq
	 2oqBG51YNbNxg==
Authentication-Results: linux3247.grserver.gr;
	spf=pass (sender IP is 2a05:f6c3:fefd:0:42c:a43d:2848:c282) smtp.mailfrom=lkml@antheas.dev smtp.helo=antheas-z13
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
From: Antheas Kapenekakis <lkml@antheas.dev>
To: platform-driver-x86@vger.kernel.org,
	linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Corentin Chary <corentin.chary@gmail.com>,
	"Luke D . Jones" <luke@ljones.dev>,
	Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Denis Benato <denis.benato@linux.dev>,
	Antheas Kapenekakis <lkml@antheas.dev>
Subject: [PATCH v12 02/11] HID: asus: initialize additional endpoints only for
 certain devices
Date: Thu, 22 Jan 2026 08:50:35 +0100
Message-ID: <20260122075044.5070-3-lkml@antheas.dev>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260122075044.5070-1-lkml@antheas.dev>
References: <20260122075044.5070-1-lkml@antheas.dev>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: 
 <176906826040.712012.3894645244315568667@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

Currently, ID1/ID2 initializations are performed for all NKEY devices.
However, ID1 initializations are only required for RGB control and are
only supported for RGB capable devices. ID2 initializations are only
required for initializing the Anime display endpoint which is only
supported on devices with an Anime display. Both of these
initializations are for functionality that is not present on this driver
and are performed for devices which might not support them.

At the same time, there are older NKEY devices that have only been
tested with these initializations in the kernel and it is not possible
to recheck them. There is a possibility that especially with the ID1
initialization, certain laptop models might have their shortcuts stop
working (currently unproven).

To avoid sending unnecessary commands, change to only initialize ID1/ID2
for those NKEY devices suspected to be problematic without them by
introducing a quirk for them and replacing the NKEY quirk in the block
that performs the inits with that. Therefore, new devices that do not
need (and some do not support) these initializations will not have
them performed.

In addition, as these initializations might not be supported by the
affected devices, change the function to not bail if they fail.

Acked-by: Benjamin Tissoires <bentiss@kernel.org>
Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
---
 drivers/hid/hid-asus.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index 323e6302bac5..92904b5a700c 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -90,6 +90,7 @@ MODULE_DESCRIPTION("Asus HID Keyboard and TouchPad");
 #define QUIRK_ROG_NKEY_KEYBOARD		BIT(11)
 #define QUIRK_ROG_CLAYMORE_II_KEYBOARD BIT(12)
 #define QUIRK_ROG_ALLY_XPAD		BIT(13)
+#define QUIRK_ROG_NKEY_ID1ID2_INIT		BIT(14)
 
 #define I2C_KEYBOARD_QUIRKS			(QUIRK_FIX_NOTEBOOK_REPORT | \
 						 QUIRK_NO_INIT_REPORTS | \
@@ -652,14 +653,9 @@ static int asus_kbd_register_leds(struct hid_device *hdev)
 	if (!(kbd_func & SUPPORT_KBD_BACKLIGHT))
 		return -ENODEV;
 
-	if (drvdata->quirks & QUIRK_ROG_NKEY_KEYBOARD) {
-		ret = asus_kbd_init(hdev, FEATURE_KBD_LED_REPORT_ID1);
-		if (ret < 0)
-			return ret;
-
-		ret = asus_kbd_init(hdev, FEATURE_KBD_LED_REPORT_ID2);
-		if (ret < 0)
-			return ret;
+	if (drvdata->quirks & QUIRK_ROG_NKEY_ID1ID2_INIT) {
+		asus_kbd_init(hdev, FEATURE_KBD_LED_REPORT_ID1);
+		asus_kbd_init(hdev, FEATURE_KBD_LED_REPORT_ID2);
 	}
 
 	if (dmi_match(DMI_PRODUCT_FAMILY, "ProArt P16")) {
@@ -1376,10 +1372,10 @@ static const struct hid_device_id asus_devices[] = {
 	  QUIRK_USE_KBD_BACKLIGHT },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK,
 	    USB_DEVICE_ID_ASUSTEK_ROG_NKEY_KEYBOARD),
-	  QUIRK_USE_KBD_BACKLIGHT | QUIRK_ROG_NKEY_KEYBOARD },
+	  QUIRK_USE_KBD_BACKLIGHT | QUIRK_ROG_NKEY_KEYBOARD | QUIRK_ROG_NKEY_ID1ID2_INIT },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK,
 	    USB_DEVICE_ID_ASUSTEK_ROG_NKEY_KEYBOARD2),
-	  QUIRK_USE_KBD_BACKLIGHT | QUIRK_ROG_NKEY_KEYBOARD },
+	  QUIRK_USE_KBD_BACKLIGHT | QUIRK_ROG_NKEY_KEYBOARD | QUIRK_ROG_NKEY_ID1ID2_INIT },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK,
 	    USB_DEVICE_ID_ASUSTEK_ROG_Z13_LIGHTBAR),
 	  QUIRK_USE_KBD_BACKLIGHT | QUIRK_ROG_NKEY_KEYBOARD },
-- 
2.52.0


