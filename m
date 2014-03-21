From: Jean Delvare <jdelvare@suse.de>
Subject: [RFC PATCH] HID: Stop hiding options with !EXPERT
Date: Fri, 21 Mar 2014 09:46:36 +0100
Message-ID: <20140321094636.66fc62f2@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:37343 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751620AbaCUIqi (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 21 Mar 2014 04:46:38 -0400
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id C535775020
	for <linux-input@vger.kernel.org>; Fri, 21 Mar 2014 08:46:37 +0000 (UTC)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jiri Kosina <jkosina@suse.cz>

Many HID driver options are hidden unless EXPERT is set. While I
understand the idea of simplifying the kernel configuration for most
users, in practice I believe it adds more confusion than it helps.

One thing that worries me is that, in non-EXPERT mode, these drivers
will be either built-in or modular based on apparent magic. For
example, switching INPUT and HID from m to y will cause all these
drivers to be built into the kernel when they were previously built
as modules. Short of enabling EXPERT mode altogether, the user has no
control over that.

Generally I do not think tristate options should depend on !EXPERT.
Of these, 11 of 15 are currently in the hid subsystem.

The HID_LOGITECH option is even worse than the others. Sub-options
depend on it, and this causes menuconfig and friends to display the
option even though the user can't change its value. The help page for
HID_LOGITECH will not explain why the value can't be changed. It only
says, for example:

  Depends on: INPUT [=y] && HID [=y]

and that leaves the user puzzled about why the option is forced to y.
You might argue that this is a Kconfig bug, but that doesn't make it
less annoying for the user.

Even worse is that some of the sub-options of HID_LOGITECH select
INPUT_FF_MEMLESS, which in turn gets out of control for the user. So,
if you set INPUT=y and HID=y (something most general purpose
distributions would do these days, as both modules would get loaded on
a vast majority of systems otherwise), and you want support for
force-feedback game controllers, you can't have that as a module, it
has to be built-in, regardless of how rare these devices are.

Of course, all this madness goes away once EXPERT is enabled, but then
the rest of the kernel configuration becomes more complex, which
totally voids the original point.

For this reason, I would like all HID device tristate options to be
displayed regardless of EXPERT being set or not. We can let the
default settings still depend on EXPERT, that's not intrusive.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
Cc: Jiri Kosina <jkosina@suse.cz>
---
 drivers/hid/Kconfig |   22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

--- linux-3.14-rc7.orig/drivers/hid/Kconfig	2014-03-20 21:06:41.457316973 +0100
+++ linux-3.14-rc7/drivers/hid/Kconfig	2014-03-20 21:06:59.861752396 +0100
@@ -91,7 +91,7 @@ menu "Special HID drivers"
 	depends on HID
 
 config HID_A4TECH
-	tristate "A4 tech mice" if EXPERT
+	tristate "A4 tech mice"
 	depends on HID
 	default !EXPERT
 	---help---
@@ -112,7 +112,7 @@ config HID_ACRUX_FF
 	game controllers.
 
 config HID_APPLE
-	tristate "Apple {i,Power,Mac}Books" if EXPERT
+	tristate "Apple {i,Power,Mac}Books"
 	depends on HID
 	default !EXPERT
 	---help---
@@ -140,21 +140,21 @@ config HID_AUREAL
 	Support for Aureal Cy se W-01RN Remote Controller and other Aureal derived remotes.
 
 config HID_BELKIN
-	tristate "Belkin Flip KVM and Wireless keyboard" if EXPERT
+	tristate "Belkin Flip KVM and Wireless keyboard"
 	depends on HID
 	default !EXPERT
 	---help---
 	Support for Belkin Flip KVM and Wireless keyboard.
 
 config HID_CHERRY
-	tristate "Cherry Cymotion keyboard" if EXPERT
+	tristate "Cherry Cymotion keyboard"
 	depends on HID
 	default !EXPERT
 	---help---
 	Support for Cherry Cymotion keyboard.
 
 config HID_CHICONY
-	tristate "Chicony Tactical pad" if EXPERT
+	tristate "Chicony Tactical pad"
 	depends on HID
 	default !EXPERT
 	---help---
@@ -176,7 +176,7 @@ config HID_PRODIKEYS
 	  and some additional multimedia keys.
 
 config HID_CYPRESS
-	tristate "Cypress mouse and barcode readers" if EXPERT
+	tristate "Cypress mouse and barcode readers"
 	depends on HID
 	default !EXPERT
 	---help---
@@ -225,7 +225,7 @@ config HID_ELO
 	different devices than those handled by CONFIG_TOUCHSCREEN_USB_ELO.
 
 config HID_EZKEY
-	tristate "Ezkey BTC 8193 keyboard" if EXPERT
+	tristate "Ezkey BTC 8193 keyboard"
 	depends on HID
 	default !EXPERT
 	---help---
@@ -310,7 +310,7 @@ config HID_TWINHAN
 	Support for Twinhan IR remote control.
 
 config HID_KENSINGTON
-	tristate "Kensington Slimblade Trackball" if EXPERT
+	tristate "Kensington Slimblade Trackball"
 	depends on HID
 	default !EXPERT
 	---help---
@@ -336,7 +336,7 @@ config HID_LENOVO_TPKBD
 	controlling the mute and microphone mute LEDs.
 
 config HID_LOGITECH
-	tristate "Logitech devices" if EXPERT
+	tristate "Logitech devices"
 	depends on HID
 	default !EXPERT
 	---help---
@@ -413,14 +413,14 @@ config HID_MAGICMOUSE
 	Apple Wireless "Magic" Mouse and the Apple Wireless "Magic" Trackpad.
 
 config HID_MICROSOFT
-	tristate "Microsoft non-fully HID-compliant devices" if EXPERT
+	tristate "Microsoft non-fully HID-compliant devices"
 	depends on HID
 	default !EXPERT
 	---help---
 	Support for Microsoft devices that are not fully compliant with HID standard.
 
 config HID_MONTEREY
-	tristate "Monterey Genius KB29E keyboard" if EXPERT
+	tristate "Monterey Genius KB29E keyboard"
 	depends on HID
 	default !EXPERT
 	---help---


-- 
Jean Delvare
SUSE L3 Support
