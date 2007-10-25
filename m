From: Stephen Hemminger <shemminger@linux-foundation.org>
Subject: [PATCH] apanel: space savings.
Date: Thu, 25 Oct 2007 13:19:06 -0700
Message-ID: <20071025131906.36847ed7@shemminger-laptop>
References: <20070702111724.43ee5b43@freepuppy.localdomain.hemminger.net>
	<200709140130.59732.dtor@insightbb.com>
	<20070916215516.2934abad@oldman.hemminger.net>
	<200709161623.00286.dtor@insightbb.com>
	<20071023125555.38d63567@shemminger-laptop>
	<20071024160300.85e1cbda.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20071024160300.85e1cbda.akpm@linux-foundation.org>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: dtor@insightbb.com, pavel@ucw.cz, lenb@kernel.org, linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Eliminate the device_names they are only used for debug
messages. Add paren's for one expression.

Signed-off-by: Stephen Hemminger <shemminger@linux-foundation.org>

--- a/drivers/input/misc/apanel.c	2007-10-25 09:20:23.000000000 -0700
+++ b/drivers/input/misc/apanel.c	2007-10-25 12:07:00.000000000 -0700
@@ -27,7 +27,7 @@
 #include <linux/leds.h>
 
 #define APANEL_NAME	"Fujitsu Application Panel"
-#define APANEL_VERSION	"1.3"
+#define APANEL_VERSION	"1.3.1"
 #define APANEL		"apanel"
 
 /* How often we poll keys - msecs */
@@ -40,6 +40,7 @@ enum apanel_devid {
 	APANEL_DEV_CDBTN  = 2,
 	APANEL_DEV_LCD	  = 3,
 	APANEL_DEV_LED	  = 4,
+
 	APANEL_DEV_MAX,
 };
 
@@ -53,14 +54,6 @@ enum apanel_chip {
 /* Result of BIOS snooping/probing -- what features are supported */
 static enum apanel_chip device_chip[APANEL_DEV_MAX];
 
-/* names for APANEL_XXX */
-static const char *device_names[APANEL_DEV_MAX] __initdata = {
-	[APANEL_DEV_APPBTN] = "Application Buttons",
-	[APANEL_DEV_LCD]    = "LCD",
-	[APANEL_DEV_LED]    = "LED",
-	[APANEL_DEV_CDBTN]  = "CD Buttons",
-};
-
 #define MAX_PANEL_KEYS	12
 
 struct apanel {
@@ -123,7 +116,7 @@ static void apanel_poll(struct input_pol
 
 	dev_dbg(&ipdev->input->dev, APANEL ": data %#x\n", data);
 	for (i = 0; i < ipdev->input->keycodemax; i++)
-		if (1ul << i & data)
+		if ((1u << i) & data)
 			report_key(idev, ap->keymap[i]);
 }
 
@@ -366,17 +359,14 @@ static int __init apanel_init(void)
 		}
 
 		if (devno >= APANEL_DEV_MAX)
-			pr_notice(APANEL ": unknown device %d found\n", devno);
+			pr_notice(APANEL ": unknown device %u found\n", devno);
 		else if (device_chip[devno] != CHIP_NONE)
-			pr_warning(APANEL ": duplicate entry for %s\n",
-				   device_names[devno]);
+			pr_warning(APANEL ": duplicate entry for devno %u\n", devno);
 
 		else if (method != 1 && method != 2 && method != 4) {
-			pr_notice(APANEL ": unknown  method %u for %s\n",
-				  method, device_names[devno]);
+			pr_notice(APANEL ": unknown method %u for devno %u\n",
+				  method, devno);
 		} else {
-			pr_debug(APANEL ": %s found.\n", device_names[devno]);
-
 			device_chip[devno] = (enum apanel_chip) chip;
 			++found;
 		}
