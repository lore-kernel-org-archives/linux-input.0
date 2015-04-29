From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 07/10] mfd/extcon: max77693: Rename defines to allow
 inclusion with max77843
Date: Wed, 29 Apr 2015 14:12:29 +0100
Message-ID: <20150429131229.GO9169@x1>
References: <1430305114-23598-1-git-send-email-k.kozlowski.k@gmail.com>
 <1430305114-23598-8-git-send-email-k.kozlowski.k@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1430305114-23598-8-git-send-email-k.kozlowski.k@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
Cc: Chanwoo Choi <cw00.choi@samsung.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Samuel Ortiz <sameo@linux.intel.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wed, 29 Apr 2015, Krzysztof Kozlowski wrote:

> Add MAX77693 prefix to some of the defines used in max77693 extcon
> driver so the max77693-private.h can be included simultaneously with
> max77843-private.h.
>=20
> Additionally use BIT() macro in header.
>=20
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
> ---
>  drivers/extcon/extcon-max77693.c     |  76 +++++++++++++------------=
-
>  include/linux/mfd/max77693-private.h | 102 +++++++++++++++++--------=
----------
>  2 files changed, 91 insertions(+), 87 deletions(-)

[...]

> diff --git a/include/linux/mfd/max77693-private.h b/include/linux/mfd=
/max77693-private.h
> index 8c4143c0c651..7201c0b61bd5 100644
> --- a/include/linux/mfd/max77693-private.h
> +++ b/include/linux/mfd/max77693-private.h
> @@ -310,30 +310,30 @@ enum max77693_muic_reg {
>  #define INTMASK2_CHGTYP_MASK		(1 << INTMASK2_CHGTYP_SHIFT)
> =20
>  /* MAX77693 MUIC - STATUS1~3 Register */
> -#define STATUS1_ADC_SHIFT		(0)
> -#define STATUS1_ADCLOW_SHIFT		(5)
> -#define STATUS1_ADCERR_SHIFT		(6)
> -#define STATUS1_ADC1K_SHIFT		(7)
> -#define STATUS1_ADC_MASK		(0x1f << STATUS1_ADC_SHIFT)
> -#define STATUS1_ADCLOW_MASK		(0x1 << STATUS1_ADCLOW_SHIFT)
> -#define STATUS1_ADCERR_MASK		(0x1 << STATUS1_ADCERR_SHIFT)
> -#define STATUS1_ADC1K_MASK		(0x1 << STATUS1_ADC1K_SHIFT)
> -
> -#define STATUS2_CHGTYP_SHIFT		(0)
> -#define STATUS2_CHGDETRUN_SHIFT		(3)
> -#define STATUS2_DCDTMR_SHIFT		(4)
> -#define STATUS2_DXOVP_SHIFT		(5)
> -#define STATUS2_VBVOLT_SHIFT		(6)
> -#define STATUS2_VIDRM_SHIFT		(7)
> -#define STATUS2_CHGTYP_MASK		(0x7 << STATUS2_CHGTYP_SHIFT)
> -#define STATUS2_CHGDETRUN_MASK		(0x1 << STATUS2_CHGDETRUN_SHIFT)
> -#define STATUS2_DCDTMR_MASK		(0x1 << STATUS2_DCDTMR_SHIFT)
> -#define STATUS2_DXOVP_MASK		(0x1 << STATUS2_DXOVP_SHIFT)
> -#define STATUS2_VBVOLT_MASK		(0x1 << STATUS2_VBVOLT_SHIFT)
> -#define STATUS2_VIDRM_MASK		(0x1 << STATUS2_VIDRM_SHIFT)
> -
> -#define STATUS3_OVP_SHIFT		(2)
> -#define STATUS3_OVP_MASK		(0x1 << STATUS3_OVP_SHIFT)
> +#define MAX77693_STATUS1_ADC_SHIFT		(0)
> +#define MAX77693_STATUS1_ADCLOW_SHIFT		(5)
> +#define MAX77693_STATUS1_ADCERR_SHIFT		(6)
> +#define MAX77693_STATUS1_ADC1K_SHIFT		(7)
> +#define MAX77693_STATUS1_ADC_MASK		(0x1f << MAX77693_STATUS1_ADC_SHI=
=46T)
> +#define MAX77693_STATUS1_ADCLOW_MASK		BIT(MAX77693_STATUS1_ADCLOW_SH=
IFT)
> +#define MAX77693_STATUS1_ADCERR_MASK		BIT(MAX77693_STATUS1_ADCERR_SH=
IFT)
> +#define MAX77693_STATUS1_ADC1K_MASK		BIT(MAX77693_STATUS1_ADC1K_SHIF=
T)
> +
> +#define MAX77693_STATUS2_CHGTYP_SHIFT		(0)
> +#define MAX77693_STATUS2_CHGDETRUN_SHIFT	(3)
> +#define MAX77693_STATUS2_DCDTMR_SHIFT		(4)
> +#define MAX77693_STATUS2_DXOVP_SHIFT		(5)
> +#define MAX77693_STATUS2_VBVOLT_SHIFT		(6)
> +#define MAX77693_STATUS2_VIDRM_SHIFT		(7)
> +#define MAX77693_STATUS2_CHGTYP_MASK		(0x7 << MAX77693_STATUS2_CHGTY=
P_SHIFT)
> +#define MAX77693_STATUS2_CHGDETRUN_MASK		BIT(MAX77693_STATUS2_CHGDET=
RUN_SHIFT)
> +#define MAX77693_STATUS2_DCDTMR_MASK		BIT(MAX77693_STATUS2_DCDTMR_SH=
IFT)
> +#define MAX77693_STATUS2_DXOVP_MASK		BIT(MAX77693_STATUS2_DXOVP_SHIF=
T)
> +#define MAX77693_STATUS2_VBVOLT_MASK		BIT(MAX77693_STATUS2_VBVOLT_SH=
IFT)
> +#define MAX77693_STATUS2_VIDRM_MASK		BIT(MAX77693_STATUS2_VIDRM_SHIF=
T)
> +
> +#define MAX77693_STATUS3_OVP_SHIFT		(2)
> +#define MAX77693_STATUS3_OVP_MASK		BIT(MAX77693_STATUS3_OVP_SHIFT)
> =20
>  /* MAX77693 CDETCTRL1~2 register */
>  #define CDETCTRL1_CHGDETEN_SHIFT	(0)
> @@ -362,38 +362,38 @@ enum max77693_muic_reg {
>  #define COMN1SW_MASK			(0x7 << COMN1SW_SHIFT)
>  #define COMP2SW_MASK			(0x7 << COMP2SW_SHIFT)
>  #define COMP_SW_MASK			(COMP2SW_MASK | COMN1SW_MASK)
> -#define CONTROL1_SW_USB			((1 << COMP2SW_SHIFT) \
> +#define MAX77693_CONTROL1_SW_USB	((1 << COMP2SW_SHIFT) \
>  						| (1 << COMN1SW_SHIFT))
> -#define CONTROL1_SW_AUDIO		((2 << COMP2SW_SHIFT) \
> +#define MAX77693_CONTROL1_SW_AUDIO	((2 << COMP2SW_SHIFT) \
>  						| (2 << COMN1SW_SHIFT))
> -#define CONTROL1_SW_UART		((3 << COMP2SW_SHIFT) \
> +#define MAX77693_CONTROL1_SW_UART	((3 << COMP2SW_SHIFT) \
>  						| (3 << COMN1SW_SHIFT))
> -#define CONTROL1_SW_OPEN		((0 << COMP2SW_SHIFT) \
> +#define MAX77693_CONTROL1_SW_OPEN	((0 << COMP2SW_SHIFT) \
>  						| (0 << COMN1SW_SHIFT))
> =20
> -#define CONTROL2_LOWPWR_SHIFT		(0)
> -#define CONTROL2_ADCEN_SHIFT		(1)
> -#define CONTROL2_CPEN_SHIFT		(2)
> -#define CONTROL2_SFOUTASRT_SHIFT	(3)
> -#define CONTROL2_SFOUTORD_SHIFT		(4)
> -#define CONTROL2_ACCDET_SHIFT		(5)
> -#define CONTROL2_USBCPINT_SHIFT		(6)
> -#define CONTROL2_RCPS_SHIFT		(7)
> -#define CONTROL2_LOWPWR_MASK		(0x1 << CONTROL2_LOWPWR_SHIFT)
> -#define CONTROL2_ADCEN_MASK		(0x1 << CONTROL2_ADCEN_SHIFT)
> -#define CONTROL2_CPEN_MASK		(0x1 << CONTROL2_CPEN_SHIFT)
> -#define CONTROL2_SFOUTASRT_MASK		(0x1 << CONTROL2_SFOUTASRT_SHIFT)
> -#define CONTROL2_SFOUTORD_MASK		(0x1 << CONTROL2_SFOUTORD_SHIFT)
> -#define CONTROL2_ACCDET_MASK		(0x1 << CONTROL2_ACCDET_SHIFT)
> -#define CONTROL2_USBCPINT_MASK		(0x1 << CONTROL2_USBCPINT_SHIFT)
> -#define CONTROL2_RCPS_MASK		(0x1 << CONTROL2_RCPS_SHIFT)
> -
> -#define CONTROL3_JIGSET_SHIFT		(0)
> -#define CONTROL3_BTLDSET_SHIFT		(2)
> -#define CONTROL3_ADCDBSET_SHIFT		(4)
> -#define CONTROL3_JIGSET_MASK		(0x3 << CONTROL3_JIGSET_SHIFT)
> -#define CONTROL3_BTLDSET_MASK		(0x3 << CONTROL3_BTLDSET_SHIFT)
> -#define CONTROL3_ADCDBSET_MASK		(0x3 << CONTROL3_ADCDBSET_SHIFT)
> +#define MAX77693_CONTROL2_LOWPWR_SHIFT		(0)
> +#define MAX77693_CONTROL2_ADCEN_SHIFT		(1)
> +#define MAX77693_CONTROL2_CPEN_SHIFT		(2)
> +#define MAX77693_CONTROL2_SFOUTASRT_SHIFT	(3)
> +#define MAX77693_CONTROL2_SFOUTORD_SHIFT	(4)
> +#define MAX77693_CONTROL2_ACCDET_SHIFT		(5)
> +#define MAX77693_CONTROL2_USBCPINT_SHIFT	(6)
> +#define MAX77693_CONTROL2_RCPS_SHIFT		(7)

