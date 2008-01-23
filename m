From: "eric miao" <eric.y.miao@gmail.com>
Subject: [PATCH 7/12] pxa: make pxa27x_keypad.c support both pxa27x and pxa3xx
Date: Wed, 23 Jan 2008 15:29:13 +0800
Message-ID: <f17812d70801222329v3d3b7dd3m95d8a3ce62471d3d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.176]:59093 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752646AbYAWH3Q (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 23 Jan 2008 02:29:16 -0500
Received: by wa-out-1112.google.com with SMTP id v27so4886135wah.23
        for <linux-input@vger.kernel.org>; Tue, 22 Jan 2008 23:29:13 -0800 (PST)
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>

>From a1e8e5741916fdb9ccfda2940ac274218fab6cc5 Mon Sep 17 00:00:00 2001
From: eric miao <eric.miao@marvell.com>
Date: Wed, 23 Jan 2008 15:08:41 +0800
Subject: [PATCH] pxa: make pxa27x_keypad.c support both pxa27x and pxa3xx

Signed-off-by: eric miao <eric.miao@marvell.com>
---
 drivers/input/keyboard/Kconfig |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
index 33e292b..9dd9b50 100644
--- a/drivers/input/keyboard/Kconfig
+++ b/drivers/input/keyboard/Kconfig
@@ -239,10 +239,10 @@ config KEYBOARD_OMAP
 	  module will be called omap-keypad.

 config KEYBOARD_PXA27x
-	tristate "PXA27x keypad support"
-	depends on PXA27x
+	tristate "PXA27x/PXA3xx keypad support"
+	depends on PXA27x || PXA3xx
 	help
-	  Enable support for PXA27x keypad controller
+	  Enable support for PXA27x/PXA3xx keypad controller

 	  To compile this driver as a module, choose M here: the
 	  module will be called pxa27x_keypad.
-- 
1.5.2.5.GIT



-- 
Cheers
- eric
