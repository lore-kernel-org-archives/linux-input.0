From: Christian Lamparter <chunkeey@googlemail.com>
Subject: [PATCH] Kirkwood: WPS button keycode mapping
Date: Tue, 9 Mar 2010 00:25:29 +0100
Message-ID: <201003090025.29849.chunkeey@googlemail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f219.google.com ([209.85.220.219]:38364 "EHLO
	mail-fx0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751070Ab0CHXZj (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 8 Mar 2010 18:25:39 -0500
Received: by fxm19 with SMTP id 19so6926538fxm.21
        for <linux-input@vger.kernel.org>; Mon, 08 Mar 2010 15:25:38 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Lennert Buytenhek <buytenh@marvell.com>, Nicolas Pitre <nico@marvell.com>, linux-input@vger.kernel.org

Commit "Input: add KEY_WPS_BUTTON definition"
added a generic keycode for WPS button.
Let's use it, instead of "F1" mapping.

Signed-off-by: Christian Lamparter <chunkeey@googlemail.com>
---
(untested, don't have the HW - please keep the CC!)

KEY_WPS_BUTTON chance made it into 2.6.34-rc1.
---
diff --git a/arch/arm/mach-kirkwood/mv88f6281gtw_ge-setup.c b/arch/arm/mach-kirkwood/mv88f6281gtw_ge-setup.c
index 0358f45..5e6f711 100644
--- a/arch/arm/mach-kirkwood/mv88f6281gtw_ge-setup.c
+++ b/arch/arm/mach-kirkwood/mv88f6281gtw_ge-setup.c
@@ -74,9 +74,9 @@ static struct gpio_keys_button mv88f6281gtw_ge_button_pins[] = {
 		.desc		= "SWR Button",
 		.active_low	= 1,
 	}, {
-		.code		= KEY_F1,
+		.code		= KEY_WPS_BUTTON,
 		.gpio		= 46,
-		.desc		= "WPS Button(F1)",
+		.desc		= "WPS Button",
 		.active_low	= 1,
 	},
 };
