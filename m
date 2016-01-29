From: Stefan Agner <stefan@agner.ch>
Subject: [PATCH v2 2/3] input: touchscreen: ad7879: fix default x/y axis assignment
Date: Fri, 29 Jan 2016 15:48:14 -0800
Message-ID: <1454111295-5615-2-git-send-email-stefan@agner.ch>
References: <1454111295-5615-1-git-send-email-stefan@agner.ch>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1454111295-5615-1-git-send-email-stefan@agner.ch>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com, michael.hennerich@analog.com, robh+dt@kernel.org
Cc: mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, realmz6@gmail.com, broonie@kernel.org, jic23@kernel.org, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Stefan Agner <stefan@agner.ch>
List-Id: linux-input@vger.kernel.org

The X/Y position measurements read from the controller are interpreted
wrong. The first measurement X+ contains the Y position, and the second
measurement Y+ the X position (see also Table 11 Register Table in the
data sheet).

The problem is already known and a swap option has been introduced:
commit 6680884a4420 ("Input: ad7879 - add option to correct xy axis")

However, the meaning of the new boolean is inverted since the underlying
values are already swapped. Let ts->swap_xy set to true actually be the
swapped configuration of the two axis.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
Changes since v1:
- Keep axis swapped by default when using platform data

 drivers/input/touchscreen/ad7879.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/input/touchscreen/ad7879.c b/drivers/input/touchscreen/ad7879.c
index 93b8ea2..abd0220 100644
--- a/drivers/input/touchscreen/ad7879.c
+++ b/drivers/input/touchscreen/ad7879.c
@@ -94,8 +94,8 @@
 #define AD7879_TEMP_BIT			(1<<1)
 
 enum {
-	AD7879_SEQ_XPOS  = 0,
-	AD7879_SEQ_YPOS  = 1,
+	AD7879_SEQ_YPOS  = 0,
+	AD7879_SEQ_XPOS  = 1,
 	AD7879_SEQ_Z1    = 2,
 	AD7879_SEQ_Z2    = 3,
 	AD7879_NR_SENSE  = 4,
@@ -517,7 +517,9 @@ struct ad7879 *ad7879_probe(struct device *dev, u8 devid, unsigned int irq,
 	ts->dev = dev;
 	ts->input = input_dev;
 	ts->irq = irq;
-	ts->swap_xy = pdata->swap_xy;
+
+	/* Use swapped axis by default (backward compatibility) */
+	ts->swap_xy = !pdata->swap_xy;
 
 	setup_timer(&ts->timer, ad7879_timer, (unsigned long) ts);
 
-- 
2.7.0
