From: Jean Delvare <jdelvare@suse.de>
Subject: [PATCH RESEND] HID: Stop hiding options with !EXPERT
Date: Mon, 26 Jan 2015 11:12:23 +0100
Message-ID: <20150126111223.24b6a938@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:46892 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753022AbbAZKMb (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 26 Jan 2015 05:12:31 -0500
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id 43077ADB3
	for <linux-input@vger.kernel.org>; Mon, 26 Jan 2015 10:12:30 +0000 (UTC)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org

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
This was already sent on 2014-03-21, and discussed:
  http://www.spinics.net/lists/linux-input/msg30493.html
I believe I answered all the points that were raised back then so I
think this patch can be applied now. Thanks.

 drivers/hid/Kconfig |   22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

--- linux-3.19-rc6.orig/drivers/hid/Kconfig	2015-01-26 10:30:56.514183521 +0100
+++ linux-3.19-rc6/drivers/hid/Kconfig	2015-01-26 10:59:48.227551041 +0100
@@ -92,7 +92,7 @@ menu "Special HID drivers"
 	depends on HID
 
 config HID_A4TECH
-	tristate "A4 tech mice" if EXPERT
+	tristate "A4 tech mice"
 	depends on HID
 	default !EXPERT
 	---help---
@@ -113,7 +113,7 @@ config HID_ACRUX_FF
 	game controllers.
 
 config HID_APPLE
-	tristate "Apple {i,Power,Mac}Books" if EXPERT
+	tristate "Apple {i,Power,Mac}Books"
 	depends on HID
 	default !EXPERT
 	---help---
@@ -141,21 +141,21 @@ config HID_AUREAL
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
@@ -186,7 +186,7 @@ config HID_CP2112
 	customizable USB descriptor fields are exposed as sysfs attributes.
 
 config HID_CYPRESS
-	tristate "Cypress mouse and barcode readers" if EXPERT
+	tristate "Cypress mouse and barcode readers"
 	depends on HID
 	default !EXPERT
 	---help---
@@ -235,7 +235,7 @@ config HID_ELO
 	different devices than those handled by CONFIG_TOUCHSCREEN_USB_ELO.
 
 config HID_EZKEY
-	tristate "Ezkey BTC 8193 keyboard" if EXPERT
+	tristate "Ezkey BTC 8193 keyboard"
 	depends on HID
 	default !EXPERT
 	---help---
@@ -334,7 +334,7 @@ config HID_TWINHAN
 	Support for Twinhan IR remote control.
 
 config HID_KENSINGTON
-	tristate "Kensington Slimblade Trackball" if EXPERT
+	tristate "Kensington Slimblade Trackball"
 	depends on HID
 	default !EXPERT
 	---help---
@@ -362,7 +362,7 @@ config HID_LENOVO
 	- ThinkPad Compact USB Keyboard with TrackPoint (supports Fn keys)
 
 config HID_LOGITECH
-	tristate "Logitech devices" if EXPERT
+	tristate "Logitech devices"
 	depends on HID
 	default !EXPERT
 	---help---
@@ -451,14 +451,14 @@ config HID_MAGICMOUSE
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
