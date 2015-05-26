From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2 5/9] extcon/input/mfd/regulator: max77843: Switch to
 common max77693 state container
Date: Tue, 26 May 2015 10:46:49 -0700
Message-ID: <20150526174649.GD10571@dtor-ws>
References: <1432446213-4886-1-git-send-email-k.kozlowski.k@gmail.com>
 <1432446213-4886-6-git-send-email-k.kozlowski.k@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f170.google.com ([209.85.223.170]:34938 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751830AbbEZRqy (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 26 May 2015 13:46:54 -0400
Content-Disposition: inline
In-Reply-To: <1432446213-4886-6-git-send-email-k.kozlowski.k@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
Cc: Chanwoo Choi <cw00.choi@samsung.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linux-pm@vger.kernel.org

On Sun, May 24, 2015 at 02:43:29PM +0900, Krzysztof Kozlowski wrote:
> Switch to the same definition of state container as in MAX77693 drivers.
> This will allow usage of one regulator driver in both devices: MAX77693
> and MAX77843.
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>

For input:

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

> ---
>  drivers/extcon/extcon-max77843.c     | 17 +++++++++--------
>  drivers/input/misc/max77843-haptic.c |  3 ++-
>  drivers/mfd/max77843.c               | 20 +++++++++++---------
>  drivers/regulator/max77843.c         |  6 ++++--
>  include/linux/mfd/max77693-common.h  |  5 +++++
>  include/linux/mfd/max77843-private.h | 20 --------------------
>  6 files changed, 31 insertions(+), 40 deletions(-)
> 
> diff --git a/drivers/extcon/extcon-max77843.c b/drivers/extcon/extcon-max77843.c
> index d78a64d7fc20..0f5910dcccb7 100644
> --- a/drivers/extcon/extcon-max77843.c
> +++ b/drivers/extcon/extcon-max77843.c
> @@ -16,6 +16,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/kernel.h>
>  #include <linux/mfd/max77843-private.h>
> +#include <linux/mfd/max77693-common.h>
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
>  #include <linux/workqueue.h>
> @@ -32,7 +33,7 @@ enum max77843_muic_status {
>  
>  struct max77843_muic_info {
>  	struct device *dev;
> -	struct max77843 *max77843;
> +	struct max77693_dev *max77843;
>  	struct extcon_dev *edev;
>  
>  	struct mutex mutex;
> @@ -198,7 +199,7 @@ static const struct regmap_irq_chip max77843_muic_irq_chip = {
>  static int max77843_muic_set_path(struct max77843_muic_info *info,
>  		u8 val, bool attached)
>  {
> -	struct max77843 *max77843 = info->max77843;
> +	struct max77693_dev *max77843 = info->max77843;
>  	int ret = 0;
>  	unsigned int ctrl1, ctrl2;
>  
> @@ -539,7 +540,7 @@ static void max77843_muic_irq_work(struct work_struct *work)
>  {
>  	struct max77843_muic_info *info = container_of(work,
>  			struct max77843_muic_info, irq_work);
> -	struct max77843 *max77843 = info->max77843;
> +	struct max77693_dev *max77843 = info->max77843;
>  	int ret = 0;
>  
>  	mutex_lock(&info->mutex);
> @@ -615,7 +616,7 @@ static void max77843_muic_detect_cable_wq(struct work_struct *work)
>  {
>  	struct max77843_muic_info *info = container_of(to_delayed_work(work),
>  			struct max77843_muic_info, wq_detcable);
> -	struct max77843 *max77843 = info->max77843;
> +	struct max77693_dev *max77843 = info->max77843;
>  	int chg_type, adc, ret;
>  	bool attached;
>  
> @@ -656,7 +657,7 @@ err_cable_wq:
>  static int max77843_muic_set_debounce_time(struct max77843_muic_info *info,
>  		enum max77843_muic_adc_debounce_time time)
>  {
> -	struct max77843 *max77843 = info->max77843;
> +	struct max77693_dev *max77843 = info->max77843;
>  	int ret;
>  
>  	switch (time) {
> @@ -681,7 +682,7 @@ static int max77843_muic_set_debounce_time(struct max77843_muic_info *info,
>  	return 0;
>  }
>  
> -static int max77843_init_muic_regmap(struct max77843 *max77843)
> +static int max77843_init_muic_regmap(struct max77693_dev *max77843)
>  {
>  	int ret;
>  
> @@ -720,7 +721,7 @@ err_muic_i2c:
>  
>  static int max77843_muic_probe(struct platform_device *pdev)
>  {
> -	struct max77843 *max77843 = dev_get_drvdata(pdev->dev.parent);
> +	struct max77693_dev *max77843 = dev_get_drvdata(pdev->dev.parent);
>  	struct max77843_muic_info *info;
>  	unsigned int id;
>  	int i, ret;
> @@ -821,7 +822,7 @@ err_muic_irq:
>  static int max77843_muic_remove(struct platform_device *pdev)
>  {
>  	struct max77843_muic_info *info = platform_get_drvdata(pdev);
> -	struct max77843 *max77843 = info->max77843;
> +	struct max77693_dev *max77843 = info->max77843;
>  
>  	cancel_work_sync(&info->irq_work);
>  	regmap_del_irq_chip(max77843->irq, max77843->irq_data_muic);
> diff --git a/drivers/input/misc/max77843-haptic.c b/drivers/input/misc/max77843-haptic.c
> index dccbb465a055..92583dcc808b 100644
> --- a/drivers/input/misc/max77843-haptic.c
> +++ b/drivers/input/misc/max77843-haptic.c
> @@ -15,6 +15,7 @@
>  #include <linux/init.h>
>  #include <linux/input.h>
>  #include <linux/mfd/max77843-private.h>
> +#include <linux/mfd/max77693-common.h>
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
>  #include <linux/pwm.h>
> @@ -243,7 +244,7 @@ static void max77843_haptic_close(struct input_dev *dev)
>  
>  static int max77843_haptic_probe(struct platform_device *pdev)
>  {
> -	struct max77843 *max77843 = dev_get_drvdata(pdev->dev.parent);
> +	struct max77693_dev *max77843 = dev_get_drvdata(pdev->dev.parent);
>  	struct max77843_haptic *haptic;
>  	int error;
>  
> diff --git a/drivers/mfd/max77843.c b/drivers/mfd/max77843.c
> index a354ac677ec7..d4ce1303edf7 100644
> --- a/drivers/mfd/max77843.c
> +++ b/drivers/mfd/max77843.c
> @@ -18,6 +18,7 @@
>  #include <linux/module.h>
>  #include <linux/mfd/core.h>
>  #include <linux/mfd/max77843-private.h>
> +#include <linux/mfd/max77693-common.h>
>  #include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  
> @@ -71,7 +72,7 @@ static const struct regmap_irq_chip max77843_irq_chip = {
>  };
>  
>  /* Charger and Charger regulator use same regmap. */
> -static int max77843_chg_init(struct max77843 *max77843)
> +static int max77843_chg_init(struct max77693_dev *max77843)
>  {
>  	int ret;
>  
> @@ -101,7 +102,7 @@ err_chg_i2c:
>  static int max77843_probe(struct i2c_client *i2c,
>  			  const struct i2c_device_id *id)
>  {
> -	struct max77843 *max77843;
> +	struct max77693_dev *max77843;
>  	unsigned int reg_data;
>  	int ret;
>  
> @@ -113,6 +114,7 @@ static int max77843_probe(struct i2c_client *i2c,
>  	max77843->dev = &i2c->dev;
>  	max77843->i2c = i2c;
>  	max77843->irq = i2c->irq;
> +	max77843->type = id->driver_data;
>  
>  	max77843->regmap = devm_regmap_init_i2c(i2c,
>  			&max77843_regmap_config);
> @@ -123,7 +125,7 @@ static int max77843_probe(struct i2c_client *i2c,
>  
>  	ret = regmap_add_irq_chip(max77843->regmap, max77843->irq,
>  			IRQF_TRIGGER_LOW | IRQF_ONESHOT | IRQF_SHARED,
> -			0, &max77843_irq_chip, &max77843->irq_data);
> +			0, &max77843_irq_chip, &max77843->irq_data_topsys);
>  	if (ret) {
>  		dev_err(&i2c->dev, "Failed to add TOPSYS IRQ chip\n");
>  		return ret;
> @@ -164,18 +166,18 @@ static int max77843_probe(struct i2c_client *i2c,
>  	return 0;
>  
>  err_pmic_id:
> -	regmap_del_irq_chip(max77843->irq, max77843->irq_data);
> +	regmap_del_irq_chip(max77843->irq, max77843->irq_data_topsys);
>  
>  	return ret;
>  }
>  
>  static int max77843_remove(struct i2c_client *i2c)
>  {
> -	struct max77843 *max77843 = i2c_get_clientdata(i2c);
> +	struct max77693_dev *max77843 = i2c_get_clientdata(i2c);
>  
>  	mfd_remove_devices(max77843->dev);
>  
> -	regmap_del_irq_chip(max77843->irq, max77843->irq_data);
> +	regmap_del_irq_chip(max77843->irq, max77843->irq_data_topsys);
>  
>  	i2c_unregister_device(max77843->i2c_chg);
>  
> @@ -188,7 +190,7 @@ static const struct of_device_id max77843_dt_match[] = {
>  };
>  
>  static const struct i2c_device_id max77843_id[] = {
> -	{ "max77843", },
> +	{ "max77843", TYPE_MAX77843, },
>  	{ },
>  };
>  MODULE_DEVICE_TABLE(i2c, max77843_id);
> @@ -196,7 +198,7 @@ MODULE_DEVICE_TABLE(i2c, max77843_id);
>  static int __maybe_unused max77843_suspend(struct device *dev)
>  {
>  	struct i2c_client *i2c = container_of(dev, struct i2c_client, dev);
> -	struct max77843 *max77843 = i2c_get_clientdata(i2c);
> +	struct max77693_dev *max77843 = i2c_get_clientdata(i2c);
>  
>  	disable_irq(max77843->irq);
>  	if (device_may_wakeup(dev))
> @@ -208,7 +210,7 @@ static int __maybe_unused max77843_suspend(struct device *dev)
>  static int __maybe_unused max77843_resume(struct device *dev)
>  {
>  	struct i2c_client *i2c = container_of(dev, struct i2c_client, dev);
> -	struct max77843 *max77843 = i2c_get_clientdata(i2c);
> +	struct max77693_dev *max77843 = i2c_get_clientdata(i2c);
>  
>  	if (device_may_wakeup(dev))
>  		disable_irq_wake(max77843->irq);
> diff --git a/drivers/regulator/max77843.c b/drivers/regulator/max77843.c
> index f4fd0d3cfa6e..93507c3aff23 100644
> --- a/drivers/regulator/max77843.c
> +++ b/drivers/regulator/max77843.c
> @@ -16,6 +16,7 @@
>  #include <linux/regulator/driver.h>
>  #include <linux/regulator/machine.h>
>  #include <linux/mfd/max77843-private.h>
> +#include <linux/mfd/max77693-common.h>
>  #include <linux/regulator/of_regulator.h>
>  
>  enum max77843_regulator_type {
> @@ -130,7 +131,8 @@ static const struct regulator_desc max77843_supported_regulators[] = {
>  	},
>  };
>  
> -static struct regmap *max77843_get_regmap(struct max77843 *max77843, int reg_id)
> +static struct regmap *max77843_get_regmap(struct max77693_dev *max77843,
> +					  int reg_id)
>  {
>  	switch (reg_id) {
>  	case MAX77843_SAFEOUT1:
> @@ -145,7 +147,7 @@ static struct regmap *max77843_get_regmap(struct max77843 *max77843, int reg_id)
>  
>  static int max77843_regulator_probe(struct platform_device *pdev)
>  {
> -	struct max77843 *max77843 = dev_get_drvdata(pdev->dev.parent);
> +	struct max77693_dev *max77843 = dev_get_drvdata(pdev->dev.parent);
>  	struct regulator_config config = {};
>  	int i;
>  
> diff --git a/include/linux/mfd/max77693-common.h b/include/linux/mfd/max77693-common.h
> index 7da4cc38e982..095b121aa725 100644
> --- a/include/linux/mfd/max77693-common.h
> +++ b/include/linux/mfd/max77693-common.h
> @@ -15,6 +15,9 @@
>  enum max77693_types {
>  	TYPE_MAX77693_UNKNOWN,
>  	TYPE_MAX77693,
> +	TYPE_MAX77843,
> +
> +	TYPE_MAX77693_NUM,
>  };
>  
>  /*
> @@ -25,12 +28,14 @@ struct max77693_dev {
>  	struct i2c_client *i2c;		/* 0xCC , PMIC, Charger, Flash LED */
>  	struct i2c_client *i2c_muic;	/* 0x4A , MUIC */
>  	struct i2c_client *i2c_haptic;	/* MAX77693: 0x90 , Haptic */
> +	struct i2c_client *i2c_chg;	/* MAX77843: 0xD2, Charger */
>  
>  	enum max77693_types type;
>  
>  	struct regmap *regmap;
>  	struct regmap *regmap_muic;
>  	struct regmap *regmap_haptic;	/* Only MAX77693 */
> +	struct regmap *regmap_chg;	/* Only MAX77843 */
>  
>  	struct regmap_irq_chip_data *irq_data_led;
>  	struct regmap_irq_chip_data *irq_data_topsys;
> diff --git a/include/linux/mfd/max77843-private.h b/include/linux/mfd/max77843-private.h
> index 7178ace8379e..0121d9440340 100644
> --- a/include/linux/mfd/max77843-private.h
> +++ b/include/linux/mfd/max77843-private.h
> @@ -431,24 +431,4 @@ enum max77843_irq_muic {
>  #define MAX77843_REG_SAFEOUTCTRL_SAFEOUT2_MASK \
>  		(0x3 << SAFEOUTCTRL_SAFEOUT2_SHIFT)
>  
> -struct max77843 {
> -	struct device *dev;
> -
> -	struct i2c_client *i2c;
> -	struct i2c_client *i2c_chg;
> -	struct i2c_client *i2c_fuel;
> -	struct i2c_client *i2c_muic;
> -
> -	struct regmap *regmap;
> -	struct regmap *regmap_chg;
> -	struct regmap *regmap_fuel;
> -	struct regmap *regmap_muic;
> -
> -	struct regmap_irq_chip_data *irq_data;
> -	struct regmap_irq_chip_data *irq_data_chg;
> -	struct regmap_irq_chip_data *irq_data_fuel;
> -	struct regmap_irq_chip_data *irq_data_muic;
> -
> -	int irq;
> -};
>  #endif /* __MAX77843_H__ */
> -- 
> 2.1.4
> 

-- 
Dmitry
