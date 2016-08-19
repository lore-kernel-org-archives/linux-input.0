From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH] Input: jornada720_kbd - switch to using dev_dbg
Date: Fri, 19 Aug 2016 10:07:47 -0700
Message-ID: <20160819170747.GA23763@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Russell King <rmk+kernel@armlinux.org.uk>, Kristoffer Ericson <kristoffer.ericson@gmail.com>, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Switch to using dev_dbg instead of naked printk so that output is uniform
with the other driver messages in the kernel.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/keyboard/jornada720_kbd.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/input/keyboard/jornada720_kbd.c b/drivers/input/keyboard/jornada720_kbd.c
index 6483404..fd8e15e 100644
--- a/drivers/input/keyboard/jornada720_kbd.c
+++ b/drivers/input/keyboard/jornada720_kbd.c
@@ -65,10 +65,8 @@ static irqreturn_t jornada720_kbd_interrupt(int irq, void *dev_id)
 	jornada_ssp_start();
 
 	if (jornada_ssp_inout(GETSCANKEYCODE) != TXDUMMY) {
-		printk(KERN_DEBUG
-			"jornada720_kbd: "
-			"GetKeycode command failed with ETIMEDOUT, "
-			"flushed bus\n");
+		dev_dbg(&pdev->dev,
+			"GetKeycode command failed with ETIMEDOUT, flushed bus\n");
 	} else {
 		/* How many keycodes are waiting for us? */
 		count = jornada_ssp_byte(TXDUMMY);
-- 
2.8.0.rc3.226.g39d4020


-- 
Dmitry
