From: Libo Chen <clbchenlibo.chen@huawei.com>
Subject: [PATCH 3/3] driver: input: twl6040-vibra: fix missing of_node_put
Date: Sat, 31 Aug 2013 14:45:05 +0800
Message-ID: <522190F1.3010103@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: Bill Pemberton <wfp5p@virginia.edu>, peter.ujfalusi@ti.com, broonie@opensource.wolfsonmicro.com, javier@dowhile0.org, linux-input@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Li Zefan <lizefan@huawei.com>, "zhangwei(Jovi)" <jovi.zhangwei@huawei.com>
List-Id: linux-input@vger.kernel.org


decrease twl6040_core_node device_node refcount after task completion

There are two ways to implement the function of_node_put through
the marco CONFIG_OF_DYNAMIC, so it is save to call directly.

Signed-off-by: Libo Chen <libo.chen@huawei.com>
---
 drivers/input/misc/twl6040-vibra.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/input/misc/twl6040-vibra.c b/drivers/input/misc/twl6040-vibra.c
index 0c2dfc8..f16193a 100644
--- a/drivers/input/misc/twl6040-vibra.c
+++ b/drivers/input/misc/twl6040-vibra.c
@@ -271,12 +271,14 @@ static int twl6040_vibra_probe(struct platform_device *pdev)
 #endif

 	if (!pdata && !twl6040_core_node) {
+		of_node_put(twl6040_core_node);
 		dev_err(&pdev->dev, "platform_data not available\n");
 		return -EINVAL;
 	}

 	info = devm_kzalloc(&pdev->dev, sizeof(*info), GFP_KERNEL);
 	if (!info) {
+		of_node_put(twl6040_core_node);
 		dev_err(&pdev->dev, "couldn't allocate memory\n");
 		return -ENOMEM;
 	}
@@ -304,6 +306,7 @@ static int twl6040_vibra_probe(struct platform_device *pdev)
 				     &vddvibl_uV);
 		of_property_read_u32(twl6040_core_node, "ti,vddvibr-uV",
 				     &vddvibr_uV);
+		of_node_put(twl6040_core_node);
 	}

 	if ((!info->vibldrv_res && !info->viblmotor_res) ||
-- 
1.7.1
