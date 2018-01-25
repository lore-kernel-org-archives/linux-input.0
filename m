From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] Input: twl6040-vibra: Delete an error message for a failed
 memory allocation in twl6040_vibra_probe()
Date: Thu, 25 Jan 2018 16:08:47 +0100
Message-ID: <d020fc80-4805-81da-aa27-2c3082129f74@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Language: en-GB
Sender: kernel-janitors-owner@vger.kernel.org
To: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-input@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 25 Jan 2018 16:01:32 +0100

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/input/misc/twl6040-vibra.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/input/misc/twl6040-vibra.c b/drivers/input/misc/twl6040-vibra.c
index 5690eb7ff954..1bdca0eeed3f 100644
--- a/drivers/input/misc/twl6040-vibra.c
+++ b/drivers/input/misc/twl6040-vibra.c
@@ -259,7 +259,6 @@ static int twl6040_vibra_probe(struct platform_device *pdev)
 	info = devm_kzalloc(&pdev->dev, sizeof(*info), GFP_KERNEL);
 	if (!info) {
 		of_node_put(twl6040_core_node);
-		dev_err(&pdev->dev, "couldn't allocate memory\n");
 		return -ENOMEM;
 	}
 
-- 
2.16.1

