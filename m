From: Andrew Drake <adrake@adrake.org>
Subject: [PATCH v2] Input: bcm5974: Add support for newer MacBookPro8,2
Date: Tue, 16 Aug 2011 03:23:52 -0700
Message-ID: <4E4A4538.4050608@adrake.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch1ehsobe005.messaging.microsoft.com ([216.32.181.185]:59715
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751624Ab1HPKX7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 16 Aug 2011 06:23:59 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: rydberg@euromail.se, Dmitry Torokhov <dmitry.torokhov@gmail.com>, gaowanlong@cn.fujitsu.com

New MacBook Pro devices reporting product name MacBookPro8,2 come with
newer/higher resolution touchpads than others with the same product
name with USB ID 05ac:0252. This patch adds support for these devices.

Signed-off-by: Andrew Drake <adrake@adrake.org>
Reviewed-by: Wanlong Gao <gaowanlong@cn.fujitsu.com>
---
 drivers/input/mouse/bcm5974.c |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/drivers/input/mouse/bcm5974.c b/drivers/input/mouse/bcm5974.c
index 48d9ec1..da28018 100644
--- a/drivers/input/mouse/bcm5974.c
+++ b/drivers/input/mouse/bcm5974.c
@@ -71,6 +71,10 @@
 #define USB_DEVICE_ID_APPLE_WELLSPRING6_ANSI	0x024c
 #define USB_DEVICE_ID_APPLE_WELLSPRING6_ISO	0x024d
 #define USB_DEVICE_ID_APPLE_WELLSPRING6_JIS	0x024e
+/* Macbook8,2 (unibody) */
+#define USB_DEVICE_ID_APPLE_WELLSPRING5A_ANSI	0x0252
+#define USB_DEVICE_ID_APPLE_WELLSPRING5A_ISO	0x0253
+#define USB_DEVICE_ID_APPLE_WELLSPRING5A_JIS	0x0254
 
 #define BCM5974_DEVICE(prod) {					\
 	.match_flags = (USB_DEVICE_ID_MATCH_DEVICE |		\
@@ -112,6 +116,10 @@ static const struct usb_device_id bcm5974_table[] = {
 	BCM5974_DEVICE(USB_DEVICE_ID_APPLE_WELLSPRING6_ANSI),
 	BCM5974_DEVICE(USB_DEVICE_ID_APPLE_WELLSPRING6_ISO),
 	BCM5974_DEVICE(USB_DEVICE_ID_APPLE_WELLSPRING6_JIS),
+	/* MacbookPro8,2 */
+	BCM5974_DEVICE(USB_DEVICE_ID_APPLE_WELLSPRING5A_ANSI),
+	BCM5974_DEVICE(USB_DEVICE_ID_APPLE_WELLSPRING5A_ISO),
+	BCM5974_DEVICE(USB_DEVICE_ID_APPLE_WELLSPRING5A_JIS),
 	/* Terminating entry */
 	{}
 };
@@ -314,6 +322,18 @@ static const struct bcm5974_config bcm5974_config_table[] = {
 		{ DIM_X, DIM_X / SN_COORD, -4620, 5140 },
 		{ DIM_Y, DIM_Y / SN_COORD, -150, 6600 }
 	},
+	{
+		USB_DEVICE_ID_APPLE_WELLSPRING5A_ANSI,
+		USB_DEVICE_ID_APPLE_WELLSPRING5A_ISO,
+		USB_DEVICE_ID_APPLE_WELLSPRING5A_JIS,
+		HAS_INTEGRATED_BUTTON,
+		0x84, sizeof(struct bt_data),
+		0x81, TYPE2, FINGER_TYPE2, FINGER_TYPE2 + SIZEOF_ALL_FINGERS,
+		{ DIM_PRESSURE, DIM_PRESSURE / SN_PRESSURE, 0, 300 },
+		{ DIM_WIDTH, DIM_WIDTH / SN_WIDTH, 0, 2048 },
+		{ DIM_X, DIM_X / SN_COORD, -4750, 5280 },
+		{ DIM_Y, DIM_Y / SN_COORD, -150, 6730 }
+	},
 	{}
 };
 
-- 
1.7.6


