From: Simon Wood <gitsend@mungewell.org>
Subject: [Patch-V2 6/6] HID:hid-logitech: Documentation updates/corrections
Date: Sun, 18 Sep 2016 10:55:42 -0600
Message-ID: <1474217742-3992-6-git-send-email-simon@mungewell.org>
References: <1473461449-8060-1-git-send-email-simon@mungewell.org>
 <1474217742-3992-1-git-send-email-simon@mungewell.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from host18.canaca.com ([66.49.204.205]:53778 "EHLO
        host18.canaca.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934105AbcIRQ4l (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sun, 18 Sep 2016 12:56:41 -0400
In-Reply-To: <1474217742-3992-1-git-send-email-simon@mungewell.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, Edwin Velds <edwin@velds.nl>, Elias Vanderstuyft <elias.vds@gmail.com>, Michal Maly <madcatxster@gmail.com>, Simon Wood <simon@mungewell.org>

Signed-off-by: Simon Wood <simon@mungewell.org>
---
 .../ABI/testing/sysfs-driver-hid-logitech-lg4ff    |  6 ++++++
 drivers/hid/Kconfig                                | 23 +++++++++++++---------
 2 files changed, 20 insertions(+), 9 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-driver-hid-logitech-lg4ff b/Documentation/ABI/testing/sysfs-driver-hid-logitech-lg4ff
index 9cd7c5a..305dffd 100644
--- a/Documentation/ABI/testing/sysfs-driver-hid-logitech-lg4ff
+++ b/Documentation/ABI/testing/sysfs-driver-hid-logitech-lg4ff
@@ -35,6 +35,12 @@ Description:	Displays a set of alternate modes supported by a wheel. Each
 		  DF-EX <*--------> G25 <-> G27
 		  DF-EX <*----------------> G27
 
+		G29:
+		  DF-EX <*> DFP <-> G25 <-> G27 <-> G29
+		  DF-EX <*--------> G25 <-> G27 <-> G29
+		  DF-EX <*----------------> G27 <-> G29
+		  DF-EX <*------------------------> G29
+
 		DFGT:
 		  DF-EX <*> DFP <-> DFGT
 		  DF-EX <*--------> DFGT
diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 78ac481..5227d8a 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -457,8 +457,6 @@ config LOGITECH_FF
 	  - Logitech WingMan Cordless RumblePad
 	  - Logitech WingMan Cordless RumblePad 2
 	  - Logitech WingMan Force 3D
-	  - Logitech Formula Force EX
-	  - Logitech WingMan Formula Force GP
 
 	  and if you want to enable force feedback for them.
 	  Note: if you say N here, this device will still be supported, but without
@@ -488,15 +486,22 @@ config LOGIWHEELS_FF
 	select INPUT_FF_MEMLESS
 	default LOGITECH_FF
 	help
-	  Say Y here if you want to enable force feedback and range setting
+	  Say Y here if you want to enable force feedback and range setting(*)
 	  support for following Logitech wheels:
+	  - Logitech G25 (*)
+	  - Logitech G27 (*)
+	  - Logitech G29 (*)
 	  - Logitech Driving Force
-	  - Logitech Driving Force Pro
-	  - Logitech Driving Force GT
-	  - Logitech G25
-	  - Logitech G27
-	  - Logitech MOMO/MOMO 2
-	  - Logitech Formula Force EX
+	  - Logitech Driving Force Pro (*)
+	  - Logitech Driving Force GT (*)
+	  - Logitech Driving Force EX/RX
+	  - Logitech Driving Force Wireless
+	  - Logitech Speed Force Wireless
+	  - Logitech MOMO Force
+	  - Logitech MOMO Racing Force
+	  - Logitech Formula Force GP
+	  - Logitech Formula Force EX/RX
+	  - Logitech Wingman Formula Force GP
 
 config HID_MAGICMOUSE
 	tristate "Apple Magic Mouse/Trackpad multi-touch support"
-- 
2.7.4

