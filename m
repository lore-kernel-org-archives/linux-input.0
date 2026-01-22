Received: from relay14.grserver.gr (relay14.grserver.gr [157.180.73.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49251F1304;
	Thu, 22 Jan 2026 07:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.180.73.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769068291; cv=none; b=U3guzjXzz2UY8+W9DWYNyhSo7b84UAtmwl75f35HViz2/4D3QFYapzVlT6g/zz6NlYNp+6Znn14GFb44XRaimWwrjLMyELKudM2TvMUf5dUgB++4k7NN3KEuglt2mUS8qs+ysWNdNUWto5zGwv/aG/+be+ZkZGpYLHxQiAZnEHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769068291; c=relaxed/simple;
	bh=qC/J0+4+tdmZ37XLBWyV/NfGCb0il0AY9ubrh5qmRhs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uOB5W+QzlySZOa5jK6I0ACBwKg8lwSamwDCb6eL0LPuE1TFo1XLf0Jq8BnX/FIOYjee3IFVALdhS57tfl7I3tusrKVhmF8jtOuiAHcNIxNj/TIQmuBuSRgA7t41u8BK1BhabvF+qcjiTtPrlG3omGu8J1dehO10qR2ZCbd3pmso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=T5NCm62z; arc=none smtp.client-ip=157.180.73.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="T5NCm62z"
Received: from relay14 (localhost [127.0.0.1])
	by relay14.grserver.gr (Proxmox) with ESMTP id 6A376409DF;
	Thu, 22 Jan 2026 07:51:17 +0000 (UTC)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay14.grserver.gr (Proxmox) with ESMTPS id D8858409C5;
	Thu, 22 Jan 2026 07:51:16 +0000 (UTC)
Received: from antheas-z13 (unknown [IPv6:2a05:f6c3:fefd:0:42c:a43d:2848:c282])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id 2B5271FE2D0;
	Thu, 22 Jan 2026 09:51:15 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1769068276;
	bh=EZI62rLY8T5iCqJeT156w6aRaLQTMZvHv5YNdeVWJHQ=; h=From:To:Subject;
	b=T5NCm62zuN2Qza9CxKT1vBjwv1hX9C6U+z7WuwkqMy+WKJvrM264mdtslh7yw5UyZ
	 IZc2njMY1QIeSd4XGDGW4eNHD7im2MyAYu1ddMTH+hEMIMMDeZDo1CcDcVt0n76jS/
	 S/iIdgblTrCiut4wqS9ylBt8dKpe0+5Zx+F7whO2Pmi8r94U0vKGd7m66IXxWdDtj7
	 1MejMkIDWOBCic7XnUtkh7tUz7Qv+8owRHmc5d0WMs7O/Lse7VfV/B0OtQlLOR0ZGT
	 /JvdsgYJh9yWYOl2oEFItrH1Z2K4CMN0/EddCyd8oSu6WZwd73AXvTqM2Buu/08Q4A
	 DnUmZKwzJX5QQ==
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
	Antheas Kapenekakis <lkml@antheas.dev>,
	Denis Benato <benato.denis96@gmail.com>
Subject: [PATCH v12 09/11] platform/x86: asus-wmi: remove unused keyboard
 backlight quirk
Date: Thu, 22 Jan 2026 08:50:42 +0100
Message-ID: <20260122075044.5070-10-lkml@antheas.dev>
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
 <176906827635.715398.3817779136930238516@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

The quirk for selecting whether keyboard backlight should be controlled
by HID or WMI is not needed anymore, so remove the file containing it.

Reviewed-by: Denis Benato <benato.denis96@gmail.com>
Acked-by: Benjamin Tissoires <bentiss@kernel.org>
Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
---
 .../platform_data/x86/asus-wmi-leds-ids.h     | 50 -------------------
 1 file changed, 50 deletions(-)
 delete mode 100644 include/linux/platform_data/x86/asus-wmi-leds-ids.h

diff --git a/include/linux/platform_data/x86/asus-wmi-leds-ids.h b/include/linux/platform_data/x86/asus-wmi-leds-ids.h
deleted file mode 100644
index 034a039c4e37..000000000000
--- a/include/linux/platform_data/x86/asus-wmi-leds-ids.h
+++ /dev/null
@@ -1,50 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __PLATFORM_DATA_X86_ASUS_WMI_LEDS_IDS_H
-#define __PLATFORM_DATA_X86_ASUS_WMI_LEDS_IDS_H
-
-#include <linux/dmi.h>
-#include <linux/types.h>
-
-/* To be used by both hid-asus and asus-wmi to determine which controls kbd_brightness */
-#if IS_REACHABLE(CONFIG_ASUS_WMI) || IS_REACHABLE(CONFIG_HID_ASUS)
-static const struct dmi_system_id asus_use_hid_led_dmi_ids[] = {
-	{
-		.matches = {
-			DMI_MATCH(DMI_PRODUCT_FAMILY, "ROG Zephyrus"),
-		},
-	},
-	{
-		.matches = {
-			DMI_MATCH(DMI_PRODUCT_FAMILY, "ROG Strix"),
-		},
-	},
-	{
-		.matches = {
-			DMI_MATCH(DMI_PRODUCT_FAMILY, "ROG Flow"),
-		},
-	},
-	{
-		.matches = {
-			DMI_MATCH(DMI_PRODUCT_FAMILY, "ProArt P16"),
-		},
-	},
-	{
-		.matches = {
-			DMI_MATCH(DMI_BOARD_NAME, "GA403U"),
-		},
-	},
-	{
-		.matches = {
-			DMI_MATCH(DMI_BOARD_NAME, "GU605M"),
-		},
-	},
-	{
-		.matches = {
-			DMI_MATCH(DMI_BOARD_NAME, "RC71L"),
-		},
-	},
-	{ },
-};
-#endif
-
-#endif	/* __PLATFORM_DATA_X86_ASUS_WMI_LEDS_IDS_H */
-- 
2.52.0


