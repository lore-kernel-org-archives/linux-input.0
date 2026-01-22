Received: from relay15.grserver.gr (relay15.grserver.gr [46.62.234.254])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E2B327BFA;
	Thu, 22 Jan 2026 07:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.62.234.254
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769068277; cv=none; b=LFTlw/zxehvVm3I08rlcGClelfV0QirWLnaBhHT+w/g/8ASIrZNux4h+MHIV9qfEhjaZlbbMivDIHV8G09/zyTl0H3/Od79ojg4fRWuNYjXuDIKb4YUZwiqB3aMtiC2gie5E3R0RfjX0lXEYLQWhKA+5e8KYEzVBVGYzRnG80DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769068277; c=relaxed/simple;
	bh=xvCg7zOYdy9FyIIo4uzv80svRawVDeDbsraVxgub+w0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EdZQ9XSMB5NBv+s5ZYNAb0xiLX1LhM9qLc+oXXCAHmVKf2aUg0H+ZrjQbadi9D5qhEsJP5BAxzIyTzBswbu0D0yzT1Nh8EKImR9cjOJ5tsyRbH1OF07oxgprgvdVCcLPKMMWKLEOSWwMb+fytkgSdqbQeXdua3p2kJkE9rxE8zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=ZmSp6aDf; arc=none smtp.client-ip=46.62.234.254
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="ZmSp6aDf"
Received: from relay15 (localhost [127.0.0.1])
	by relay15.grserver.gr (Proxmox) with ESMTP id 6E37C407BD;
	Thu, 22 Jan 2026 07:50:56 +0000 (UTC)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay15.grserver.gr (Proxmox) with ESMTPS id DA3E340932;
	Thu, 22 Jan 2026 07:50:55 +0000 (UTC)
Received: from antheas-z13 (unknown [IPv6:2a05:f6c3:fefd:0:42c:a43d:2848:c282])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id 479461FF471;
	Thu, 22 Jan 2026 09:50:52 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1769068255;
	bh=D08pQAfWzA5LBVvxbPafmANS5uUpsxec2CIzT0lSssM=; h=From:To:Subject;
	b=ZmSp6aDf4XU7L9ekz6P/cB5t6UKwrfpzeaw0ArZSUKKHbsCzD4vK0KAa759o1IQbH
	 cJYpp2djnjVXMmA7zyKeSU/FXvwk5iZsIVjdGFEEvF48/FAaLIORQDgiBo195wXsNB
	 yUbWBZ5ZbHlFbUDmm34Q4bvZe6H5zV3+Q1WvfHLWvCDeikuNEbC9+5RcYlTGdZk6Rd
	 R1fSgn4IS3rulqTN07P8yugYIiZp9onghXxKCxxR7eBWBpKJyoNBXvfO8+45Tx7QLf
	 EsY2yN3Al6zCSg6Nu5V2vCyBvvXiSOFextJ1Y9T4+sm87jDtpwCWIRAZXF1toYFvVa
	 kfvPjYCSTfaIw==
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
Subject: [PATCH v12 01/11] HID: asus: simplify RGB init sequence
Date: Thu, 22 Jan 2026 08:50:34 +0100
Message-ID: <20260122075044.5070-2-lkml@antheas.dev>
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
 <176906825499.711593.17081695700773488229@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

Currently, RGB initialization forks depending on whether a device is
NKEY. However, in reality both initialization forks are the same, other
than the NKEY initialization initializing the LED_REPORT_ID1,
LED_REPORT_ID2 endpoints, and the non-NKEY initialization having a
functionality check which is skipped for the NKEY path.

Therefore, merge the if blocks, gate the ID1/ID2 initializations
behind the NKEY quirk instead, and introduce the functionality check
for NKEY devices (it is supported by them).

There should be no functional change with this patch.

Acked-by: Benjamin Tissoires <bentiss@kernel.org>
Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
---
 drivers/hid/hid-asus.c | 52 ++++++++++++++++++------------------------
 1 file changed, 22 insertions(+), 30 deletions(-)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index 472bca54642b..323e6302bac5 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -639,13 +639,20 @@ static int asus_kbd_register_leds(struct hid_device *hdev)
 	unsigned char kbd_func;
 	int ret;
 
-	if (drvdata->quirks & QUIRK_ROG_NKEY_KEYBOARD) {
-		/* Initialize keyboard */
-		ret = asus_kbd_init(hdev, FEATURE_KBD_REPORT_ID);
-		if (ret < 0)
-			return ret;
+	ret = asus_kbd_init(hdev, FEATURE_KBD_REPORT_ID);
+	if (ret < 0)
+		return ret;
 
-		/* The LED endpoint is initialised in two HID */
+	/* Get keyboard functions */
+	ret = asus_kbd_get_functions(hdev, &kbd_func, FEATURE_KBD_REPORT_ID);
+	if (ret < 0)
+		return ret;
+
+	/* Check for backlight support */
+	if (!(kbd_func & SUPPORT_KBD_BACKLIGHT))
+		return -ENODEV;
+
+	if (drvdata->quirks & QUIRK_ROG_NKEY_KEYBOARD) {
 		ret = asus_kbd_init(hdev, FEATURE_KBD_LED_REPORT_ID1);
 		if (ret < 0)
 			return ret;
@@ -653,34 +660,19 @@ static int asus_kbd_register_leds(struct hid_device *hdev)
 		ret = asus_kbd_init(hdev, FEATURE_KBD_LED_REPORT_ID2);
 		if (ret < 0)
 			return ret;
+	}
 
-		if (dmi_match(DMI_PRODUCT_FAMILY, "ProArt P16")) {
-			ret = asus_kbd_disable_oobe(hdev);
-			if (ret < 0)
-				return ret;
-		}
-
-		if (drvdata->quirks & QUIRK_ROG_ALLY_XPAD) {
-			intf = to_usb_interface(hdev->dev.parent);
-			udev = interface_to_usbdev(intf);
-			validate_mcu_fw_version(hdev,
-				le16_to_cpu(udev->descriptor.idProduct));
-		}
-
-	} else {
-		/* Initialize keyboard */
-		ret = asus_kbd_init(hdev, FEATURE_KBD_REPORT_ID);
-		if (ret < 0)
-			return ret;
-
-		/* Get keyboard functions */
-		ret = asus_kbd_get_functions(hdev, &kbd_func, FEATURE_KBD_REPORT_ID);
+	if (dmi_match(DMI_PRODUCT_FAMILY, "ProArt P16")) {
+		ret = asus_kbd_disable_oobe(hdev);
 		if (ret < 0)
 			return ret;
+	}
 
-		/* Check for backlight support */
-		if (!(kbd_func & SUPPORT_KBD_BACKLIGHT))
-			return -ENODEV;
+	if (drvdata->quirks & QUIRK_ROG_ALLY_XPAD) {
+		intf = to_usb_interface(hdev->dev.parent);
+		udev = interface_to_usbdev(intf);
+		validate_mcu_fw_version(hdev,
+			le16_to_cpu(udev->descriptor.idProduct));
 	}
 
 	drvdata->kbd_backlight = devm_kzalloc(&hdev->dev,
-- 
2.52.0


