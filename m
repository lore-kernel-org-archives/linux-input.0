From: Zhuohua Li <lizhuohua1994@gmail.com>
Subject: [PATCH] Input: misc: Kconfig: fixed a spelling mistake
Date: Thu, 28 Dec 2017 16:30:50 +0800
Message-ID: <20171228083050.6475-1-lizhuohua1994@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pl0-f67.google.com ([209.85.160.67]:36534 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751079AbdL1IbY (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 28 Dec 2017 03:31:24 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Zhuohua Li <lizhuohua1994@gmail.com>

fixed a spelling mistake: buttong -> button

Signed-off-by: Zhuohua Li <lizhuohua1994@gmail.com>
---
 drivers/input/misc/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
index 9f082a388388..509ba8ef1464 100644
--- a/drivers/input/misc/Kconfig
+++ b/drivers/input/misc/Kconfig
@@ -468,7 +468,7 @@ config INPUT_TPS65218_PWRBUTTON
 	tristate "TPS65218 Power button driver"
 	depends on (MFD_TPS65217 || MFD_TPS65218)
 	help
-	  Say Y here if you want to enable power buttong reporting for
+	  Say Y here if you want to enable power button reporting for
 	  TPS65217 and TPS65218 Power Management IC devices.
 
 	  To compile this driver as a module, choose M here. The module will
-- 
2.13.6

