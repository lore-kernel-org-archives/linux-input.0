From: Randy Dunlap <rdunlap@xenotime.net>
Subject: [PATCH -next] hid: fix WACOM Kconfig warning
Date: Thu, 29 Mar 2012 09:18:35 -0700
Message-ID: <4F748B5B.9010104@xenotime.net>
References: <20120329144217.6cacd2f040fa9abb9190ae1e@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <20120329144217.6cacd2f040fa9abb9190ae1e@canb.auug.org.au>
Sender: linux-next-owner@vger.kernel.org
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

Fix hid Kconfig warning:

drivers/hid/Kconfig:595:error: recursive dependency detected!
drivers/hid/Kconfig:595:	symbol HID_WACOM depends on HID_WACOM

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 drivers/hid/Kconfig |    1 -
 1 file changed, 1 deletion(-)

--- linux-next-20120329.orig/drivers/hid/Kconfig
+++ linux-next-20120329/drivers/hid/Kconfig
@@ -595,7 +595,6 @@ config THRUSTMASTER_FF
 config HID_WACOM
 	tristate "Wacom Bluetooth devices support"
 	depends on BT_HIDP
-	depends on HID_WACOM
 	select POWER_SUPPLY
 	---help---
 	Support for Wacom Graphire Bluetooth and Intuos4 WL tablets.
