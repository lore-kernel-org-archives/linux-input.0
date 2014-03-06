From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH v2] mfd: max8997: use regmap to access registers
Date: Thu, 06 Mar 2014 11:44:00 +0900
Message-ID: <5317E0F0.60808@samsung.com>
References: <1394031497-16648-1-git-send-email-r.baldyga@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-leds-owner@vger.kernel.org>
In-reply-to: <1394031497-16648-1-git-send-email-r.baldyga@samsung.com>
Sender: linux-leds-owner@vger.kernel.org
To: Robert Baldyga <r.baldyga@samsung.com>
Cc: sameo@linux.intel.com, lee.jones@linaro.org, myungjoo.ham@samsung.com, dmitry.torokhov@gmail.com, cooloney@gmail.com, rpurdie@rpsys.net, dbaryshkov@gmail.com, dwmw2@infradead.org, lgirdwood@gmail.com, broonie@kernel.org, a.zummo@towertech.it, paul.gortmaker@windriver.com, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linux-leds@vger.kernel.org, rtc-linux@googlegroups.com, m.szyprowski@samsung.com, k.kozlowski@samsung.com
List-Id: linux-input@vger.kernel.org

This patch has build error as following:=20
I added some comment in max8997_irq_init()
At least, you should test kernel build.

drivers/mfd/max8997-irq.c: In function =91max8997_irq_init=92:
drivers/mfd/max8997-irq.c:333:3: error: =91i2c=92 undeclared (first use=
 in this function)
drivers/mfd/max8997-irq.c:333:3: note: each undeclared identifier is re=
ported only once for each function it appears in
make[2]: *** [drivers/mfd/max8997-irq.o] Error 1
make[1]: *** [drivers/mfd] Error 2
make[1]: *** Waiting for unfinished jobs....


Thansk,
Chanwoo CHoi

On 03/05/2014 11:58 PM, Robert Baldyga wrote:
> This patch modifies max8997 driver and each associated function drive=
r,
> to use regmap instead of operating directly on i2c bus. It will allow=
 to
