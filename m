From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [PATCH v6 1/9] input: max8997-haptic: Fix NULL pointer dereference
Date: Fri, 06 May 2016 09:21:21 +0200
Message-ID: <1462519289-2356-2-git-send-email-k.kozlowski@samsung.com>
References: <1462519289-2356-1-git-send-email-k.kozlowski@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1462519289-2356-1-git-send-email-k.kozlowski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Jacek Anaszewski <j.anaszewski@samsung.com>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Alessandro Zummo <a.zummo@towertech.it>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linux-leds@vger.kernel.org, linux-pm@vger.kernel.org, rtc-linux@googlegroups.com
Cc: r.baldyga@hackerion.com, Marek Szyprowski <m.szyprowski@samsung.com>, stable@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-Id: linux-input@vger.kernel.org

From: Marek Szyprowski <m.szyprowski@samsung.com>

NULL pointer derefence happens when booting with DTB because the
platform data for haptic device is not set in supplied data from parent
MFD device.

The MFD device creates only platform data (from Device Tree) for itself,
not for haptic child.

Unable to handle kernel NULL pointer dereference at virtual address 0000009c
pgd = c0004000
	[0000009c] *pgd=00000000
	Internal error: Oops: 5 [#1] PREEMPT SMP ARM
	(max8997_haptic_probe) from [<c03f9cec>] (platform_drv_probe+0x4c/0xb0)
	(platform_drv_probe) from [<c03f8440>] (driver_probe_device+0x214/0x2c0)
	(driver_probe_device) from [<c03f8598>] (__driver_attach+0xac/0xb0)
	(__driver_attach) from [<c03f67ac>] (bus_for_each_dev+0x68/0x9c)
	(bus_for_each_dev) from [<c03f7a38>] (bus_add_driver+0x1a0/0x218)
	(bus_add_driver) from [<c03f8db0>] (driver_register+0x78/0xf8)
	(driver_register) from [<c0101774>] (do_one_initcall+0x90/0x1d8)
	(do_one_initcall) from [<c0a00dbc>] (kernel_init_freeable+0x15c/0x1fc)
	(kernel_init_freeable) from [<c06bb5b4>] (kernel_init+0x8/0x114)
	(kernel_init) from [<c0107938>] (ret_from_fork+0x14/0x3c)

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: <stable@vger.kernel.org>
Fixes: 104594b01ce7 ("Input: add driver support for MAX8997-haptic")
[k.kozlowski: Write commit message, add CC-stable]
Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 drivers/input/misc/max8997_haptic.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/input/misc/max8997_haptic.c b/drivers/input/misc/max8997_haptic.c
index a806ba3818f7..8d6326d7e7be 100644
--- a/drivers/input/misc/max8997_haptic.c
+++ b/drivers/input/misc/max8997_haptic.c
@@ -255,12 +255,14 @@ static int max8997_haptic_probe(struct platform_device *pdev)
 	struct max8997_dev *iodev = dev_get_drvdata(pdev->dev.parent);
 	const struct max8997_platform_data *pdata =
 					dev_get_platdata(iodev->dev);
-	const struct max8997_haptic_platform_data *haptic_pdata =
-					pdata->haptic_pdata;
+	const struct max8997_haptic_platform_data *haptic_pdata = NULL;
 	struct max8997_haptic *chip;
 	struct input_dev *input_dev;
 	int error;
 
+	if (pdata)
+		haptic_pdata = pdata->haptic_pdata;
+
 	if (!haptic_pdata) {
 		dev_err(&pdev->dev, "no haptic platform data\n");
 		return -EINVAL;
-- 
1.9.1
