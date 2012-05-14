From: Devendra Naga <devendra.aaru@gmail.com>
Subject: [PATCH] drivers/input/mouse: Fix a "make randconfig" warning at MOUSE_APPLETOUCH dependency with USB_SUPPORT and USB_ARCH_HAS_HCD
Date: Tue, 15 May 2012 04:45:29 +0530
Message-ID: <1337037329-23618-1-git-send-email-devendra.aaru@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:39510 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758228Ab2ENXPi (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 14 May 2012 19:15:38 -0400
Received: by pbbrp8 with SMTP id rp8so6719830pbb.19
        for <linux-input@vger.kernel.org>; Mon, 14 May 2012 16:15:37 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Paul Parsons <lost.distance@yahoo.com>, Jiri Kosina <jkosina@suse.cz>, Jan Steinhoff <mail@jan-steinhoff.de>, linux-input@vger.kernel.org
Cc: Devendra Naga <devendra.aaru@gmail.com>

From: Devendra Naga <devendra@devendra.(none)>

when ran make randconfig got the warning

"MOUSE_APPLETOUCH selects USB which has unmet direct dependencies (USB_SUPPORT && USB_ARCH_HAS_HCD)"

Signed-off-by: Devendra Naga <devendra.aaru@gmail.com>
---
 drivers/input/mouse/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/mouse/Kconfig b/drivers/input/mouse/Kconfig
index cd6268c..044378f 100644
--- a/drivers/input/mouse/Kconfig
+++ b/drivers/input/mouse/Kconfig
@@ -152,7 +152,7 @@ config MOUSE_SERIAL
 config MOUSE_APPLETOUCH
 	tristate "Apple USB Touchpad support"
 	depends on USB_ARCH_HAS_HCD
-	select USB
+	select USB if USB_SUPPORT && USB_ARCH_HAS_HCD
 	help
 	  Say Y here if you want to use an Apple USB Touchpad.
 
-- 
1.7.9.5

