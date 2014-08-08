From: Kiran Padwal <kiran.padwal@smartplayin.com>
Subject: [PATCH 1/2] Input: da9055_onkey: Remove unnecessary OOM meassage
Date: Fri,  8 Aug 2014 12:44:57 +0530
Message-ID: <1407482097-17624-1-git-send-email-kiran.padwal@smartplayin.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: support.opensource@diasemi.com, dmitry.torokhov@gmail.com
Cc: anthony.olech.opensource@diasemi.com, david.chen@diasemi.com, kiran.padwal21@gmail.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Kiran Padwal <kiran.padwal@smartplayin.com>
List-Id: linux-input@vger.kernel.org

There is no need to print out-of-memory errors since this is already
done by the memory management subsystem which even calls dump_stack().

Signed-off-by: Kiran Padwal <kiran.padwal@smartplayin.com>
---
 drivers/input/misc/da9055_onkey.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/input/misc/da9055_onkey.c b/drivers/input/misc/da9055_onkey.c
index 4765799..ed6eaa9 100644
--- a/drivers/input/misc/da9055_onkey.c
+++ b/drivers/input/misc/da9055_onkey.c
@@ -87,10 +87,8 @@ static int da9055_onkey_probe(struct platform_device *pdev)
 	}
 
 	onkey = devm_kzalloc(&pdev->dev, sizeof(*onkey), GFP_KERNEL);
-	if (!onkey) {
-		dev_err(&pdev->dev, "Failed to allocate memory\n");
+	if (!onkey)
 		return -ENOMEM;
-	}
 
 	input_dev = input_allocate_device();
 	if (!input_dev) {
-- 
1.7.9.5
