From: Nick Dyer <nick@shmanahar.org>
Subject: [PATCH v1 02/10] Input: atmel_mxt_ts - use BIT() macro everywhere
Date: Fri, 20 Jul 2018 22:51:14 +0100
Message-ID: <20180720215122.23558-2-nick@shmanahar.org>
References: <20180720215122.23558-1-nick@shmanahar.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180720215122.23558-1-nick@shmanahar.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Chris Healy <cphealy@gmail.com>, Nikita Yushchenko <nikita.yoush@cogentembedded.com>, Lucas Stach <l.stach@pengutronix.de>, Nick Dyer <nick.dyer@itdev.co.uk>
List-Id: linux-input@vger.kernel.org

From: Nick Dyer <nick.dyer@itdev.co.uk>

Signed-off-by: Nick Dyer <nick.dyer@itdev.co.uk>
---
 drivers/input/touchscreen/atmel_mxt_ts.c | 36 ++++++++++++------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index 48c5ccab00a0..9555947a2d46 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -88,12 +88,12 @@
 #define MXT_COMMAND_DIAGNOSTIC	5
 
 /* Define for T6 status byte */
-#define MXT_T6_STATUS_RESET	(1 << 7)
-#define MXT_T6_STATUS_OFL	(1 << 6)
-#define MXT_T6_STATUS_SIGERR	(1 << 5)
-#define MXT_T6_STATUS_CAL	(1 << 4)
-#define MXT_T6_STATUS_CFGERR	(1 << 3)
-#define MXT_T6_STATUS_COMSERR	(1 << 2)
+#define MXT_T6_STATUS_RESET	BIT(7)
+#define MXT_T6_STATUS_OFL	BIT(6)
+#define MXT_T6_STATUS_SIGERR	BIT(5)
+#define MXT_T6_STATUS_CAL	BIT(4)
+#define MXT_T6_STATUS_CFGERR	BIT(3)
+#define MXT_T6_STATUS_COMSERR	BIT(2)
 
 /* MXT_GEN_POWER_T7 field */
 struct t7_config {
@@ -112,14 +112,14 @@ struct t7_config {
 #define MXT_T9_RANGE		18
 
 /* MXT_TOUCH_MULTI_T9 status */
-#define MXT_T9_UNGRIP		(1 << 0)
-#define MXT_T9_SUPPRESS		(1 << 1)
-#define MXT_T9_AMP		(1 << 2)
-#define MXT_T9_VECTOR		(1 << 3)
-#define MXT_T9_MOVE		(1 << 4)
-#define MXT_T9_RELEASE		(1 << 5)
-#define MXT_T9_PRESS		(1 << 6)
-#define MXT_T9_DETECT		(1 << 7)
+#define MXT_T9_UNGRIP		BIT(0)
+#define MXT_T9_SUPPRESS		BIT(1)
+#define MXT_T9_AMP		BIT(2)
+#define MXT_T9_VECTOR		BIT(3)
+#define MXT_T9_MOVE		BIT(4)
+#define MXT_T9_RELEASE		BIT(5)
+#define MXT_T9_PRESS		BIT(6)
+#define MXT_T9_DETECT		BIT(7)
 
 struct t9_range {
 	__le16 x;
@@ -127,9 +127,9 @@ struct t9_range {
 } __packed;
 
 /* MXT_TOUCH_MULTI_T9 orient */
-#define MXT_T9_ORIENT_SWITCH	(1 << 0)
-#define MXT_T9_ORIENT_INVERTX	(1 << 1)
-#define MXT_T9_ORIENT_INVERTY	(1 << 2)
+#define MXT_T9_ORIENT_SWITCH	BIT(0)
+#define MXT_T9_ORIENT_INVERTX	BIT(1)
+#define MXT_T9_ORIENT_INVERTY	BIT(2)
 
 /* MXT_SPT_COMMSCONFIG_T18 */
 #define MXT_COMMS_CTRL		0
@@ -214,7 +214,7 @@ enum t100_type {
 #define MXT_FRAME_CRC_PASS	0x04
 #define MXT_APP_CRC_FAIL	0x40	/* valid 7 8 bit only */
 #define MXT_BOOT_STATUS_MASK	0x3f
-#define MXT_BOOT_EXTENDED_ID	(1 << 5)
+#define MXT_BOOT_EXTENDED_ID	BIT(5)
 #define MXT_BOOT_ID_MASK	0x1f
 
 /* Touchscreen absolute values */
-- 
2.17.1
