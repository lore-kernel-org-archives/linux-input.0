From: Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: [PATCH 07/36] Use menuconfig objects II - HID
Date: Mon, 30 Apr 2007 13:27:48 +0200 (MEST)
Message-ID: <Pine.LNX.4.61.0704301326230.29151@yvahk01.tjqt.qr>
References: <Pine.LNX.4.61.0704301225060.29151@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <Pine.LNX.4.61.0704301225060.29151@yvahk01.tjqt.qr>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Jiri Kosina <jkosina@suse.cz>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org


Make a "menuconfig" out of the Kconfig objects "menu, ..., endmenu",
so that the user can disable all the options in that menu at once
instead of having to disable each option separately.

Signed-off-by: Jan Engelhardt <jengelh@gmx.de>

---
 drivers/hid/Kconfig |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

--- linux-2.6.21-mm_20070428.orig/drivers/hid/Kconfig
+++ linux-2.6.21-mm_20070428/drivers/hid/Kconfig
@@ -1,8 +1,12 @@
 #
 # HID driver configuration
 #
-menu "HID Devices"
+menuconfig HID_SUPPORT
+	bool "HID Devices"
 	depends on INPUT
+	default y
+
+if HID_SUPPORT
 
 config HID
 	tristate "Generic HID support"
@@ -58,5 +62,4 @@ config HIDRAW
 
 source "drivers/hid/usbhid/Kconfig"
 
-endmenu
-
+endif # HID_SUPPORT
