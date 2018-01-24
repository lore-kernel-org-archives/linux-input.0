From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 1/3] Input: apbps2: Delete an error message for a failed
 memory allocation in apbps2_of_probe()
Date: Wed, 24 Jan 2018 17:34:51 +0100
Message-ID: <ee3d6628-e8a4-c6c5-c66b-597fb2b28a47@users.sourceforge.net>
References: <50013a33-b7ca-fce1-9769-bfe3db850a8a@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <50013a33-b7ca-fce1-9769-bfe3db850a8a@users.sourceforge.net>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-input@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 24 Jan 2018 16:43:04 +0100

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/input/serio/apbps2.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/input/serio/apbps2.c b/drivers/input/serio/apbps2.c
index 45d4e08ca4f8..9b75c4e1bc13 100644
--- a/drivers/input/serio/apbps2.c
+++ b/drivers/input/serio/apbps2.c
@@ -140,10 +140,8 @@ static int apbps2_of_probe(struct platform_device *ofdev)
 	struct resource *res;
 
 	priv = devm_kzalloc(&ofdev->dev, sizeof(*priv), GFP_KERNEL);
-	if (!priv) {
-		dev_err(&ofdev->dev, "memory allocation failed\n");
+	if (!priv)
 		return -ENOMEM;
-	}
 
 	/* Find Device Address */
 	res = platform_get_resource(ofdev, IORESOURCE_MEM, 0);
-- 
2.16.1
