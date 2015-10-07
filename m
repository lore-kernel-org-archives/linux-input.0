From: fcooper@ti.com
Subject: [RFC 1/4] Input: edt-ft5x06 - Use max support points to determine how much to read
Date: Wed,  7 Oct 2015 07:21:38 -0500
Message-ID: <1444220501-23623-2-git-send-email-fcooper@ti.com>
References: <1444220501-23623-1-git-send-email-fcooper@ti.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1444220501-23623-1-git-send-email-fcooper@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, fcooper@ti.com, maxime.ripard@free-electrons.com, LW@KARO-electronics.de, jg1.han@samsung.com, asaf.vertz@tandemg.com
List-Id: linux-input@vger.kernel.org

From: Franklin S Cooper Jr <fcooper@ti.com>

Calculate the amount of data that needs to be read for the specified max
number of support points. If the maximum number of support points changes
then the amount that is read from the touch screen controller should
reflect this.

Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
---
 drivers/input/touchscreen/edt-ft5x06.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touchscreen/edt-ft5x06.c
index 7239c31..1e0ed6e 100644
--- a/drivers/input/touchscreen/edt-ft5x06.c
+++ b/drivers/input/touchscreen/edt-ft5x06.c
@@ -178,14 +178,16 @@ static irqreturn_t edt_ft5x06_ts_isr(int irq, void *dev_id)
 		cmd = 0xf9; /* tell the controller to send touch data */
 		offset = 5; /* where the actual touch data starts */
 		tplen = 4;  /* data comes in so called frames */
-		datalen = 26; /* how much bytes to listen for */
+
+		/* how many bytes to listen for */
+		datalen = tplen * MAX_SUPPORT_POINTS + offset + 1;
 		break;
 
 	case M09:
 		cmd = 0x02;
 		offset = 1;
 		tplen = 6;
-		datalen = 29;
+		datalen = tplen * MAX_SUPPORT_POINTS - cmd + 1;
 		break;
 
 	default:
-- 
2.6.1
