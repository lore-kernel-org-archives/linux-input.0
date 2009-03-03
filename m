From: Mike Rapoport <mike@compulab.co.il>
Subject: [PATCH] Input: add BTN_TOUCH event (Was: [PATCH RESEND] Input: wm97xx:
 add BTN_TOUCH event to wm97xx)
Date: Tue, 03 Mar 2009 10:27:54 +0200
Message-ID: <49ACEA0A.7040906@compulab.co.il>
References: <49ABE938.8040502@compulab.co.il> <20090302142838.GA23342@rakim.wolfsonmicro.main> <49AC0677.7040102@compulab.co.il> <20090302162151.GA24717@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cathcart.site5.com ([74.54.107.137]:36502 "EHLO
	cathcart.site5.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751664AbZCCI17 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 3 Mar 2009 03:27:59 -0500
In-Reply-To: <20090302162151.GA24717@rakim.wolfsonmicro.main>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: dmitry.torokhov@gmail.com, LKML <linux-kernel@vger.kernel.org>, linux-input <linux-input@vger.kernel.org>

Mark Brown wrote:
> On Mon, Mar 02, 2009 at 06:16:55PM +0200, Mike Rapoport wrote:
> 
>> Most touchscreen drivers already have BTN_TOUCH event generation:
> 
> Hrm, I'd found some other hits but I could well have been working on a
> platform tree with additional drivers merged at the time.
> 
>> If there no objection I can make a similar patch for mainstone-wm97xx.c and ucb1400_ts.c

Add BTN_TOUCH event reporting to ucb1400_ts and accelerated mainstone-wm97xx
touchscreen drivers. Together with previously posted similar patch for
wm97xx-core this will make all touchscreen drivers behave consistently wrt.
BTN_TOUCH.


Signed-off-by: Mike Rapoport <mike@compulab.co.il>

 drivers/input/touchscreen/mainstone-wm97xx.c |    1 +
 drivers/input/touchscreen/ucb1400_ts.c       |    5 ++++-
 2 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/drivers/input/touchscreen/mainstone-wm97xx.c b/drivers/input/touchscreen/mainstone-wm97xx.c
index 1d11e2b..4d49690 100644
--- a/drivers/input/touchscreen/mainstone-wm97xx.c
+++ b/drivers/input/touchscreen/mainstone-wm97xx.c
@@ -162,6 +162,7 @@ static int wm97xx_acc_pen_down(struct wm97xx *wm)
 		input_report_abs(wm->input_dev, ABS_X, x & 0xfff);
 		input_report_abs(wm->input_dev, ABS_Y, y & 0xfff);
 		input_report_abs(wm->input_dev, ABS_PRESSURE, p & 0xfff);
+		input_report_key(wm->input_dev, BTN_TOUCH, (p != 0));
 		input_sync(wm->input_dev);
 		reads++;
 	} while (reads < cinfo[sp_idx].reads);
diff --git a/drivers/input/touchscreen/ucb1400_ts.c b/drivers/input/touchscreen/ucb1400_ts.c
index 5498662..e868264 100644
--- a/drivers/input/touchscreen/ucb1400_ts.c
+++ b/drivers/input/touchscreen/ucb1400_ts.c
@@ -151,12 +151,14 @@ static void ucb1400_ts_evt_add(struct input_dev *idev, u16 pressure, u16 x, u16
 	input_report_abs(idev, ABS_X, x);
 	input_report_abs(idev, ABS_Y, y);
 	input_report_abs(idev, ABS_PRESSURE, pressure);
+	input_report_key(idev, BTN_TOUCH, 1);
 	input_sync(idev);
 }

 static void ucb1400_ts_event_release(struct input_dev *idev)
 {
 	input_report_abs(idev, ABS_PRESSURE, 0);
+	input_report_key(idev, BTN_TOUCH, 0);
 	input_sync(idev);
 }

@@ -377,7 +379,8 @@ static int ucb1400_ts_probe(struct platform_device *dev)
 	ucb->ts_idev->id.product	= ucb->id;
 	ucb->ts_idev->open		= ucb1400_ts_open;
 	ucb->ts_idev->close		= ucb1400_ts_close;
-	ucb->ts_idev->evbit[0]		= BIT_MASK(EV_ABS);
+	ucb->ts_idev->evbit[0]		= BIT_MASK(EV_ABS) | BIT_MASK(EV_KEY);
+	ucb->ts_idev->keybit[BIT_WORD(BTN_TOUCH)] = BIT_MASK(BTN_TOUCH);

 	ucb1400_adc_enable(ucb->ac97);
 	x_res = ucb1400_ts_read_xres(ucb);


-- 
Sincerely yours,
Mike.



