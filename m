From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH] Input: ucb1400_ts - fix suspend and resume handling
Date: Thu, 31 Aug 2017 18:27:38 -0700
Message-ID: <20170901012738.GA1286@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:38456 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751109AbdIAB1m (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 31 Aug 2017 21:27:42 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Anton Volkov <avolkov@ispras.ru>

Instead of stopping the touchscreen we were starting it in suspend, and
disabling it in resume.

Fixes: c899afedf168 ("Input: ucb1400_ts - convert to threaded IRQ")
Reported-by: Anton Volkov <avolkov@ispras.ru>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/touchscreen/ucb1400_ts.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/ucb1400_ts.c b/drivers/input/touchscreen/ucb1400_ts.c
index c1e23cfc6155..1a86cbd9326f 100644
--- a/drivers/input/touchscreen/ucb1400_ts.c
+++ b/drivers/input/touchscreen/ucb1400_ts.c
@@ -414,7 +414,7 @@ static int __maybe_unused ucb1400_ts_suspend(struct device *dev)
 	mutex_lock(&idev->mutex);
 
 	if (idev->users)
-		ucb1400_ts_start(ucb);
+		ucb1400_ts_stop(ucb);
 
 	mutex_unlock(&idev->mutex);
 	return 0;
@@ -428,7 +428,7 @@ static int __maybe_unused ucb1400_ts_resume(struct device *dev)
 	mutex_lock(&idev->mutex);
 
 	if (idev->users)
-		ucb1400_ts_stop(ucb);
+		ucb1400_ts_start(ucb);
 
 	mutex_unlock(&idev->mutex);
 	return 0;
-- 
2.14.1.581.gf28d330327-goog


-- 
Dmitry
