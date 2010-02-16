From: Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH] input: enable sh_keysc on SH-Mobile ARM
Date: Tue, 16 Feb 2010 19:53:15 +0900
Message-ID: <20100216105315.15440.95212.sendpatchset@t400s>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yx0-f200.google.com ([209.85.210.200]:56948 "EHLO
	mail-yx0-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751030Ab0BPKxh (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 16 Feb 2010 05:53:37 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: lethal@linux-sh.org, Magnus Damm <magnus.damm@gmail.com>, dmitry.torokhov@gmail.com, linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Update the Kconfig entry for the sh_keysc driver to
enable build on SH-Mobile ARM platforms.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 drivers/input/keyboard/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- 0001/drivers/input/keyboard/Kconfig
+++ work/drivers/input/keyboard/Kconfig	2010-02-16 19:35:04.000000000 +0900
@@ -363,7 +363,7 @@ config KEYBOARD_SUNKBD
 
 config KEYBOARD_SH_KEYSC
 	tristate "SuperH KEYSC keypad support"
-	depends on SUPERH
+	depends on SUPERH || ARCH_SHMOBILE
 	help
 	  Say Y here if you want to use a keypad attached to the KEYSC block
 	  on SuperH processors such as sh7722 and sh7343.
