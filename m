From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: [PATCH] HID: plantronics: fix Kconfig default
Date: Sun, 1 Feb 2015 20:42:04 +0100
Message-ID: <20150201204204.76467dec@kant>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

This driver didn't exist until before v3.19.
Why would suddenly everybody want to build it?

Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>
---
 drivers/hid/Kconfig |    1 -
 1 file changed, 1 deletion(-)

--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -628,7 +628,6 @@ config HID_PICOLCD_CIR
 
 config HID_PLANTRONICS
 	tristate "Plantronics USB HID Driver"
-	default !EXPERT
 	depends on HID
 	---help---
 	Provides HID support for Plantronics telephony devices.


-- 
Stefan Richter
-=====-===== --=- ----=
http://arcgraph.de/sr/
