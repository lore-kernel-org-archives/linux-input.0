From: Thomas Abraham <thomas.abraham@linaro.org>
Subject: [PATCH 1/2] input: samsung-keypad: Add HAVE_SAMSUNG_KEYPAD config
 option
Date: Tue, 06 Sep 2011 19:25:16 +0530
Message-ID: <1315317317-21873-2-git-send-email-thomas.abraham@linaro.org>
References: <1315317317-21873-1-git-send-email-thomas.abraham@linaro.org>
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:26987 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754598Ab1IFN4K (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 6 Sep 2011 09:56:10 -0400
In-reply-to: <1315317317-21873-1-git-send-email-thomas.abraham@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: devicetree-discuss@lists.ozlabs.org
Cc: grant.likely@secretlab.ca, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, kgene.kim@samsung.com, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, jy0922.shim@samsung.com, dh09.lee@samsung.com

Samsung keyboard driver could be used with platforms using device tree.
So the inclusion of samsung keyboard driver cannot be based on
SAMSUNG_DEV_KEYPAD. A new config option HAVE_SAMSUNG_KEYPAD is added
which device tree based platforms should use to include samsung keyboard
driver.

Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
---
 drivers/input/keyboard/Kconfig |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
index b4dee9d..370fb18 100644
--- a/drivers/input/keyboard/Kconfig
+++ b/drivers/input/keyboard/Kconfig
@@ -423,9 +423,16 @@ config KEYBOARD_PMIC8XXX
 	  To compile this driver as a module, choose M here: the module will
 	  be called pmic8xxx-keypad.
 
+config HAVE_SAMSUNG_KEYPAD
+	bool
+	help
+	  This will include Samsung Keypad controller driver support. If you
+	  want to include Samsung Keypad support for any machine, kindly
+	  select this in the respective mach-xxxx/Kconfig file.
+
 config KEYBOARD_SAMSUNG
 	tristate "Samsung keypad support"
-	depends on SAMSUNG_DEV_KEYPAD
+	depends on SAMSUNG_DEV_KEYPAD || HAVE_SAMSUNG_KEYPAD
 	help
 	  Say Y here if you want to use the Samsung keypad.
 
-- 
1.6.6.rc2

