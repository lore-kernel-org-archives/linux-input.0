From: "Enrico Weigelt, metux IT consult" <info@metux.net>
Subject: [PATCH v2] input: misc: soc_button_array: use platform_device_register_resndata()
Date: Tue, 20 Aug 2019 13:16:43 +0200
Message-ID: <1566299803-19243-1-git-send-email-info@metux.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

From: Enrico Weigelt <info@metux.net>

The registration of gpio-keys device can be written much shorter
by using the platform_device_register_resndata() helper.

v2:
    * pass &pdev->dev to platform_device_register_resndata()
    * fixed errval on failed platform_device_register_resndata()

Signed-off-by: Enrico Weigelt <info@metux.net>
---
 drivers/input/misc/soc_button_array.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/input/misc/soc_button_array.c b/drivers/input/misc/soc_button_array.c
index 5e59f8e5..27550f9 100644
--- a/drivers/input/misc/soc_button_array.c
+++ b/drivers/input/misc/soc_button_array.c
@@ -110,25 +110,24 @@ static int soc_button_lookup_gpio(struct device *dev, int acpi_index)
 	gpio_keys_pdata->nbuttons = n_buttons;
 	gpio_keys_pdata->rep = autorepeat;
 
-	pd = platform_device_alloc("gpio-keys", PLATFORM_DEVID_AUTO);
-	if (!pd) {
-		error = -ENOMEM;
+	pd = platform_device_register_resndata(
+		&pdev->dev,
+		"gpio-keys",
+		PLATFORM_DEVID_AUTO,
+		NULL,
+		0,
+		gpio_keys_pdata,
+		sizeof(*gpio_keys_pdata));
+
+	error = PTR_ERR_OR_ZERO(pd);
+
+	if (IS_ERR(pd)) {
+		dev_err(&pdev->dev, "failed registering gpio-keys: %ld\n", PTR_ERR(pd));
 		goto err_free_mem;
 	}
 
-	error = platform_device_add_data(pd, gpio_keys_pdata,
-					 sizeof(*gpio_keys_pdata));
-	if (error)
-		goto err_free_pdev;
-
-	error = platform_device_add(pd);
-	if (error)
-		goto err_free_pdev;
-
 	return pd;
 
-err_free_pdev:
-	platform_device_put(pd);
 err_free_mem:
 	devm_kfree(&pdev->dev, gpio_keys_pdata);
 	return ERR_PTR(error);
-- 
1.9.1
