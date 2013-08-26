From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH v2] Input: cyttsp4 - remove useless NULL test from cyttsp4_watchdog_timer()
Date: Mon, 26 Aug 2013 14:00:12 +0800
Message-ID: <CAPgLHd-VmhDGxLgx7T7BoTntOhOabG4j07u-fFtB0X3NVwOgyw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bk0-f43.google.com ([209.85.214.43]:49978 "EHLO
	mail-bk0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755334Ab3HZGAO (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 26 Aug 2013 02:00:14 -0400
Received: by mail-bk0-f43.google.com with SMTP id mz13so922389bkb.16
        for <linux-input@vger.kernel.org>; Sun, 25 Aug 2013 23:00:13 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: javier@dowhile0.org, dmitry.torokhov@gmail.com
Cc: yongjun_wei@trendmicro.com.cn, linux-input@vger.kernel.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Remove useless NULL test from cyttsp4_watchdog_timer().

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
v1 -> v2: remove NULL test instead.
  (was: Input: cyttsp4 - fix potential NULL pointer dereference in cyttsp4_watchdog_timer())
---
 drivers/input/touchscreen/cyttsp4_core.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/input/touchscreen/cyttsp4_core.c b/drivers/input/touchscreen/cyttsp4_core.c
index edcf799..22719d0 100644
--- a/drivers/input/touchscreen/cyttsp4_core.c
+++ b/drivers/input/touchscreen/cyttsp4_core.c
@@ -1246,9 +1246,6 @@ static void cyttsp4_watchdog_timer(unsigned long handle)
 
 	dev_vdbg(cd->dev, "%s: Watchdog timer triggered\n", __func__);
 
-	if (!cd)
-		return;
-
 	if (!work_pending(&cd->watchdog_work))
 		schedule_work(&cd->watchdog_work);
 

