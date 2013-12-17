From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH -next] Input: zforce - fix error return code in zforce_start()
Date: Tue, 17 Dec 2013 11:27:16 +0800
Message-ID: <CAPgLHd8WBR38qd9VHfazXVTbuoJ=GPOafHzSz8d9XJ-F61a7nQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bk0-f45.google.com ([209.85.214.45]:52034 "EHLO
	mail-bk0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751551Ab3LQD1R (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 16 Dec 2013 22:27:17 -0500
Received: by mail-bk0-f45.google.com with SMTP id mx13so2631979bkb.32
        for <linux-input@vger.kernel.org>; Mon, 16 Dec 2013 19:27:16 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, rydberg@euromail.se, heiko@sntech.de
Cc: yongjun_wei@trendmicro.com.cn, linux-input@vger.kernel.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

The error code was not set if unable to set config, so the error
condition wasn't reflected in the return value. Fix to return a
negative error code from the error handling case instead of 0.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 drivers/input/touchscreen/zforce_ts.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/zforce_ts.c b/drivers/input/touchscreen/zforce_ts.c
index aa127ba..2175f34 100644
--- a/drivers/input/touchscreen/zforce_ts.c
+++ b/drivers/input/touchscreen/zforce_ts.c
@@ -279,7 +279,8 @@ static int zforce_start(struct zforce_ts *ts)
 		goto error;
 	}
 
-	if (zforce_setconfig(ts, SETCONFIG_DUALTOUCH)) {
+	ret = zforce_setconfig(ts, SETCONFIG_DUALTOUCH);
+	if (ret) {
 		dev_err(&client->dev, "Unable to set config\n");
 		goto error;
 	}

