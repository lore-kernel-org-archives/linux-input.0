From: Daniel Nicoletti <dantti12@gmail.com>
Subject: [PATCH] HID: Allow HID_BATTERY_STRENGTH to be enabled
Date: Tue,  9 Dec 2014 10:28:54 -0200
Message-ID: <1418128134-7997-1-git-send-email-dantti12@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jkosina@suse.cz
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Daniel Nicoletti <dantti12@gmail.com>
List-Id: linux-input@vger.kernel.org

Allows for HID_BATTERY_STRENGTH config be enabled
without the need for HID module to be built-in,
prior to this HID and POWER_SUPPLY had to be
equal, and now we only select POWER_SUPPLY and
depend on the HID module.

Signed-off-by: Daniel Nicoletti <dantti12@gmail.com>
---
 drivers/hid/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index f42df4d..602ac07 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -27,7 +27,8 @@ if HID
 
 config HID_BATTERY_STRENGTH
 	bool "Battery level reporting for HID devices"
-	depends on HID && POWER_SUPPLY && HID = POWER_SUPPLY
+	depends on HID
+	select POWER_SUPPLY
 	default n
 	---help---
 	This option adds support of reporting battery strength (for HID devices
-- 
2.1.0
