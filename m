From: Franklin S Cooper Jr <fcooper@ti.com>
Subject: [PATCH 1/4] Input: edt-ft5x06 - Use max support points to determine how much to read
Date: Fri, 16 Oct 2015 09:14:26 -0500
Message-ID: <1445004869-31986-2-git-send-email-fcooper@ti.com>
References: <1445004869-31986-1-git-send-email-fcooper@ti.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1445004869-31986-1-git-send-email-fcooper@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, maxime.ripard@free-electrons.com, LW@KARO-electronics.de, jg1.han@samsung.com, asaf.vertz@tandemg.com
Cc: Franklin S Cooper Jr <fcooper@ti.com>
List-Id: linux-input@vger.kernel.org

Calculate the amount of data that needs to be read for the specified max
number of support points. If the maximum number of support points changes
then the amount that is read from the touch screen controller should
reflect this.

Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
---
Changes since RFC:
Added crclen variable
Simplified datalen algorithm

 drivers/input/touchscreen/edt-ft5x06.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touchscreen/edt-ft5x06.c
index a8640c7..e5b0b5d 100644
--- a/drivers/input/touchscreen/edt-ft5x06.c
+++ b/drivers/input/touchscreen/edt-ft5x06.c
@@ -168,9 +168,9 @@ static irqreturn_t edt_ft5x06_ts_isr(int irq, void *dev_id)
 	struct edt_ft5x06_ts_data *tsdata = dev_id;
 	struct device *dev = &tsdata->client->dev;
 	u8 cmd;
-	u8 rdbuf[29];
+	u8 rdbuf[31];
 	int i, type, x, y, id;
-	int offset, tplen, datalen;
+	int offset, tplen, datalen, crclen;
 	int error;
 
 	switch (tsdata->version) {
@@ -178,14 +178,18 @@ static irqreturn_t edt_ft5x06_ts_isr(int irq, void *dev_id)
 		cmd = 0xf9; /* tell the controller to send touch data */
 		offset = 5; /* where the actual touch data starts */
 		tplen = 4;  /* data comes in so called frames */
-		datalen = 26; /* how much bytes to listen for */
+		crclen = 1; /* length of the crc data */
+
+		/* how many bytes to listen for */
+		datalen = tplen * MAX_SUPPORT_POINTS + offset + crclen;
 		break;
 
 	case M09:
 		cmd = 0x02;
 		offset = 1;
 		tplen = 6;
-		datalen = 29;
+		crclen = 0;
+		datalen = tplen * MAX_SUPPORT_POINTS + offset + crclen;
 		break;
 
 	default:
-- 
2.6.1
