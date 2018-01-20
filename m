From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 2/2] Input: zforce_ts: Delete an unnecessary return statement
 in zforce_input_close()
Date: Sat, 20 Jan 2018 21:20:38 +0100
Message-ID: <7d14b5af-bc11-305c-6a90-18e8a3b3196c@users.sourceforge.net>
References: <e36553b1-3221-7944-59bd-6bb9358c488f@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <e36553b1-3221-7944-59bd-6bb9358c488f@users.sourceforge.net>
Content-Language: en-GB
Sender: kernel-janitors-owner@vger.kernel.org
To: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-input@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 20 Jan 2018 20:43:06 +0100

The script "checkpatch.pl" pointed information out like the following.

WARNING: void function return statements are not generally useful

Thus remove such a statement in the affected function.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/input/touchscreen/zforce_ts.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/input/touchscreen/zforce_ts.c b/drivers/input/touchscreen/zforce_ts.c
index 9fb6b3f201f9..e462a152b4e6 100644
--- a/drivers/input/touchscreen/zforce_ts.c
+++ b/drivers/input/touchscreen/zforce_ts.c
@@ -612,8 +612,6 @@ static void zforce_input_close(struct input_dev *dev)
 	ret = zforce_stop(ts);
 	if (ret)
 		dev_warn(&client->dev, "stopping zforce failed\n");
-
-	return;
 }
 
 static int __maybe_unused zforce_suspend(struct device *dev)
-- 
2.15.1

