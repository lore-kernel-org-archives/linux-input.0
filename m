From: Quentin Schulz <quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: [PATCH v4 3/8] iio: adc: sun4i-gpadc-iio: move code
 used in MFD probing to new function
Date: Wed,  5 Apr 2017 11:06:29 +0200
Message-ID: <20170405090634.4649-4-quentin.schulz@free-electrons.com>
References: <20170405090634.4649-1-quentin.schulz@free-electrons.com>
Reply-To: quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBCLZXSNY5IDBBOHHSLDQKGQEDTCCE5Y-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20170405090634.4649-1-quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org, jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, knaack.h-Mmb7MZpHnFY@public.gmane.org, lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org, pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org
Cc: Quentin Schulz <quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, icenowy-ymACFijhrKM@public.gmane.org
List-Id: linux-input@vger.kernel.org

This moves code used in MFD probing to a new sun4i_gpadc_probe_mfd
function.

This driver was initially written for A10, A13 and A31 SoCs which
already had a DT binding for this IP, thus we needed to use an MFD to
probe the different drivers without changing the DT binding of these
SoCs.

For SoCs that will require to create a DT binding for this IP, we can
avoid using an MFD, thus we need two separate functions: one for probing
via MFD and one for probing without MFD.

This split the code specific to MFD probing in a function separated from
the driver probe function.

Signed-off-by: Quentin Schulz <quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Acked-by: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---

v3:
  - updated commit log,

added in v2

 drivers/iio/adc/sun4i-gpadc-iio.c | 78 ++++++++++++++++++++++-----------------
 1 file changed, 45 insertions(+), 33 deletions(-)

diff --git a/drivers/iio/adc/sun4i-gpadc-iio.c b/drivers/iio/adc/sun4i-gpadc-iio.c
index a8e134f..7cb997a 100644
--- a/drivers/iio/adc/sun4i-gpadc-iio.c
+++ b/drivers/iio/adc/sun4i-gpadc-iio.c
@@ -454,31 +454,16 @@ static int sun4i_irq_init(struct platform_device *pdev, const char *name,
 	return 0;
 }
 
-static int sun4i_gpadc_probe(struct platform_device *pdev)
+static int sun4i_gpadc_probe_mfd(struct platform_device *pdev,
+				 struct iio_dev *indio_dev)
 {
-	struct sun4i_gpadc_iio *info;
-	struct iio_dev *indio_dev;
+	struct sun4i_gpadc_iio *info = iio_priv(indio_dev);
+	struct sun4i_gpadc_dev *sun4i_gpadc_dev =
+		dev_get_drvdata(pdev->dev.parent);
 	int ret;
-	struct sun4i_gpadc_dev *sun4i_gpadc_dev;
-
-	sun4i_gpadc_dev = dev_get_drvdata(pdev->dev.parent);
-
-	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*info));
-	if (!indio_dev)
-		return -ENOMEM;
 
-	info = iio_priv(indio_dev);
-	platform_set_drvdata(pdev, indio_dev);
-
-	mutex_init(&info->mutex);
 	info->regmap = sun4i_gpadc_dev->regmap;
-	info->indio_dev = indio_dev;
-	init_completion(&info->completion);
-	indio_dev->name = dev_name(&pdev->dev);
-	indio_dev->dev.parent = &pdev->dev;
-	indio_dev->dev.of_node = pdev->dev.of_node;
-	indio_dev->info = &sun4i_gpadc_iio_info;
-	indio_dev->modes = INDIO_DIRECT_MODE;
+
 	indio_dev->num_channels = ARRAY_SIZE(sun4i_gpadc_channels);
 	indio_dev->channels = sun4i_gpadc_channels;
 
@@ -519,8 +504,7 @@ static int sun4i_gpadc_probe(struct platform_device *pdev)
 			dev_err(&pdev->dev,
 				"could not register thermal sensor: %ld\n",
 				PTR_ERR(tzd));
-			ret = PTR_ERR(tzd);
-			goto err;
+			return PTR_ERR(tzd);
 		}
 	} else {
 		indio_dev->num_channels =
@@ -528,36 +512,65 @@ static int sun4i_gpadc_probe(struct platform_device *pdev)
 		indio_dev->channels = sun4i_gpadc_channels_no_temp;
 	}
 
-	pm_runtime_set_autosuspend_delay(&pdev->dev,
-					 SUN4I_GPADC_AUTOSUSPEND_DELAY);
-	pm_runtime_use_autosuspend(&pdev->dev);
-	pm_runtime_set_suspended(&pdev->dev);
-	pm_runtime_enable(&pdev->dev);
-
 	if (IS_ENABLED(CONFIG_THERMAL_OF)) {
 		ret = sun4i_irq_init(pdev, "TEMP_DATA_PENDING",
 				     sun4i_gpadc_temp_data_irq_handler,
 				     "temp_data", &info->temp_data_irq,
 				     &info->ignore_temp_data_irq);
 		if (ret < 0)
-			goto err;
+			return ret;
 	}
 
 	ret = sun4i_irq_init(pdev, "FIFO_DATA_PENDING",
 			     sun4i_gpadc_fifo_data_irq_handler, "fifo_data",
 			     &info->fifo_data_irq, &info->ignore_fifo_data_irq);
 	if (ret < 0)
-		goto err;
+		return ret;
 
 	if (IS_ENABLED(CONFIG_THERMAL_OF)) {
 		ret = iio_map_array_register(indio_dev, sun4i_gpadc_hwmon_maps);
 		if (ret < 0) {
 			dev_err(&pdev->dev,
 				"failed to register iio map array\n");
-			goto err;
+			return ret;
 		}
 	}
 
+	return 0;
+}
+
+static int sun4i_gpadc_probe(struct platform_device *pdev)
+{
+	struct sun4i_gpadc_iio *info;
+	struct iio_dev *indio_dev;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*info));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	info = iio_priv(indio_dev);
+	platform_set_drvdata(pdev, indio_dev);
+
+	mutex_init(&info->mutex);
+	info->indio_dev = indio_dev;
+	init_completion(&info->completion);
+	indio_dev->name = dev_name(&pdev->dev);
+	indio_dev->dev.parent = &pdev->dev;
+	indio_dev->dev.of_node = pdev->dev.of_node;
+	indio_dev->info = &sun4i_gpadc_iio_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+
+	ret = sun4i_gpadc_probe_mfd(pdev, indio_dev);
+	if (ret)
+		return ret;
+
+	pm_runtime_set_autosuspend_delay(&pdev->dev,
+					 SUN4I_GPADC_AUTOSUSPEND_DELAY);
+	pm_runtime_use_autosuspend(&pdev->dev);
+	pm_runtime_set_suspended(&pdev->dev);
+	pm_runtime_enable(&pdev->dev);
+
 	ret = devm_iio_device_register(&pdev->dev, indio_dev);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "could not register the device\n");
@@ -570,7 +583,6 @@ static int sun4i_gpadc_probe(struct platform_device *pdev)
 	if (IS_ENABLED(CONFIG_THERMAL_OF))
 		iio_map_array_unregister(indio_dev);
 
-err:
 	pm_runtime_put(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 
-- 
2.9.3
