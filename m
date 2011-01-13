From: Nikolai Kondrashov <spbnick@gmail.com>
Subject: [PATCH 3/3] Input: update dragonrise Kconfig description
Date: Thu, 13 Jan 2011 21:56:43 +0300
Message-ID: <1294945003-7687-4-git-send-email-spbnick@gmail.com>
References: <1294945003-7687-1-git-send-email-spbnick@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:50053 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751835Ab1AMS5Q (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 13 Jan 2011 13:57:16 -0500
Received: by mail-ey0-f174.google.com with SMTP id 27so1038768eye.19
        for <linux-input@vger.kernel.org>; Thu, 13 Jan 2011 10:57:15 -0800 (PST)
In-Reply-To: <1294945003-7687-1-git-send-email-spbnick@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input <linux-input@vger.kernel.org>, Vladislav Naumov <vnaum@vnaum.com>, Nikolai Kondrashov <spbnick@gmail.com>

Add list of (supposedly) supported gamepads to dragonrise driver Kconfig
description.

Signed-off-by: Nikolai Kondrashov <spbnick@gmail.com>
---
 drivers/hid/Kconfig |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 3052e29..c1c5dc0 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -140,7 +140,12 @@ config HID_DRAGONRISE
 	tristate "DragonRise Inc. game controller"
 	depends on USB_HID
 	---help---
-	Say Y here if you have DragonRise Inc.game controllers.
+	Say Y here if you have DragonRise Inc. game controllers.
+	These might be branded as:
+	- Tesun USB-703
+	- Media-tech MT1504 "Rogue"
+	- DVTech JS19 "Gear"
+	- Defender Game Master
 
 config DRAGONRISE_FF
 	bool "DragonRise Inc. force feedback"
-- 
1.7.2.3

