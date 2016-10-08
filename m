From: Scott Branden <scott.branden@broadcom.com>
Subject: [PATCH] Input: set default for iProc touchscreen
Date: Sat,  8 Oct 2016 11:11:35 -0700
Message-ID: <1475950295-9660-1-git-send-email-scott.branden@broadcom.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f172.google.com ([209.85.192.172]:32773 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751691AbcJHSLs (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Sat, 8 Oct 2016 14:11:48 -0400
Received: by mail-pf0-f172.google.com with SMTP id 190so36911485pfv.0
        for <linux-input@vger.kernel.org>; Sat, 08 Oct 2016 11:11:46 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>, Scott Branden <scott.branden@broadcom.com>, Ray Jui <rjui@broadcom.com>

Enable the Broadcom iProc touchscreen by default for all iProc platforms.

Signed-off-by: Ray Jui <rjui@broadcom.com>
Signed-off-by: Scott Branden <scott.branden@broadcom.com>
---
 drivers/input/touchscreen/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
index 2fb1f43..f785371 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -364,6 +364,7 @@ config TOUCHSCREEN_ILI210X
 config TOUCHSCREEN_IPROC
 	tristate "IPROC touch panel driver support"
 	depends on ARCH_BCM_IPROC || COMPILE_TEST
+	default ARCH_BCM_IPROC
 	help
 	  Say Y here if you want to add support for the IPROC touch
 	  controller to your system.
-- 
2.5.0