> simplify IRQ handling using regmap-irq.
>=20
> Signed-off-by: Robert Baldyga <r.baldyga@samsung.com>
> ---
>=20
> Changelog:
>=20
> v2:
> - check devm_regmap_init_i2c() return value
> - use proper register maps for muic and haptic registers in functions
>   max8997_freeze() and max8997_restore()
> - fix style problems
>=20
> v1: http://www.spinics.net/lists/kernel/msg1700375.html
>=20
>  drivers/extcon/extcon-max8997.c     |   17 ++---
>  drivers/input/misc/max8997_haptic.c |   33 ++++-----
>  drivers/leds/leds-max8997.c         |   12 ++--
>  drivers/mfd/max8997-irq.c           |   31 ++++----
>  drivers/mfd/max8997.c               |  133 ++++++++++++++++++++++---=
----------
>  drivers/power/max8997_charger.c     |   28 ++++----
>  drivers/regulator/max8997.c         |   80 ++++++++++-----------
>  drivers/rtc/rtc-max8997.c           |   51 ++++++++------
>  include/linux/mfd/max8997-private.h |   19 +++--
>  9 files changed, 227 insertions(+), 177 deletions(-)
>=20
> diff --git a/drivers/extcon/extcon-max8997.c b/drivers/extcon/extcon-=
max8997.c
> index 6a00464..9abc614 100644
> --- a/drivers/extcon/extcon-max8997.c
> +++ b/drivers/extcon/extcon-max8997.c
> @@ -116,7 +116,7 @@ enum max8997_muic_charger_type {
> =20
>  struct max8997_muic_info {
>  	struct device *dev;
> -	struct i2c_client *muic;
> +	struct max8997_dev *max8997;
>  	struct extcon_dev *edev;
>  	int prev_cable_type;
>  	int prev_chg_type;
> @@ -190,7 +190,7 @@ static int max8997_muic_set_debounce_time(struct =
max8997_muic_info *info,
>  	case ADC_DEBOUNCE_TIME_10MS:
>  	case ADC_DEBOUNCE_TIME_25MS:
>  	case ADC_DEBOUNCE_TIME_38_62MS:
> -		ret =3D max8997_update_reg(info->muic,
> +		ret =3D max8997_update_reg(info->max8997->regmap_muic,
>  					  MAX8997_MUIC_REG_CONTROL3,
>  					  time << CONTROL3_ADCDBSET_SHIFT,
>  					  CONTROL3_ADCDBSET_MASK);
> @@ -228,7 +228,7 @@ static int max8997_muic_set_path(struct max8997_m=
uic_info *info,
>  	else
>  		ctrl1 =3D CONTROL1_SW_OPEN;
> =20
> -	ret =3D max8997_update_reg(info->muic,
> +	ret =3D max8997_update_reg(info->max8997->regmap_muic,
>  			MAX8997_MUIC_REG_CONTROL1, ctrl1, COMP_SW_MASK);
>  	if (ret < 0) {
>  		dev_err(info->dev, "failed to update MUIC register\n");
> @@ -240,7 +240,7 @@ static int max8997_muic_set_path(struct max8997_m=
uic_info *info,
>  	else
>  		ctrl2 |=3D CONTROL2_LOWPWR_MASK;	/* LowPwr=3D1, CPEn=3D0 */
> =20
> -	ret =3D max8997_update_reg(info->muic,
> +	ret =3D max8997_update_reg(info->max8997->regmap_muic,
>  			MAX8997_MUIC_REG_CONTROL2, ctrl2,
>  			CONTROL2_LOWPWR_MASK | CONTROL2_CPEN_MASK);
>  	if (ret < 0) {
> @@ -543,7 +543,8 @@ static void max8997_muic_irq_work(struct work_str=
uct *work)
>  		if (info->irq =3D=3D muic_irqs[i].virq)
>  			irq_type =3D muic_irqs[i].irq;
> =20
> -	ret =3D max8997_bulk_read(info->muic, MAX8997_MUIC_REG_STATUS1,
> +	ret =3D max8997_bulk_read(info->max8997->regmap_muic,
> +				MAX8997_MUIC_REG_STATUS1,
>  				2, info->status);
>  	if (ret) {
>  		dev_err(info->dev, "failed to read muic register\n");
> @@ -605,7 +606,7 @@ static int max8997_muic_detect_dev(struct max8997=
_muic_info *info)
>  	mutex_lock(&info->mutex);
> =20
>  	/* Read STATUSx register to detect accessory */
> -	ret =3D max8997_bulk_read(info->muic,
> +	ret =3D max8997_bulk_read(info->max8997->regmap_muic,
>  			MAX8997_MUIC_REG_STATUS1, 2, info->status);
>  	if (ret) {
>  		dev_err(info->dev, "failed to read MUIC register\n");
> @@ -667,7 +668,7 @@ static int max8997_muic_probe(struct platform_dev=
ice *pdev)
>  	}
> =20
>  	info->dev =3D &pdev->dev;
> -	info->muic =3D max8997->muic;
> +	info->max8997 =3D max8997;
> =20
>  	platform_set_drvdata(pdev, info);
>  	mutex_init(&info->mutex);
> @@ -721,7 +722,7 @@ static int max8997_muic_probe(struct platform_dev=
ice *pdev)
> =20
>  		/* Initialize registers according to platform data */
>  		for (i =3D 0; i < muic_pdata->num_init_data; i++) {
> -			max8997_write_reg(info->muic,
> +			max8997_write_reg(info->max8997->regmap_muic,
>  					muic_pdata->init_data[i].addr,
>  					muic_pdata->init_data[i].data);
>  		}
> diff --git a/drivers/input/misc/max8997_haptic.c b/drivers/input/misc=
/max8997_haptic.c
> index 1fea548..bce1f0f 100644
> --- a/drivers/input/misc/max8997_haptic.c
> +++ b/drivers/input/misc/max8997_haptic.c
> @@ -45,7 +45,7 @@
> =20
>  struct max8997_haptic {
>  	struct device *dev;
> -	struct i2c_client *client;
> +	struct max8997_dev *max8997;
>  	struct input_dev *input_dev;
>  	struct regulator *regulator;
> =20
> @@ -86,19 +86,19 @@ static int max8997_haptic_set_duty_cycle(struct m=
ax8997_haptic *chip)
>  		}
>  		switch (chip->internal_mode_pattern) {
>  		case 0:
> -			max8997_write_reg(chip->client,
> +			max8997_write_reg(chip->max8997->regmap_haptic,
>  				MAX8997_HAPTIC_REG_SIGPWMDC1, duty_index);
>  			break;
>  		case 1:
> -			max8997_write_reg(chip->client,
> +			max8997_write_reg(chip->max8997->regmap_haptic,
>  				MAX8997_HAPTIC_REG_SIGPWMDC2, duty_index);
>  			break;
>  		case 2:
> -			max8997_write_reg(chip->client,
> +			max8997_write_reg(chip->max8997->regmap_haptic,
>  				MAX8997_HAPTIC_REG_SIGPWMDC3, duty_index);
>  			break;
>  		case 3:
> -			max8997_write_reg(chip->client,
> +			max8997_write_reg(chip->max8997->regmap_haptic,
>  				MAX8997_HAPTIC_REG_SIGPWMDC4, duty_index);
>  			break;
>  		default:
> @@ -115,50 +115,51 @@ static void max8997_haptic_configure(struct max=
8997_haptic *chip)
>  	value =3D chip->type << MAX8997_MOTOR_TYPE_SHIFT |
>  		chip->enabled << MAX8997_ENABLE_SHIFT |
>  		chip->mode << MAX8997_MODE_SHIFT | chip->pwm_divisor;
> -	max8997_write_reg(chip->client, MAX8997_HAPTIC_REG_CONF2, value);
> +	max8997_write_reg(chip->max8997->regmap_haptic,
> +		MAX8997_HAPTIC_REG_CONF2, value);
> =20
>  	if (chip->mode =3D=3D MAX8997_INTERNAL_MODE && chip->enabled) {
>  		value =3D chip->internal_mode_pattern << MAX8997_CYCLE_SHIFT |
>  			chip->internal_mode_pattern << MAX8997_SIG_PERIOD_SHIFT |
>  			chip->internal_mode_pattern << MAX8997_SIG_DUTY_SHIFT |
>  			chip->internal_mode_pattern << MAX8997_PWM_DUTY_SHIFT;
> -		max8997_write_reg(chip->client,
> +		max8997_write_reg(chip->max8997->regmap_haptic,
>  			MAX8997_HAPTIC_REG_DRVCONF, value);
> =20
>  		switch (chip->internal_mode_pattern) {
>  		case 0:
>  			value =3D chip->pattern_cycle << 4;
> -			max8997_write_reg(chip->client,
> +			max8997_write_reg(chip->max8997->regmap_haptic,
>  				MAX8997_HAPTIC_REG_CYCLECONF1, value);
>  			value =3D chip->pattern_signal_period;
> -			max8997_write_reg(chip->client,
> +			max8997_write_reg(chip->max8997->regmap_haptic,
>  				MAX8997_HAPTIC_REG_SIGCONF1, value);
>  			break;
> =20
>  		case 1:
>  			value =3D chip->pattern_cycle;
> -			max8997_write_reg(chip->client,
> +			max8997_write_reg(chip->max8997->regmap_haptic,
>  				MAX8997_HAPTIC_REG_CYCLECONF1, value);
>  			value =3D chip->pattern_signal_period;
> -			max8997_write_reg(chip->client,
> +			max8997_write_reg(chip->max8997->regmap_haptic,
>  				MAX8997_HAPTIC_REG_SIGCONF2, value);
>  			break;
> =20
>  		case 2:
>  			value =3D chip->pattern_cycle << 4;
> -			max8997_write_reg(chip->client,
> +			max8997_write_reg(chip->max8997->regmap_haptic,
>  				MAX8997_HAPTIC_REG_CYCLECONF2, value);
>  			value =3D chip->pattern_signal_period;
> -			max8997_write_reg(chip->client,
> +			max8997_write_reg(chip->max8997->regmap_haptic,
>  				MAX8997_HAPTIC_REG_SIGCONF3, value);
>  			break;
> =20
>  		case 3:
>  			value =3D chip->pattern_cycle;
> -			max8997_write_reg(chip->client,
> +			max8997_write_reg(chip->max8997->regmap_haptic,
>  				MAX8997_HAPTIC_REG_CYCLECONF2, value);
>  			value =3D chip->pattern_signal_period;
> -			max8997_write_reg(chip->client,
> +			max8997_write_reg(chip->max8997->regmap_haptic,
>  				MAX8997_HAPTIC_REG_SIGCONF4, value);
>  			break;
> =20
> @@ -267,7 +268,7 @@ static int max8997_haptic_probe(struct platform_d=
evice *pdev)
>  	INIT_WORK(&chip->work, max8997_haptic_play_effect_work);
>  	mutex_init(&chip->mutex);
> =20
> -	chip->client =3D iodev->haptic;
> +	chip->max8997 =3D iodev;
>  	chip->dev =3D &pdev->dev;
>  	chip->input_dev =3D input_dev;
>  	chip->pwm_period =3D haptic_pdata->pwm_period;
> diff --git a/drivers/leds/leds-max8997.c b/drivers/leds/leds-max8997.=
c
> index f449a8b..a6b8696 100644
> --- a/drivers/leds/leds-max8997.c
> +++ b/drivers/leds/leds-max8997.c
> @@ -53,7 +53,6 @@ static void max8997_led_set_mode(struct max8997_led=
 *led,
>  			enum max8997_led_mode mode)
>  {
>  	int ret;
> -	struct i2c_client *client =3D led->iodev->i2c;
>  	u8 mask =3D 0, val;
> =20
>  	switch (mode) {
> @@ -89,8 +88,8 @@ static void max8997_led_set_mode(struct max8997_led=
 *led,
>  	}
> =20
>  	if (mask) {
> -		ret =3D max8997_update_reg(client, MAX8997_REG_LEN_CNTL, val,
> -					 mask);
> +		ret =3D max8997_update_reg(led->iodev->regmap,
> +					MAX8997_REG_LEN_CNTL, val, mask);
>  		if (ret)
>  			dev_err(led->iodev->dev,
>  				"failed to update register(%d)\n", ret);
> @@ -102,7 +101,6 @@ static void max8997_led_set_mode(struct max8997_l=
ed *led,
>  static void max8997_led_enable(struct max8997_led *led, bool enable)
>  {
>  	int ret;
> -	struct i2c_client *client =3D led->iodev->i2c;
>  	u8 val =3D 0, mask =3D MAX8997_LED_BOOST_ENABLE_MASK;
> =20
>  	if (led->enabled =3D=3D enable)
> @@ -110,7 +108,8 @@ static void max8997_led_enable(struct max8997_led=
 *led, bool enable)
> =20
>  	val =3D enable ? MAX8997_LED_BOOST_ENABLE_MASK : 0;
> =20
> -	ret =3D max8997_update_reg(client, MAX8997_REG_BOOST_CNTL, val, mas=
k);
> +	ret =3D max8997_update_reg(led->iodev->regmap,
> +				MAX8997_REG_BOOST_CNTL, val, mask);
>  	if (ret)
>  		dev_err(led->iodev->dev,
>  			"failed to update register(%d)\n", ret);
> @@ -122,7 +121,6 @@ static void max8997_led_set_current(struct max899=
7_led *led,
>  				enum led_brightness value)
>  {
>  	int ret;
> -	struct i2c_client *client =3D led->iodev->i2c;
>  	u8 val =3D 0, mask =3D 0, reg =3D 0;
> =20
>  	switch (led->led_mode) {
> @@ -143,7 +141,7 @@ static void max8997_led_set_current(struct max899=
7_led *led,
>  	}
> =20
>  	if (mask) {
> -		ret =3D max8997_update_reg(client, reg, val, mask);
> +		ret =3D max8997_update_reg(led->iodev->regmap, reg, val, mask);
>  		if (ret)
>  			dev_err(led->iodev->dev,
>  				"failed to update register(%d)\n", ret);
> diff --git a/drivers/mfd/max8997-irq.c b/drivers/mfd/max8997-irq.c
> index 43fa614..05d3b87 100644
> --- a/drivers/mfd/max8997-irq.c
> +++ b/drivers/mfd/max8997-irq.c
> @@ -124,15 +124,20 @@ static void max8997_irq_sync_unlock(struct irq_=
data *data)
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
> +		max8997_write_reg(map, max8997_mask_reg[i],
>  				max8997->irq_masks_cur[i]);
>  	}
> =20
> @@ -185,7 +190,7 @@ static irqreturn_t max8997_irq_thread(int irq, vo=
id *data)
>  	int ret;
>  	int i, cur_irq;
> =20
> -	ret =3D max8997_read_reg(max8997->i2c, MAX8997_REG_INTSRC, &irq_src=
);
> +	ret =3D max8997_read_reg(max8997->regmap, MAX8997_REG_INTSRC, &irq_=
src);
>  	if (ret < 0) {
>  		dev_err(max8997->dev, "Failed to read interrupt source: %d\n",
>  				ret);
> @@ -194,7 +199,7 @@ static irqreturn_t max8997_irq_thread(int irq, vo=
id *data)
> =20
>  	if (irq_src & MAX8997_IRQSRC_PMIC) {
>  		/* PMIC INT1 ~ INT4 */
> -		max8997_bulk_read(max8997->i2c, MAX8997_REG_INT1, 4,
> +		max8997_bulk_read(max8997->regmap, MAX8997_REG_INT1, 4,
>  				&irq_reg[PMIC_INT1]);
>  	}
>  	if (irq_src & MAX8997_IRQSRC_FUELGAUGE) {
> @@ -215,8 +220,8 @@ static irqreturn_t max8997_irq_thread(int irq, vo=
id *data)
>  	}
>  	if (irq_src & MAX8997_IRQSRC_MUIC) {
>  		/* MUIC INT1 ~ INT3 */
> -		max8997_bulk_read(max8997->muic, MAX8997_MUIC_REG_INT1, 3,
> -				&irq_reg[MUIC_INT1]);
> +		max8997_bulk_read(max8997->regmap_muic,
> +				MAX8997_MUIC_REG_INT1, 3, &irq_reg[MUIC_INT1]);
>  	}
>  	if (irq_src & MAX8997_IRQSRC_GPIO) {
>  		/* GPIO Interrupt */
> @@ -225,7 +230,7 @@ static irqreturn_t max8997_irq_thread(int irq, vo=
id *data)
>  		irq_reg[GPIO_LOW] =3D 0;
>  		irq_reg[GPIO_HI] =3D 0;
> =20
> -		max8997_bulk_read(max8997->i2c, MAX8997_REG_GPIOCNTL1,
> +		max8997_bulk_read(max8997->regmap, MAX8997_REG_GPIOCNTL1,
>  				MAX8997_NUM_GPIO, gpio_info);
>  		for (i =3D 0; i < MAX8997_NUM_GPIO; i++) {
>  			bool interrupt =3D false;
> @@ -260,7 +265,7 @@ static irqreturn_t max8997_irq_thread(int irq, vo=
id *data)
>  	}
>  	if (irq_src & MAX8997_IRQSRC_FLASH) {
>  		/* Flash Status Interrupt */
> -		ret =3D max8997_read_reg(max8997->i2c, MAX8997_REG_FLASHSTATUS,
> +		ret =3D max8997_read_reg(max8997->regmap, MAX8997_REG_FLASHSTATUS,
>  				&irq_reg[FLASH_STATUS]);
>  	}
> =20
> @@ -323,22 +328,20 @@ int max8997_irq_init(struct max8997_dev *max899=
7)
> =20
>  	/* Mask individual interrupt sources */
>  	for (i =3D 0; i < MAX8997_IRQ_GROUP_NR; i++) {
> -		struct i2c_client *i2c;
> -

If you delete i2c instance, this patch happen build error.

>  		max8997->irq_masks_cur[i] =3D 0xff;
>  		max8997->irq_masks_cache[i] =3D 0xff;
>  		i2c =3D get_i2c(max8997, i);

This line need 'i2c' instance.

> =20
> -		if (IS_ERR_OR_NULL(i2c))
> +		if (IS_ERR_OR_NULL(max8997->regmap))
>  			continue;
>  		if (max8997_mask_reg[i] =3D=3D MAX8997_REG_INVALID)
>  			continue;
> =20
> -		max8997_write_reg(i2c, max8997_mask_reg[i], 0xff);
> +		max8997_write_reg(max8997->regmap, max8997_mask_reg[i], 0xff);
>  	}
> =20
>  	for (i =3D 0; i < MAX8997_NUM_GPIO; i++) {
> -		max8997->gpio_status[i] =3D (max8997_read_reg(max8997->i2c,
> +		max8997->gpio_status[i] =3D (max8997_read_reg(max8997->regmap,
>  						MAX8997_REG_GPIOCNTL1 + i,
>  						&val)
>  					& MAX8997_GPIO_DATA_MASK) ?
> diff --git a/drivers/mfd/max8997.c b/drivers/mfd/max8997.c
> index be88a3b..590e368 100644
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
> @@ -57,82 +58,82 @@ static struct of_device_id max8997_pmic_dt_match[=
] =3D {
>  };
>  #endif
> =20
> -int max8997_read_reg(struct i2c_client *i2c, u8 reg, u8 *dest)
> +int max8997_read_reg(struct regmap *map, u8 reg, u8 *dest)
>  {
> -	struct max8997_dev *max8997 =3D i2c_get_clientdata(i2c);
> +	unsigned int val;
>  	int ret;
> =20
> -	mutex_lock(&max8997->iolock);
> -	ret =3D i2c_smbus_read_byte_data(i2c, reg);
> -	mutex_unlock(&max8997->iolock);
> -	if (ret < 0)
> -		return ret;
> +	ret =3D regmap_read(map, reg, &val);
> +	*dest =3D val;
> =20
> -	ret &=3D 0xff;
> -	*dest =3D ret;
> -	return 0;
> +	return ret;
>  }
>  EXPORT_SYMBOL_GPL(max8997_read_reg);
> =20
> -int max8997_bulk_read(struct i2c_client *i2c, u8 reg, int count, u8 =
*buf)
> +int max8997_bulk_read(struct regmap *map, u8 reg, int count, u8 *buf=
)
>  {
> -	struct max8997_dev *max8997 =3D i2c_get_clientdata(i2c);
>  	int ret;
> =20
> -	mutex_lock(&max8997->iolock);
> -	ret =3D i2c_smbus_read_i2c_block_data(i2c, reg, count, buf);
> -	mutex_unlock(&max8997->iolock);
> -	if (ret < 0)
> -		return ret;
> +	ret =3D regmap_bulk_read(map, reg, buf, count);
> =20
> -	return 0;
> +	return ret;
>  }
>  EXPORT_SYMBOL_GPL(max8997_bulk_read);
> =20
> -int max8997_write_reg(struct i2c_client *i2c, u8 reg, u8 value)
> +int max8997_write_reg(struct regmap *map, u8 reg, u8 value)
>  {
> -	struct max8997_dev *max8997 =3D i2c_get_clientdata(i2c);
>  	int ret;
> =20
> -	mutex_lock(&max8997->iolock);
> -	ret =3D i2c_smbus_write_byte_data(i2c, reg, value);
> -	mutex_unlock(&max8997->iolock);
> +	ret =3D regmap_write(map, reg, value);
> +
>  	return ret;
>  }
>  EXPORT_SYMBOL_GPL(max8997_write_reg);
> =20
> -int max8997_bulk_write(struct i2c_client *i2c, u8 reg, int count, u8=
 *buf)
> +int max8997_bulk_write(struct regmap *map, u8 reg, int count, u8 *bu=
f)
>  {
> -	struct max8997_dev *max8997 =3D i2c_get_clientdata(i2c);
>  	int ret;
> =20
> -	mutex_lock(&max8997->iolock);
> -	ret =3D i2c_smbus_write_i2c_block_data(i2c, reg, count, buf);
> -	mutex_unlock(&max8997->iolock);
> -	if (ret < 0)
> -		return ret;
> +	ret =3D regmap_bulk_write(map, reg, buf, count);
> =20
> -	return 0;
> +	return ret;
>  }
>  EXPORT_SYMBOL_GPL(max8997_bulk_write);
> =20
> -int max8997_update_reg(struct i2c_client *i2c, u8 reg, u8 val, u8 ma=
sk)
> +int max8997_update_reg(struct regmap *map, u8 reg, u8 val, u8 mask)
>  {
> -	struct max8997_dev *max8997 =3D i2c_get_clientdata(i2c);
>  	int ret;
> =20
> -	mutex_lock(&max8997->iolock);
> -	ret =3D i2c_smbus_read_byte_data(i2c, reg);
> -	if (ret >=3D 0) {
> -		u8 old_val =3D ret & 0xff;
> -		u8 new_val =3D (val & mask) | (old_val & (~mask));
> -		ret =3D i2c_smbus_write_byte_data(i2c, reg, new_val);
> -	}
> -	mutex_unlock(&max8997->iolock);
> +	ret =3D regmap_update_bits(map, reg, mask, val);
> +
>  	return ret;
>  }
>  EXPORT_SYMBOL_GPL(max8997_update_reg);
> =20
> +static const struct regmap_config max8997_regmap_config =3D {
> +	.reg_bits =3D 8,
> +	.val_bits =3D 8,
> +	.max_register =3D MAX8997_REG_PMIC_END,
> +};
> +
> +static const struct regmap_config max8997_regmap_rtc_config =3D {
> +	.reg_bits =3D 8,
> +	.val_bits =3D 8,
> +	.max_register =3D MAX8997_RTC_REG_END,
> +};
> +
> +static const struct regmap_config max8997_regmap_haptic_config =3D {
> +	.reg_bits =3D 8,
> +	.val_bits =3D 8,
> +	.max_register =3D MAX8997_HAPTIC_REG_END,
> +};
> +
> +static const struct regmap_config max8997_regmap_muic_config =3D {
> +	.reg_bits =3D 8,
> +	.val_bits =3D 8,
> +	.max_register =3D MAX8997_MUIC_REG_END,
> +};
> +
>  /*
>   * Only the common platform data elements for max8997 are parsed her=
e from the
>   * device tree. Other sub-modules of max8997 such as pmic, rtc and o=
thers have
> @@ -202,6 +203,14 @@ static int max8997_i2c_probe(struct i2c_client *=
i2c,
>  	if (!pdata)
>  		return ret;
> =20
> +	max8997->regmap =3D devm_regmap_init_i2c(i2c, &max8997_regmap_confi=
g);
> +	if (IS_ERR(max8997->regmap)) {
> +		ret =3D PTR_ERR(max8997->regmap);
> +		dev_err(max8997->dev, "failed to allocate register map: %d\n",
> +				ret);
> +		return ret;
> +	}
> +
>  	max8997->pdata =3D pdata;
>  	max8997->ono =3D pdata->ono;
> =20
> @@ -209,11 +218,40 @@ static int max8997_i2c_probe(struct i2c_client =
*i2c,
> =20
>  	max8997->rtc =3D i2c_new_dummy(i2c->adapter, I2C_ADDR_RTC);
>  	i2c_set_clientdata(max8997->rtc, max8997);
> +
>  	max8997->haptic =3D i2c_new_dummy(i2c->adapter, I2C_ADDR_HAPTIC);
>  	i2c_set_clientdata(max8997->haptic, max8997);
> +
>  	max8997->muic =3D i2c_new_dummy(i2c->adapter, I2C_ADDR_MUIC);
>  	i2c_set_clientdata(max8997->muic, max8997);
> =20
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
> @@ -238,6 +276,7 @@ static int max8997_i2c_probe(struct i2c_client *i=
2c,
> =20
>  err_mfd:
>  	mfd_remove_devices(max8997->dev);
> +err_regmap:
>  	i2c_unregister_device(max8997->muic);
>  	i2c_unregister_device(max8997->haptic);
>  	i2c_unregister_device(max8997->rtc);
> @@ -423,15 +462,15 @@ static int max8997_freeze(struct device *dev)
>  	int i;
> =20
>  	for (i =3D 0; i < ARRAY_SIZE(max8997_dumpaddr_pmic); i++)
> -		max8997_read_reg(i2c, max8997_dumpaddr_pmic[i],
> +		max8997_read_reg(max8997->regmap, max8997_dumpaddr_pmic[i],
>  				&max8997->reg_dump[i]);
> =20
>  	for (i =3D 0; i < ARRAY_SIZE(max8997_dumpaddr_muic); i++)
> -		max8997_read_reg(i2c, max8997_dumpaddr_muic[i],
> +		max8997_read_reg(max8997->regmap_muic, max8997_dumpaddr_muic[i],
>  				&max8997->reg_dump[i + MAX8997_REG_PMIC_END]);
> =20
>  	for (i =3D 0; i < ARRAY_SIZE(max8997_dumpaddr_haptic); i++)
> -		max8997_read_reg(i2c, max8997_dumpaddr_haptic[i],
> +		max8997_read_reg(max8997->regmap_haptic, max8997_dumpaddr_haptic[i=
],
>  				&max8997->reg_dump[i + MAX8997_REG_PMIC_END +
>  				MAX8997_MUIC_REG_END]);
> =20
> @@ -445,15 +484,15 @@ static int max8997_restore(struct device *dev)
>  	int i;
> =20
>  	for (i =3D 0; i < ARRAY_SIZE(max8997_dumpaddr_pmic); i++)
> -		max8997_write_reg(i2c, max8997_dumpaddr_pmic[i],
> +		max8997_write_reg(max8997->regmap, max8997_dumpaddr_pmic[i],
>  				max8997->reg_dump[i]);
> =20
>  	for (i =3D 0; i < ARRAY_SIZE(max8997_dumpaddr_muic); i++)
> -		max8997_write_reg(i2c, max8997_dumpaddr_muic[i],
> +		max8997_write_reg(max8997->regmap_muic, max8997_dumpaddr_muic[i],
>  				max8997->reg_dump[i + MAX8997_REG_PMIC_END]);
> =20
>  	for (i =3D 0; i < ARRAY_SIZE(max8997_dumpaddr_haptic); i++)
> -		max8997_write_reg(i2c, max8997_dumpaddr_haptic[i],
> +		max8997_write_reg(max8997->regmap_haptic, max8997_dumpaddr_haptic[=
i],
>  				max8997->reg_dump[i + MAX8997_REG_PMIC_END +
>  				MAX8997_MUIC_REG_END]);
> =20
> diff --git a/drivers/power/max8997_charger.c b/drivers/power/max8997_=
charger.c
> index 4bdedfe..027e9bf 100644
> --- a/drivers/power/max8997_charger.c
> +++ b/drivers/power/max8997_charger.c
> @@ -46,14 +46,14 @@ static int max8997_battery_get_property(struct po=
wer_supply *psy,
>  {
>  	struct charger_data *charger =3D container_of(psy,
>  			struct charger_data, battery);
> -	struct i2c_client *i2c =3D charger->iodev->i2c;
>  	int ret;
>  	u8 reg;
> =20
>  	switch (psp) {
>  	case POWER_SUPPLY_PROP_STATUS:
>  		val->intval =3D 0;
> -		ret =3D max8997_read_reg(i2c, MAX8997_REG_STATUS4, &reg);
> +		ret =3D max8997_read_reg(charger->iodev->regmap,
> +				MAX8997_REG_STATUS4, &reg);
>  		if (ret)
>  			return ret;
>  		if ((reg & (1 << 0)) =3D=3D 0x1)
> @@ -62,7 +62,8 @@ static int max8997_battery_get_property(struct powe=
r_supply *psy,
>  		break;
>  	case POWER_SUPPLY_PROP_PRESENT:
>  		val->intval =3D 0;
> -		ret =3D max8997_read_reg(i2c, MAX8997_REG_STATUS4, &reg);
> +		ret =3D max8997_read_reg(charger->iodev->regmap,
> +				MAX8997_REG_STATUS4, &reg);
>  		if (ret)
>  			return ret;
>  		if ((reg & (1 << 2)) =3D=3D 0x0)
> @@ -71,7 +72,8 @@ static int max8997_battery_get_property(struct powe=
r_supply *psy,
>  		break;
>  	case POWER_SUPPLY_PROP_ONLINE:
>  		val->intval =3D 0;
> -		ret =3D max8997_read_reg(i2c, MAX8997_REG_STATUS4, &reg);
> +		ret =3D max8997_read_reg(charger->iodev->regmap,
> +				MAX8997_REG_STATUS4, &reg);
>  		if (ret)
>  			return ret;
>  		/* DCINOK */
> @@ -103,7 +105,7 @@ static int max8997_battery_probe(struct platform_=
device *pdev)
>  		if (val > 0xf)
>  			val =3D 0xf;
> =20
> -		ret =3D max8997_update_reg(iodev->i2c,
> +		ret =3D max8997_update_reg(iodev->regmap,
>  				MAX8997_REG_MBCCTRL5, val, 0xf);
>  		if (ret < 0) {
>  			dev_err(&pdev->dev, "Cannot use i2c bus.\n");
> @@ -113,20 +115,20 @@ static int max8997_battery_probe(struct platfor=
m_device *pdev)
> =20
>  	switch (pdata->timeout) {
>  	case 5:
> -		ret =3D max8997_update_reg(iodev->i2c, MAX8997_REG_MBCCTRL1,
> -				0x2 << 4, 0x7 << 4);
> +		ret =3D max8997_update_reg(iodev->regmap,
> +				MAX8997_REG_MBCCTRL1, 0x2 << 4, 0x7 << 4);
>  		break;
>  	case 6:
> -		ret =3D max8997_update_reg(iodev->i2c, MAX8997_REG_MBCCTRL1,
> -				0x3 << 4, 0x7 << 4);
> +		ret =3D max8997_update_reg(iodev->regmap,
> +				MAX8997_REG_MBCCTRL1, 0x3 << 4, 0x7 << 4);
>  		break;
>  	case 7:
> -		ret =3D max8997_update_reg(iodev->i2c, MAX8997_REG_MBCCTRL1,
> -				0x4 << 4, 0x7 << 4);
> +		ret =3D max8997_update_reg(iodev->regmap,
> +				MAX8997_REG_MBCCTRL1, 0x4 << 4, 0x7 << 4);
>  		break;
>  	case 0:
> -		ret =3D max8997_update_reg(iodev->i2c, MAX8997_REG_MBCCTRL1,
> -				0x7 << 4, 0x7 << 4);
> +		ret =3D max8997_update_reg(iodev->regmap,
> +				MAX8997_REG_MBCCTRL1, 0x7 << 4, 0x7 << 4);
>  		break;
>  	default:
>  		dev_err(&pdev->dev, "incorrect timeout value (%d)\n",
> diff --git a/drivers/regulator/max8997.c b/drivers/regulator/max8997.=
c
> index 2d618fc..470435e 100644
> --- a/drivers/regulator/max8997.c
> +++ b/drivers/regulator/max8997.c
> @@ -258,7 +258,6 @@ static int max8997_get_enable_register(struct reg=
ulator_dev *rdev,
>  static int max8997_reg_is_enabled(struct regulator_dev *rdev)
>  {
>  	struct max8997_data *max8997 =3D rdev_get_drvdata(rdev);
> -	struct i2c_client *i2c =3D max8997->iodev->i2c;
>  	int ret, reg, mask, pattern;
>  	u8 val;
> =20
> @@ -266,7 +265,7 @@ static int max8997_reg_is_enabled(struct regulato=
r_dev *rdev)
>  	if (ret)
>  		return ret;
> =20
> -	ret =3D max8997_read_reg(i2c, reg, &val);
> +	ret =3D max8997_read_reg(max8997->iodev->regmap, reg, &val);
>  	if (ret)
>  		return ret;
> =20
> @@ -276,27 +275,25 @@ static int max8997_reg_is_enabled(struct regula=
tor_dev *rdev)
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
> +	return max8997_update_reg(max8997->iodev->regmap, reg, pattern, mas=
k);
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
> +	return max8997_update_reg(max8997->iodev->regmap, reg, ~pattern, ma=
sk);
>  }
> =20
>  static int max8997_get_voltage_register(struct regulator_dev *rdev,
> @@ -368,7 +365,6 @@ static int max8997_get_voltage_register(struct re=
gulator_dev *rdev,
>  static int max8997_get_voltage_sel(struct regulator_dev *rdev)
>  {
>  	struct max8997_data *max8997 =3D rdev_get_drvdata(rdev);
> -	struct i2c_client *i2c =3D max8997->iodev->i2c;
>  	int reg, shift, mask, ret;
>  	u8 val;
> =20
> @@ -376,7 +372,7 @@ static int max8997_get_voltage_sel(struct regulat=
or_dev *rdev)
>  	if (ret)
>  		return ret;
> =20
> -	ret =3D max8997_read_reg(i2c, reg, &val);
> +	ret =3D max8997_read_reg(max8997->iodev->regmap, reg, &val);
>  	if (ret)
>  		return ret;
> =20
> @@ -413,7 +409,6 @@ static int max8997_set_voltage_charger_cv(struct =
regulator_dev *rdev,
>  		int min_uV, int max_uV, unsigned *selector)
>  {
>  	struct max8997_data *max8997 =3D rdev_get_drvdata(rdev);
> -	struct i2c_client *i2c =3D max8997->iodev->i2c;
>  	int rid =3D rdev_get_id(rdev);
>  	int lb, ub;
>  	int reg, shift =3D 0, mask, ret =3D 0;
> @@ -455,7 +450,8 @@ static int max8997_set_voltage_charger_cv(struct =
regulator_dev *rdev,
> =20
>  	*selector =3D val;
> =20
> -	ret =3D max8997_update_reg(i2c, reg, val << shift, mask);
> +	ret =3D max8997_update_reg(max8997->iodev->regmap,
> +				reg, val << shift, mask);
> =20
>  	return ret;
>  }
> @@ -468,7 +464,6 @@ static int max8997_set_voltage_ldobuck(struct reg=
ulator_dev *rdev,
>  		int min_uV, int max_uV, unsigned *selector)
>  {
>  	struct max8997_data *max8997 =3D rdev_get_drvdata(rdev);
> -	struct i2c_client *i2c =3D max8997->iodev->i2c;
>  	const struct voltage_map_desc *desc;
>  	int rid =3D rdev_get_id(rdev);
>  	int i, reg, shift, mask, ret;
> @@ -500,7 +495,8 @@ static int max8997_set_voltage_ldobuck(struct reg=
ulator_dev *rdev,
>  	if (ret)
>  		return ret;
> =20
> -	ret =3D max8997_update_reg(i2c, reg, i << shift, mask << shift);
> +	ret =3D max8997_update_reg(max8997->iodev->regmap,
> +				reg, i << shift, mask << shift);
>  	*selector =3D i;
> =20
>  	return ret;
> @@ -710,7 +706,6 @@ static int max8997_set_voltage_safeout_sel(struct=
 regulator_dev *rdev,
>  					   unsigned selector)
>  {
>  	struct max8997_data *max8997 =3D rdev_get_drvdata(rdev);
> -	struct i2c_client *i2c =3D max8997->iodev->i2c;
>  	int rid =3D rdev_get_id(rdev);
>  	int reg, shift =3D 0, mask, ret;
> =20
> @@ -721,13 +716,13 @@ static int max8997_set_voltage_safeout_sel(stru=
ct regulator_dev *rdev,
>  	if (ret)
>  		return ret;
> =20
> -	return max8997_update_reg(i2c, reg, selector << shift, mask << shif=
t);
> +	return max8997_update_reg(max8997->iodev->regmap,
> +				reg, selector << shift, mask << shift);
>  }
> =20
>  static int max8997_reg_disable_suspend(struct regulator_dev *rdev)
>  {
>  	struct max8997_data *max8997 =3D rdev_get_drvdata(rdev);
> -	struct i2c_client *i2c =3D max8997->iodev->i2c;
>  	int ret, reg, mask, pattern;
>  	int rid =3D rdev_get_id(rdev);
> =20
> @@ -735,20 +730,22 @@ static int max8997_reg_disable_suspend(struct r=
egulator_dev *rdev)
>  	if (ret)
>  		return ret;
> =20
> -	max8997_read_reg(i2c, reg, &max8997->saved_states[rid]);
> +	max8997_read_reg(max8997->iodev->regmap,
> +			reg, &max8997->saved_states[rid]);
> =20
>  	if (rid =3D=3D MAX8997_LDO1 ||
>  			rid =3D=3D MAX8997_LDO10 ||
>  			rid =3D=3D MAX8997_LDO21) {
>  		dev_dbg(&rdev->dev, "Conditional Power-Off for %s\n",
>  				rdev->desc->name);
> -		return max8997_update_reg(i2c, reg, 0x40, mask);
> +		return max8997_update_reg(max8997->iodev->regmap,
> +				reg, 0x40, mask);
>  	}
> =20
>  	dev_dbg(&rdev->dev, "Full Power-Off for %s (%xh -> %xh)\n",
>  			rdev->desc->name, max8997->saved_states[rid] & mask,
>  			(~pattern) & mask);
> -	return max8997_update_reg(i2c, reg, ~pattern, mask);
> +	return max8997_update_reg(max8997->iodev->regmap, reg, ~pattern, ma=
sk);
>  }
> =20
>  static struct regulator_ops max8997_ldo_ops =3D {
> @@ -1032,7 +1029,6 @@ static int max8997_pmic_probe(struct platform_d=
evice *pdev)
>  	struct regulator_config config =3D { };
>  	struct regulator_dev **rdev;
>  	struct max8997_data *max8997;
> -	struct i2c_client *i2c;
>  	int i, ret, size, nr_dvs;
>  	u8 max_buck1 =3D 0, max_buck2 =3D 0, max_buck5 =3D 0;
> =20
> @@ -1062,7 +1058,6 @@ static int max8997_pmic_probe(struct platform_d=
evice *pdev)
>  	max8997->iodev =3D iodev;
>  	max8997->num_regulators =3D pdata->num_regulators;
>  	platform_set_drvdata(pdev, max8997);
> -	i2c =3D max8997->iodev->i2c;
> =20
>  	max8997->buck125_gpioindex =3D pdata->buck125_default_idx;
>  	max8997->buck1_gpiodvs =3D pdata->buck1_gpiodvs;
> @@ -1112,25 +1107,25 @@ static int max8997_pmic_probe(struct platform=
_device *pdev)
> =20
>  	/* For the safety, set max voltage before setting up */
>  	for (i =3D 0; i < 8; i++) {
> -		max8997_update_reg(i2c, MAX8997_REG_BUCK1DVS1 + i,
> -				max_buck1, 0x3f);
> -		max8997_update_reg(i2c, MAX8997_REG_BUCK2DVS1 + i,
> -				max_buck2, 0x3f);
> -		max8997_update_reg(i2c, MAX8997_REG_BUCK5DVS1 + i,
> -				max_buck5, 0x3f);
> +		max8997_update_reg(max8997->iodev->regmap,
> +				MAX8997_REG_BUCK1DVS1 + i, max_buck1, 0x3f);
> +		max8997_update_reg(max8997->iodev->regmap,
> +				MAX8997_REG_BUCK2DVS1 + i, max_buck2, 0x3f);
> +		max8997_update_reg(max8997->iodev->regmap,
> +				MAX8997_REG_BUCK5DVS1 + i, max_buck5, 0x3f);
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
> +		max8997_update_reg(max8997->iodev->regmap,
> +				MAX8997_REG_BUCK1DVS1 + i,
> +				max8997->buck1_vol[i], 0x3f);
> +		max8997_update_reg(max8997->iodev->regmap,
> +				MAX8997_REG_BUCK2DVS1 + i,
> +				max8997->buck2_vol[i], 0x3f);
> +		max8997_update_reg(max8997->iodev->regmap,
> +				MAX8997_REG_BUCK5DVS1 + i,
> +				max8997->buck5_vol[i], 0x3f);
>  	}
> =20
>  	/*
> @@ -1174,16 +1169,17 @@ static int max8997_pmic_probe(struct platform=
_device *pdev)
>  	}
> =20
>  	/* DVS-GPIO disabled */
> -	max8997_update_reg(i2c, MAX8997_REG_BUCK1CTRL, (pdata->buck1_gpiodv=
s) ?
> -			(1 << 1) : (0 << 1), 1 << 1);
> -	max8997_update_reg(i2c, MAX8997_REG_BUCK2CTRL, (pdata->buck2_gpiodv=
s) ?
> -			(1 << 1) : (0 << 1), 1 << 1);
> -	max8997_update_reg(i2c, MAX8997_REG_BUCK5CTRL, (pdata->buck5_gpiodv=
s) ?
> -			(1 << 1) : (0 << 1), 1 << 1);
> +	max8997_update_reg(max8997->iodev->regmap, MAX8997_REG_BUCK1CTRL,
> +			(pdata->buck1_gpiodvs) ? (1 << 1) : (0 << 1), 1 << 1);
> +	max8997_update_reg(max8997->iodev->regmap, MAX8997_REG_BUCK2CTRL,
> +			(pdata->buck2_gpiodvs) ? (1 << 1) : (0 << 1), 1 << 1);
> +	max8997_update_reg(max8997->iodev->regmap, MAX8997_REG_BUCK5CTRL,
> +			(pdata->buck5_gpiodvs) ? (1 << 1) : (0 << 1), 1 << 1);
> =20
>  	/* Misc Settings */
>  	max8997->ramp_delay =3D 10; /* set 10mV/us, which is the default */
> -	max8997_write_reg(i2c, MAX8997_REG_BUCKRAMP, (0xf << 4) | 0x9);
> +	max8997_write_reg(max8997->iodev->regmap,
> +			MAX8997_REG_BUCKRAMP, (0xf << 4) | 0x9);
> =20
>  	for (i =3D 0; i < pdata->num_regulators; i++) {
>  		const struct voltage_map_desc *desc;
> diff --git a/drivers/rtc/rtc-max8997.c b/drivers/rtc/rtc-max8997.c
> index 0777c01..218535c 100644
> --- a/drivers/rtc/rtc-max8997.c
> +++ b/drivers/rtc/rtc-max8997.c
> @@ -68,7 +68,6 @@ enum {
>  struct max8997_rtc_info {
>  	struct device		*dev;
>  	struct max8997_dev	*max8997;
> -	struct i2c_client	*rtc;
>  	struct rtc_device	*rtc_dev;
>  	struct mutex		lock;
>  	int virq;
> @@ -118,8 +117,8 @@ static inline int max8997_rtc_set_update_reg(stru=
ct max8997_rtc_info *info)
>  {
>  	int ret;
> =20
> -	ret =3D max8997_write_reg(info->rtc, MAX8997_RTC_UPDATE1,
> -						RTC_UDR_MASK);
> +	ret =3D max8997_write_reg(info->max8997->regmap_rtc,
> +				MAX8997_RTC_UPDATE1, RTC_UDR_MASK);
>  	if (ret < 0)
>  		dev_err(info->dev, "%s: fail to write update reg(%d)\n",
>  				__func__, ret);
> @@ -140,7 +139,8 @@ static int max8997_rtc_read_time(struct device *d=
ev, struct rtc_time *tm)
>  	int ret;
> =20
>  	mutex_lock(&info->lock);
> -	ret =3D max8997_bulk_read(info->rtc, MAX8997_RTC_SEC, RTC_NR_TIME, =
data);
> +	ret =3D max8997_bulk_read(info->max8997->regmap_rtc,
> +				MAX8997_RTC_SEC, RTC_NR_TIME, data);
>  	mutex_unlock(&info->lock);
> =20
>  	if (ret < 0) {
> @@ -166,7 +166,8 @@ static int max8997_rtc_set_time(struct device *de=
v, struct rtc_time *tm)
> =20
>  	mutex_lock(&info->lock);
> =20
> -	ret =3D max8997_bulk_write(info->rtc, MAX8997_RTC_SEC, RTC_NR_TIME,=
 data);
> +	ret =3D max8997_bulk_write(info->max8997->regmap_rtc,
> +				MAX8997_RTC_SEC, RTC_NR_TIME, data);
>  	if (ret < 0) {
>  		dev_err(info->dev, "%s: fail to write time reg(%d)\n", __func__,
>  				ret);
> @@ -188,8 +189,8 @@ static int max8997_rtc_read_alarm(struct device *=
dev, struct rtc_wkalrm *alrm)
> =20
>  	mutex_lock(&info->lock);
> =20
> -	ret =3D max8997_bulk_read(info->rtc, MAX8997_RTC_ALARM1_SEC, RTC_NR=
_TIME,
> -			data);
> +	ret =3D max8997_bulk_read(info->max8997->regmap_rtc,
> +				MAX8997_RTC_ALARM1_SEC, RTC_NR_TIME, data);
>  	if (ret < 0) {
>  		dev_err(info->dev, "%s:%d fail to read alarm reg(%d)\n",
>  				__func__, __LINE__, ret);
> @@ -207,7 +208,8 @@ static int max8997_rtc_read_alarm(struct device *=
dev, struct rtc_wkalrm *alrm)
>  	}
> =20
>  	alrm->pending =3D 0;
> -	ret =3D max8997_read_reg(info->max8997->i2c, MAX8997_REG_STATUS1, &=
val);
> +	ret =3D max8997_read_reg(info->max8997->regmap_rtc,
> +			       MAX8997_REG_STATUS1, &val);
>  	if (ret < 0) {
>  		dev_err(info->dev, "%s:%d fail to read status1 reg(%d)\n",
>  				__func__, __LINE__, ret);
> @@ -230,8 +232,8 @@ static int max8997_rtc_stop_alarm(struct max8997_=
rtc_info *info)
>  	if (!mutex_is_locked(&info->lock))
>  		dev_warn(info->dev, "%s: should have mutex locked\n", __func__);
> =20
> -	ret =3D max8997_bulk_read(info->rtc, MAX8997_RTC_ALARM1_SEC, RTC_NR=
_TIME,
> -				data);
> +	ret =3D max8997_bulk_read(info->max8997->regmap_rtc,
> +				MAX8997_RTC_ALARM1_SEC, RTC_NR_TIME, data);
>  	if (ret < 0) {
>  		dev_err(info->dev, "%s: fail to read alarm reg(%d)\n",
>  				__func__, ret);
> @@ -241,8 +243,8 @@ static int max8997_rtc_stop_alarm(struct max8997_=
rtc_info *info)
>  	for (i =3D 0; i < RTC_NR_TIME; i++)
>  		data[i] &=3D ~ALARM_ENABLE_MASK;
> =20
> -	ret =3D max8997_bulk_write(info->rtc, MAX8997_RTC_ALARM1_SEC, RTC_N=
R_TIME,
> -				 data);
> +	ret =3D max8997_bulk_write(info->max8997->regmap_rtc,
> +				 MAX8997_RTC_ALARM1_SEC, RTC_NR_TIME, data);
>  	if (ret < 0) {
>  		dev_err(info->dev, "%s: fail to write alarm reg(%d)\n",
>  				__func__, ret);
> @@ -262,8 +264,8 @@ static int max8997_rtc_start_alarm(struct max8997=
_rtc_info *info)
>  	if (!mutex_is_locked(&info->lock))
>  		dev_warn(info->dev, "%s: should have mutex locked\n", __func__);
> =20
> -	ret =3D max8997_bulk_read(info->rtc, MAX8997_RTC_ALARM1_SEC, RTC_NR=
_TIME,
> -				data);
> +	ret =3D max8997_bulk_read(info->max8997->regmap_rtc,
> +				MAX8997_RTC_ALARM1_SEC, RTC_NR_TIME, data);
>  	if (ret < 0) {
>  		dev_err(info->dev, "%s: fail to read alarm reg(%d)\n",
>  				__func__, ret);
> @@ -281,8 +283,8 @@ static int max8997_rtc_start_alarm(struct max8997=
_rtc_info *info)
>  	if (data[RTC_DATE] & 0x1f)
>  		data[RTC_DATE] |=3D (1 << ALARM_ENABLE_SHIFT);
> =20
> -	ret =3D max8997_bulk_write(info->rtc, MAX8997_RTC_ALARM1_SEC, RTC_N=
R_TIME,
> -				 data);
> +	ret =3D max8997_bulk_write(info->max8997->regmap_rtc,
> +				 MAX8997_RTC_ALARM1_SEC, RTC_NR_TIME, data);
>  	if (ret < 0) {
>  		dev_err(info->dev, "%s: fail to write alarm reg(%d)\n",
>  				__func__, ret);
> @@ -313,8 +315,8 @@ static int max8997_rtc_set_alarm(struct device *d=
ev, struct rtc_wkalrm *alrm)
>  	if (ret < 0)
>  		goto out;
> =20
> -	ret =3D max8997_bulk_write(info->rtc, MAX8997_RTC_ALARM1_SEC, RTC_N=
R_TIME,
> -				data);
> +	ret =3D max8997_bulk_write(info->max8997->regmap_rtc,
> +				 MAX8997_RTC_ALARM1_SEC, RTC_NR_TIME, data);
>  	if (ret < 0) {
>  		dev_err(info->dev, "%s: fail to write alarm reg(%d)\n",
>  				__func__, ret);
> @@ -385,7 +387,8 @@ static void max8997_rtc_enable_wtsr(struct max899=
7_rtc_info *info, bool enable)
>  	dev_info(info->dev, "%s: %s WTSR\n", __func__,
>  			enable ? "enable" : "disable");
> =20
> -	ret =3D max8997_update_reg(info->rtc, MAX8997_RTC_WTSR_SMPL, val, m=
ask);
> +	ret =3D max8997_update_reg(info->max8997->regmap_rtc,
> +				 MAX8997_RTC_WTSR_SMPL, val, mask);
>  	if (ret < 0) {
>  		dev_err(info->dev, "%s: fail to update WTSR reg(%d)\n",
>  				__func__, ret);
> @@ -413,7 +416,8 @@ static void max8997_rtc_enable_smpl(struct max899=
7_rtc_info *info, bool enable)
>  	dev_info(info->dev, "%s: %s SMPL\n", __func__,
>  			enable ? "enable" : "disable");
> =20
> -	ret =3D max8997_update_reg(info->rtc, MAX8997_RTC_WTSR_SMPL, val, m=
ask);
> +	ret =3D max8997_update_reg(info->max8997->regmap_rtc,
> +				 MAX8997_RTC_WTSR_SMPL, val, mask);
>  	if (ret < 0) {
>  		dev_err(info->dev, "%s: fail to update SMPL reg(%d)\n",
>  				__func__, ret);
> @@ -423,7 +427,8 @@ static void max8997_rtc_enable_smpl(struct max899=
7_rtc_info *info, bool enable)
>  	max8997_rtc_set_update_reg(info);
> =20
>  	val =3D 0;
> -	max8997_read_reg(info->rtc, MAX8997_RTC_WTSR_SMPL, &val);
> +	max8997_read_reg(info->max8997->regmap_rtc,
> +			 MAX8997_RTC_WTSR_SMPL, &val);
>  	pr_info("%s: WTSR_SMPL(0x%02x)\n", __func__, val);
>  }
> =20
> @@ -438,7 +443,8 @@ static int max8997_rtc_init_reg(struct max8997_rt=
c_info *info)
> =20
>  	info->rtc_24hr_mode =3D 1;
> =20
> -	ret =3D max8997_bulk_write(info->rtc, MAX8997_RTC_CTRLMASK, 2, data=
);
> +	ret =3D max8997_bulk_write(info->max8997->regmap_rtc,
> +				 MAX8997_RTC_CTRLMASK, 2, data);
>  	if (ret < 0) {
>  		dev_err(info->dev, "%s: fail to write controlm reg(%d)\n",
>  				__func__, ret);
> @@ -463,7 +469,6 @@ static int max8997_rtc_probe(struct platform_devi=
ce *pdev)
>  	mutex_init(&info->lock);
>  	info->dev =3D &pdev->dev;
>  	info->max8997 =3D max8997;
> -	info->rtc =3D max8997->rtc;
> =20
>  	platform_set_drvdata(pdev, info);
> =20
> diff --git a/include/linux/mfd/max8997-private.h b/include/linux/mfd/=
max8997-private.h
> index ad1ae7f..184e40a 100644
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
>  	int type;
>  	struct platform_device *battery; /* battery control (not fuel gauge=
) */
> =20
> +	struct regmap *regmap;
> +	struct regmap *regmap_rtc;
> +	struct regmap *regmap_haptic;
> +	struct regmap *regmap_muic;
> +
>  	int irq;
>  	int ono;
>  	struct irq_domain *irq_domain;
> @@ -413,13 +420,11 @@ extern int max8997_irq_init(struct max8997_dev =
*max8997);
>  extern void max8997_irq_exit(struct max8997_dev *max8997);
>  extern int max8997_irq_resume(struct max8997_dev *max8997);
> =20
> -extern int max8997_read_reg(struct i2c_client *i2c, u8 reg, u8 *dest=
);
> -extern int max8997_bulk_read(struct i2c_client *i2c, u8 reg, int cou=
nt,
> -				u8 *buf);
> -extern int max8997_write_reg(struct i2c_client *i2c, u8 reg, u8 valu=
e);
> -extern int max8997_bulk_write(struct i2c_client *i2c, u8 reg, int co=
unt,
> -				u8 *buf);
> -extern int max8997_update_reg(struct i2c_client *i2c, u8 reg, u8 val=
, u8 mask);
> +extern int max8997_read_reg(struct regmap *map, u8 reg, u8 *dest);
> +extern int max8997_bulk_read(struct regmap *map, u8 reg, int count, =
u8 *buf);
> +extern int max8997_write_reg(struct regmap *map, u8 reg, u8 value);
> +extern int max8997_bulk_write(struct regmap *map, u8 reg, int count,=
 u8 *buf);
> +extern int max8997_update_reg(struct regmap *map, u8 reg, u8 val, u8=
 mask);
> =20
>  #define MAX8997_GPIO_INT_BOTH	(0x3 << 4)
>  #define MAX8997_GPIO_INT_RISE	(0x2 << 4)
>=20
