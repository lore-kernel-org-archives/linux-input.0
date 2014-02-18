From: Jiri Kosina <jkosina@suse.cz>
Subject: [PATCH] HID: cp2112: can't be used without gpio support
Date: Tue, 18 Feb 2014 09:55:00 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1402180953220.1192@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:56264 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754057AbaBRIzF (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 18 Feb 2014 03:55:05 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Barksdale <dbarksdale@uplogix.com>
Cc: linux-input@vger.kernel.org, fengguang.wu@intel.com

Add Kconfig driver dependency on GPIOLIB.

Reported-by: fengguang.wu@intel.com
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
---
 drivers/hid/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 5eaf0db..669cc19 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -177,7 +177,7 @@ config HID_PRODIKEYS
 
 config HID_CP2112
 	tristate "Silicon Labs CP2112 HID USB-to-SMBus Bridge support"
-	depends on USB_HID && I2C
+	depends on USB_HID && I2C && GPIOLIB
 	---help---
 	Support for Silicon Labs CP2112 HID USB to SMBus Master Bridge.
 	This is a HID device driver which registers as an i2c adapter
-- 
Jiri Kosina
SUSE Labs
