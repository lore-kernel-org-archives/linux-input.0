From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 08/10] mfd/extcon: max77843: Rename defines to allow
 inclusion with max77693
Date: Wed, 29 Apr 2015 14:11:01 +0100
Message-ID: <20150429131101.GN9169@x1>
References: <1430305114-23598-1-git-send-email-k.kozlowski.k@gmail.com>
 <1430305114-23598-9-git-send-email-k.kozlowski.k@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1430305114-23598-9-git-send-email-k.kozlowski.k@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
Cc: Chanwoo Choi <cw00.choi@samsung.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Samuel Ortiz <sameo@linux.intel.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wed, 29 Apr 2015, Krzysztof Kozlowski wrote:

> Add MAX77843_MUIC prefix to some of the defines used in max77843 extc=
on
> driver so the max77693-private.h can be included simultaneously with
> max77843-private.h.
>=20
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
> ---
>  drivers/extcon/extcon-max77843.c     |  59 ++++++++++----
>  include/linux/mfd/max77843-private.h | 154 +++++++++++++++++--------=
----------

=46or the MFD changes:

Acked-by: Lee Jones <lee.jones@linaro.org>

>  2 files changed, 118 insertions(+), 95 deletions(-)
>=20
> diff --git a/drivers/extcon/extcon-max77843.c b/drivers/extcon/extcon=
-max77843.c
> index fec26128ecfc..614f1996c51b 100644
> --- a/drivers/extcon/extcon-max77843.c
> +++ b/drivers/extcon/extcon-max77843.c
> @@ -226,11 +226,11 @@ static int max77843_muic_set_path(struct max778=
43_muic_info *info,
>  	if (attached)
>  		ctrl1 =3D val;
>  	else
> -		ctrl1 =3D CONTROL1_SW_OPEN;
> +		ctrl1 =3D MAX77843_MUIC_CONTROL1_SW_OPEN;
> =20
>  	ret =3D regmap_update_bits(max77843->regmap_muic,
>  			MAX77843_MUIC_REG_CONTROL1,
> -			CONTROL1_COM_SW, ctrl1);
> +			MAX77843_MUIC_CONTROL1_COM_SW, ctrl1);
>  	if (ret < 0) {
>  		dev_err(info->dev, "Cannot switch MUIC port\n");
>  		return ret;
> @@ -264,7 +264,7 @@ static int max77843_muic_get_cable_type(struct ma=
x77843_muic_info *info,
> =20
>  	adc =3D info->status[MAX77843_MUIC_STATUS1] &
>  			MAX77843_MUIC_STATUS1_ADC_MASK;
> -	adc >>=3D STATUS1_ADC_SHIFT;
> +	adc >>=3D MAX77843_MUIC_STATUS1_ADC_SHIFT;
> =20
>  	switch (group) {
>  	case MAX77843_CABLE_GROUP_ADC:
> @@ -330,7 +330,7 @@ static int max77843_muic_get_cable_type(struct ma=
x77843_muic_info *info,
>  			/* Get VBVolt register bit */
>  			gnd_type |=3D (info->status[MAX77843_MUIC_STATUS2] &
>  					MAX77843_MUIC_STATUS2_VBVOLT_MASK);
> -			gnd_type >>=3D STATUS2_VBVOLT_SHIFT;
> +			gnd_type >>=3D MAX77843_MUIC_STATUS2_VBVOLT_SHIFT;
> =20
>  			/* Offset of GND cable */
>  			gnd_type |=3D MAX77843_MUIC_GND_USB_HOST;
> @@ -359,7 +359,9 @@ static int max77843_muic_adc_gnd_handler(struct m=
ax77843_muic_info *info)
>  	switch (gnd_cable_type) {
>  	case MAX77843_MUIC_GND_USB_HOST:
>  	case MAX77843_MUIC_GND_USB_HOST_VB:
> -		ret =3D max77843_muic_set_path(info, CONTROL1_SW_USB, attached);
> +		ret =3D max77843_muic_set_path(info,
> +					     MAX77843_MUIC_CONTROL1_SW_USB,
> +					     attached);
>  		if (ret < 0)
>  			return ret;
> =20
> @@ -367,7 +369,9 @@ static int max77843_muic_adc_gnd_handler(struct m=
ax77843_muic_info *info)
>  		break;
>  	case MAX77843_MUIC_GND_MHL_VB:
>  	case MAX77843_MUIC_GND_MHL:
> -		ret =3D max77843_muic_set_path(info, CONTROL1_SW_OPEN, attached);
> +		ret =3D max77843_muic_set_path(info,
> +					     MAX77843_MUIC_CONTROL1_SW_OPEN,
> +					     attached);
>  		if (ret < 0)
>  			return ret;
> =20
> @@ -392,25 +396,33 @@ static int max77843_muic_jig_handler(struct max=
77843_muic_info *info,
> =20
>  	switch (cable_type) {
>  	case MAX77843_MUIC_ADC_FACTORY_MODE_USB_OFF:
> -		ret =3D max77843_muic_set_path(info, CONTROL1_SW_USB, attached);
> +		ret =3D max77843_muic_set_path(info,
> +					     MAX77843_MUIC_CONTROL1_SW_USB,
> +					     attached);
>  		if (ret < 0)
>  			return ret;
>  		extcon_set_cable_state(info->edev, "JIG-USB-OFF", attached);
>  		break;
>  	case MAX77843_MUIC_ADC_FACTORY_MODE_USB_ON:
> -		ret =3D max77843_muic_set_path(info, CONTROL1_SW_USB, attached);
> +		ret =3D max77843_muic_set_path(info,
> +					     MAX77843_MUIC_CONTROL1_SW_USB,
> +					     attached);
>  		if (ret < 0)
>  			return ret;
>  		extcon_set_cable_state(info->edev, "JIG-USB-ON", attached);
>  		break;
>  	case MAX77843_MUIC_ADC_FACTORY_MODE_UART_OFF:
> -		ret =3D max77843_muic_set_path(info, CONTROL1_SW_UART, attached);
> +		ret =3D max77843_muic_set_path(info,
> +					     MAX77843_MUIC_CONTROL1_SW_UART,
> +					     attached);
>  		if (ret < 0)
>  			return ret;
>  		extcon_set_cable_state(info->edev, "JIG-UART-OFF", attached);
>  		break;
>  	default:
> -		ret =3D max77843_muic_set_path(info, CONTROL1_SW_OPEN, attached);
> +		ret =3D max77843_muic_set_path(info,
> +					     MAX77843_MUIC_CONTROL1_SW_OPEN,
> +					     attached);
>  		if (ret < 0)
>  			return ret;
>  		break;
> @@ -502,14 +514,18 @@ static int max77843_muic_chg_handler(struct max=
77843_muic_info *info)
> =20
>  	switch (chg_type) {
>  	case MAX77843_MUIC_CHG_USB:
> -		ret =3D max77843_muic_set_path(info, CONTROL1_SW_USB, attached);
> +		ret =3D max77843_muic_set_path(info,
> +					     MAX77843_MUIC_CONTROL1_SW_USB,
> +					     attached);
>  		if (ret < 0)
>  			return ret;
> =20
>  		extcon_set_cable_state(info->edev, "USB", attached);
>  		break;
>  	case MAX77843_MUIC_CHG_DOWNSTREAM:
> -		ret =3D max77843_muic_set_path(info, CONTROL1_SW_OPEN, attached);
> +		ret =3D max77843_muic_set_path(info,
> +					     MAX77843_MUIC_CONTROL1_SW_OPEN,
> +					     attached);
>  		if (ret < 0)
>  			return ret;
> =20
> @@ -517,21 +533,27 @@ static int max77843_muic_chg_handler(struct max=
77843_muic_info *info)
>  				"CHARGER-DOWNSTREAM", attached);
>  		break;
>  	case MAX77843_MUIC_CHG_DEDICATED:
> -		ret =3D max77843_muic_set_path(info, CONTROL1_SW_OPEN, attached);
> +		ret =3D max77843_muic_set_path(info,
> +					     MAX77843_MUIC_CONTROL1_SW_OPEN,
> +					     attached);
>  		if (ret < 0)
>  			return ret;
> =20
>  		extcon_set_cable_state(info->edev, "TA", attached);
>  		break;
>  	case MAX77843_MUIC_CHG_SPECIAL_500MA:
> -		ret =3D max77843_muic_set_path(info, CONTROL1_SW_OPEN, attached);
> +		ret =3D max77843_muic_set_path(info,
> +					     MAX77843_MUIC_CONTROL1_SW_OPEN,
> +					     attached);
>  		if (ret < 0)
>  			return ret;
> =20
>  		extcon_set_cable_state(info->edev, "SLOW-CHAREGER", attached);
>  		break;
>  	case MAX77843_MUIC_CHG_SPECIAL_1A:
> -		ret =3D max77843_muic_set_path(info, CONTROL1_SW_OPEN, attached);
> +		ret =3D max77843_muic_set_path(info,
> +					     MAX77843_MUIC_CONTROL1_SW_OPEN,
> +					     attached);
>  		if (ret < 0)
>  			return ret;
> =20
> @@ -554,7 +576,8 @@ static int max77843_muic_chg_handler(struct max77=
843_muic_info *info)
>  			"failed to detect %s accessory (chg_type:0x%x)\n",
>  			attached ? "attached" : "detached", chg_type);
> =20
> -		max77843_muic_set_path(info, CONTROL1_SW_OPEN, attached);
> +		max77843_muic_set_path(info, MAX77843_MUIC_CONTROL1_SW_OPEN,
> +				       attached);
>  		return -EINVAL;
>  	}
> =20
> @@ -693,7 +716,7 @@ static int max77843_muic_set_debounce_time(struct=
 max77843_muic_info *info,
>  		ret =3D regmap_update_bits(max77843->regmap_muic,
>  				MAX77843_MUIC_REG_CONTROL4,
>  				MAX77843_MUIC_CONTROL4_ADCDBSET_MASK,
> -				time << CONTROL4_ADCDBSET_SHIFT);
> +				time << MAX77843_MUIC_CONTROL4_ADCDBSET_SHIFT);
>  		if (ret < 0) {
>  			dev_err(info->dev, "Cannot write MUIC regmap\n");
>  			return ret;
> @@ -794,7 +817,7 @@ static int max77843_muic_probe(struct platform_de=
vice *pdev)
>  	max77843_muic_set_debounce_time(info, MAX77843_DEBOUNCE_TIME_25MS);
> =20
>  	/* Set initial path for UART */
> -	max77843_muic_set_path(info, CONTROL1_SW_UART, true);
> +	max77843_muic_set_path(info, MAX77843_MUIC_CONTROL1_SW_UART, true);
> =20
>  	/* Check revision number of MUIC device */
>  	ret =3D regmap_read(max77843->regmap_muic, MAX77843_MUIC_REG_ID, &i=
d);
> diff --git a/include/linux/mfd/max77843-private.h b/include/linux/mfd=
/max77843-private.h
> index 0121d9440340..c19303b0ccfd 100644
> --- a/include/linux/mfd/max77843-private.h
> +++ b/include/linux/mfd/max77843-private.h
> @@ -318,62 +318,62 @@ enum max77843_irq_muic {
>  	MAX77843_INTSRCMASK_SYS_MASK | MAX77843_INTSRCMASK_CHGR_MASK)
> =20
>  /* MAX77843 STATUS register*/
> -#define STATUS1_ADC_SHIFT			0
> -#define STATUS1_ADCERROR_SHIFT			6
> -#define STATUS1_ADC1K_SHIFT			7
> -#define STATUS2_CHGTYP_SHIFT			0
> -#define STATUS2_CHGDETRUN_SHIFT			3
> -#define STATUS2_DCDTMR_SHIFT			4
> -#define STATUS2_DXOVP_SHIFT			5
> -#define STATUS2_VBVOLT_SHIFT			6
> -#define STATUS3_VBADC_SHIFT			0
> -#define STATUS3_VDNMON_SHIFT			4
> -#define STATUS3_DNRES_SHIFT			5
> -#define STATUS3_MPNACK_SHIFT			6
> -
> -#define MAX77843_MUIC_STATUS1_ADC_MASK		(0x1f << STATUS1_ADC_SHIFT)
> -#define MAX77843_MUIC_STATUS1_ADCERROR_MASK	BIT(STATUS1_ADCERROR_SHI=
=46T)
> -#define MAX77843_MUIC_STATUS1_ADC1K_MASK	BIT(STATUS1_ADC1K_SHIFT)
> -#define MAX77843_MUIC_STATUS2_CHGTYP_MASK	(0x7 << STATUS2_CHGTYP_SHI=
=46T)
> -#define MAX77843_MUIC_STATUS2_CHGDETRUN_MASK	BIT(STATUS2_CHGDETRUN_S=
HIFT)
> -#define MAX77843_MUIC_STATUS2_DCDTMR_MASK	BIT(STATUS2_DCDTMR_SHIFT)
> -#define MAX77843_MUIC_STATUS2_DXOVP_MASK	BIT(STATUS2_DXOVP_SHIFT)
> -#define MAX77843_MUIC_STATUS2_VBVOLT_MASK	BIT(STATUS2_VBVOLT_SHIFT)
> -#define MAX77843_MUIC_STATUS3_VBADC_MASK	(0xf << STATUS3_VBADC_SHIFT=
)
> -#define MAX77843_MUIC_STATUS3_VDNMON_MASK	BIT(STATUS3_VDNMON_SHIFT)
> -#define MAX77843_MUIC_STATUS3_DNRES_MASK	BIT(STATUS3_DNRES_SHIFT)
> -#define MAX77843_MUIC_STATUS3_MPNACK_MASK	BIT(STATUS3_MPNACK_SHIFT)
> +#define MAX77843_MUIC_STATUS1_ADC_SHIFT		0
> +#define MAX77843_MUIC_STATUS1_ADCERROR_SHIFT	6
> +#define MAX77843_MUIC_STATUS1_ADC1K_SHIFT	7
> +#define MAX77843_MUIC_STATUS2_CHGTYP_SHIFT	0
> +#define MAX77843_MUIC_STATUS2_CHGDETRUN_SHIFT	3
> +#define MAX77843_MUIC_STATUS2_DCDTMR_SHIFT	4
> +#define MAX77843_MUIC_STATUS2_DXOVP_SHIFT	5
> +#define MAX77843_MUIC_STATUS2_VBVOLT_SHIFT	6
> +#define MAX77843_MUIC_STATUS3_VBADC_SHIFT	0
> +#define MAX77843_MUIC_STATUS3_VDNMON_SHIFT	4
> +#define MAX77843_MUIC_STATUS3_DNRES_SHIFT	5
> +#define MAX77843_MUIC_STATUS3_MPNACK_SHIFT	6
> +
> +#define MAX77843_MUIC_STATUS1_ADC_MASK		(0x1f << MAX77843_MUIC_STATU=
S1_ADC_SHIFT)
> +#define MAX77843_MUIC_STATUS1_ADCERROR_MASK	BIT(MAX77843_MUIC_STATUS=
1_ADCERROR_SHIFT)
> +#define MAX77843_MUIC_STATUS1_ADC1K_MASK	BIT(MAX77843_MUIC_STATUS1_A=
DC1K_SHIFT)
> +#define MAX77843_MUIC_STATUS2_CHGTYP_MASK	(0x7 << MAX77843_MUIC_STAT=
US2_CHGTYP_SHIFT)
> +#define MAX77843_MUIC_STATUS2_CHGDETRUN_MASK	BIT(MAX77843_MUIC_STATU=
S2_CHGDETRUN_SHIFT)
> +#define MAX77843_MUIC_STATUS2_DCDTMR_MASK	BIT(MAX77843_MUIC_STATUS2_=
DCDTMR_SHIFT)
> +#define MAX77843_MUIC_STATUS2_DXOVP_MASK	BIT(MAX77843_MUIC_STATUS2_D=
XOVP_SHIFT)
> +#define MAX77843_MUIC_STATUS2_VBVOLT_MASK	BIT(MAX77843_MUIC_STATUS2_=
VBVOLT_SHIFT)
> +#define MAX77843_MUIC_STATUS3_VBADC_MASK	(0xf << MAX77843_MUIC_STATU=
S3_VBADC_SHIFT)
> +#define MAX77843_MUIC_STATUS3_VDNMON_MASK	BIT(MAX77843_MUIC_STATUS3_=
VDNMON_SHIFT)
> +#define MAX77843_MUIC_STATUS3_DNRES_MASK	BIT(MAX77843_MUIC_STATUS3_D=
NRES_SHIFT)
> +#define MAX77843_MUIC_STATUS3_MPNACK_MASK	BIT(MAX77843_MUIC_STATUS3_=
MPNACK_SHIFT)
> =20
>  /* MAX77843 CONTROL register */
> -#define CONTROL1_COMP1SW_SHIFT			0
> -#define CONTROL1_COMP2SW_SHIFT			3
> -#define CONTROL1_IDBEN_SHIFT			7
> -#define CONTROL2_LOWPWR_SHIFT			0
> -#define CONTROL2_ADCEN_SHIFT			1
> -#define CONTROL2_CPEN_SHIFT			2
> -#define CONTROL2_ACC_DET_SHIFT			5
> -#define CONTROL2_USBCPINT_SHIFT			6
> -#define CONTROL2_RCPS_SHIFT			7
> -#define CONTROL3_JIGSET_SHIFT			0
> -#define CONTROL4_ADCDBSET_SHIFT			0
> -#define CONTROL4_USBAUTO_SHIFT			4
> -#define CONTROL4_FCTAUTO_SHIFT			5
> -#define CONTROL4_ADCMODE_SHIFT			6
> -
> -#define MAX77843_MUIC_CONTROL1_COMP1SW_MASK	(0x7 << CONTROL1_COMP1SW=
_SHIFT)
> -#define MAX77843_MUIC_CONTROL1_COMP2SW_MASK	(0x7 << CONTROL1_COMP2SW=
_SHIFT)
> -#define MAX77843_MUIC_CONTROL1_IDBEN_MASK	BIT(CONTROL1_IDBEN_SHIFT)
> -#define MAX77843_MUIC_CONTROL2_LOWPWR_MASK	BIT(CONTROL2_LOWPWR_SHIFT=
)
> -#define MAX77843_MUIC_CONTROL2_ADCEN_MASK	BIT(CONTROL2_ADCEN_SHIFT)
> -#define MAX77843_MUIC_CONTROL2_CPEN_MASK	BIT(CONTROL2_CPEN_SHIFT)
> -#define MAX77843_MUIC_CONTROL2_ACC_DET_MASK	BIT(CONTROL2_ACC_DET_SHI=
=46T)
> -#define MAX77843_MUIC_CONTROL2_USBCPINT_MASK	BIT(CONTROL2_USBCPINT_S=
HIFT)
> -#define MAX77843_MUIC_CONTROL2_RCPS_MASK	BIT(CONTROL2_RCPS_SHIFT)
> -#define MAX77843_MUIC_CONTROL3_JIGSET_MASK	(0x3 << CONTROL3_JIGSET_S=
HIFT)
> -#define MAX77843_MUIC_CONTROL4_ADCDBSET_MASK	(0x3 << CONTROL4_ADCDBS=
ET_SHIFT)
> -#define MAX77843_MUIC_CONTROL4_USBAUTO_MASK	BIT(CONTROL4_USBAUTO_SHI=
=46T)
> -#define MAX77843_MUIC_CONTROL4_FCTAUTO_MASK	BIT(CONTROL4_FCTAUTO_SHI=
=46T)
> -#define MAX77843_MUIC_CONTROL4_ADCMODE_MASK	(0x3 << CONTROL4_ADCMODE=
_SHIFT)
> +#define MAX77843_MUIC_CONTROL1_COMP1SW_SHIFT	0
> +#define MAX77843_MUIC_CONTROL1_COMP2SW_SHIFT	3
> +#define MAX77843_MUIC_CONTROL1_IDBEN_SHIFT	7
> +#define MAX77843_MUIC_CONTROL2_LOWPWR_SHIFT	0
> +#define MAX77843_MUIC_CONTROL2_ADCEN_SHIFT	1
> +#define MAX77843_MUIC_CONTROL2_CPEN_SHIFT	2
> +#define MAX77843_MUIC_CONTROL2_ACC_DET_SHIFT	5
> +#define MAX77843_MUIC_CONTROL2_USBCPINT_SHIFT	6
> +#define MAX77843_MUIC_CONTROL2_RCPS_SHIFT	7
> +#define MAX77843_MUIC_CONTROL3_JIGSET_SHIFT	0
> +#define MAX77843_MUIC_CONTROL4_ADCDBSET_SHIFT	0
> +#define MAX77843_MUIC_CONTROL4_USBAUTO_SHIFT	4
> +#define MAX77843_MUIC_CONTROL4_FCTAUTO_SHIFT	5
> +#define MAX77843_MUIC_CONTROL4_ADCMODE_SHIFT	6
> +
> +#define MAX77843_MUIC_CONTROL1_COMP1SW_MASK	(0x7 << MAX77843_MUIC_CO=
NTROL1_COMP1SW_SHIFT)
> +#define MAX77843_MUIC_CONTROL1_COMP2SW_MASK	(0x7 << MAX77843_MUIC_CO=
NTROL1_COMP2SW_SHIFT)
> +#define MAX77843_MUIC_CONTROL1_IDBEN_MASK	BIT(MAX77843_MUIC_CONTROL1=
_IDBEN_SHIFT)
> +#define MAX77843_MUIC_CONTROL2_LOWPWR_MASK	BIT(MAX77843_MUIC_CONTROL=
2_LOWPWR_SHIFT)
> +#define MAX77843_MUIC_CONTROL2_ADCEN_MASK	BIT(MAX77843_MUIC_CONTROL2=
_ADCEN_SHIFT)
> +#define MAX77843_MUIC_CONTROL2_CPEN_MASK	BIT(MAX77843_MUIC_CONTROL2_=
CPEN_SHIFT)
> +#define MAX77843_MUIC_CONTROL2_ACC_DET_MASK	BIT(MAX77843_MUIC_CONTRO=
L2_ACC_DET_SHIFT)
> +#define MAX77843_MUIC_CONTROL2_USBCPINT_MASK	BIT(MAX77843_MUIC_CONTR=
OL2_USBCPINT_SHIFT)
> +#define MAX77843_MUIC_CONTROL2_RCPS_MASK	BIT(MAX77843_MUIC_CONTROL2_=
RCPS_SHIFT)
> +#define MAX77843_MUIC_CONTROL3_JIGSET_MASK	(0x3 << MAX77843_MUIC_CON=
TROL3_JIGSET_SHIFT)
> +#define MAX77843_MUIC_CONTROL4_ADCDBSET_MASK	(0x3 << MAX77843_MUIC_C=
ONTROL4_ADCDBSET_SHIFT)
> +#define MAX77843_MUIC_CONTROL4_USBAUTO_MASK	BIT(MAX77843_MUIC_CONTRO=
L4_USBAUTO_SHIFT)
> +#define MAX77843_MUIC_CONTROL4_FCTAUTO_MASK	BIT(MAX77843_MUIC_CONTRO=
L4_FCTAUTO_SHIFT)
> +#define MAX77843_MUIC_CONTROL4_ADCMODE_MASK	(0x3 << MAX77843_MUIC_CO=
NTROL4_ADCMODE_SHIFT)
> =20
>  /* MAX77843 switch port */
>  #define COM_OPEN				0
> @@ -383,38 +383,38 @@ enum max77843_irq_muic {
>  #define COM_AUX_USB				4
>  #define COM_AUX_UART				5
> =20
> -#define CONTROL1_COM_SW \
> +#define MAX77843_MUIC_CONTROL1_COM_SW \
>  	((MAX77843_MUIC_CONTROL1_COMP1SW_MASK | \
>  	 MAX77843_MUIC_CONTROL1_COMP2SW_MASK))
> =20
> -#define CONTROL1_SW_OPEN \
> -	((COM_OPEN << CONTROL1_COMP1SW_SHIFT | \
> -	 COM_OPEN << CONTROL1_COMP2SW_SHIFT))
> -#define CONTROL1_SW_USB \
> -	((COM_USB << CONTROL1_COMP1SW_SHIFT | \
> -	 COM_USB << CONTROL1_COMP2SW_SHIFT))
> -#define CONTROL1_SW_AUDIO \
> -	((COM_AUDIO << CONTROL1_COMP1SW_SHIFT | \
> -	 COM_AUDIO << CONTROL1_COMP2SW_SHIFT))
> -#define CONTROL1_SW_UART \
> -	((COM_UART << CONTROL1_COMP1SW_SHIFT | \
> -	 COM_UART << CONTROL1_COMP2SW_SHIFT))
> -#define CONTROL1_SW_AUX_USB \
> -	((COM_AUX_USB << CONTROL1_COMP1SW_SHIFT | \
> -	 COM_AUX_USB << CONTROL1_COMP2SW_SHIFT))
> -#define CONTROL1_SW_AUX_UART \
> -	((COM_AUX_UART << CONTROL1_COMP1SW_SHIFT | \
> -	 COM_AUX_UART << CONTROL1_COMP2SW_SHIFT))
> +#define MAX77843_MUIC_CONTROL1_SW_OPEN \
> +	((COM_OPEN << MAX77843_MUIC_CONTROL1_COMP1SW_SHIFT | \
> +	 COM_OPEN << MAX77843_MUIC_CONTROL1_COMP2SW_SHIFT))
> +#define MAX77843_MUIC_CONTROL1_SW_USB \
> +	((COM_USB << MAX77843_MUIC_CONTROL1_COMP1SW_SHIFT | \
> +	 COM_USB << MAX77843_MUIC_CONTROL1_COMP2SW_SHIFT))
> +#define MAX77843_MUIC_CONTROL1_SW_AUDIO \
> +	((COM_AUDIO << MAX77843_MUIC_CONTROL1_COMP1SW_SHIFT | \
> +	 COM_AUDIO << MAX77843_MUIC_CONTROL1_COMP2SW_SHIFT))
> +#define MAX77843_MUIC_CONTROL1_SW_UART \
> +	((COM_UART << MAX77843_MUIC_CONTROL1_COMP1SW_SHIFT | \
> +	 COM_UART << MAX77843_MUIC_CONTROL1_COMP2SW_SHIFT))
> +#define MAX77843_MUIC_CONTROL1_SW_AUX_USB \
> +	((COM_AUX_USB << MAX77843_MUIC_CONTROL1_COMP1SW_SHIFT | \
> +	 COM_AUX_USB << MAX77843_MUIC_CONTROL1_COMP2SW_SHIFT))
> +#define MAX77843_MUIC_CONTROL1_SW_AUX_UART \
> +	((COM_AUX_UART << MAX77843_MUIC_CONTROL1_COMP1SW_SHIFT | \
> +	 COM_AUX_UART << MAX77843_MUIC_CONTROL1_COMP2SW_SHIFT))
> =20
>  #define MAX77843_DISABLE			0
>  #define MAX77843_ENABLE				1
> =20
>  #define CONTROL4_AUTO_DISABLE \
> -	((MAX77843_DISABLE << CONTROL4_USBAUTO_SHIFT) | \
> -	(MAX77843_DISABLE << CONTROL4_FCTAUTO_SHIFT))
> +	((MAX77843_DISABLE << MAX77843_MUIC_CONTROL4_USBAUTO_SHIFT) | \
> +	(MAX77843_DISABLE << MAX77843_MUIC_CONTROL4_FCTAUTO_SHIFT))
>  #define CONTROL4_AUTO_ENABLE \
> -	((MAX77843_ENABLE << CONTROL4_USBAUTO_SHIFT) | \
> -	(MAX77843_ENABLE << CONTROL4_FCTAUTO_SHIFT))
> +	((MAX77843_ENABLE << MAX77843_MUIC_CONTROL4_USBAUTO_SHIFT) | \
> +	(MAX77843_ENABLE << MAX77843_MUIC_CONTROL4_FCTAUTO_SHIFT))
> =20
>  /* MAX77843 SAFEOUT LDO Control register */
>  #define SAFEOUTCTRL_SAFEOUT1_SHIFT		0

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