Why the need for the added () all of the sudden?

> +#define MAX77693_CONTROL2_LOWPWR_MASK		BIT(MAX77693_CONTROL2_LOWPWR_=
SHIFT)
> +#define MAX77693_CONTROL2_ADCEN_MASK		BIT(MAX77693_CONTROL2_ADCEN_SH=
IFT)
> +#define MAX77693_CONTROL2_CPEN_MASK		BIT(MAX77693_CONTROL2_CPEN_SHIF=
T)
> +#define MAX77693_CONTROL2_SFOUTASRT_MASK	BIT(MAX77693_CONTROL2_SFOUT=
ASRT_SHIFT)
> +#define MAX77693_CONTROL2_SFOUTORD_MASK		BIT(MAX77693_CONTROL2_SFOUT=
ORD_SHIFT)
> +#define MAX77693_CONTROL2_ACCDET_MASK		BIT(MAX77693_CONTROL2_ACCDET_=
SHIFT)
> +#define MAX77693_CONTROL2_USBCPINT_MASK		BIT(MAX77693_CONTROL2_USBCP=
INT_SHIFT)
> +#define MAX77693_CONTROL2_RCPS_MASK		BIT(MAX77693_CONTROL2_RCPS_SHIF=
T)
> +
> +#define MAX77693_CONTROL3_JIGSET_SHIFT		(0)
> +#define MAX77693_CONTROL3_BTLDSET_SHIFT		(2)
> +#define MAX77693_CONTROL3_ADCDBSET_SHIFT	(4)
> +#define MAX77693_CONTROL3_JIGSET_MASK		(0x3 << MAX77693_CONTROL3_JIG=
SET_SHIFT)
> +#define MAX77693_CONTROL3_BTLDSET_MASK		(0x3 << MAX77693_CONTROL3_BT=
LDSET_SHIFT)
> +#define MAX77693_CONTROL3_ADCDBSET_MASK		(0x3 << MAX77693_CONTROL3_A=
DCDBSET_SHIFT)
> =20
>  /* Slave addr =3D 0x90: Haptic */
>  enum max77693_haptic_reg {

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
