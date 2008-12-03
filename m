From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.28-rc7] hid: "default y" considered evil
Date: Wed, 3 Dec 2008 13:01:11 -0800
Message-ID: <200812031301.11475.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp123.sbc.mail.sp1.yahoo.com ([69.147.64.96]:41647 "HELO
	smtp123.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751079AbYLCVHx (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 3 Dec 2008 16:07:53 -0500
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz

From: David Brownell <dbrownell@users.sourceforge.net>

Fix the obnoxious "default y" for all the "special" HID code,
which forces folk with EMBEDDED defined to manually override
that inappropriate default for almost 20 choices.  The general
policy is against "default y"; it should apply here too.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
---
 drivers/hid/Kconfig |   36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -85,14 +85,14 @@ config HID_COMPAT
 config HID_A4TECH
 	tristate "A4 tech" if EMBEDDED
 	depends on USB_HID
-	default y
+	default !EMBEDDED
 	---help---
 	Support for A4 tech X5 and WOP-35 / Trust 450L mice.
 
 config HID_APPLE
 	tristate "Apple" if EMBEDDED
 	depends on (USB_HID || BT_HIDP)
-	default y
+	default !EMBEDDED
 	---help---
 	Support for some Apple devices which less or more break
 	HID specification.
@@ -103,42 +103,42 @@ config HID_APPLE
 config HID_BELKIN
 	tristate "Belkin" if EMBEDDED
 	depends on USB_HID
-	default y
+	default !EMBEDDED
 	---help---
 	Support for Belkin Flip KVM and Wireless keyboard.
 
 config HID_BRIGHT
 	tristate "Bright" if EMBEDDED
 	depends on USB_HID
-	default y
+	default !EMBEDDED
 	---help---
 	Support for Bright ABNT-2 keyboard.
 
 config HID_CHERRY
 	tristate "Cherry" if EMBEDDED
 	depends on USB_HID
-	default y
+	default !EMBEDDED
 	---help---
 	Support for Cherry Cymotion keyboard.
 
 config HID_CHICONY
 	tristate "Chicony" if EMBEDDED
 	depends on USB_HID
-	default y
+	default !EMBEDDED
 	---help---
 	Support for Chicony Tactical pad.
 
 config HID_CYPRESS
 	tristate "Cypress" if EMBEDDED
 	depends on USB_HID
-	default y
+	default !EMBEDDED
 	---help---
 	Support for cypress mouse and barcode readers.
 
 config HID_DELL
 	tristate "Dell" if EMBEDDED
 	depends on USB_HID
-	default y
+	default !EMBEDDED
 	---help---
 	Support for quirky Dell HID hardware that require
 	special LED handling (W7658 and SK8115 models)
@@ -146,21 +146,21 @@ config HID_DELL
 config HID_EZKEY
 	tristate "Ezkey" if EMBEDDED
 	depends on USB_HID
-	default y
+	default !EMBEDDED
 	---help---
 	Support for Ezkey BTC 8193 keyboard.
 
 config HID_GYRATION
 	tristate "Gyration" if EMBEDDED
 	depends on USB_HID
-	default y
+	default !EMBEDDED
 	---help---
 	Support for Gyration remote control.
 
 config HID_LOGITECH
 	tristate "Logitech" if EMBEDDED
 	depends on USB_HID
-	default y
+	default !EMBEDDED
 	---help---
 	Support for Logitech devices that are not fully compliant with HID standard.
 
@@ -191,21 +191,21 @@ config LOGIRUMBLEPAD2_FF
 config HID_MICROSOFT
 	tristate "Microsoft" if EMBEDDED
 	depends on USB_HID
-	default y
+	default !EMBEDDED
 	---help---
 	Support for Microsoft devices that are not fully compliant with HID standard.
 
 config HID_MONTEREY
 	tristate "Monterey" if EMBEDDED
 	depends on USB_HID
-	default y
+	default !EMBEDDED
 	---help---
 	Support for Monterey Genius KB29E.
 
 config HID_PANTHERLORD
 	tristate "Pantherlord devices support" if EMBEDDED
 	depends on USB_HID
-	default y
+	default !EMBEDDED
 	---help---
 	Support for PantherLord/GreenAsia based device support.
 
@@ -220,28 +220,28 @@ config PANTHERLORD_FF
 config HID_PETALYNX
 	tristate "Petalynx" if EMBEDDED
 	depends on USB_HID
-	default y
+	default !EMBEDDED
 	---help---
 	Support for Petalynx Maxter remote control.
 
 config HID_SAMSUNG
 	tristate "Samsung" if EMBEDDED
 	depends on USB_HID
-	default y
+	default !EMBEDDED
 	---help---
 	Support for Samsung InfraRed remote control.
 
 config HID_SONY
 	tristate "Sony" if EMBEDDED
 	depends on USB_HID
-	default y
+	default !EMBEDDED
 	---help---
 	Support for Sony PS3 controller.
 
 config HID_SUNPLUS
 	tristate "Sunplus" if EMBEDDED
 	depends on USB_HID
-	default y
+	default !EMBEDDED
 	---help---
 	Support for Sunplus wireless desktop.
 
