From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 2/2] Input: da9063_onkey: Improve a size determination in
 da9063_onkey_probe()
Date: Thu, 25 Jan 2018 20:36:22 +0100
Message-ID: <b6c60de6-122b-43d8-8298-9bd0be98dfee@users.sourceforge.net>
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
Date: Thu, 25 Jan 2018 20:24:47 +0100

Replace the specification of a data structure by a pointer dereference
as the parameter for the operator "sizeof" to make the corresponding size
determination a bit safer according to the Linux coding style convention.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/input/misc/da9063_onkey.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/input/misc/da9063_onkey.c b/drivers/input/misc/da9063_onkey.c
index acf592975bef..310f9c408636 100644
--- a/drivers/input/misc/da9063_onkey.c
+++ b/drivers/input/misc/da9063_onkey.c
@@ -213,8 +213,7 @@ static int da9063_onkey_probe(struct platform_device *pdev)
 	if (!match)
 		return -ENXIO;
 
-	onkey = devm_kzalloc(&pdev->dev, sizeof(struct da9063_onkey),
-			     GFP_KERNEL);
+	onkey = devm_kzalloc(&pdev->dev, sizeof(*onkey), GFP_KERNEL);
 	if (!onkey)
 		return -ENOMEM;
 
-- 
2.16.1
