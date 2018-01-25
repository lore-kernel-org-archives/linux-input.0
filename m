From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 1/2] Input: sirfsoc-onkey: Delete an error message for a
 failed memory allocation in sirfsoc_pwrc_probe()
Date: Thu, 25 Jan 2018 16:46:56 +0100
Message-ID: <00544fed-52b0-0536-ad4e-f023668f08dd@users.sourceforge.net>
References: <b66f4105-57f2-adc2-ecde-cd4dacac408c@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <b66f4105-57f2-adc2-ecde-cd4dacac408c@users.sourceforge.net>
Content-Language: en-GB
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Barry Song <baohua@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 25 Jan 2018 16:32:09 +0100

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/input/misc/sirfsoc-onkey.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/input/misc/sirfsoc-onkey.c b/drivers/input/misc/sirfsoc-onkey.c
index 4fd038d476a3..9d8b4e2d7063 100644
--- a/drivers/input/misc/sirfsoc-onkey.c
+++ b/drivers/input/misc/sirfsoc-onkey.c
@@ -113,10 +113,8 @@ static int sirfsoc_pwrc_probe(struct platform_device *pdev)
 
 	pwrcdrv = devm_kzalloc(&pdev->dev, sizeof(struct sirfsoc_pwrc_drvdata),
 			       GFP_KERNEL);
-	if (!pwrcdrv) {
-		dev_info(&pdev->dev, "Not enough memory for the device data\n");
+	if (!pwrcdrv)
 		return -ENOMEM;
-	}
 
 	/*
 	 * We can't use of_iomap because pwrc is not mapped in memory,
-- 
2.16.1
