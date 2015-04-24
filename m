From: Dan Murphy <dmurphy@ti.com>
Subject: [PATCH] Input: drv2667: Fix Kconfig error for help screen
Date: Fri, 24 Apr 2015 13:16:40 -0500
Message-ID: <1429899401-7629-1-git-send-email-dmurphy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:35922 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030183AbbDXSQq (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 24 Apr 2015 14:16:46 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, Dan Murphy <dmurphy@ti.com>

Fix the Kconfig for the drv2667 as there was a copy/paste
error.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 drivers/input/misc/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
index 4436ab1..7838f1a 100644
--- a/drivers/input/misc/Kconfig
+++ b/drivers/input/misc/Kconfig
@@ -784,6 +784,6 @@ config INPUT_DRV2667_HAPTICS
 	  Say Y to enable support for the TI DRV2667 haptics driver.
 
 	  To compile this driver as a module, choose M here: the
-	  module will be called drv260x-haptics.
+	  module will be called drv2667-haptics.
 
 endif
-- 
1.9.1

