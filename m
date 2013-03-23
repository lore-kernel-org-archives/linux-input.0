From: "Vishwanathrao Badarkhe, Manish" <manishv.b-l0cyMroinI0@public.gmane.org>
Subject: [PATCH] tps6507x-ts: update to devm_* API
Date: Sat, 23 Mar 2013 16:30:23 +0530
Message-ID: <1364036423-2057-1-git-send-email-manishv.b@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: manishv.b-l0cyMroinI0@public.gmane.org, broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, wfp5p-4Ng6DfrEGID2fBVCVOL8/A@public.gmane.org, u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, rmk+kernel-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org
List-Id: linux-input@vger.kernel.org

Update the code to use devm_* API so that driver
core will manage resources.

Signed-off-by: Vishwanathrao Badarkhe, Manish <manishv.b-l0cyMroinI0@public.gmane.org>
---
:100644 100644 820a066... 65e0f9a... M	drivers/input/touchscreen/tps6507x-ts.c
 drivers/input/touchscreen/tps6507x-ts.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/drivers/input/touchscreen/tps6507x-ts.c b/drivers/input/touchscreen/tps6507x-ts.c
index 820a066..65e0f9a 100644
--- a/drivers/input/touchscreen/tps6507x-ts.c
+++ b/drivers/input/touchscreen/tps6507x-ts.c
@@ -261,7 +261,7 @@ static int tps6507x_ts_probe(struct platform_device *pdev)
 
 	init_data = tps_board->tps6507x_ts_init_data;
 
-	tsc = kzalloc(sizeof(struct tps6507x_ts), GFP_KERNEL);
+	tsc = devm_kzalloc(&pdev->dev, sizeof(struct tps6507x_ts), GFP_KERNEL);
 	if (!tsc) {
 		dev_err(tps6507x_dev->dev, "failed to allocate driver data\n");
 		error = -ENOMEM;
@@ -339,7 +339,6 @@ err2:
 	cancel_delayed_work_sync(&tsc->work);
 	input_free_device(input_dev);
 err1:
-	kfree(tsc);
 	tps6507x_dev->ts = NULL;
 err0:
 	return error;
@@ -356,7 +355,6 @@ static int tps6507x_ts_remove(struct platform_device *pdev)
 	input_unregister_device(input_dev);
 
 	tps6507x_dev->ts = NULL;
-	kfree(tsc);
 
 	return 0;
 }
-- 
1.7.4.1
