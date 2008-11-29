From: Jean Delvare <khali@linux-fr.org>
Subject: [PATCH] Input: Make MOUSE_PS2_LIFEBOOK depend on X86
Date: Sat, 29 Nov 2008 19:11:30 +0100
Message-ID: <20081129191130.6684c3e6@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from zone0.gcu-squad.org ([212.85.147.21]:4338 "EHLO
	services.gcu-squad.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751690AbYK2SLm (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 29 Nov 2008 13:11:42 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

As far as I know, all Fujitsu-Siemens Lifebook systems are x86-based.
So we might was well make MOUSE_PS2_LIFEBOOK depend on X86. This will
avoid surprising things like:

arch/arm/configs/s3c2410_defconfig:CONFIG_MOUSE_PS2_LIFEBOOK=y

(and several dozen similar ones.)

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/mouse/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.28-rc6.orig/drivers/input/mouse/Kconfig	2008-11-04 21:39:20.000000000 +0100
+++ linux-2.6.28-rc6/drivers/input/mouse/Kconfig	2008-11-29 19:00:31.000000000 +0100
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
