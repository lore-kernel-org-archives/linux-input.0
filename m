From: Franklin S Cooper Jr <fcooper@ti.com>
Subject: [PATCH 4/4] Input: edt-ft5x06 - Work around FT5506 firmware bug
Date: Fri, 16 Oct 2015 09:14:29 -0500
Message-ID: <1445004869-31986-5-git-send-email-fcooper@ti.com>
References: <1445004869-31986-1-git-send-email-fcooper@ti.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1445004869-31986-1-git-send-email-fcooper@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, maxime.ripard@free-electrons.com, LW@KARO-electronics.de, jg1.han@samsung.com, asaf.vertz@tandemg.com
Cc: Franklin S Cooper Jr <fcooper@ti.com>
List-Id: linux-input@vger.kernel.org

In the touchscreen controller ISR, reading the tsc starting from
register 0x2 causes the tsc to infrequently update the detected
finger's x and y coordinate. The irq pin toggles at a fast rate to
indicate touch events are happening. However, the tsc on average
updates the touch point's x and y value every ~100 ms which is much
slower than the advertised rate of 100+ Hz. This leads to multiple reads
within this ~100 ms time window returning the same value.

Example:
X: 10 , Y: 30
X: 10 , Y: 30
X: 10,  Y: 30
..
// After 100 ms
X: 300, Y: 300
X: 300, y: 300
..
// After 100 ms
X: 1743, Y: 621
X: 1743, Y: 621

For some reason if instead of starting to read at register 0x2 you
start reading at register 0x0 this issue isn't seen. This seems like
a quirk only seen in the EDT FT5506 so to fix this issue simply
adjust the code to start reading from 0x0. Technically this isn't wrong
so no regressions should be seen with other touchscreen controllers
supported by this driver.

Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
---
Changes since RFC:
Increase rdbuf to accomodate extra 2 bytes being read.

 drivers/input/touchscreen/edt-ft5x06.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touchscreen/edt-ft5x06.c
index e095838..a8d48e0 100644
--- a/drivers/input/touchscreen/edt-ft5x06.c
+++ b/drivers/input/touchscreen/edt-ft5x06.c
@@ -172,7 +172,7 @@ static irqreturn_t edt_ft5x06_ts_isr(int irq, void *dev_id)
 	struct edt_ft5x06_ts_data *tsdata = dev_id;
 	struct device *dev = &tsdata->client->dev;
 	u8 cmd;
-	u8 rdbuf[61];
+	u8 rdbuf[63];
 	int i, type, x, y, id;
 	int offset, tplen, datalen, crclen;
 	int error;
@@ -189,8 +189,8 @@ static irqreturn_t edt_ft5x06_ts_isr(int irq, void *dev_id)
 		break;
 
 	case M09:
-		cmd = 0x02;
-		offset = 1;
+		cmd = 0x0;
+		offset = 3;
 		tplen = 6;
 		crclen = 0;
 		datalen = tplen * tsdata->max_support_points + offset + crclen;
-- 
2.6.1
