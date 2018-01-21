From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 2/2] Input: auo-pixcir-ts: Delete an unnecessary return
 statement in auo_pixcir_input_close()
Date: Sun, 21 Jan 2018 22:16:15 +0100
Message-ID: <285e8d30-2d7e-f035-f4a4-679b3d79f57b@users.sourceforge.net>
References: <df18b548-f95e-e315-9e77-f379af7909e8@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout.web.de ([217.72.192.78]:53284 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751047AbeAUVQX (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Sun, 21 Jan 2018 16:16:23 -0500
In-Reply-To: <df18b548-f95e-e315-9e77-f379af7909e8@users.sourceforge.net>
Content-Language: en-GB
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 21 Jan 2018 22:06:28 +0100

The script "checkpatch.pl" pointed information out like the following.

WARNING: void function return statements are not generally useful

Thus remove such a statement in the affected function.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/input/touchscreen/auo-pixcir-ts.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/input/touchscreen/auo-pixcir-ts.c b/drivers/input/touchscreen/auo-pixcir-ts.c
index 398e27c48a51..df8ca856393b 100644
--- a/drivers/input/touchscreen/auo-pixcir-ts.c
+++ b/drivers/input/touchscreen/auo-pixcir-ts.c
@@ -408,8 +408,6 @@ static void auo_pixcir_input_close(struct input_dev *dev)
 	struct auo_pixcir_ts *ts = input_get_drvdata(dev);
 
 	auo_pixcir_stop(ts);
-
-	return;
 }
 
 static int __maybe_unused auo_pixcir_suspend(struct device *dev)
-- 
2.16.0

