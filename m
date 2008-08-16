From: Huang Weiyi <weiyi.huang@gmail.com>
Subject: [INPUT] removed unused #include <version.h>
Date: Sun, 17 Aug 2008 07:50:53 +0800
Message-ID: <20080817064601.160F.WEIYI.HUANG@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.187]:14173 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752514AbYHPXvE (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 16 Aug 2008 19:51:04 -0400
Received: by ti-out-0910.google.com with SMTP id b6so623856tic.23
        for <linux-input@vger.kernel.org>; Sat, 16 Aug 2008 16:51:04 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, dtor@mail.ru
Cc: linux-input@vger.kernel.org

The drivers below do not use LINUX_VERSION_CODE nor KERNEL_VERSION.
  drivers/input/keyboard/gpio_keys.c
  drivers/input/mouse/gpio_mouse.c
  drivers/input/tablet/gtco.c

This patch removes the said #include <version.h>.

Signed-off-by: Huang Weiyi <weiyi.huang@gmail.com>

diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index be58730..a0fcc4c 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -9,7 +9,6 @@
  */
 
 #include <linux/module.h>
-#include <linux/version.h>
 
 #include <linux/init.h>
 #include <linux/fs.h>
diff --git a/drivers/input/mouse/gpio_mouse.c b/drivers/input/mouse/gpio_mouse.c
index 3392901..72cf5e3 100644
--- a/drivers/input/mouse/gpio_mouse.c
+++ b/drivers/input/mouse/gpio_mouse.c
@@ -9,7 +9,6 @@
  */
 
 #include <linux/init.h>
-#include <linux/version.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/input-polldev.h>
diff --git a/drivers/input/tablet/gtco.c b/drivers/input/tablet/gtco.c
index b9b7a98..7df0228 100644
--- a/drivers/input/tablet/gtco.c
+++ b/drivers/input/tablet/gtco.c
@@ -64,7 +64,6 @@ Scott Hill shill@gtcocalcomp.com
 #include <asm/byteorder.h>
 
 
-#include <linux/version.h>
 #include <linux/usb/input.h>
 
 /* Version with a Major number of 2 is for kernel inclusion only. */

