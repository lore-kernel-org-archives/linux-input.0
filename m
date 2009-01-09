From: Jean Delvare <khali@linux-fr.org>
Subject: [PATCH] Input: Make MOUSE_PS2_LIFEBOOK depend on X86
Date: Fri, 9 Jan 2009 10:52:29 +0100
Message-ID: <20090109105229.37c2a09b@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from zone0.gcu-squad.org ([212.85.147.21]:27432 "EHLO
	services.gcu-squad.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754507AbZAIJwh (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 9 Jan 2009 04:52:37 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>

As far as I know, all Fujitsu-Siemens Lifebook systems are x86-based.
So we might as well make MOUSE_PS2_LIFEBOOK depend on X86. This will
avoid surprising things like:

arch/arm/configs/s3c2410_defconfig:CONFIG_MOUSE_PS2_LIFEBOOK=y

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
This patch was already sent on:
 * 2008-11-29

 drivers/input/mouse/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.29-rc0.orig/drivers/input/mouse/Kconfig	2009-01-09 10:06:36.000000000 +0100
+++ linux-2.6.29-rc0/drivers/input/mouse/Kconfig	2009-01-09 10:47:56.000000000 +0100
@@ -70,7 +70,7 @@ config MOUSE_PS2_SYNAPTICS
 config MOUSE_PS2_LIFEBOOK
 	bool "Fujitsu Lifebook PS/2 mouse protocol extension" if EMBEDDED
 	default y
-	depends on MOUSE_PS2
+	depends on MOUSE_PS2 && X86
 	help
 	  Say Y here if you have a Fujitsu B-series Lifebook PS/2
 	  TouchScreen connected to your system.


-- 
Jean Delvare
