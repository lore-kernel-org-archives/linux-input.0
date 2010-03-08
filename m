From: Christian Lamparter <chunkeey@googlemail.com>
Subject: [PATCH] Orion5x: replace KEY_WLAN with KEY_WPS_BUTTON
Date: Tue, 9 Mar 2010 00:26:35 +0100
Message-ID: <201003090026.35696.chunkeey@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.158]:37932 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750972Ab0CHX0j (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 8 Mar 2010 18:26:39 -0500
Received: by fg-out-1718.google.com with SMTP id 16so2620194fgg.1
        for <linux-input@vger.kernel.org>; Mon, 08 Mar 2010 15:26:37 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-input@vger.kernel.org, Lennert Buytenhek <buytenh@marvell.com>, Nicolas Pitre <nico@marvell.com>

"Input: add KEY_WPS_BUTTON definition" introduced
a generic keycode for WPS input events. 

Signed-off-by: Christian Lamparter <chunkeey@googlemail.com>
---
(untested, don't have the HW - keep the CC.)

KEY_WLAN is _reversed_ for WLAN rfkill. ;-)
---
diff --git a/arch/arm/mach-orion5x/wrt350n-v2-setup.c b/arch/arm/mach-orion5x/wrt350n-v2-setup.c
index cb0feca..f9f222e 100644
--- a/arch/arm/mach-orion5x/wrt350n-v2-setup.c
+++ b/arch/arm/mach-orion5x/wrt350n-v2-setup.c
@@ -77,7 +77,7 @@ static struct gpio_keys_button wrt350n_v2_buttons[] = {
 		.desc		= "Reset Button",
 		.active_low	= 1,
 	}, {
-		.code		= KEY_WLAN,
+		.code		= KEY_WPS_BUTTON,
 		.gpio		= 2,
 		.desc		= "WPS Button",
 		.active_low	= 1,
