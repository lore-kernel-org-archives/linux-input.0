From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 2/2] hwmon: da9052: add support for TSI channel
Date: Mon, 26 Jun 2017 15:59:31 -0700
Message-ID: <20170626225931.GB31139@roeck-us.net>
References: <20170626144832.32322-1-sebastian.reichel@collabora.co.uk>
 <20170626144832.32322-3-sebastian.reichel@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-hwmon-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170626144832.32322-3-sebastian.reichel@collabora.co.uk>
Sender: linux-hwmon-owner@vger.kernel.org
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: Sebastian Reichel <sre@kernel.org>, Support Opensource <support.opensource@diasemi.com>, Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jean Delvare <jdelvare@suse.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, devicetree@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, Jun 26, 2017 at 04:48:32PM +0200, Sebastian Reichel wrote:
> TSI channel has a 4 channel mux connected to it and is normally
> used for touchscreen support. The hardware may alternatively
> use it as general purpose adc.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
> ---
>  .../devicetree/bindings/mfd/da9052-i2c.txt         |   8 +
>  drivers/hwmon/da9052-hwmon.c                       | 229 ++++++++++++++++++++-
>  drivers/input/touchscreen/da9052_tsi.c             |   5 +
>  include/linux/mfd/da9052/da9052.h                  |   6 +
>  4 files changed, 244 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/da9052-i2c.txt b/Documentation/devicetree/bindings/mfd/da9052-i2c.txt
> index 9554292dc6cb..94f3bb1d9a0a 100644
> --- a/Documentation/devicetree/bindings/mfd/da9052-i2c.txt
> +++ b/Documentation/devicetree/bindings/mfd/da9052-i2c.txt
> @@ -4,6 +4,14 @@ Required properties:
>  - compatible : Should be "dlg,da9052", "dlg,da9053-aa",
>  			 "dlg,da9053-ab", or "dlg,da9053-bb"
>  
> +Optional properties:
> +- diag,tsi-as-adc : Boolean, if set the X+, X-, Y+, Y- touchscreen
> +                    input lines are used as general purpose analogue
> +					input.
> +- diag,tsiref-microvolt: Voltage applied to the TSIREF pin, which is
> +                         used as reference voltage when reading TSI
> +						 pins as ADC. Defaults to 2500000.

Wouldn't it be better to handle this using a regulator ?

