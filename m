From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH] Input: cyttsp4 - fix potential NULL pointer dereference in cyttsp4_watchdog_timer()
Date: Mon, 26 Aug 2013 12:55:42 +0800
Message-ID: <CAPgLHd9YkK2-nqympYoKb+OTWfkND+3SJYGw_vCRbN6VpXWZog@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bk0-f47.google.com ([209.85.214.47]:53443 "EHLO
	mail-bk0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751854Ab3HZEzn (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 26 Aug 2013 00:55:43 -0400
Received: by mail-bk0-f47.google.com with SMTP id mx12so922049bkb.34
        for <linux-input@vger.kernel.org>; Sun, 25 Aug 2013 21:55:42 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: javier@dowhile0.org, dmitry.torokhov@gmail.com, fery@cypress.com
Cc: yongjun_wei@trendmicro.com.cn, linux-input@vger.kernel.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

The dereference should be moved below the NULL test.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 drivers/input/touchscreen/cyttsp4_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/cyttsp4_core.c b/drivers/input/touchscreen/cyttsp4_core.c
index 963da05..ffa8e35 100644
--- a/drivers/input/touchscreen/cyttsp4_core.c
+++ b/drivers/input/touchscreen/cyttsp4_core.c
@@ -1244,11 +1244,11 @@ static void cyttsp4_watchdog_timer(unsigned long handle)
 {
 	struct cyttsp4 *cd = (struct cyttsp4 *)handle;
 
-	dev_vdbg(cd->dev, "%s: Watchdog timer triggered\n", __func__);
-
 	if (!cd)
 		return;
 
+	dev_vdbg(cd->dev, "%s: Watchdog timer triggered\n", __func__);
+
 	if (!work_pending(&cd->watchdog_work))
 		schedule_work(&cd->watchdog_work);
 

