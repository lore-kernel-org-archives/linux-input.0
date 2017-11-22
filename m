From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 5/6] Input: misc: remove unneeded MODULE_VERSION() usage
Date: Wed, 22 Nov 2017 18:49:20 +0100
Message-ID: <20171122174921.20192-6-gregkh@linuxfoundation.org>
References: <20171122174921.20192-1-gregkh@linuxfoundation.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171122174921.20192-1-gregkh@linuxfoundation.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
Cc: linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ville Syrjala <syrjala@sci.fi>
List-Id: linux-input@vger.kernel.org

MODULE_VERSION is useless for in-kernel drivers, so just remove all
usage of it in the misc input drivers.  Along with this, some
DRIVER_VERSION macros were removed as they are also pointless.

Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Ville Syrjala <syrjala@sci.fi>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/input/misc/apanel.c      | 2 --
 drivers/input/misc/ati_remote2.c | 2 --
 drivers/input/misc/uinput.c      | 1 -
 3 files changed, 5 deletions(-)

diff --git a/drivers/input/misc/apanel.c b/drivers/input/misc/apanel.c
index aad1df04c854..094bddf56755 100644
--- a/drivers/input/misc/apanel.c
+++ b/drivers/input/misc/apanel.c
@@ -26,7 +26,6 @@
 #include <linux/leds.h>
 
 #define APANEL_NAME	"Fujitsu Application Panel"
-#define APANEL_VERSION	"1.3.1"
 #define APANEL		"apanel"
 
 /* How often we poll keys - msecs */
@@ -345,7 +344,6 @@ module_exit(apanel_cleanup);
 MODULE_AUTHOR("Stephen Hemminger <shemminger@linux-foundation.org>");
 MODULE_DESCRIPTION(APANEL_NAME " driver");
 MODULE_LICENSE("GPL");
-MODULE_VERSION(APANEL_VERSION);
 
 MODULE_ALIAS("dmi:*:svnFUJITSU:pnLifeBook*:pvr*:rvnFUJITSU:*");
 MODULE_ALIAS("dmi:*:svnFUJITSU:pnLifebook*:pvr*:rvnFUJITSU:*");
diff --git a/drivers/input/misc/ati_remote2.c b/drivers/input/misc/ati_remote2.c
index ebf4448b31b9..ded5b84e336d 100644
--- a/drivers/input/misc/ati_remote2.c
+++ b/drivers/input/misc/ati_remote2.c
@@ -14,10 +14,8 @@
 #include <linux/module.h>
 
 #define DRIVER_DESC    "ATI/Philips USB RF remote driver"
-#define DRIVER_VERSION "0.3"
 
 MODULE_DESCRIPTION(DRIVER_DESC);
-MODULE_VERSION(DRIVER_VERSION);
 MODULE_AUTHOR("Ville Syrjala <syrjala@sci.fi>");
 MODULE_LICENSE("GPL");
 
diff --git a/drivers/input/misc/uinput.c b/drivers/input/misc/uinput.c
index 39ddd9a73feb..91586193115f 100644
--- a/drivers/input/misc/uinput.c
+++ b/drivers/input/misc/uinput.c
@@ -1085,4 +1085,3 @@ MODULE_ALIAS("devname:" UINPUT_NAME);
 MODULE_AUTHOR("Aristeu Sergio Rozanski Filho");
 MODULE_DESCRIPTION("User level driver support for input subsystem");
 MODULE_LICENSE("GPL");
-MODULE_VERSION("0.3");
-- 
2.15.0