> +
>  Sub-nodes:
>  - regulators : Contain the regulator nodes. The DA9052/53 regulators are
>    bound using their names as listed below:
> diff --git a/drivers/hwmon/da9052-hwmon.c b/drivers/hwmon/da9052-hwmon.c
> index c9832bfacfe5..a0b9d5498ba4 100644
> --- a/drivers/hwmon/da9052-hwmon.c
> +++ b/drivers/hwmon/da9052-hwmon.c
> @@ -20,13 +20,17 @@
>  #include <linux/module.h>
>  #include <linux/slab.h>
>  #include <linux/platform_device.h>
> +#include <linux/property.h>
>  
>  #include <linux/mfd/da9052/da9052.h>
>  #include <linux/mfd/da9052/reg.h>
>  
>  struct da9052_hwmon {
> -	struct da9052	*da9052;
> -	struct mutex	hwmon_lock;
> +	struct da9052		*da9052;
> +	struct mutex		hwmon_lock;
> +	bool			tsi_as_adc;
> +	int			tsiref_mv;
> +	struct completion	tsidone;
>  };
>  
>  static const char * const input_names[] = {
> @@ -37,6 +41,10 @@ static const char * const input_names[] = {
>  	[DA9052_ADC_IN4]	=	"ADC IN4",
>  	[DA9052_ADC_IN5]	=	"ADC IN5",
>  	[DA9052_ADC_IN6]	=	"ADC IN6",
> +	[DA9052_ADC_TSI_XP]	=	"ADC TS X+",
> +	[DA9052_ADC_TSI_YP]	=	"ADC TS Y+",
> +	[DA9052_ADC_TSI_XN]	=	"ADC TS X-",
> +	[DA9052_ADC_TSI_YN]	=	"ADC TS Y-",
>  	[DA9052_ADC_TJUNC]	=	"BATTERY JUNCTION TEMP",
>  	[DA9052_ADC_VBBAT]	=	"BACK-UP BATTERY VOLTAGE",
>  };
> @@ -59,6 +67,11 @@ static inline int vbbat_reg_to_mv(int value)
>  	return DIV_ROUND_CLOSEST(value * 5000, 1023);
>  }
>  
> +static inline int input_tsireg_to_mv(struct da9052_hwmon *hwmon, int value)
> +{
> +	return DIV_ROUND_CLOSEST(value * hwmon->tsiref_mv, 1023);
> +}
> +
>  static inline int da9052_enable_vddout_channel(struct da9052 *da9052)
>  {
>  	return da9052_reg_update(da9052, DA9052_ADC_CONT_REG,
> @@ -154,6 +167,103 @@ static ssize_t da9052_read_misc_channel(struct device *dev,
>  	return sprintf(buf, "%d\n", input_reg_to_mv(ret));
>  }
>  
> +static int da9052_request_tsi_read(struct da9052_hwmon *hwmon, int channel)
> +{
> +	u8 val = BIT(6); /* TSI_MAN */
> +
> +	switch (channel) {
> +	case DA9052_ADC_TSI_XP:
> +		val |= (0 << 4); /* TSI_MUX */
> +		break;
> +	case DA9052_ADC_TSI_YP:
> +		val |= (1 << 4); /* TSI_MUX */
> +		break;
> +	case DA9052_ADC_TSI_XN:
> +		val |= (2 << 4); /* TSI_MUX */
> +		break;
> +	case DA9052_ADC_TSI_YN:
> +		val |= (3 << 4); /* TSI_MUX */
> +		break;
> +	}
> +
> +	return da9052_reg_write(hwmon->da9052, DA9052_TSI_CONT_B_REG, val);
> +}
> +
> +static int da9052_get_tsi_result(struct da9052_hwmon *hwmon, int channel)
> +{
> +	int msb, lsb;
> +
> +	switch (channel) {
> +	case DA9052_ADC_TSI_XP:
> +	case DA9052_ADC_TSI_XN:
> +		msb = da9052_reg_read(hwmon->da9052, DA9052_TSI_X_MSB_REG);
> +		if (msb < 0)
> +			return msb;
> +
> +		lsb = da9052_reg_read(hwmon->da9052, DA9052_TSI_LSB_REG);
> +		if (lsb < 0)
> +			return lsb;
> +
> +		break;
> +	case DA9052_ADC_TSI_YP:
> +	case DA9052_ADC_TSI_YN:
> +		msb = da9052_reg_read(hwmon->da9052, DA9052_TSI_Y_MSB_REG);
> +		if (msb < 0)
> +			return msb;
> +
> +		lsb = da9052_reg_read(hwmon->da9052, DA9052_TSI_LSB_REG);
> +		if (lsb < 0)
> +			return lsb;
> +		lsb >>= 2;
> +
> +		break;
> +	default:
> +		return -ENXIO;
> +	}
> +
> +	return (msb << 2) | (lsb & 0x3);
> +}
> +
> +
> +static ssize_t __da9052_read_tsi(struct device *dev, int channel)
> +{
> +	struct da9052_hwmon *hwmon = dev_get_drvdata(dev);
> +	int ret;
> +
> +	reinit_completion(&hwmon->tsidone);
> +
> +	ret = da9052_request_tsi_read(hwmon, channel);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Wait for an conversion done interrupt */
> +	if (!wait_for_completion_timeout(&hwmon->tsidone,
> +					 msecs_to_jiffies(500))) {
> +		dev_err(dev, "timeout waiting for TSI conversion interrupt\n");

Is that necessary ? After all, it is reported as -ETIMEOUT.

> +		return -ETIMEDOUT;
> +	}
> +
> +	return da9052_get_tsi_result(hwmon, channel);
> +}
> +
> +static ssize_t da9052_read_tsi(struct device *dev,
> +			       struct device_attribute *devattr,
> +			       char *buf)
> +{
> +	struct da9052_hwmon *hwmon = dev_get_drvdata(dev);
> +	int channel = to_sensor_dev_attr(devattr)->index;
> +	int ret;
> +
> +	mutex_lock(&hwmon->hwmon_lock);
> +	ret = __da9052_read_tsi(dev, channel);
> +	mutex_unlock(&hwmon->hwmon_lock);
> +
> +	if (ret < 0)
> +		return ret;
> +	else
> +		return sprintf(buf, "%d\n", input_tsireg_to_mv(hwmon, ret));
> +}
> +
>  static ssize_t da9052_read_tjunc(struct device *dev,
>  				 struct device_attribute *devattr, char *buf)
>  {
> @@ -196,6 +306,28 @@ static ssize_t show_label(struct device *dev,
>  		       input_names[to_sensor_dev_attr(devattr)->index]);
>  }
>  
> +static umode_t da9052_channel_is_visible(struct kobject *kobj,
> +					 struct attribute *a, int index)
> +{
> +	struct device *dev = container_of(kobj, struct device, kobj);
> +	struct da9052_hwmon *hwmon = dev_get_drvdata(dev);
> +
> +	switch (index) {
> +	case DA9052_ADC_TSI_XP:
> +	case DA9052_ADC_TSI_YP:
> +	case DA9052_ADC_TSI_XN:
> +	case DA9052_ADC_TSI_YN:
> +		break;
> +	default:
> +		return a->mode;
> +	}
> +
> +	if (!hwmon->tsi_as_adc)
> +		return 0;

Moving this into the case statement and using break;
in default: would simplify the code and make it a bit easier to read.

> +
> +	return a->mode;
> +}
> +
>  static SENSOR_DEVICE_ATTR(in0_input, S_IRUGO, da9052_read_vddout, NULL,
>  			  DA9052_ADC_VDDOUT);
>  static SENSOR_DEVICE_ATTR(in0_label, S_IRUGO, show_label, NULL,
> @@ -221,6 +353,23 @@ static SENSOR_DEVICE_ATTR(in9_input, S_IRUGO, da9052_read_vbbat, NULL,
>  static SENSOR_DEVICE_ATTR(in9_label, S_IRUGO, show_label, NULL,
>  			  DA9052_ADC_VBBAT);
>  
> +static SENSOR_DEVICE_ATTR(in70_input, S_IRUGO, da9052_read_tsi, NULL,
> +			  DA9052_ADC_TSI_XP);
> +static SENSOR_DEVICE_ATTR(in70_label, S_IRUGO, show_label, NULL,
> +			  DA9052_ADC_TSI_XP);
> +static SENSOR_DEVICE_ATTR(in71_input, S_IRUGO, da9052_read_tsi, NULL,
> +			  DA9052_ADC_TSI_XN);
> +static SENSOR_DEVICE_ATTR(in71_label, S_IRUGO, show_label, NULL,
> +			  DA9052_ADC_TSI_XN);
> +static SENSOR_DEVICE_ATTR(in72_input, S_IRUGO, da9052_read_tsi, NULL,
> +			  DA9052_ADC_TSI_YP);
> +static SENSOR_DEVICE_ATTR(in72_label, S_IRUGO, show_label, NULL,
> +			  DA9052_ADC_TSI_YP);
> +static SENSOR_DEVICE_ATTR(in73_input, S_IRUGO, da9052_read_tsi, NULL,
> +			  DA9052_ADC_TSI_YN);
> +static SENSOR_DEVICE_ATTR(in73_label, S_IRUGO, show_label, NULL,
> +			  DA9052_ADC_TSI_YN);
> +
>  static SENSOR_DEVICE_ATTR(curr1_input, S_IRUGO, da9052_read_ich, NULL,
>  			  DA9052_ADC_ICH);
>  static SENSOR_DEVICE_ATTR(curr1_label, S_IRUGO, show_label, NULL,
> @@ -246,6 +395,14 @@ static struct attribute *da9052_attrs[] = {
>  	&sensor_dev_attr_in5_label.dev_attr.attr,
>  	&sensor_dev_attr_in6_input.dev_attr.attr,
>  	&sensor_dev_attr_in6_label.dev_attr.attr,
> +	&sensor_dev_attr_in70_input.dev_attr.attr,
> +	&sensor_dev_attr_in70_label.dev_attr.attr,
> +	&sensor_dev_attr_in71_input.dev_attr.attr,
> +	&sensor_dev_attr_in71_label.dev_attr.attr,
> +	&sensor_dev_attr_in72_input.dev_attr.attr,
> +	&sensor_dev_attr_in72_label.dev_attr.attr,
> +	&sensor_dev_attr_in73_input.dev_attr.attr,
> +	&sensor_dev_attr_in73_label.dev_attr.attr,
>  	&sensor_dev_attr_in9_input.dev_attr.attr,
>  	&sensor_dev_attr_in9_label.dev_attr.attr,
>  	&sensor_dev_attr_curr1_input.dev_attr.attr,
> @@ -257,29 +414,93 @@ static struct attribute *da9052_attrs[] = {
>  	NULL
>  };
>  
> -ATTRIBUTE_GROUPS(da9052);
> +static const struct attribute_group da9052_group = {
> +	.attrs = da9052_attrs,
> +	.is_visible = da9052_channel_is_visible,
> +};
> +__ATTRIBUTE_GROUPS(da9052);
> +
> +static irqreturn_t da9052_tsi_datardy_irq(int irq, void *data)
> +{
> +	struct da9052_hwmon *hwmon = data;

Please make sure that there are no checkpatch warnings or errors.
I am quite sure here is one.

> +	complete(&hwmon->tsidone);
> +	return IRQ_HANDLED;
> +}
>  
>  static int da9052_hwmon_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
>  	struct da9052_hwmon *hwmon;
>  	struct device *hwmon_dev;
> +	int err;
>  
>  	hwmon = devm_kzalloc(dev, sizeof(struct da9052_hwmon), GFP_KERNEL);
>  	if (!hwmon)
>  		return -ENOMEM;
>  
> +	platform_set_drvdata(pdev, hwmon);
> +
>  	mutex_init(&hwmon->hwmon_lock);
>  	hwmon->da9052 = dev_get_drvdata(pdev->dev.parent);
>  
> +	init_completion(&hwmon->tsidone);
> +
> +	hwmon->tsi_as_adc =
> +		device_property_read_bool(pdev->dev.parent, "diag,tsi-as-adc");
> +
> +	/* get tsiref from DT, default to 2.5 Volt (typ. value in datasheet) */
> +	hwmon->tsiref_mv = 2500000;
> +	device_property_read_u32(pdev->dev.parent, "diag,tsiref-microvolt",
> +				 &hwmon->tsiref_mv);
> +
> +	/* convert from microvolt (DT) to millivolt (hwmon) */
> +	hwmon->tsiref_mv /= 1000;
> +
> +	/* TSIREF must be between 1.8 and 2.6 Volt according to datasheet */
> +	if (hwmon->tsiref_mv < 1800 || hwmon->tsiref_mv > 2600) {
> +		dev_err(hwmon->da9052->dev, "invalid TSIREF voltage: %d\n",
> +			hwmon->tsiref_mv);
> +		return -ENXIO;
> +	}
> +
> +	if (hwmon->tsi_as_adc) {
> +		/* disable touchscreen features */
> +		da9052_reg_write(hwmon->da9052, DA9052_TSI_CONT_A_REG, 0x00);
> +
> +		err = da9052_request_irq(hwmon->da9052, DA9052_IRQ_TSIREADY,
> +					 "tsiready-irq", da9052_tsi_datardy_irq,
> +					 hwmon);
> +		if (err) {
> +			dev_err(hwmon->da9052->dev,
> +				"Failed to register TSIRDY IRQ: %d\n", err);
> +			return err;
> +		}
> +	}
> +
>  	hwmon_dev = devm_hwmon_device_register_with_groups(dev, "da9052",
>  							   hwmon,
>  							   da9052_groups);
> -	return PTR_ERR_OR_ZERO(hwmon_dev);
> +	err = PTR_ERR_OR_ZERO(hwmon_dev);
> +	if (err) {
> +		if (hwmon->tsi_as_adc)
> +			da9052_free_irq(hwmon->da9052, DA9052_IRQ_TSIREADY, hwmon);
> +		return err;
> +	}
> +
> +	return 0;
> +}
> +
> +static int da9052_hwmon_remove(struct platform_device *pdev)
> +{
> +	struct da9052_hwmon *hwmon = platform_get_drvdata(pdev);
> +	if (hwmon->tsi_as_adc)
> +		da9052_free_irq(hwmon->da9052, DA9052_IRQ_TSIREADY, hwmon);
> +	return 0;
>  }
>  
>  static struct platform_driver da9052_hwmon_driver = {
>  	.probe = da9052_hwmon_probe,
> +	.remove = da9052_hwmon_remove,
>  	.driver = {
>  		.name = "da9052-hwmon",
>  	},
> diff --git a/drivers/input/touchscreen/da9052_tsi.c b/drivers/input/touchscreen/da9052_tsi.c
> index 5a013bb7bcad..f0cb239546a9 100644
> --- a/drivers/input/touchscreen/da9052_tsi.c
> +++ b/drivers/input/touchscreen/da9052_tsi.c
> @@ -16,6 +16,7 @@
>  #include <linux/delay.h>
>  #include <linux/platform_device.h>
>  #include <linux/interrupt.h>
> +#include <linux/property.h>
>  
>  #include <linux/mfd/da9052/reg.h>
>  #include <linux/mfd/da9052/da9052.h>
> @@ -238,6 +239,10 @@ static int da9052_ts_probe(struct platform_device *pdev)
>  	if (!da9052)
>  		return -EINVAL;
>  
> +	/* check if pins are used as general purpose ADC input */
> +	if (device_property_read_bool(pdev->dev.parent, "diag,tsi-as-adc"))
> +		return -ENODEV;
> +
>  	tsi = kzalloc(sizeof(struct da9052_tsi), GFP_KERNEL);
>  	input_dev = input_allocate_device();
>  	if (!tsi || !input_dev) {
> diff --git a/include/linux/mfd/da9052/da9052.h b/include/linux/mfd/da9052/da9052.h
> index ce9230af09c2..ae5b663836d0 100644
> --- a/include/linux/mfd/da9052/da9052.h
> +++ b/include/linux/mfd/da9052/da9052.h
> @@ -45,6 +45,12 @@
>  #define DA9052_ADC_TJUNC	8
>  #define DA9052_ADC_VBBAT	9
>  
> +/* TSI channel has its own 4 channel mux */
> +#define DA9052_ADC_TSI_XP	70
> +#define DA9052_ADC_TSI_XN	71
> +#define DA9052_ADC_TSI_YP	72
> +#define DA9052_ADC_TSI_YN	73
> +
>  #define DA9052_IRQ_DCIN	0
>  #define DA9052_IRQ_VBUS	1
>  #define DA9052_IRQ_DCINREM	2
> -- 
> 2.11.0
> 
