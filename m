From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 11/17] Input: tsc2005 - use true/false for boolean variables
Date: Wed, 16 Mar 2011 00:18:56 -0700
Message-ID: <20110316071856.25664.13228.stgit@hammer.corenet.prv>
References: <20110316071503.25664.55116.stgit@hammer.corenet.prv>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:60566 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752037Ab1CPHTB (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 16 Mar 2011 03:19:01 -0400
Received: by gxk21 with SMTP id 21so543968gxk.19
        for <linux-input@vger.kernel.org>; Wed, 16 Mar 2011 00:19:01 -0700 (PDT)
In-Reply-To: <20110316071503.25664.55116.stgit@hammer.corenet.prv>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Srikar <ext-srikar.1.bhavanarayana@nokia.com>, Phil Carmody <ext-phil.2.carmody@nokia.com>, Aaro Koskinen <aaro.koskinen@nokia.com>
Cc: linux-input@vger.kernel.org, lauri.leukkunen@nokia.com, David Brownell <dbrownell@users.sourceforge.net>, Imre Deak <imre.deak@nokia.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Ari Kauppi <Ext-Ari.Kauppi@nokia.com>, Tony Lindgren <tony@atomide.com>, Jarkko Nikula <jhnikula@gmail.com>, Eero Nurkkala <ext-eero.nurkkala@nokia.com>, Roman Tereshonkov <roman.tereshonkov@nokia.com>

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/touchscreen/tsc2005.c |   25 +++++++++++++------------
 1 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/input/touchscreen/tsc2005.c b/drivers/input/touchscreen/tsc2005.c
index 4f1c041..bfcff96 100644
--- a/drivers/input/touchscreen/tsc2005.c
+++ b/drivers/input/touchscreen/tsc2005.c
@@ -140,7 +140,8 @@ struct tsc2005 {
 
 	bool			disabled;
 	unsigned int		disable_depth;
-	unsigned int		pen_down;
+
+	bool			pen_down;
 
 	void			(*set_reset)(bool enable);
 };
@@ -197,7 +198,7 @@ static void tsc2005_read(struct tsc2005 *ts, u8 reg, u16 *value)
 	struct spi_message msg;
 	struct tsc2005_spi_rd spi_rd = { { 0 }, 0, 0 };
 
-	tsc2005_setup_read(&spi_rd, reg, 1);
+	tsc2005_setup_read(&spi_rd, reg, true);
 
 	spi_message_init(&msg);
 	spi_message_add_tail(&spi_rd.spi_xfer, &msg);
@@ -214,13 +215,13 @@ static void tsc2005_update_pen_state(struct tsc2005 *ts,
 		input_report_abs(ts->idev, ABS_PRESSURE, pressure);
 		if (!ts->pen_down) {
 			input_report_key(ts->idev, BTN_TOUCH, !!pressure);
-			ts->pen_down = 1;
+			ts->pen_down = true;
 		}
 	} else {
 		input_report_abs(ts->idev, ABS_PRESSURE, 0);
 		if (ts->pen_down) {
 			input_report_key(ts->idev, BTN_TOUCH, 0);
-			ts->pen_down = 0;
+			ts->pen_down = false;
 		}
 	}
 	input_sync(ts->idev);
@@ -429,9 +430,9 @@ static ssize_t tsc2005_selftest_show(struct device *dev,
 	}
 
 	/* hardware reset */
-	ts->set_reset(0);
+	ts->set_reset(false);
 	usleep_range(100, 500); /* only 10us required */
-	ts->set_reset(1);
+	ts->set_reset(true);
 	tsc2005_enable(ts);
 
 	/* test that the reset really happened */
@@ -500,10 +501,10 @@ static void tsc2005_esd_work(struct work_struct *work)
 	tsc2005_read(ts, TSC2005_REG_CFR0, &r);
 	if ((r ^ TSC2005_CFR0_INITVALUE) & TSC2005_CFR0_RW_MASK) {
 		dev_info(&ts->spi->dev, "TSC2005 not responding - resetting\n");
-		ts->set_reset(0);
+		ts->set_reset(false);
 		tsc2005_update_pen_state(ts, 0, 0, 0);
 		usleep_range(100, 500); /* only 10us required */
-		ts->set_reset(1);
+		ts->set_reset(true);
 		tsc2005_start_scan(ts);
 	}
 
@@ -517,10 +518,10 @@ out:
 
 static void __devinit tsc2005_setup_spi_xfer(struct tsc2005 *ts)
 {
-	tsc2005_setup_read(&ts->spi_x, TSC2005_REG_X, 0);
-	tsc2005_setup_read(&ts->spi_y, TSC2005_REG_Y, 0);
-	tsc2005_setup_read(&ts->spi_z1, TSC2005_REG_Z1, 0);
-	tsc2005_setup_read(&ts->spi_z2, TSC2005_REG_Z2, 1);
+	tsc2005_setup_read(&ts->spi_x, TSC2005_REG_X, false);
+	tsc2005_setup_read(&ts->spi_y, TSC2005_REG_Y, false);
+	tsc2005_setup_read(&ts->spi_z1, TSC2005_REG_Z1, false);
+	tsc2005_setup_read(&ts->spi_z2, TSC2005_REG_Z2, true);
 
 	spi_message_init(&ts->spi_read_msg);
 	spi_message_add_tail(&ts->spi_x.spi_xfer, &ts->spi_read_msg);

