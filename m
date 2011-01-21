From: Nikolai Kondrashov <spbnick@gmail.com>
Subject: [PATCH 3/3] Input: update dragonrise Kconfig description
Date: Fri, 21 Jan 2011 12:30:15 +0300
Message-ID: <1295602215-6056-4-git-send-email-spbnick@gmail.com>
References: <1295602215-6056-1-git-send-email-spbnick@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:36118 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750955Ab1AUJaj (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 21 Jan 2011 04:30:39 -0500
Received: by ewy5 with SMTP id 5so773421ewy.19
        for <linux-input@vger.kernel.org>; Fri, 21 Jan 2011 01:30:38 -0800 (PST)
In-Reply-To: <1295602215-6056-1-git-send-email-spbnick@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input <linux-input@vger.kernel.org>, Vladislav Naumov <vnaum@vnaum.com>, Nikolai Kondrashov <spbnick@gmail.com>

Add list of (supposedly) supported gamepads to dragonrise driver Kconfig
description.

Signed-off-by: Nikolai Kondrashov <spbnick@gmail.com>
---
 drivers/hid/Kconfig |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 24cca2f..98600e5 100644
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

