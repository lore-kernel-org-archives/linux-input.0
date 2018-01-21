From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 2/2] Input: da9034-ts: Improve a size determination in
 da9034_touch_probe()
Date: Sun, 21 Jan 2018 20:48:37 +0100
Message-ID: <8e27d655-4f18-b156-3d78-a12b28f79b5b@users.sourceforge.net>
References: <44ae37ef-deaa-c963-e0f7-c407159afa0c@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <44ae37ef-deaa-c963-e0f7-c407159afa0c@users.sourceforge.net>
Content-Language: en-GB
Sender: kernel-janitors-owner@vger.kernel.org
To: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-input@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 21 Jan 2018 20:36:20 +0100

Replace the specification of a data structure by a pointer dereference
as the parameter for the operator "sizeof" to make the corresponding size
determination a bit safer according to the Linux coding style convention.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/input/touchscreen/da9034-ts.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/da9034-ts.c b/drivers/input/touchscreen/da9034-ts.c
index b30cfe1e62da..c9c423aebe1e 100644
--- a/drivers/input/touchscreen/da9034-ts.c
+++ b/drivers/input/touchscreen/da9034-ts.c
@@ -303,8 +303,7 @@ static int da9034_touch_probe(struct platform_device *pdev)
 	struct input_dev *input_dev;
 	int error;
 
-	touch = devm_kzalloc(&pdev->dev, sizeof(struct da9034_touch),
-			     GFP_KERNEL);
+	touch = devm_kzalloc(&pdev->dev, sizeof(*touch), GFP_KERNEL);
 	if (!touch)
 		return -ENOMEM;
 
-- 
2.16.0

