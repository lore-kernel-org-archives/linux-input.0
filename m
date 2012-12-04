From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: [PATCH 03/14] HID: i2c-hid: enhance Kconfig
Date: Tue,  4 Dec 2012 16:27:44 +0100
Message-ID: <1354634875-5182-4-git-send-email-benjamin.tissoires@gmail.com>
References: <1354634875-5182-1-git-send-email-benjamin.tissoires@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1354634875-5182-1-git-send-email-benjamin.tissoires@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>, Jiri Kosina <jkosina@suse.cz>, Jean Delvare <khali@linux-fr.org>, linux-input@vger.kernel.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

The "comment" part can never be displayed, so we can remove it.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@gmail.com>
---
 drivers/hid/i2c-hid/Kconfig | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/hid/i2c-hid/Kconfig b/drivers/hid/i2c-hid/Kconfig
index 5b7d4d8..64ce108 100644
--- a/drivers/hid/i2c-hid/Kconfig
+++ b/drivers/hid/i2c-hid/Kconfig
@@ -7,15 +7,12 @@ config I2C_HID
 	depends on I2C && INPUT
 	select HID
 	---help---
-	  Say Y here if you want to use the HID over i2c protocol
-	  implementation.
+	  Say Y here if you use a keyboard, a touchpad, a touchscreen, or any
+	  other HID based devices which is connected to your computer via I2C.
 
 	  If unsure, say N.
 
 	  This support is also available as a module.  If so, the module
 	  will be called i2c-hid.
 
-comment "Input core support is needed for HID over I2C input layer"
-	depends on I2C_HID && INPUT=n
-
 endmenu
-- 
1.8.0.1
