From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 1/2] Input: stmpe-ts - remove input_free_device() in
	stmpe_ts_remove()
Date: Fri, 03 Sep 2010 09:30:51 +0800
Message-ID: <1283477451.5439.6.camel@mola>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Luotao Fu <l.fu@pengutronix.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

No need to call input_free_device() after input_unregister_device().

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 drivers/input/touchscreen/stmpe-ts.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/input/touchscreen/stmpe-ts.c b/drivers/input/touchscreen/stmpe-ts.c
index 656148e..0339d1d 100644
--- a/drivers/input/touchscreen/stmpe-ts.c
+++ b/drivers/input/touchscreen/stmpe-ts.c
@@ -361,7 +361,6 @@ static int __devexit stmpe_ts_remove(struct platform_device *pdev)
 	platform_set_drvdata(pdev, NULL);
 
 	input_unregister_device(ts->idev);
-	input_free_device(ts->idev);
 
 	kfree(ts);
 
-- 
1.7.2
