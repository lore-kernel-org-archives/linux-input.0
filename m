From: Dan Carpenter <error27@gmail.com>
Subject: [patch 1/2] input/tps6507x-ts: dereferencing before checking
Date: Mon, 31 May 2010 14:01:22 +0200
Message-ID: <20100531120122.GR5483@bicker>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ew0-f216.google.com ([209.85.219.216]:61098 "EHLO
	mail-ew0-f216.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751691Ab0EaMBi (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 31 May 2010 08:01:38 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Todd Fischer <todd.fischer@ridgerun.com>, Samuel Ortiz <sameo@linux.intel.com>, linux-input@vger.kernel.org, kernel-janitors@vger.kernel.org

This patch moves the dereference after the check for NULL.

Signed-off-by: Dan Carpenter <error27@gmail.com>

diff --git a/drivers/input/touchscreen/tps6507x-ts.c b/drivers/input/touchscreen/tps6507x-ts.c
index 5de80a1..b99db09 100644
--- a/drivers/input/touchscreen/tps6507x-ts.c
+++ b/drivers/input/touchscreen/tps6507x-ts.c
@@ -355,10 +355,11 @@ static int __devexit tps6507x_ts_remove(struct platform_device *pdev)
 {
 	struct tps6507x_dev *tps6507x_dev = platform_get_drvdata(pdev);
 	struct tps6507x_ts *tsc = tps6507x_dev->ts;
-	struct input_dev *input_dev = tsc->input_dev;
+	struct input_dev *input_dev;
 
 	if (!tsc)
 		return 0;
+	input_dev = tsc->input_dev;
 
 	cancel_delayed_work(&tsc->work);
 	flush_workqueue(tsc->wq);
