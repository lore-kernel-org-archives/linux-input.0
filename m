From: Vipul Kumar Samar <vipulkumar.samar@st.com>
Subject: [PATCH] input:stmpe-ts: Add support to report BTN_TOUCH event
Date: Thu, 13 Dec 2012 10:57:10 +0530
Message-ID: <7c50ed5f531db8ab992ebeaf1a48853a6274faf2.1355376050.git.vipulkumar.samar@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from eu1sys200aog109.obsmtp.com ([207.126.144.127]:52098 "EHLO
	eu1sys200aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750708Ab2LMF1f (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 13 Dec 2012 00:27:35 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, spear-devel@list.st.com, lee.jones@linaro.org, viresh.kumar@linaro.org, shiraz.hashim@st.com, Vipul Kumar Samar <vipulkumar.samar@st.com>

stmpe touchscreen supports BTN_TOUCH event but doesn't report it. Add
BTN_TOUCH reporting capability to the stmpe touchscreen driver.

Signed-off-by: Vipul Kumar Samar <vipulkumar.samar@st.com>
---
 drivers/input/touchscreen/stmpe-ts.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/input/touchscreen/stmpe-ts.c b/drivers/input/touchscreen/stmpe-ts.c
index 076442a..c3399a1 100644
--- a/drivers/input/touchscreen/stmpe-ts.c
+++ b/drivers/input/touchscreen/stmpe-ts.c
@@ -121,6 +121,7 @@ static void stmpe_work(struct work_struct *work)
 	__stmpe_reset_fifo(ts->stmpe);
 
 	input_report_abs(ts->idev, ABS_PRESSURE, 0);
+	input_report_key(ts->idev, BTN_TOUCH, 0);
 	input_sync(ts->idev);
 }
 
@@ -154,6 +155,7 @@ static irqreturn_t stmpe_ts_handler(int irq, void *data)
 	input_report_abs(ts->idev, ABS_X, x);
 	input_report_abs(ts->idev, ABS_Y, y);
 	input_report_abs(ts->idev, ABS_PRESSURE, z);
+	input_report_key(ts->idev, BTN_TOUCH, 1);
 	input_sync(ts->idev);
 
        /* flush the FIFO after we have read out our values. */
-- 
1.7.2.2

