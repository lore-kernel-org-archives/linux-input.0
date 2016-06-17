From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [RESEND v7 1/6] mfd: max8997: Use regmap to access registers
Date: Fri, 17 Jun 2016 08:53:49 +0100
Message-ID: <20160617075349.GE21702@dell>
References: <1466143833-5856-1-git-send-email-k.kozlowski@samsung.com>
 <1466143833-5856-2-git-send-email-k.kozlowski@samsung.com>
Reply-To: rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <rtc-linux+bncBDA7X7F2WUEBBZGYR25QKGQE4CGBIKA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Content-Disposition: inline
In-Reply-To: <1466143833-5856-2-git-send-email-k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/rtc-linux/subscribe>
To: Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, MyungJoo Ham <myungjoo.ham-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Chanwoo Choi <cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Richard Purdie <rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org>, Jacek Anaszewski <j.anaszewski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Alessandro Zummo <a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org>, Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-leds-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, r.baldyga-anjuHVi6/WSaMJb+Lgu22Q@public.gmane.org, Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-input@vger.kernel.org

FAO Mark,

Just your Ack missing on this set.

> From: Robert Baldyga <r.baldyga-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
>=20
> This patch modifies max8997 driver and each associated function driver,
> to use regmap instead of operating directly on i2c bus. It will allow to
> simplify IRQ handling using regmap-irq.
>=20
> Signed-off-by: Robert Baldyga <r.baldyga-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> Reviewed-by: Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> Acked-by: Chanwoo Choi <cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> Acked-by: Bryan Wu <cooloney-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Acked-by: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Acked-by: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> Acked-by: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Acked-by: Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> [k.kozlowski: Collect acks, rebase on v4.6-rc6]
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> Acked-by: Jacek Anaszewski <j.anaszewski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> ---
>  drivers/extcon/extcon-max8997.c       |  31 ++++----
>  drivers/input/misc/max8997_haptic.c   |  34 ++++----
>  drivers/leds/leds-max8997.c           |  13 ++--
>  drivers/mfd/Kconfig                   |   1 +
>  drivers/mfd/max8997-irq.c             |  64 ++++++---------
>  drivers/mfd/max8997.c                 | 141 +++++++++++++++-------------=
------
>  drivers/power/max8997_charger.c       |  33 ++++----
>  drivers/regulator/max8997-regulator.c |  87 ++++++++++-----------
>  drivers/rtc/rtc-max8997.c             |  56 ++++++++------
>  include/linux/mfd/max8997-private.h   |  17 ++--
>  10 files changed, 228 insertions(+), 249 deletions(-)
>=20
> diff --git a/drivers/extcon/extcon-max8997.c b/drivers/extcon/extcon-max8=
997.c
> index 9a89320d09a8..fc812257bfc7 100644
> --- a/drivers/extcon/extcon-max8997.c
> +++ b/drivers/extcon/extcon-max8997.c
> @@ -27,6 +27,7 @@
>  #include <linux/mfd/max8997-private.h>
>  #include <linux/extcon.h>
>  #include <linux/irqdomain.h>
> +#include <linux/regmap.h>
> =20
>  #define	DEV_NAME			"max8997-muic"
>  #define	DELAY_MS_DEFAULT		20000		/* unit: millisecond */
> @@ -116,7 +117,7 @@ enum max8997_muic_charger_type {
> =20
>  struct max8997_muic_info {
>  	struct device *dev;
> -	struct i2c_client *muic;
> +	struct max8997_dev *max8997;
>  	struct extcon_dev *edev;
>  	int prev_cable_type;
>  	int prev_chg_type;
> @@ -174,10 +175,10 @@ static int max8997_muic_set_debounce_time(struct ma=
x8997_muic_info *info,
>  	case ADC_DEBOUNCE_TIME_10MS:
>  	case ADC_DEBOUNCE_TIME_25MS:
>  	case ADC_DEBOUNCE_TIME_38_62MS:
> -		ret =3D max8997_update_reg(info->muic,
> +		ret =3D regmap_update_bits(info->max8997->regmap_muic,
>  					  MAX8997_MUIC_REG_CONTROL3,
> -					  time << CONTROL3_ADCDBSET_SHIFT,
> -					  CONTROL3_ADCDBSET_MASK);
> +					  CONTROL3_ADCDBSET_MASK,
> +					  time << CONTROL3_ADCDBSET_SHIFT);
>  		if (ret) {
>  			dev_err(info->dev, "failed to set ADC debounce time\n");
>  			return ret;
> @@ -212,8 +213,8 @@ static int max8997_muic_set_path(struct max8997_muic_=
info *info,
>  	else
>  		ctrl1 =3D CONTROL1_SW_OPEN;
> =20
> -	ret =3D max8997_update_reg(info->muic,
> -			MAX8997_MUIC_REG_CONTROL1, ctrl1, COMP_SW_MASK);
> +	ret =3D regmap_update_bits(info->max8997->regmap_muic,
> +			MAX8997_MUIC_REG_CONTROL1, COMP_SW_MASK, ctrl1);
>  	if (ret < 0) {
>  		dev_err(info->dev, "failed to update MUIC register\n");
>  		return ret;
> @@ -224,9 +225,9 @@ static int max8997_muic_set_path(struct max8997_muic_=
info *info,
>  	else
>  		ctrl2 |=3D CONTROL2_LOWPWR_MASK;	/* LowPwr=3D1, CPEn=3D0 */
> =20
> -	ret =3D max8997_update_reg(info->muic,
> -			MAX8997_MUIC_REG_CONTROL2, ctrl2,
> -			CONTROL2_LOWPWR_MASK | CONTROL2_CPEN_MASK);
> +	ret =3D regmap_update_bits(info->max8997->regmap_muic,
> +			MAX8997_MUIC_REG_CONTROL2,
> +			CONTROL2_LOWPWR_MASK | CONTROL2_CPEN_MASK, ctrl2);
>  	if (ret < 0) {
>  		dev_err(info->dev, "failed to update MUIC register\n");
>  		return ret;
> @@ -530,8 +531,8 @@ static void max8997_muic_irq_work(struct work_struct =
*work)
>  		if (info->irq =3D=3D muic_irqs[i].virq)
>  			irq_type =3D muic_irqs[i].irq;
> =20
> -	ret =3D max8997_bulk_read(info->muic, MAX8997_MUIC_REG_STATUS1,
> -				2, info->status);
> +	ret =3D regmap_bulk_read(info->max8997->regmap_muic,
> +				MAX8997_MUIC_REG_STATUS1, info->status, 2);
>  	if (ret) {
>  		dev_err(info->dev, "failed to read muic register\n");
>  		mutex_unlock(&info->mutex);
> @@ -590,8 +591,8 @@ static int max8997_muic_detect_dev(struct max8997_mui=
c_info *info)
>  	mutex_lock(&info->mutex);
> =20
>  	/* Read STATUSx register to detect accessory */
> -	ret =3D max8997_bulk_read(info->muic,
> -			MAX8997_MUIC_REG_STATUS1, 2, info->status);
> +	ret =3D regmap_bulk_read(info->max8997->regmap_muic,
> +			MAX8997_MUIC_REG_STATUS1, info->status, 2);
>  	if (ret) {
>  		dev_err(info->dev, "failed to read MUIC register\n");
>  		mutex_unlock(&info->mutex);
> @@ -650,7 +651,7 @@ static int max8997_muic_probe(struct platform_device =
*pdev)
>  		return -ENOMEM;
> =20
>  	info->dev =3D &pdev->dev;
> -	info->muic =3D max8997->muic;
> +	info->max8997 =3D max8997;
> =20
>  	platform_set_drvdata(pdev, info);
>  	mutex_init(&info->mutex);
> @@ -700,7 +701,7 @@ static int max8997_muic_probe(struct platform_device =
*pdev)
> =20
>  		/* Initialize registers according to platform data */
>  		for (i =3D 0; i < muic_pdata->num_init_data; i++) {
> -			max8997_write_reg(info->muic,
> +			regmap_write(info->max8997->regmap_muic,
>  					muic_pdata->init_data[i].addr,
>  					muic_pdata->init_data[i].data);
>  		}
> diff --git a/drivers/input/misc/max8997_haptic.c b/drivers/input/misc/max=
8997_haptic.c
> index 99bc762881d5..b1c81cdde240 100644
> --- a/drivers/input/misc/max8997_haptic.c
> +++ b/drivers/input/misc/max8997_haptic.c
> @@ -31,6 +31,7 @@
>  #include <linux/mfd/max8997-private.h>
>  #include <linux/mfd/max8997.h>
>  #include <linux/regulator/consumer.h>
> +#include <linux/regmap.h>
> =20
>  /* Haptic configuration 2 register */
>  #define MAX8997_MOTOR_TYPE_SHIFT	7
> @@ -45,7 +46,7 @@
> =20
>  struct max8997_haptic {
>  	struct device *dev;
> -	struct i2c_client *client;
> +	struct max8997_dev *max8997;
>  	struct input_dev *input_dev;
>  	struct regulator *regulator;
> =20
> @@ -86,19 +87,19 @@ static int max8997_haptic_set_duty_cycle(struct max89=
97_haptic *chip)
>  		}
>  		switch (chip->internal_mode_pattern) {
>  		case 0:
> -			max8997_write_reg(chip->client,
> +			regmap_write(chip->max8997->regmap_haptic,
>  				MAX8997_HAPTIC_REG_SIGPWMDC1, duty_index);
>  			break;
>  		case 1:
> -			max8997_write_reg(chip->client,
> +			regmap_write(chip->max8997->regmap_haptic,
>  				MAX8997_HAPTIC_REG_SIGPWMDC2, duty_index);
>  			break;
>  		case 2:
> -			max8997_write_reg(chip->client,
> +			regmap_write(chip->max8997->regmap_haptic,
>  				MAX8997_HAPTIC_REG_SIGPWMDC3, duty_index);
>  			break;
>  		case 3:
> -			max8997_write_reg(chip->client,
> +			regmap_write(chip->max8997->regmap_haptic,
>  				MAX8997_HAPTIC_REG_SIGPWMDC4, duty_index);
>  			break;
>  		default:
> @@ -115,50 +116,51 @@ static void max8997_haptic_configure(struct max8997=
_haptic *chip)
>  	value =3D chip->type << MAX8997_MOTOR_TYPE_SHIFT |
>  		chip->enabled << MAX8997_ENABLE_SHIFT |
>  		chip->mode << MAX8997_MODE_SHIFT | chip->pwm_divisor;
> -	max8997_write_reg(chip->client, MAX8997_HAPTIC_REG_CONF2, value);
> +	regmap_write(chip->max8997->regmap_haptic,
> +		MAX8997_HAPTIC_REG_CONF2, value);
> =20
>  	if (chip->mode =3D=3D MAX8997_INTERNAL_MODE && chip->enabled) {
>  		value =3D chip->internal_mode_pattern << MAX8997_CYCLE_SHIFT |
>  			chip->internal_mode_pattern << MAX8997_SIG_PERIOD_SHIFT |
>  			chip->internal_mode_pattern << MAX8997_SIG_DUTY_SHIFT |
>  			chip->internal_mode_pattern << MAX8997_PWM_DUTY_SHIFT;
> -		max8997_write_reg(chip->client,
> +		regmap_write(chip->max8997->regmap_haptic,
>  			MAX8997_HAPTIC_REG_DRVCONF, value);
> =20
>  		switch (chip->internal_mode_pattern) {
>  		case 0:
>  			value =3D chip->pattern_cycle << 4;
> -			max8997_write_reg(chip->client,
> +			regmap_write(chip->max8997->regmap_haptic,
>  				MAX8997_HAPTIC_REG_CYCLECONF1, value);
>  			value =3D chip->pattern_signal_period;
> -			max8997_write_reg(chip->client,
> +			regmap_write(chip->max8997->regmap_haptic,
>  				MAX8997_HAPTIC_REG_SIGCONF1, value);
>  			break;
> =20
>  		case 1:
>  			value =3D chip->pattern_cycle;
> -			max8997_write_reg(chip->client,
> +			regmap_write(chip->max8997->regmap_haptic,
>  				MAX8997_HAPTIC_REG_CYCLECONF1, value);
>  			value =3D chip->pattern_signal_period;
> -			max8997_write_reg(chip->client,
> +			regmap_write(chip->max8997->regmap_haptic,
>  				MAX8997_HAPTIC_REG_SIGCONF2, value);
>  			break;
> =20
>  		case 2:
>  			value =3D chip->pattern_cycle << 4;
> -			max8997_write_reg(chip->client,
> +			regmap_write(chip->max8997->regmap_haptic,
>  				MAX8997_HAPTIC_REG_CYCLECONF2, value);
>  			value =3D chip->pattern_signal_period;
> -			max8997_write_reg(chip->client,
> +			regmap_write(chip->max8997->regmap_haptic,
>  				MAX8997_HAPTIC_REG_SIGCONF3, value);
>  			break;
> =20
>  		case 3:
>  			value =3D chip->pattern_cycle;
> -			max8997_write_reg(chip->client,
> +			regmap_write(chip->max8997->regmap_haptic,
>  				MAX8997_HAPTIC_REG_CYCLECONF2, value);
>  			value =3D chip->pattern_signal_period;
> -			max8997_write_reg(chip->client,
> +			regmap_write(chip->max8997->regmap_haptic,
>  				MAX8997_HAPTIC_REG_SIGCONF4, value);
>  			break;
> =20
> @@ -279,7 +281,7 @@ static int max8997_haptic_probe(struct platform_devic=
e *pdev)
>  	INIT_WORK(&chip->work, max8997_haptic_play_effect_work);
>  	mutex_init(&chip->mutex);
> =20
> -	chip->client =3D iodev->haptic;
> +	chip->max8997 =3D iodev;
>  	chip->dev =3D &pdev->dev;
>  	chip->input_dev =3D input_dev;
>  	chip->pwm_period =3D haptic_pdata->pwm_period;
> diff --git a/drivers/leds/leds-max8997.c b/drivers/leds/leds-max8997.c
> index 4edf74f1d6d4..e5f0dc2e9edf 100644
> --- a/drivers/leds/leds-max8997.c
> +++ b/drivers/leds/leds-max8997.c
> @@ -17,6 +17,7 @@
>  #include <linux/mfd/max8997.h>
>  #include <linux/mfd/max8997-private.h>
>  #include <linux/platform_device.h>
> +#include <linux/regmap.h>
> =20
>  #define MAX8997_LED_FLASH_SHIFT			3
>  #define MAX8997_LED_FLASH_CUR_MASK		0xf8
> @@ -52,7 +53,6 @@ static void max8997_led_set_mode(struct max8997_led *le=
d,
>  			enum max8997_led_mode mode)
>  {
>  	int ret;
> -	struct i2c_client *client =3D led->iodev->i2c;
>  	u8 mask =3D 0, val;
> =20
>  	switch (mode) {
> @@ -88,8 +88,8 @@ static void max8997_led_set_mode(struct max8997_led *le=
d,
>  	}
> =20
>  	if (mask) {
> -		ret =3D max8997_update_reg(client, MAX8997_REG_LEN_CNTL, val,
> -					 mask);
> +		ret =3D regmap_update_bits(led->iodev->regmap,
> +					MAX8997_REG_LEN_CNTL, mask, val);
>  		if (ret)
>  			dev_err(led->iodev->dev,
>  				"failed to update register(%d)\n", ret);
> @@ -101,7 +101,6 @@ static void max8997_led_set_mode(struct max8997_led *=
led,
>  static void max8997_led_enable(struct max8997_led *led, bool enable)
>  {
>  	int ret;
> -	struct i2c_client *client =3D led->iodev->i2c;
>  	u8 val =3D 0, mask =3D MAX8997_LED_BOOST_ENABLE_MASK;
> =20
>  	if (led->enabled =3D=3D enable)
> @@ -109,7 +108,8 @@ static void max8997_led_enable(struct max8997_led *le=
d, bool enable)
> =20
>  	val =3D enable ? MAX8997_LED_BOOST_ENABLE_MASK : 0;
> =20
> -	ret =3D max8997_update_reg(client, MAX8997_REG_BOOST_CNTL, val, mask);
> +	ret =3D regmap_update_bits(led->iodev->regmap,
> +				MAX8997_REG_BOOST_CNTL, mask, val);
>  	if (ret)
>  		dev_err(led->iodev->dev,
>  			"failed to update register(%d)\n", ret);
> @@ -121,7 +121,6 @@ static void max8997_led_set_current(struct max8997_le=
d *led,
>  				enum led_brightness value)
>  {
>  	int ret;
> -	struct i2c_client *client =3D led->iodev->i2c;
>  	u8 val =3D 0, mask =3D 0, reg =3D 0;
> =20
>  	switch (led->led_mode) {
> @@ -142,7 +141,7 @@ static void max8997_led_set_current(struct max8997_le=
d *led,
>  	}
> =20
>  	if (mask) {
> -		ret =3D max8997_update_reg(client, reg, val, mask);
> +		ret =3D regmap_update_bits(led->iodev->regmap, reg, mask, val);
>  		if (ret)
>  			dev_err(led->iodev->dev,
>  				"failed to update register(%d)\n", ret);
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 1bcf601de5bc..d7c6491ce3b9 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -621,6 +621,7 @@ config MFD_MAX8997
>  	bool "Maxim Semiconductor MAX8997/8966 PMIC Support"
>  	depends on I2C=3Dy
>  	select MFD_CORE
> +	select REGMAP_I2C
>  	select IRQ_DOMAIN
>  	help
>  	  Say yes here to add support for Maxim Semiconductor MAX8997/8966.
> diff --git a/drivers/mfd/max8997-irq.c b/drivers/mfd/max8997-irq.c
> index b95a46d79b9d..6ab5f955c510 100644
> --- a/drivers/mfd/max8997-irq.c
> +++ b/drivers/mfd/max8997-irq.c
> @@ -26,6 +26,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/mfd/max8997.h>
>  #include <linux/mfd/max8997-private.h>
> +#include <linux/regmap.h>
> =20
>  static const u8 max8997_mask_reg[] =3D {
>  	[PMIC_INT1] =3D MAX8997_REG_INT1MSK,
> @@ -41,25 +42,6 @@ static const u8 max8997_mask_reg[] =3D {
>  	[FLASH_STATUS] =3D MAX8997_REG_INVALID,
>  };
> =20
> -static struct i2c_client *get_i2c(struct max8997_dev *max8997,
> -				enum max8997_irq_source src)
> -{
> -	switch (src) {
> -	case PMIC_INT1 ... PMIC_INT4:
> -		return max8997->i2c;
> -	case FUEL_GAUGE:
> -		return NULL;
> -	case MUIC_INT1 ... MUIC_INT3:
> -		return max8997->muic;
> -	case GPIO_LOW ... GPIO_HI:
> -		return max8997->i2c;
> -	case FLASH_STATUS:
> -		return max8997->i2c;
> -	default:
> -		return ERR_PTR(-EINVAL);
> -	}
> -}
> -
>  struct max8997_irq_data {
>  	int mask;
>  	enum max8997_irq_source group;
> @@ -124,15 +106,20 @@ static void max8997_irq_sync_unlock(struct irq_data=
 *data)
>  	int i;
> =20
>  	for (i =3D 0; i < MAX8997_IRQ_GROUP_NR; i++) {
> +		struct regmap *map;
>  		u8 mask_reg =3D max8997_mask_reg[i];
> -		struct i2c_client *i2c =3D get_i2c(max8997, i);
> +
> +		if (i >=3D MUIC_INT1 && i <=3D MUIC_INT3)
> +			map =3D max8997->regmap_muic;
> +		else
> +			map =3D max8997->regmap;
> =20
>  		if (mask_reg =3D=3D MAX8997_REG_INVALID ||
> -				IS_ERR_OR_NULL(i2c))
> +				IS_ERR_OR_NULL(map))
>  			continue;
>  		max8997->irq_masks_cache[i] =3D max8997->irq_masks_cur[i];
> =20
> -		max8997_write_reg(i2c, max8997_mask_reg[i],
> +		regmap_write(map, max8997_mask_reg[i],
>  				max8997->irq_masks_cur[i]);
>  	}
> =20
> @@ -180,11 +167,11 @@ static irqreturn_t max8997_irq_thread(int irq, void=
 *data)
>  {
>  	struct max8997_dev *max8997 =3D data;
>  	u8 irq_reg[MAX8997_IRQ_GROUP_NR] =3D {};
> -	u8 irq_src;
> +	unsigned int irq_src;
>  	int ret;
>  	int i, cur_irq;
> =20
> -	ret =3D max8997_read_reg(max8997->i2c, MAX8997_REG_INTSRC, &irq_src);
> +	ret =3D regmap_read(max8997->regmap, MAX8997_REG_INTSRC, &irq_src);
>  	if (ret < 0) {
>  		dev_err(max8997->dev, "Failed to read interrupt source: %d\n",
>  				ret);
> @@ -193,8 +180,8 @@ static irqreturn_t max8997_irq_thread(int irq, void *=
data)
> =20
>  	if (irq_src & MAX8997_IRQSRC_PMIC) {
>  		/* PMIC INT1 ~ INT4 */
> -		max8997_bulk_read(max8997->i2c, MAX8997_REG_INT1, 4,
> -				&irq_reg[PMIC_INT1]);
> +		regmap_bulk_read(max8997->regmap, MAX8997_REG_INT1,
> +				&irq_reg[PMIC_INT1], 4);
>  	}
>  	if (irq_src & MAX8997_IRQSRC_FUELGAUGE) {
>  		/*
> @@ -214,8 +201,8 @@ static irqreturn_t max8997_irq_thread(int irq, void *=
data)
>  	}
>  	if (irq_src & MAX8997_IRQSRC_MUIC) {
>  		/* MUIC INT1 ~ INT3 */
> -		max8997_bulk_read(max8997->muic, MAX8997_MUIC_REG_INT1, 3,
> -				&irq_reg[MUIC_INT1]);
> +		regmap_bulk_read(max8997->regmap_muic, MAX8997_MUIC_REG_INT1,
> +				&irq_reg[MUIC_INT1], 3);
>  	}
>  	if (irq_src & MAX8997_IRQSRC_GPIO) {
>  		/* GPIO Interrupt */
> @@ -224,8 +211,8 @@ static irqreturn_t max8997_irq_thread(int irq, void *=
data)
>  		irq_reg[GPIO_LOW] =3D 0;
>  		irq_reg[GPIO_HI] =3D 0;
> =20
> -		max8997_bulk_read(max8997->i2c, MAX8997_REG_GPIOCNTL1,
> -				MAX8997_NUM_GPIO, gpio_info);
> +		regmap_bulk_read(max8997->regmap, MAX8997_REG_GPIOCNTL1,
> +				gpio_info, MAX8997_NUM_GPIO);
>  		for (i =3D 0; i < MAX8997_NUM_GPIO; i++) {
>  			bool interrupt =3D false;
> =20
> @@ -259,8 +246,10 @@ static irqreturn_t max8997_irq_thread(int irq, void =
*data)
>  	}
>  	if (irq_src & MAX8997_IRQSRC_FLASH) {
>  		/* Flash Status Interrupt */
> -		ret =3D max8997_read_reg(max8997->i2c, MAX8997_REG_FLASHSTATUS,
> -				&irq_reg[FLASH_STATUS]);
> +		unsigned int data;
> +		ret =3D regmap_read(max8997->regmap,
> +				MAX8997_REG_FLASHSTATUS, &data);
> +		irq_reg[FLASH_STATUS] =3D data;
>  	}
> =20
>  	/* Apply masking */
> @@ -308,7 +297,7 @@ int max8997_irq_init(struct max8997_dev *max8997)
>  	struct irq_domain *domain;
>  	int i;
>  	int ret;
> -	u8 val;
> +	unsigned int val;
> =20
>  	if (!max8997->irq) {
>  		dev_warn(max8997->dev, "No interrupt specified.\n");
> @@ -319,22 +308,19 @@ int max8997_irq_init(struct max8997_dev *max8997)
> =20
>  	/* Mask individual interrupt sources */
>  	for (i =3D 0; i < MAX8997_IRQ_GROUP_NR; i++) {
> -		struct i2c_client *i2c;
> -
>  		max8997->irq_masks_cur[i] =3D 0xff;
>  		max8997->irq_masks_cache[i] =3D 0xff;
> -		i2c =3D get_i2c(max8997, i);
> =20
> -		if (IS_ERR_OR_NULL(i2c))
> +		if (IS_ERR_OR_NULL(max8997->regmap))
>  			continue;
>  		if (max8997_mask_reg[i] =3D=3D MAX8997_REG_INVALID)
>  			continue;
> =20
> -		max8997_write_reg(i2c, max8997_mask_reg[i], 0xff);
> +		regmap_write(max8997->regmap, max8997_mask_reg[i], 0xff);
>  	}
> =20
>  	for (i =3D 0; i < MAX8997_NUM_GPIO; i++) {
> -		max8997->gpio_status[i] =3D (max8997_read_reg(max8997->i2c,
> +		max8997->gpio_status[i] =3D (regmap_read(max8997->regmap,
>  						MAX8997_REG_GPIOCNTL1 + i,
>  						&val)
>  					& MAX8997_GPIO_DATA_MASK) ?
> diff --git a/drivers/mfd/max8997.c b/drivers/mfd/max8997.c
> index f316348e3d98..f1c82110b2ab 100644
> --- a/drivers/mfd/max8997.c
> +++ b/drivers/mfd/max8997.c
> @@ -33,6 +33,7 @@
>  #include <linux/mfd/core.h>
>  #include <linux/mfd/max8997.h>
>  #include <linux/mfd/max8997-private.h>
> +#include <linux/regmap.h>
> =20
>  #define I2C_ADDR_PMIC	(0xCC >> 1)
>  #define I2C_ADDR_MUIC	(0x4A >> 1)
> @@ -58,81 +59,29 @@ static const struct of_device_id max8997_pmic_dt_matc=
h[] =3D {
>  MODULE_DEVICE_TABLE(of, max8997_pmic_dt_match);
>  #endif
> =20
> -int max8997_read_reg(struct i2c_client *i2c, u8 reg, u8 *dest)
> -{
> -	struct max8997_dev *max8997 =3D i2c_get_clientdata(i2c);
> -	int ret;
> -
> -	mutex_lock(&max8997->iolock);
> -	ret =3D i2c_smbus_read_byte_data(i2c, reg);
> -	mutex_unlock(&max8997->iolock);
> -	if (ret < 0)
> -		return ret;
> -
> -	ret &=3D 0xff;
> -	*dest =3D ret;
> -	return 0;
> -}
> -EXPORT_SYMBOL_GPL(max8997_read_reg);
> -
> -int max8997_bulk_read(struct i2c_client *i2c, u8 reg, int count, u8 *buf=
)
> -{
> -	struct max8997_dev *max8997 =3D i2c_get_clientdata(i2c);
> -	int ret;
> -
> -	mutex_lock(&max8997->iolock);
> -	ret =3D i2c_smbus_read_i2c_block_data(i2c, reg, count, buf);
> -	mutex_unlock(&max8997->iolock);
> -	if (ret < 0)
> -		return ret;
> -
> -	return 0;
> -}
> -EXPORT_SYMBOL_GPL(max8997_bulk_read);
> -
> -int max8997_write_reg(struct i2c_client *i2c, u8 reg, u8 value)
> -{
> -	struct max8997_dev *max8997 =3D i2c_get_clientdata(i2c);
> -	int ret;
> -
> -	mutex_lock(&max8997->iolock);
> -	ret =3D i2c_smbus_write_byte_data(i2c, reg, value);
> -	mutex_unlock(&max8997->iolock);
> -	return ret;
> -}
> -EXPORT_SYMBOL_GPL(max8997_write_reg);
> -
> -int max8997_bulk_write(struct i2c_client *i2c, u8 reg, int count, u8 *bu=
f)
> -{
> -	struct max8997_dev *max8997 =3D i2c_get_clientdata(i2c);
> -	int ret;
> +static const struct regmap_config max8997_regmap_config =3D {
> +	.reg_bits =3D 8,
> +	.val_bits =3D 8,
> +	.max_register =3D MAX8997_REG_PMIC_END,
> +};
> =20
> -	mutex_lock(&max8997->iolock);
> -	ret =3D i2c_smbus_write_i2c_block_data(i2c, reg, count, buf);
> -	mutex_unlock(&max8997->iolock);
> -	if (ret < 0)
> -		return ret;
> +static const struct regmap_config max8997_regmap_rtc_config =3D {
> +	.reg_bits =3D 8,
> +	.val_bits =3D 8,
> +	.max_register =3D MAX8997_RTC_REG_END,
> +};
> =20
> -	return 0;
> -}
> -EXPORT_SYMBOL_GPL(max8997_bulk_write);
> +static const struct regmap_config max8997_regmap_haptic_config =3D {
> +	.reg_bits =3D 8,
> +	.val_bits =3D 8,
> +	.max_register =3D MAX8997_HAPTIC_REG_END,
> +};
> =20
> -int max8997_update_reg(struct i2c_client *i2c, u8 reg, u8 val, u8 mask)
> -{
> -	struct max8997_dev *max8997 =3D i2c_get_clientdata(i2c);
> -	int ret;
> -
> -	mutex_lock(&max8997->iolock);
> -	ret =3D i2c_smbus_read_byte_data(i2c, reg);
> -	if (ret >=3D 0) {
> -		u8 old_val =3D ret & 0xff;
> -		u8 new_val =3D (val & mask) | (old_val & (~mask));
> -		ret =3D i2c_smbus_write_byte_data(i2c, reg, new_val);
> -	}
> -	mutex_unlock(&max8997->iolock);
> -	return ret;
> -}
> -EXPORT_SYMBOL_GPL(max8997_update_reg);
> +static const struct regmap_config max8997_regmap_muic_config =3D {
> +	.reg_bits =3D 8,
> +	.val_bits =3D 8,
> +	.max_register =3D MAX8997_MUIC_REG_END,
> +};
> =20
>  /*
>   * Only the common platform data elements for max8997 are parsed here fr=
om the
> @@ -231,6 +180,41 @@ static int max8997_i2c_probe(struct i2c_client *i2c,
>  	}
>  	i2c_set_clientdata(max8997->muic, max8997);
> =20
> +	max8997->regmap =3D devm_regmap_init_i2c(i2c, &max8997_regmap_config);
> +	if (IS_ERR(max8997->regmap)) {
> +		ret =3D PTR_ERR(max8997->regmap);
> +		dev_err(max8997->dev,
> +				"failed to allocate register map: %d\n", ret);
> +		return ret;
> +	}
> +
> +	max8997->regmap_rtc =3D devm_regmap_init_i2c(max8997->rtc,
> +					&max8997_regmap_rtc_config);
> +	if (IS_ERR(max8997->regmap_rtc)) {
> +		ret =3D PTR_ERR(max8997->regmap_rtc);
> +		dev_err(max8997->dev,
> +				"failed to allocate register map: %d\n", ret);
> +		goto err_regmap;
> +	}
> +
> +	max8997->regmap_haptic =3D devm_regmap_init_i2c(max8997->haptic,
> +					&max8997_regmap_haptic_config);
> +	if (IS_ERR(max8997->regmap_haptic)) {
> +		ret =3D PTR_ERR(max8997->regmap_haptic);
> +		dev_err(max8997->dev,
> +				"failed to allocate register map: %d\n", ret);
> +		goto err_regmap;
> +	}
> +
> +	max8997->regmap_muic =3D devm_regmap_init_i2c(max8997->muic,
> +					&max8997_regmap_muic_config);
> +	if (IS_ERR(max8997->regmap_muic)) {
> +		ret =3D PTR_ERR(max8997->regmap_muic);
> +		dev_err(max8997->dev,
> +				"failed to allocate register map: %d\n", ret);
> +		goto err_regmap;
> +	}
> +
>  	pm_runtime_set_active(max8997->dev);
> =20
>  	max8997_irq_init(max8997);
> @@ -255,6 +239,7 @@ static int max8997_i2c_probe(struct i2c_client *i2c,
> =20
>  err_mfd:
>  	mfd_remove_devices(max8997->dev);
> +err_regmap:
>  	i2c_unregister_device(max8997->muic);
>  err_i2c_muic:
>  	i2c_unregister_device(max8997->haptic);
> @@ -442,15 +427,15 @@ static int max8997_freeze(struct device *dev)
>  	int i;
> =20
>  	for (i =3D 0; i < ARRAY_SIZE(max8997_dumpaddr_pmic); i++)
> -		max8997_read_reg(i2c, max8997_dumpaddr_pmic[i],
> +		regmap_read(max8997->regmap, max8997_dumpaddr_pmic[i],
>  				&max8997->reg_dump[i]);
> =20
>  	for (i =3D 0; i < ARRAY_SIZE(max8997_dumpaddr_muic); i++)
> -		max8997_read_reg(i2c, max8997_dumpaddr_muic[i],
> +		regmap_read(max8997->regmap_muic, max8997_dumpaddr_muic[i],
>  				&max8997->reg_dump[i + MAX8997_REG_PMIC_END]);
> =20
>  	for (i =3D 0; i < ARRAY_SIZE(max8997_dumpaddr_haptic); i++)
> -		max8997_read_reg(i2c, max8997_dumpaddr_haptic[i],
> +		regmap_read(max8997->regmap_haptic, max8997_dumpaddr_haptic[i],
>  				&max8997->reg_dump[i + MAX8997_REG_PMIC_END +
>  				MAX8997_MUIC_REG_END]);
> =20
> @@ -464,15 +449,15 @@ static int max8997_restore(struct device *dev)
>  	int i;
> =20
>  	for (i =3D 0; i < ARRAY_SIZE(max8997_dumpaddr_pmic); i++)
> -		max8997_write_reg(i2c, max8997_dumpaddr_pmic[i],
> +		regmap_write(max8997->regmap, max8997_dumpaddr_pmic[i],
>  				max8997->reg_dump[i]);
> =20
>  	for (i =3D 0; i < ARRAY_SIZE(max8997_dumpaddr_muic); i++)
> -		max8997_write_reg(i2c, max8997_dumpaddr_muic[i],
> +		regmap_write(max8997->regmap_muic, max8997_dumpaddr_muic[i],
>  				max8997->reg_dump[i + MAX8997_REG_PMIC_END]);
> =20
>  	for (i =3D 0; i < ARRAY_SIZE(max8997_dumpaddr_haptic); i++)
> -		max8997_write_reg(i2c, max8997_dumpaddr_haptic[i],
> +		regmap_write(max8997->regmap_haptic, max8997_dumpaddr_haptic[i],
>  				max8997->reg_dump[i + MAX8997_REG_PMIC_END +
>  				MAX8997_MUIC_REG_END]);
> =20
> diff --git a/drivers/power/max8997_charger.c b/drivers/power/max8997_char=
ger.c
> index 0b2eab571528..a9f5ddcf83a8 100644
> --- a/drivers/power/max8997_charger.c
> +++ b/drivers/power/max8997_charger.c
> @@ -26,6 +26,7 @@
>  #include <linux/power_supply.h>
>  #include <linux/mfd/max8997.h>
>  #include <linux/mfd/max8997-private.h>
> +#include <linux/regmap.h>
> =20
>  struct charger_data {
>  	struct device *dev;
> @@ -45,14 +46,14 @@ static int max8997_battery_get_property(struct power_=
supply *psy,
>  		union power_supply_propval *val)
>  {
>  	struct charger_data *charger =3D power_supply_get_drvdata(psy);
> -	struct i2c_client *i2c =3D charger->iodev->i2c;
>  	int ret;
> -	u8 reg;
> +	unsigned int reg;
> =20
>  	switch (psp) {
>  	case POWER_SUPPLY_PROP_STATUS:
>  		val->intval =3D 0;
> -		ret =3D max8997_read_reg(i2c, MAX8997_REG_STATUS4, &reg);
> +		ret =3D regmap_read(charger->iodev->regmap,
> +				MAX8997_REG_STATUS4, &reg);
>  		if (ret)
>  			return ret;
>  		if ((reg & (1 << 0)) =3D=3D 0x1)
> @@ -61,7 +62,8 @@ static int max8997_battery_get_property(struct power_su=
pply *psy,
>  		break;
>  	case POWER_SUPPLY_PROP_PRESENT:
>  		val->intval =3D 0;
> -		ret =3D max8997_read_reg(i2c, MAX8997_REG_STATUS4, &reg);
> +		ret =3D regmap_read(charger->iodev->regmap,
> +				MAX8997_REG_STATUS4, &reg);
>  		if (ret)
>  			return ret;
>  		if ((reg & (1 << 2)) =3D=3D 0x0)
> @@ -70,7 +72,8 @@ static int max8997_battery_get_property(struct power_su=
pply *psy,
>  		break;
>  	case POWER_SUPPLY_PROP_ONLINE:
>  		val->intval =3D 0;
> -		ret =3D max8997_read_reg(i2c, MAX8997_REG_STATUS4, &reg);
> +		ret =3D regmap_read(charger->iodev->regmap,
> +				MAX8997_REG_STATUS4, &reg);
>  		if (ret)
>  			return ret;
>  		/* DCINOK */
> @@ -111,8 +114,8 @@ static int max8997_battery_probe(struct platform_devi=
ce *pdev)
>  		if (val > 0xf)
>  			val =3D 0xf;
> =20
> -		ret =3D max8997_update_reg(iodev->i2c,
> -				MAX8997_REG_MBCCTRL5, val, 0xf);
> +		ret =3D regmap_update_bits(iodev->regmap,
> +				MAX8997_REG_MBCCTRL5, 0xf, val);
>  		if (ret < 0) {
>  			dev_err(&pdev->dev, "Cannot use i2c bus.\n");
>  			return ret;
> @@ -121,20 +124,20 @@ static int max8997_battery_probe(struct platform_de=
vice *pdev)
> =20
>  	switch (pdata->timeout) {
>  	case 5:
> -		ret =3D max8997_update_reg(iodev->i2c, MAX8997_REG_MBCCTRL1,
> -				0x2 << 4, 0x7 << 4);
> +		ret =3D regmap_update_bits(iodev->regmap,
> +				MAX8997_REG_MBCCTRL1, 0x7 << 4, 0x2 << 4);
>  		break;
>  	case 6:
> -		ret =3D max8997_update_reg(iodev->i2c, MAX8997_REG_MBCCTRL1,
> -				0x3 << 4, 0x7 << 4);
> +		ret =3D regmap_update_bits(iodev->regmap,
> +				MAX8997_REG_MBCCTRL1, 0x7 << 4, 0x3 << 4);
>  		break;
>  	case 7:
> -		ret =3D max8997_update_reg(iodev->i2c, MAX8997_REG_MBCCTRL1,
> -				0x4 << 4, 0x7 << 4);
> +		ret =3D regmap_update_bits(iodev->regmap,
> +				MAX8997_REG_MBCCTRL1, 0x7 << 4, 0x4 << 4);
>  		break;
>  	case 0:
> -		ret =3D max8997_update_reg(iodev->i2c, MAX8997_REG_MBCCTRL1,
> -				0x7 << 4, 0x7 << 4);
> +		ret =3D regmap_update_bits(iodev->regmap,
> +				MAX8997_REG_MBCCTRL1, 0x7 << 4, 0x7 << 4);
>  		break;
>  	default:
>  		dev_err(&pdev->dev, "incorrect timeout value (%d)\n",
> diff --git a/drivers/regulator/max8997-regulator.c b/drivers/regulator/ma=
x8997-regulator.c
> index efabc0ea0e96..362d85a849d5 100644
> --- a/drivers/regulator/max8997-regulator.c
> +++ b/drivers/regulator/max8997-regulator.c
> @@ -33,6 +33,7 @@
>  #include <linux/mfd/max8997.h>
>  #include <linux/mfd/max8997-private.h>
>  #include <linux/regulator/of_regulator.h>
> +#include <linux/regmap.h>
> =20
>  struct max8997_data {
>  	struct device *dev;
> @@ -50,7 +51,7 @@ struct max8997_data {
>  	int buck125_gpioindex;
>  	bool ignore_gpiodvs_side_effect;
> =20
> -	u8 saved_states[MAX8997_REG_MAX];
> +	unsigned int saved_states[MAX8997_REG_MAX];
>  };
> =20
>  static const unsigned int safeoutvolt[] =3D {
> @@ -257,15 +258,14 @@ static int max8997_get_enable_register(struct regul=
ator_dev *rdev,
>  static int max8997_reg_is_enabled(struct regulator_dev *rdev)
>  {
>  	struct max8997_data *max8997 =3D rdev_get_drvdata(rdev);
> -	struct i2c_client *i2c =3D max8997->iodev->i2c;
>  	int ret, reg, mask, pattern;
> -	u8 val;
> +	unsigned int val;
> =20
>  	ret =3D max8997_get_enable_register(rdev, &reg, &mask, &pattern);
>  	if (ret)
>  		return ret;
> =20
> -	ret =3D max8997_read_reg(i2c, reg, &val);
> +	ret =3D regmap_read(max8997->iodev->regmap, reg, &val);
>  	if (ret)
>  		return ret;
> =20
> @@ -275,27 +275,25 @@ static int max8997_reg_is_enabled(struct regulator_=
dev *rdev)
>  static int max8997_reg_enable(struct regulator_dev *rdev)
>  {
>  	struct max8997_data *max8997 =3D rdev_get_drvdata(rdev);
> -	struct i2c_client *i2c =3D max8997->iodev->i2c;
>  	int ret, reg, mask, pattern;
> =20
>  	ret =3D max8997_get_enable_register(rdev, &reg, &mask, &pattern);
>  	if (ret)
>  		return ret;
> =20
> -	return max8997_update_reg(i2c, reg, pattern, mask);
> +	return regmap_update_bits(max8997->iodev->regmap, reg, mask, pattern);
>  }
> =20
>  static int max8997_reg_disable(struct regulator_dev *rdev)
>  {
>  	struct max8997_data *max8997 =3D rdev_get_drvdata(rdev);
> -	struct i2c_client *i2c =3D max8997->iodev->i2c;
>  	int ret, reg, mask, pattern;
> =20
>  	ret =3D max8997_get_enable_register(rdev, &reg, &mask, &pattern);
>  	if (ret)
>  		return ret;
> =20
> -	return max8997_update_reg(i2c, reg, ~pattern, mask);
> +	return regmap_update_bits(max8997->iodev->regmap, reg, mask, ~pattern);
>  }
> =20
>  static int max8997_get_voltage_register(struct regulator_dev *rdev,
> @@ -367,15 +365,14 @@ static int max8997_get_voltage_register(struct regu=
lator_dev *rdev,
>  static int max8997_get_voltage_sel(struct regulator_dev *rdev)
>  {
>  	struct max8997_data *max8997 =3D rdev_get_drvdata(rdev);
> -	struct i2c_client *i2c =3D max8997->iodev->i2c;
>  	int reg, shift, mask, ret;
> -	u8 val;
> +	unsigned int val;
> =20
>  	ret =3D max8997_get_voltage_register(rdev, &reg, &shift, &mask);
>  	if (ret)
>  		return ret;
> =20
> -	ret =3D max8997_read_reg(i2c, reg, &val);
> +	ret =3D regmap_read(max8997->iodev->regmap, reg, &val);
>  	if (ret)
>  		return ret;
> =20
> @@ -412,7 +409,6 @@ static int max8997_set_voltage_charger_cv(struct regu=
lator_dev *rdev,
>  		int min_uV, int max_uV, unsigned *selector)
>  {
>  	struct max8997_data *max8997 =3D rdev_get_drvdata(rdev);
> -	struct i2c_client *i2c =3D max8997->iodev->i2c;
>  	int rid =3D rdev_get_id(rdev);
>  	int lb, ub;
>  	int reg, shift =3D 0, mask, ret =3D 0;
> @@ -454,7 +450,8 @@ static int max8997_set_voltage_charger_cv(struct regu=
lator_dev *rdev,
> =20
>  	*selector =3D val;
> =20
> -	ret =3D max8997_update_reg(i2c, reg, val << shift, mask);
> +	ret =3D regmap_update_bits(max8997->iodev->regmap,
> +				reg, mask, val << shift);
> =20
>  	return ret;
>  }
> @@ -467,7 +464,6 @@ static int max8997_set_voltage_ldobuck(struct regulat=
or_dev *rdev,
>  		int min_uV, int max_uV, unsigned *selector)
>  {
>  	struct max8997_data *max8997 =3D rdev_get_drvdata(rdev);
> -	struct i2c_client *i2c =3D max8997->iodev->i2c;
>  	const struct voltage_map_desc *desc;
>  	int rid =3D rdev_get_id(rdev);
>  	int i, reg, shift, mask, ret;
> @@ -499,7 +495,8 @@ static int max8997_set_voltage_ldobuck(struct regulat=
or_dev *rdev,
>  	if (ret)
>  		return ret;
> =20
> -	ret =3D max8997_update_reg(i2c, reg, i << shift, mask << shift);
> +	ret =3D regmap_update_bits(max8997->iodev->regmap,
> +				reg, mask << shift, i << shift);
>  	*selector =3D i;
> =20
>  	return ret;
> @@ -709,7 +706,6 @@ static int max8997_set_voltage_safeout_sel(struct reg=
ulator_dev *rdev,
>  					   unsigned selector)
>  {
>  	struct max8997_data *max8997 =3D rdev_get_drvdata(rdev);
> -	struct i2c_client *i2c =3D max8997->iodev->i2c;
>  	int rid =3D rdev_get_id(rdev);
>  	int reg, shift =3D 0, mask, ret;
> =20
> @@ -720,13 +716,13 @@ static int max8997_set_voltage_safeout_sel(struct r=
egulator_dev *rdev,
>  	if (ret)
>  		return ret;
> =20
> -	return max8997_update_reg(i2c, reg, selector << shift, mask << shift);
> +	return regmap_update_bits(max8997->iodev->regmap,
> +				reg, mask << shift, selector << shift);
>  }
> =20
>  static int max8997_reg_disable_suspend(struct regulator_dev *rdev)
>  {
>  	struct max8997_data *max8997 =3D rdev_get_drvdata(rdev);
> -	struct i2c_client *i2c =3D max8997->iodev->i2c;
>  	int ret, reg, mask, pattern;
>  	int rid =3D rdev_get_id(rdev);
> =20
> @@ -734,20 +730,22 @@ static int max8997_reg_disable_suspend(struct regul=
ator_dev *rdev)
>  	if (ret)
>  		return ret;
> =20
> -	max8997_read_reg(i2c, reg, &max8997->saved_states[rid]);
> +	regmap_read(max8997->iodev->regmap,
> +			reg, &max8997->saved_states[rid]);
> =20
>  	if (rid =3D=3D MAX8997_LDO1 ||
>  			rid =3D=3D MAX8997_LDO10 ||
>  			rid =3D=3D MAX8997_LDO21) {
>  		dev_dbg(&rdev->dev, "Conditional Power-Off for %s\n",
>  				rdev->desc->name);
> -		return max8997_update_reg(i2c, reg, 0x40, mask);
> +		return regmap_update_bits(max8997->iodev->regmap,
> +				reg, mask, 0x40);
>  	}
> =20
>  	dev_dbg(&rdev->dev, "Full Power-Off for %s (%xh -> %xh)\n",
>  			rdev->desc->name, max8997->saved_states[rid] & mask,
>  			(~pattern) & mask);
> -	return max8997_update_reg(i2c, reg, ~pattern, mask);
> +	return regmap_update_bits(max8997->iodev->regmap, reg, mask, ~pattern);
>  }
> =20
>  static struct regulator_ops max8997_ldo_ops =3D {
> @@ -1031,7 +1029,6 @@ static int max8997_pmic_probe(struct platform_devic=
e *pdev)
>  	struct regulator_config config =3D { };
>  	struct regulator_dev *rdev;
>  	struct max8997_data *max8997;
> -	struct i2c_client *i2c;
>  	int i, ret, nr_dvs;
>  	u8 max_buck1 =3D 0, max_buck2 =3D 0, max_buck5 =3D 0;
> =20
> @@ -1055,7 +1052,6 @@ static int max8997_pmic_probe(struct platform_devic=
e *pdev)
>  	max8997->iodev =3D iodev;
>  	max8997->num_regulators =3D pdata->num_regulators;
>  	platform_set_drvdata(pdev, max8997);
> -	i2c =3D max8997->iodev->i2c;
> =20
>  	max8997->buck125_gpioindex =3D pdata->buck125_default_idx;
>  	max8997->buck1_gpiodvs =3D pdata->buck1_gpiodvs;
> @@ -1105,25 +1101,25 @@ static int max8997_pmic_probe(struct platform_dev=
ice *pdev)
> =20
>  	/* For the safety, set max voltage before setting up */
>  	for (i =3D 0; i < 8; i++) {
> -		max8997_update_reg(i2c, MAX8997_REG_BUCK1DVS1 + i,
> -				max_buck1, 0x3f);
> -		max8997_update_reg(i2c, MAX8997_REG_BUCK2DVS1 + i,
> -				max_buck2, 0x3f);
> -		max8997_update_reg(i2c, MAX8997_REG_BUCK5DVS1 + i,
> -				max_buck5, 0x3f);
> +		regmap_update_bits(max8997->iodev->regmap,
> +				MAX8997_REG_BUCK1DVS1 + i, 0x3f, max_buck1);
> +		regmap_update_bits(max8997->iodev->regmap,
> +				MAX8997_REG_BUCK2DVS1 + i, 0x3f, max_buck2);
> +		regmap_update_bits(max8997->iodev->regmap,
> +				MAX8997_REG_BUCK5DVS1 + i, 0x3f, max_buck5);
>  	}
> =20
>  	/* Initialize all the DVS related BUCK registers */
>  	for (i =3D 0; i < nr_dvs; i++) {
> -		max8997_update_reg(i2c, MAX8997_REG_BUCK1DVS1 + i,
> -				max8997->buck1_vol[i],
> -				0x3f);
> -		max8997_update_reg(i2c, MAX8997_REG_BUCK2DVS1 + i,
> -				max8997->buck2_vol[i],
> -				0x3f);
> -		max8997_update_reg(i2c, MAX8997_REG_BUCK5DVS1 + i,
> -				max8997->buck5_vol[i],
> -				0x3f);
> +		regmap_update_bits(max8997->iodev->regmap,
> +				MAX8997_REG_BUCK1DVS1 + i,
> +				0x3f, max8997->buck1_vol[i]);
> +		regmap_update_bits(max8997->iodev->regmap,
> +				MAX8997_REG_BUCK2DVS1 + i,
> +				0x3f, max8997->buck2_vol[i]);
> +		regmap_update_bits(max8997->iodev->regmap,
> +				MAX8997_REG_BUCK5DVS1 + i,
> +				0x3f, max8997->buck5_vol[i]);
>  	}
> =20
>  	/*
> @@ -1167,16 +1163,17 @@ static int max8997_pmic_probe(struct platform_dev=
ice *pdev)
>  	}
> =20
>  	/* DVS-GPIO disabled */
> -	max8997_update_reg(i2c, MAX8997_REG_BUCK1CTRL, (pdata->buck1_gpiodvs) ?
> -			(1 << 1) : (0 << 1), 1 << 1);
> -	max8997_update_reg(i2c, MAX8997_REG_BUCK2CTRL, (pdata->buck2_gpiodvs) ?
> -			(1 << 1) : (0 << 1), 1 << 1);
> -	max8997_update_reg(i2c, MAX8997_REG_BUCK5CTRL, (pdata->buck5_gpiodvs) ?
> -			(1 << 1) : (0 << 1), 1 << 1);
> +	regmap_update_bits(max8997->iodev->regmap, MAX8997_REG_BUCK1CTRL,
> +			1 << 1, (pdata->buck1_gpiodvs) ? (1 << 1) : (0 << 1));
> +	regmap_update_bits(max8997->iodev->regmap, MAX8997_REG_BUCK2CTRL,
> +			1 << 1, (pdata->buck2_gpiodvs) ? (1 << 1) : (0 << 1));
> +	regmap_update_bits(max8997->iodev->regmap, MAX8997_REG_BUCK5CTRL,
> +			1 << 1, (pdata->buck5_gpiodvs) ? (1 << 1) : (0 << 1));
> =20
>  	/* Misc Settings */
>  	max8997->ramp_delay =3D 10; /* set 10mV/us, which is the default */
> -	max8997_write_reg(i2c, MAX8997_REG_BUCKRAMP, (0xf << 4) | 0x9);
> +	regmap_write(max8997->iodev->regmap,
> +			MAX8997_REG_BUCKRAMP, (0xf << 4) | 0x9);
> =20
>  	for (i =3D 0; i < pdata->num_regulators; i++) {
>  		const struct voltage_map_desc *desc;
> diff --git a/drivers/rtc/rtc-max8997.c b/drivers/rtc/rtc-max8997.c
> index db984d4bf952..d017a34a9f70 100644
> --- a/drivers/rtc/rtc-max8997.c
> +++ b/drivers/rtc/rtc-max8997.c
> @@ -22,6 +22,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/mfd/max8997-private.h>
>  #include <linux/irqdomain.h>
> +#include <linux/regmap.h>
> =20
>  /* Module parameter for WTSR function control */
>  static int wtsr_en =3D 1;
> @@ -70,7 +71,6 @@ enum {
>  struct max8997_rtc_info {
>  	struct device		*dev;
>  	struct max8997_dev	*max8997;
> -	struct i2c_client	*rtc;
>  	struct rtc_device	*rtc_dev;
>  	struct mutex		lock;
>  	int virq;
> @@ -120,8 +120,8 @@ static inline int max8997_rtc_set_update_reg(struct m=
ax8997_rtc_info *info)
>  {
>  	int ret;
> =20
> -	ret =3D max8997_write_reg(info->rtc, MAX8997_RTC_UPDATE1,
> -						RTC_UDR_MASK);
> +	ret =3D regmap_write(info->max8997->regmap_rtc,
> +				MAX8997_RTC_UPDATE1, RTC_UDR_MASK);
>  	if (ret < 0)
>  		dev_err(info->dev, "%s: fail to write update reg(%d)\n",
>  				__func__, ret);
> @@ -142,7 +142,8 @@ static int max8997_rtc_read_time(struct device *dev, =
struct rtc_time *tm)
>  	int ret;
> =20
>  	mutex_lock(&info->lock);
> -	ret =3D max8997_bulk_read(info->rtc, MAX8997_RTC_SEC, RTC_NR_TIME, data=
);
> +	ret =3D regmap_bulk_read(info->max8997->regmap_rtc,
> +				MAX8997_RTC_SEC, data, RTC_NR_TIME);
>  	mutex_unlock(&info->lock);
> =20
>  	if (ret < 0) {
> @@ -168,7 +169,8 @@ static int max8997_rtc_set_time(struct device *dev, s=
truct rtc_time *tm)
> =20
>  	mutex_lock(&info->lock);
> =20
> -	ret =3D max8997_bulk_write(info->rtc, MAX8997_RTC_SEC, RTC_NR_TIME, dat=
a);
> +	ret =3D regmap_bulk_write(info->max8997->regmap_rtc,
> +				MAX8997_RTC_SEC, data, RTC_NR_TIME);
>  	if (ret < 0) {
>  		dev_err(info->dev, "%s: fail to write time reg(%d)\n", __func__,
>  				ret);
> @@ -185,13 +187,13 @@ static int max8997_rtc_read_alarm(struct device *de=
v, struct rtc_wkalrm *alrm)
>  {
>  	struct max8997_rtc_info *info =3D dev_get_drvdata(dev);
>  	u8 data[RTC_NR_TIME];
> -	u8 val;
> +	unsigned int val;
>  	int i, ret;
> =20
>  	mutex_lock(&info->lock);
> =20
> -	ret =3D max8997_bulk_read(info->rtc, MAX8997_RTC_ALARM1_SEC, RTC_NR_TIM=
E,
> -			data);
> +	ret =3D regmap_bulk_read(info->max8997->regmap_rtc,
> +				MAX8997_RTC_ALARM1_SEC, data, RTC_NR_TIME);
>  	if (ret < 0) {
>  		dev_err(info->dev, "%s:%d fail to read alarm reg(%d)\n",
>  				__func__, __LINE__, ret);
> @@ -209,7 +211,8 @@ static int max8997_rtc_read_alarm(struct device *dev,=
 struct rtc_wkalrm *alrm)
>  	}
> =20
>  	alrm->pending =3D 0;
> -	ret =3D max8997_read_reg(info->max8997->i2c, MAX8997_REG_STATUS1, &val)=
;
> +	ret =3D regmap_read(info->max8997->regmap_rtc,
> +			       MAX8997_REG_STATUS1, &val);
>  	if (ret < 0) {
>  		dev_err(info->dev, "%s:%d fail to read status1 reg(%d)\n",
>  				__func__, __LINE__, ret);
> @@ -232,8 +235,8 @@ static int max8997_rtc_stop_alarm(struct max8997_rtc_=
info *info)
>  	if (!mutex_is_locked(&info->lock))
>  		dev_warn(info->dev, "%s: should have mutex locked\n", __func__);
> =20
> -	ret =3D max8997_bulk_read(info->rtc, MAX8997_RTC_ALARM1_SEC, RTC_NR_TIM=
E,
> -				data);
> +	ret =3D regmap_bulk_read(info->max8997->regmap_rtc,
> +				MAX8997_RTC_ALARM1_SEC, data, RTC_NR_TIME);
>  	if (ret < 0) {
>  		dev_err(info->dev, "%s: fail to read alarm reg(%d)\n",
>  				__func__, ret);
> @@ -243,8 +246,8 @@ static int max8997_rtc_stop_alarm(struct max8997_rtc_=
info *info)
>  	for (i =3D 0; i < RTC_NR_TIME; i++)
>  		data[i] &=3D ~ALARM_ENABLE_MASK;
> =20
> -	ret =3D max8997_bulk_write(info->rtc, MAX8997_RTC_ALARM1_SEC, RTC_NR_TI=
ME,
> -				 data);
> +	ret =3D regmap_bulk_write(info->max8997->regmap_rtc,
> +				 MAX8997_RTC_ALARM1_SEC, data, RTC_NR_TIME);
>  	if (ret < 0) {
>  		dev_err(info->dev, "%s: fail to write alarm reg(%d)\n",
>  				__func__, ret);
> @@ -264,8 +267,8 @@ static int max8997_rtc_start_alarm(struct max8997_rtc=
_info *info)
>  	if (!mutex_is_locked(&info->lock))
>  		dev_warn(info->dev, "%s: should have mutex locked\n", __func__);
> =20
> -	ret =3D max8997_bulk_read(info->rtc, MAX8997_RTC_ALARM1_SEC, RTC_NR_TIM=
E,
> -				data);
> +	ret =3D regmap_bulk_read(info->max8997->regmap_rtc,
> +				MAX8997_RTC_ALARM1_SEC, data, RTC_NR_TIME);
>  	if (ret < 0) {
>  		dev_err(info->dev, "%s: fail to read alarm reg(%d)\n",
>  				__func__, ret);
> @@ -283,8 +286,8 @@ static int max8997_rtc_start_alarm(struct max8997_rtc=
_info *info)
>  	if (data[RTC_DATE] & 0x1f)
>  		data[RTC_DATE] |=3D (1 << ALARM_ENABLE_SHIFT);
> =20
> -	ret =3D max8997_bulk_write(info->rtc, MAX8997_RTC_ALARM1_SEC, RTC_NR_TI=
ME,
> -				 data);
> +	ret =3D regmap_bulk_write(info->max8997->regmap_rtc,
> +				 MAX8997_RTC_ALARM1_SEC, data, RTC_NR_TIME);
>  	if (ret < 0) {
>  		dev_err(info->dev, "%s: fail to write alarm reg(%d)\n",
>  				__func__, ret);
> @@ -315,8 +318,8 @@ static int max8997_rtc_set_alarm(struct device *dev, =
struct rtc_wkalrm *alrm)
>  	if (ret < 0)
>  		goto out;
> =20
> -	ret =3D max8997_bulk_write(info->rtc, MAX8997_RTC_ALARM1_SEC, RTC_NR_TI=
ME,
> -				data);
> +	ret =3D regmap_bulk_write(info->max8997->regmap_rtc,
> +				 MAX8997_RTC_ALARM1_SEC, data, RTC_NR_TIME);
>  	if (ret < 0) {
>  		dev_err(info->dev, "%s: fail to write alarm reg(%d)\n",
>  				__func__, ret);
> @@ -387,7 +390,8 @@ static void max8997_rtc_enable_wtsr(struct max8997_rt=
c_info *info, bool enable)
>  	dev_info(info->dev, "%s: %s WTSR\n", __func__,
>  			enable ? "enable" : "disable");
> =20
> -	ret =3D max8997_update_reg(info->rtc, MAX8997_RTC_WTSR_SMPL, val, mask)=
;
> +	ret =3D regmap_update_bits(info->max8997->regmap_rtc,
> +				 MAX8997_RTC_WTSR_SMPL, mask, val);
>  	if (ret < 0) {
>  		dev_err(info->dev, "%s: fail to update WTSR reg(%d)\n",
>  				__func__, ret);
> @@ -400,7 +404,7 @@ static void max8997_rtc_enable_wtsr(struct max8997_rt=
c_info *info, bool enable)
>  static void max8997_rtc_enable_smpl(struct max8997_rtc_info *info, bool =
enable)
>  {
>  	int ret;
> -	u8 val, mask;
> +	unsigned int val, mask;
> =20
>  	if (!smpl_en)
>  		return;
> @@ -415,7 +419,8 @@ static void max8997_rtc_enable_smpl(struct max8997_rt=
c_info *info, bool enable)
>  	dev_info(info->dev, "%s: %s SMPL\n", __func__,
>  			enable ? "enable" : "disable");
> =20
> -	ret =3D max8997_update_reg(info->rtc, MAX8997_RTC_WTSR_SMPL, val, mask)=
;
> +	ret =3D regmap_update_bits(info->max8997->regmap_rtc,
> +				 MAX8997_RTC_WTSR_SMPL, mask, val);
>  	if (ret < 0) {
>  		dev_err(info->dev, "%s: fail to update SMPL reg(%d)\n",
>  				__func__, ret);
> @@ -425,7 +430,8 @@ static void max8997_rtc_enable_smpl(struct max8997_rt=
c_info *info, bool enable)
>  	max8997_rtc_set_update_reg(info);
> =20
>  	val =3D 0;
> -	max8997_read_reg(info->rtc, MAX8997_RTC_WTSR_SMPL, &val);
> +	regmap_read(info->max8997->regmap_rtc,
> +			 MAX8997_RTC_WTSR_SMPL, &val);
>  	pr_info("WTSR_SMPL(0x%02x)\n", val);
>  }
> =20
> @@ -440,7 +446,8 @@ static int max8997_rtc_init_reg(struct max8997_rtc_in=
fo *info)
> =20
>  	info->rtc_24hr_mode =3D 1;
> =20
> -	ret =3D max8997_bulk_write(info->rtc, MAX8997_RTC_CTRLMASK, 2, data);
> +	ret =3D regmap_bulk_write(info->max8997->regmap_rtc,
> +				 MAX8997_RTC_CTRLMASK, data, 2);
>  	if (ret < 0) {
>  		dev_err(info->dev, "%s: fail to write controlm reg(%d)\n",
>  				__func__, ret);
> @@ -465,7 +472,6 @@ static int max8997_rtc_probe(struct platform_device *=
pdev)
>  	mutex_init(&info->lock);
>  	info->dev =3D &pdev->dev;
>  	info->max8997 =3D max8997;
> -	info->rtc =3D max8997->rtc;
> =20
>  	platform_set_drvdata(pdev, info);
> =20
> diff --git a/include/linux/mfd/max8997-private.h b/include/linux/mfd/max8=
997-private.h
> index 78c76cd4d37b..ea80ef80dbf8 100644
> --- a/include/linux/mfd/max8997-private.h
> +++ b/include/linux/mfd/max8997-private.h
> @@ -309,6 +309,8 @@ enum max8997_rtc_reg {
>  	MAX8997_RTC_ALARM2_MONTH	=3D 0x22,
>  	MAX8997_RTC_ALARM2_YEAR		=3D 0x23,
>  	MAX8997_RTC_ALARM2_DAY_OF_MONTH	=3D 0x24,
> +
> +	MAX8997_RTC_REG_END		=3D 0x25,
>  };
> =20
>  enum max8997_irq_source {
> @@ -390,6 +392,11 @@ struct max8997_dev {
>  	unsigned long type;
>  	struct platform_device *battery; /* battery control (not fuel gauge) */
> =20
> +	struct regmap *regmap;
> +	struct regmap *regmap_rtc;
> +	struct regmap *regmap_haptic;
> +	struct regmap *regmap_muic;
> +
>  	int irq;
>  	int ono;
>  	struct irq_domain *irq_domain;
> @@ -398,7 +405,7 @@ struct max8997_dev {
>  	int irq_masks_cache[MAX8997_IRQ_GROUP_NR];
> =20
>  	/* For hibernation */
> -	u8 reg_dump[MAX8997_REG_PMIC_END + MAX8997_MUIC_REG_END +
> +	unsigned int reg_dump[MAX8997_REG_PMIC_END + MAX8997_MUIC_REG_END +
>  		MAX8997_HAPTIC_REG_END];
> =20
>  	bool gpio_status[MAX8997_NUM_GPIO];
> @@ -413,14 +420,6 @@ extern int max8997_irq_init(struct max8997_dev *max8=
997);
>  extern void max8997_irq_exit(struct max8997_dev *max8997);
>  extern int max8997_irq_resume(struct max8997_dev *max8997);
> =20
> -extern int max8997_read_reg(struct i2c_client *i2c, u8 reg, u8 *dest);
> -extern int max8997_bulk_read(struct i2c_client *i2c, u8 reg, int count,
> -				u8 *buf);
> -extern int max8997_write_reg(struct i2c_client *i2c, u8 reg, u8 value);
> -extern int max8997_bulk_write(struct i2c_client *i2c, u8 reg, int count,
> -				u8 *buf);
> -extern int max8997_update_reg(struct i2c_client *i2c, u8 reg, u8 val, u8=
 mask);
> -
>  #define MAX8997_GPIO_INT_BOTH	(0x3 << 4)
>  #define MAX8997_GPIO_INT_RISE	(0x2 << 4)
>  #define MAX8997_GPIO_INT_FALL	(0x1 << 4)

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

--=20
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
---=20
You received this message because you are subscribed to the Google Groups "=
rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to rtc-linux+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.
