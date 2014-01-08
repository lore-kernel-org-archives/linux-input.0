From: Anthony Olech <anthony.olech.opensource@diasemi.com>
Subject: [PATCH V1] input: fix memory leak in da9052 touchscreen driver
Date: Wed, 8 Jan 2014 16:58:10 +0000
Message-ID: <201401081709.s08H9nMr038265@swsrvapps-02.lan>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Huqiu Liu <liuhq11@mails.tsinghua.edu.cn>, David Dajun Chen <david.chen@diasemi.com>
List-Id: linux-input@vger.kernel.org

The touchscreen component driver for the da9052/3 Dialog PMICs
leaks memory by not freeing the input device in the remove call.

This patch matches the existing call to input_alloc_device()
in da9052_ts_probe() to a new call to input_free_device() in
da9052_ts_remove()

Suggested-by: Huqiu Liu <liuhq11@mails.tsinghua.edu.cn>
Signed-off-by: Anthony Olech <anthony.olech.opensource@diasemi.com>
---
This patch is relative to linux-next repository tag next-20140108

Many thanks to Huqiu Liu who found the bug.

 drivers/input/touchscreen/da9052_tsi.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/input/touchscreen/da9052_tsi.c b/drivers/input/touchscreen/da9052_tsi.c
index ab64d58..43a69d1 100644
--- a/drivers/input/touchscreen/da9052_tsi.c
+++ b/drivers/input/touchscreen/da9052_tsi.c
@@ -320,6 +320,7 @@ err_free_mem:
 static int  da9052_ts_remove(struct platform_device *pdev)
 {
 	struct da9052_tsi *tsi = platform_get_drvdata(pdev);
+	struct input_dev *input_dev = tsi->dev;
 
 	da9052_reg_write(tsi->da9052, DA9052_LDO9_REG, 0x19);
 
@@ -328,6 +329,7 @@ static int  da9052_ts_remove(struct platform_device *pdev)
 
 	input_unregister_device(tsi->dev);
 	kfree(tsi);
+	input_free_device(input_dev);
 
 	return 0;
 }
-- 
end-of-patch for input: fix memory leak in da9052 touchscreen driver V1
