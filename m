From: Moritz Fischer <moritz.fischer@ettus.com>
Subject: [PATCH 1/2] input: misc: e3x0-button: Fix typo in module name
Date: Sun, 25 Oct 2015 13:06:06 -0700
Message-ID: <1445803567-8511-1-git-send-email-moritz.fischer@ettus.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oi0-f44.google.com ([209.85.218.44]:35315 "EHLO
	mail-oi0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751579AbbJYUFr (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 25 Oct 2015 16:05:47 -0400
Received: by oifu63 with SMTP id u63so47620414oif.2
        for <linux-input@vger.kernel.org>; Sun, 25 Oct 2015 13:05:47 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: jaewon02.kim@samsung.com, k.kozlowski@samsung.com, dmurphy@ti.com, geert@linux-m68k.org, courtney.cavin@sonymobile.com, carlo@caione.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Moritz Fischer <moritz.fischer@ettus.com>

The produced module will be called e3x0-button, not
e3x0_button.

Signed-off-by: Moritz Fischer <moritz.fischer@ettus.com>
---
 drivers/input/misc/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
index 906dd1b..7ac277c7 100644
--- a/drivers/input/misc/Kconfig
+++ b/drivers/input/misc/Kconfig
@@ -101,7 +101,7 @@ config INPUT_E3X0_BUTTON
 	  USRP E3x0 Button.
 
 	  To compile this driver as a module, choose M here: the
-	  module will be called e3x0_button.
+	  module will be called e3x0-button.
 
 config INPUT_PCSPKR
 	tristate "PC Speaker support"
-- 
2.6.2

