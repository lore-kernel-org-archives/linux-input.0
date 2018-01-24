From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 2/2] Input: wm831x-on: Improve a size determination in
 wm831x_on_probe()
Date: Wed, 24 Jan 2018 22:22:35 +0100
Message-ID: <43f052c7-c98d-7ca2-08ca-e5428b5ad575@users.sourceforge.net>
References: <e307cfde-58e2-3f4d-ecd7-5c80ace0bb5b@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <e307cfde-58e2-3f4d-ecd7-5c80ace0bb5b@users.sourceforge.net>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org, patches@opensource.cirrus.com, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-input@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 24 Jan 2018 21:58:42 +0100

Replace the specification of a data structure by a pointer dereference
as the parameter for the operator "sizeof" to make the corresponding size
determination a bit safer according to the Linux coding style convention.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/input/misc/wm831x-on.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/input/misc/wm831x-on.c b/drivers/input/misc/wm831x-on.c
index 06f5c4857a0c..0d8f7a11f63d 100644
--- a/drivers/input/misc/wm831x-on.c
+++ b/drivers/input/misc/wm831x-on.c
@@ -75,8 +75,7 @@ static int wm831x_on_probe(struct platform_device *pdev)
 	int irq = wm831x_irq(wm831x, platform_get_irq(pdev, 0));
 	int ret;
 
-	wm831x_on = devm_kzalloc(&pdev->dev, sizeof(struct wm831x_on),
-				 GFP_KERNEL);
+	wm831x_on = devm_kzalloc(&pdev->dev, sizeof(*wm831x_on), GFP_KERNEL);
 	if (!wm831x_on)
 		return -ENOMEM;
 
-- 
2.16.1
