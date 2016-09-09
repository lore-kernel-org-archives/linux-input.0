From: Simon Wood <gitsend@mungewell.org>
Subject: [PATCH 5/5] HID:hid-logitech: Documentation updates/corrections
Date: Fri,  9 Sep 2016 16:50:49 -0600
Message-ID: <1473461449-8060-5-git-send-email-simon@mungewell.org>
References: <1473461449-8060-1-git-send-email-simon@mungewell.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1473461449-8060-1-git-send-email-simon@mungewell.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, Edwin Velds <edwin@velds.nl>, Elias Vanderstuyft <elias.vds@gmail.com>, Michal Maly <madcatxster@gmail.com>, Simon Wood <simon@mungewell.org>
List-Id: linux-input@vger.kernel.org

Signed-off-by: Simon Wood <simon@mungewell.org>
---
 Documentation/ABI/testing/sysfs-driver-hid-logitech-lg4ff | 6 ++++++
 drivers/hid/Kconfig                                       | 6 +++---
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-driver-hid-logitech-lg4ff b/Documentation/ABI/testing/sysfs-driver-hid-logitech-lg4ff
index 69fb890..36e4d68 100644
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
index 78ac481..bebf89c0 100644
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
@@ -491,12 +489,14 @@ config LOGIWHEELS_FF
 	  Say Y here if you want to enable force feedback and range setting
 	  support for following Logitech wheels:
 	  - Logitech Driving Force
+	  - Logitech Driving Force EX
 	  - Logitech Driving Force Pro
 	  - Logitech Driving Force GT
 	  - Logitech G25
 	  - Logitech G27
+	  - Logitech G29
 	  - Logitech MOMO/MOMO 2
-	  - Logitech Formula Force EX
+	  - Logitech Formula Force EX/FX/GP
 
 config HID_MAGICMOUSE
 	tristate "Apple Magic Mouse/Trackpad multi-touch support"
-- 
2.7.4
