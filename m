From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 1/2] Input: da9063_onkey: Delete an error message for a failed
 memory allocation in da9063_onkey_probe()
Date: Thu, 25 Jan 2018 20:35:23 +0100
Message-ID: <77166fc3-f853-46a2-2a90-141e7a6e039b@users.sourceforge.net>
References: <9b0e8f6a-6386-d307-34fc-7936c52bd0c6@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <9b0e8f6a-6386-d307-34fc-7936c52bd0c6@users.sourceforge.net>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org, support.opensource@diasemi.com, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Steve Twiss <stwiss.opensource@diasemi.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-input@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 25 Jan 2018 20:22:57 +0100

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/input/misc/da9063_onkey.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/input/misc/da9063_onkey.c b/drivers/input/misc/da9063_onkey.c
index 3e9c353d82ef..acf592975bef 100644
--- a/drivers/input/misc/da9063_onkey.c
+++ b/drivers/input/misc/da9063_onkey.c
@@ -215,10 +215,8 @@ static int da9063_onkey_probe(struct platform_device *pdev)
 
 	onkey = devm_kzalloc(&pdev->dev, sizeof(struct da9063_onkey),
 			     GFP_KERNEL);
-	if (!onkey) {
-		dev_err(&pdev->dev, "Failed to allocate memory.\n");
+	if (!onkey)
 		return -ENOMEM;
-	}
 
 	onkey->config = match->data;
 	onkey->dev = &pdev->dev;
-- 
2.16.1
