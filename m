From: Frank Praznik <frank.praznik@oh.rr.com>
Subject: [PATCH] HID: Kconfig updates for the Sony module
Date: Sat,  1 Feb 2014 10:39:58 -0500
Message-ID: <1391269198-8210-1-git-send-email-frank.praznik@oh.rr.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:50905 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751944AbaBAPkJ (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 1 Feb 2014 10:40:09 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, Frank Praznik <frank.praznik@oh.rr.com>

Update the HID_SONY config with 'select POWER_SUPPLY' to fix build issues
relating to undefined references to the  power_supply_* functions in
certain build configurations.

Update the description text to reflect that Playstation 4 controllers are now
supported.

Signed-off-by: Frank Praznik <frank.praznik@oh.rr.com>

---

 Apply to jikos/hid.git/for-3.15/sony
 
 This should fix the errors that the buildbot was reporting.

 drivers/hid/Kconfig | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index f722001..0e4cdc2 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -608,25 +608,27 @@ config HID_SAMSUNG
 	Support for Samsung InfraRed remote control or keyboards.
 
 config HID_SONY
-	tristate "Sony PS2/3 accessories"
+	tristate "Sony PS2/3/4 accessories"
 	depends on USB_HID
 	depends on NEW_LEDS
 	depends on LEDS_CLASS
+	select POWER_SUPPLY
 	---help---
 	Support for
 
 	  * Sony PS3 6-axis controllers
+	  * Sony PS4 DualShock 4 controllers
 	  * Buzz controllers
 	  * Sony PS3 Blue-ray Disk Remote Control (Bluetooth)
 	  * Logitech Harmony adapter for Sony Playstation 3 (Bluetooth)
 
 config SONY_FF
-	bool "Sony PS2/3 accessories force feedback support"
+	bool "Sony PS2/3/4 accessories force feedback support"
 	depends on HID_SONY
 	select INPUT_FF_MEMLESS
 	---help---
-	Say Y here if you have a Sony PS2/3 accessory and want to enable force
-	feedback support for it.
+	Say Y here if you have a Sony PS2/3/4 accessory and want to enable
+	force feedback support for it.
 
 config HID_SPEEDLINK
 	tristate "Speedlink VAD Cezanne mouse support"
-- 
1.8.5.3

