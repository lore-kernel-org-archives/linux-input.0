From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH v2 7/9] mfd/extcon: max77843: Rename defines to allow
 inclusion with max77693
Date: Fri, 29 May 2015 20:06:11 +0900
Message-ID: <55684823.1040501@samsung.com>
References: <1432446213-4886-1-git-send-email-k.kozlowski.k@gmail.com>
 <1432446213-4886-8-git-send-email-k.kozlowski.k@gmail.com>
 <CAGTfZH1BeqqP-=7sRrW-AbwiS23VtqipSj4qfujZqg1k-wi3Qg@mail.gmail.com>
 <CAJKOXPeON7dC2+bmKBpVFdvKmr05QMO_mW9Pc6XOFrFzb7_34A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
In-reply-to: <CAJKOXPeON7dC2+bmKBpVFdvKmr05QMO_mW9Pc6XOFrFzb7_34A@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
To: =?UTF-8?B?S3J6eXN6dG9mIEtvesWCb3dza2k=?= <k.kozlowski.k@gmail.com>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On 05/28/2015 08:42 AM, Krzysztof Koz=C5=82owski wrote:
> 2015-05-27 22:50 GMT+09:00 Chanwoo Choi <cwchoi00@gmail.com>:
>> On Sun, May 24, 2015 at 2:43 PM, Krzysztof Kozlowski
>> <k.kozlowski.k@gmail.com> wrote:
>>> Add MAX77843_MUIC prefix to some of the defines used in max77843 ex=
tcon
>>> driver so the max77693-private.h can be included simultaneously wit=
h
>>> max77843-private.h.
>>>
>>> Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
>>> Acked-by: Lee Jones <lee.jones@linaro.org>
>>> ---
>>>  drivers/extcon/extcon-max77843.c     |  49 +++++++----
>>>  include/linux/mfd/max77843-private.h | 154 +++++++++++++++++------=
------------
>>>  2 files changed, 109 insertions(+), 94 deletions(-)
>>>
>>> diff --git a/drivers/extcon/extcon-max77843.c b/drivers/extcon/extc=
on-max77843.c
>>> index 0f5910dcccb7..8a38d4acf026 100644
>>> --- a/drivers/extcon/extcon-max77843.c
>>> +++ b/drivers/extcon/extcon-max77843.c
>>> @@ -206,11 +206,11 @@ static int max77843_muic_set_path(struct max7=
7843_muic_info *info,
>>>         if (attached)
>>>                 ctrl1 =3D val;
>>>         else
>>> -               ctrl1 =3D CONTROL1_SW_OPEN;
>>> +               ctrl1 =3D MAX77843_MUIC_CONTROL1_SW_OPEN;
>>>
>>>         ret =3D regmap_update_bits(max77843->regmap_muic,
>>>                         MAX77843_MUIC_REG_CONTROL1,
>>> -                       CONTROL1_COM_SW, ctrl1);
>>> +                       MAX77843_MUIC_CONTROL1_COM_SW, ctrl1);
>>>         if (ret < 0) {
>>>                 dev_err(info->dev, "Cannot switch MUIC port\n");
>>>                 return ret;
>>> @@ -244,7 +244,7 @@ static int max77843_muic_get_cable_type(struct =
max77843_muic_info *info,
>>>
>>>         adc =3D info->status[MAX77843_MUIC_STATUS1] &
>>>                         MAX77843_MUIC_STATUS1_ADC_MASK;
>>> -       adc >>=3D STATUS1_ADC_SHIFT;
>>> +       adc >>=3D MAX77843_MUIC_STATUS1_ADC_SHIFT;
>>>
>>>         switch (group) {
>>>         case MAX77843_CABLE_GROUP_ADC:
>>> @@ -310,7 +310,7 @@ static int max77843_muic_get_cable_type(struct =
max77843_muic_info *info,
>>>                         /* Get VBVolt register bit */
>>>                         gnd_type |=3D (info->status[MAX77843_MUIC_S=
TATUS2] &
>>>                                         MAX77843_MUIC_STATUS2_VBVOL=
T_MASK);
>>> -                       gnd_type >>=3D STATUS2_VBVOLT_SHIFT;
>>> +                       gnd_type >>=3D MAX77843_MUIC_STATUS2_VBVOLT=
_SHIFT;
>>>
>>>                         /* Offset of GND cable */
>>>                         gnd_type |=3D MAX77843_MUIC_GND_USB_HOST;
>>> @@ -339,7 +339,9 @@ static int max77843_muic_adc_gnd_handler(struct=
 max77843_muic_info *info)
>>>         switch (gnd_cable_type) {
>>>         case MAX77843_MUIC_GND_USB_HOST:
>>>         case MAX77843_MUIC_GND_USB_HOST_VB:
>>> -               ret =3D max77843_muic_set_path(info, CONTROL1_SW_US=
B, attached);
>>> +               ret =3D max77843_muic_set_path(info,
>>> +                                            MAX77843_MUIC_CONTROL1=
_SW_USB,
>>> +                                            attached);
>>>                 if (ret < 0)
>>>                         return ret;
>>>
>>> @@ -347,7 +349,9 @@ static int max77843_muic_adc_gnd_handler(struct=
 max77843_muic_info *info)
>>>                 break;
>>>         case MAX77843_MUIC_GND_MHL_VB:
>>>         case MAX77843_MUIC_GND_MHL:
>>> -               ret =3D max77843_muic_set_path(info, CONTROL1_SW_OP=
EN, attached);
>>> +               ret =3D max77843_muic_set_path(info,
>>> +                                            MAX77843_MUIC_CONTROL1=
_SW_OPEN,
>>> +                                            attached);
>>>                 if (ret < 0)
>>>                         return ret;
>>>
>>> @@ -366,7 +370,7 @@ static int max77843_muic_jig_handler(struct max=
77843_muic_info *info,
>>>                 int cable_type, bool attached)
>>>  {
>>>         int ret;
>>> -       u8 path =3D CONTROL1_SW_OPEN;
>>> +       u8 path =3D MAX77843_MUIC_CONTROL1_SW_OPEN;
>>>
>>>         dev_dbg(info->dev, "external connector is %s (adc:0x%02x)\n=
",
>>>                         attached ? "attached" : "detached", cable_t=
ype);
>>> @@ -374,10 +378,10 @@ static int max77843_muic_jig_handler(struct m=
ax77843_muic_info *info,
>>>         switch (cable_type) {
>>>         case MAX77843_MUIC_ADC_FACTORY_MODE_USB_OFF:
>>>         case MAX77843_MUIC_ADC_FACTORY_MODE_USB_ON:
>>> -               path =3D CONTROL1_SW_USB;
>>> +               path =3D MAX77843_MUIC_CONTROL1_SW_USB;
>>>                 break;
>>>         case MAX77843_MUIC_ADC_FACTORY_MODE_UART_OFF:
>>> -               path =3D CONTROL1_SW_UART;
>>> +               path =3D MAX77843_MUIC_CONTROL1_SW_UART;
>>>                 break;
>>>         default:
>>>                 return -EINVAL;
>>> @@ -475,14 +479,18 @@ static int max77843_muic_chg_handler(struct m=
ax77843_muic_info *info)
>>>
>>>         switch (chg_type) {
>>>         case MAX77843_MUIC_CHG_USB:
>>> -               ret =3D max77843_muic_set_path(info, CONTROL1_SW_US=
B, attached);
>>> +               ret =3D max77843_muic_set_path(info,
>>> +                                            MAX77843_MUIC_CONTROL1=
_SW_USB,
>>> +                                            attached);
>>>                 if (ret < 0)
>>>                         return ret;
>>>
>>>                 extcon_set_cable_state_(info->edev, EXTCON_USB, att=
ached);
>>>                 break;
>>>         case MAX77843_MUIC_CHG_DOWNSTREAM:
>>> -               ret =3D max77843_muic_set_path(info, CONTROL1_SW_OP=
EN, attached);
>>> +               ret =3D max77843_muic_set_path(info,
>>> +                                            MAX77843_MUIC_CONTROL1=
_SW_OPEN,
>>> +                                            attached);
>>>                 if (ret < 0)
>>>                         return ret;
>>>
>>> @@ -490,14 +498,18 @@ static int max77843_muic_chg_handler(struct m=
ax77843_muic_info *info)
>>>                                         attached);
>>>                 break;
>>>         case MAX77843_MUIC_CHG_DEDICATED:
>>> -               ret =3D max77843_muic_set_path(info, CONTROL1_SW_OP=
EN, attached);
>>> +               ret =3D max77843_muic_set_path(info,
>>> +                                            MAX77843_MUIC_CONTROL1=
_SW_OPEN,
>>> +                                            attached);
>>>                 if (ret < 0)
>>>                         return ret;
>>>
>>>                 extcon_set_cable_state_(info->edev, EXTCON_TA, atta=
ched);
>>>                 break;
>>>         case MAX77843_MUIC_CHG_SPECIAL_500MA:
>>> -               ret =3D max77843_muic_set_path(info, CONTROL1_SW_OP=
EN, attached);
>>> +               ret =3D max77843_muic_set_path(info,
>>> +                                            MAX77843_MUIC_CONTROL1=
_SW_OPEN,
>>> +                                            attached);
>>>                 if (ret < 0)
>>>                         return ret;
>>>
>>> @@ -505,7 +517,9 @@ static int max77843_muic_chg_handler(struct max=
77843_muic_info *info)
>>>                                         attached);
>>>                 break;
>>>         case MAX77843_MUIC_CHG_SPECIAL_1A:
>>> -               ret =3D max77843_muic_set_path(info, CONTROL1_SW_OP=
EN, attached);
>>> +               ret =3D max77843_muic_set_path(info,
>>> +                                            MAX77843_MUIC_CONTROL1=
_SW_OPEN,
>>> +                                            attached);
>>>                 if (ret < 0)
>>>                         return ret;
>>>
>>> @@ -529,7 +543,8 @@ static int max77843_muic_chg_handler(struct max=
77843_muic_info *info)
>>>                         "failed to detect %s accessory (chg_type:0x=
%x)\n",
>>>                         attached ? "attached" : "detached", chg_typ=
e);
>>>
>>> -               max77843_muic_set_path(info, CONTROL1_SW_OPEN, atta=
ched);
>>> +               max77843_muic_set_path(info, MAX77843_MUIC_CONTROL1=
_SW_OPEN,
>>> +                                      attached);
>>>                 return -EINVAL;
>>>         }
>>>
>>> @@ -668,7 +683,7 @@ static int max77843_muic_set_debounce_time(stru=
ct max77843_muic_info *info,
>>>                 ret =3D regmap_update_bits(max77843->regmap_muic,
>>>                                 MAX77843_MUIC_REG_CONTROL4,
>>>                                 MAX77843_MUIC_CONTROL4_ADCDBSET_MAS=
K,
>>> -                               time << CONTROL4_ADCDBSET_SHIFT);
>>> +                               time << MAX77843_MUIC_CONTROL4_ADCD=
BSET_SHIFT);
>>>                 if (ret < 0) {
>>>                         dev_err(info->dev, "Cannot write MUIC regma=
p\n");
>>>                         return ret;
>>> @@ -769,7 +784,7 @@ static int max77843_muic_probe(struct platform_=
device *pdev)
>>>         max77843_muic_set_debounce_time(info, MAX77843_DEBOUNCE_TIM=
E_25MS);
>>>
>>>         /* Set initial path for UART */
>>> -       max77843_muic_set_path(info, CONTROL1_SW_UART, true);
>>> +       max77843_muic_set_path(info, MAX77843_MUIC_CONTROL1_SW_UART=
, true);
>>>
>>>         /* Check revision number of MUIC device */
>>>         ret =3D regmap_read(max77843->regmap_muic, MAX77843_MUIC_RE=
G_ID, &id);
>>> diff --git a/include/linux/mfd/max77843-private.h b/include/linux/m=
fd/max77843-private.h
>>> index 0121d9440340..c19303b0ccfd 100644
>>> --- a/include/linux/mfd/max77843-private.h
>>> +++ b/include/linux/mfd/max77843-private.h
>>> @@ -318,62 +318,62 @@ enum max77843_irq_muic {
>>>         MAX77843_INTSRCMASK_SYS_MASK | MAX77843_INTSRCMASK_CHGR_MAS=
K)
>>>
>>>  /* MAX77843 STATUS register*/
>>> -#define STATUS1_ADC_SHIFT                      0
>>> -#define STATUS1_ADCERROR_SHIFT                 6
>>> -#define STATUS1_ADC1K_SHIFT                    7
>>> -#define STATUS2_CHGTYP_SHIFT                   0
>>> -#define STATUS2_CHGDETRUN_SHIFT                        3
>>> -#define STATUS2_DCDTMR_SHIFT                   4
>>> -#define STATUS2_DXOVP_SHIFT                    5
>>> -#define STATUS2_VBVOLT_SHIFT                   6
>>> -#define STATUS3_VBADC_SHIFT                    0
>>> -#define STATUS3_VDNMON_SHIFT                   4
>>> -#define STATUS3_DNRES_SHIFT                    5
>>> -#define STATUS3_MPNACK_SHIFT                   6
>>> -
>>> -#define MAX77843_MUIC_STATUS1_ADC_MASK         (0x1f << STATUS1_AD=
C_SHIFT)
>>> -#define MAX77843_MUIC_STATUS1_ADCERROR_MASK    BIT(STATUS1_ADCERRO=
R_SHIFT)
>>> -#define MAX77843_MUIC_STATUS1_ADC1K_MASK       BIT(STATUS1_ADC1K_S=
HIFT)
>>> -#define MAX77843_MUIC_STATUS2_CHGTYP_MASK      (0x7 << STATUS2_CHG=
TYP_SHIFT)
>>> -#define MAX77843_MUIC_STATUS2_CHGDETRUN_MASK   BIT(STATUS2_CHGDETR=
UN_SHIFT)
>>> -#define MAX77843_MUIC_STATUS2_DCDTMR_MASK      BIT(STATUS2_DCDTMR_=
SHIFT)
>>> -#define MAX77843_MUIC_STATUS2_DXOVP_MASK       BIT(STATUS2_DXOVP_S=
HIFT)
>>> -#define MAX77843_MUIC_STATUS2_VBVOLT_MASK      BIT(STATUS2_VBVOLT_=
SHIFT)
>>> -#define MAX77843_MUIC_STATUS3_VBADC_MASK       (0xf << STATUS3_VBA=
DC_SHIFT)
>>> -#define MAX77843_MUIC_STATUS3_VDNMON_MASK      BIT(STATUS3_VDNMON_=
SHIFT)
>>> -#define MAX77843_MUIC_STATUS3_DNRES_MASK       BIT(STATUS3_DNRES_S=
HIFT)
>>> -#define MAX77843_MUIC_STATUS3_MPNACK_MASK      BIT(STATUS3_MPNACK_=
SHIFT)
>>> +#define MAX77843_MUIC_STATUS1_ADC_SHIFT                0
>>> +#define MAX77843_MUIC_STATUS1_ADCERROR_SHIFT   6
>>> +#define MAX77843_MUIC_STATUS1_ADC1K_SHIFT      7
>>> +#define MAX77843_MUIC_STATUS2_CHGTYP_SHIFT     0
>>> +#define MAX77843_MUIC_STATUS2_CHGDETRUN_SHIFT  3
>>> +#define MAX77843_MUIC_STATUS2_DCDTMR_SHIFT     4
>>> +#define MAX77843_MUIC_STATUS2_DXOVP_SHIFT      5
>>> +#define MAX77843_MUIC_STATUS2_VBVOLT_SHIFT     6
>>> +#define MAX77843_MUIC_STATUS3_VBADC_SHIFT      0
>>> +#define MAX77843_MUIC_STATUS3_VDNMON_SHIFT     4
>>> +#define MAX77843_MUIC_STATUS3_DNRES_SHIFT      5
>>> +#define MAX77843_MUIC_STATUS3_MPNACK_SHIFT     6
>>> +
>>> +#define MAX77843_MUIC_STATUS1_ADC_MASK         (0x1f << MAX77843_M=
UIC_STATUS1_ADC_SHIFT)
>>> +#define MAX77843_MUIC_STATUS1_ADCERROR_MASK    BIT(MAX77843_MUIC_S=
TATUS1_ADCERROR_SHIFT)
>>> +#define MAX77843_MUIC_STATUS1_ADC1K_MASK       BIT(MAX77843_MUIC_S=
TATUS1_ADC1K_SHIFT)
>>> +#define MAX77843_MUIC_STATUS2_CHGTYP_MASK      (0x7 << MAX77843_MU=
IC_STATUS2_CHGTYP_SHIFT)
>>> +#define MAX77843_MUIC_STATUS2_CHGDETRUN_MASK   BIT(MAX77843_MUIC_S=
TATUS2_CHGDETRUN_SHIFT)
>>> +#define MAX77843_MUIC_STATUS2_DCDTMR_MASK      BIT(MAX77843_MUIC_S=
TATUS2_DCDTMR_SHIFT)
>>> +#define MAX77843_MUIC_STATUS2_DXOVP_MASK       BIT(MAX77843_MUIC_S=
TATUS2_DXOVP_SHIFT)
>>> +#define MAX77843_MUIC_STATUS2_VBVOLT_MASK      BIT(MAX77843_MUIC_S=
TATUS2_VBVOLT_SHIFT)
>>> +#define MAX77843_MUIC_STATUS3_VBADC_MASK       (0xf << MAX77843_MU=
IC_STATUS3_VBADC_SHIFT)
>>> +#define MAX77843_MUIC_STATUS3_VDNMON_MASK      BIT(MAX77843_MUIC_S=
TATUS3_VDNMON_SHIFT)
>>> +#define MAX77843_MUIC_STATUS3_DNRES_MASK       BIT(MAX77843_MUIC_S=
TATUS3_DNRES_SHIFT)
>>> +#define MAX77843_MUIC_STATUS3_MPNACK_MASK      BIT(MAX77843_MUIC_S=
TATUS3_MPNACK_SHIFT)
>>>
>>>  /* MAX77843 CONTROL register */
>>> -#define CONTROL1_COMP1SW_SHIFT                 0
>>> -#define CONTROL1_COMP2SW_SHIFT                 3
>>> -#define CONTROL1_IDBEN_SHIFT                   7
>>> -#define CONTROL2_LOWPWR_SHIFT                  0
>>> -#define CONTROL2_ADCEN_SHIFT                   1
>>> -#define CONTROL2_CPEN_SHIFT                    2
>>> -#define CONTROL2_ACC_DET_SHIFT                 5
>>> -#define CONTROL2_USBCPINT_SHIFT                        6
>>> -#define CONTROL2_RCPS_SHIFT                    7
>>> -#define CONTROL3_JIGSET_SHIFT                  0
>>> -#define CONTROL4_ADCDBSET_SHIFT                        0
>>> -#define CONTROL4_USBAUTO_SHIFT                 4
>>> -#define CONTROL4_FCTAUTO_SHIFT                 5
>>> -#define CONTROL4_ADCMODE_SHIFT                 6
>>> -
>>> -#define MAX77843_MUIC_CONTROL1_COMP1SW_MASK    (0x7 << CONTROL1_CO=
MP1SW_SHIFT)
>>> -#define MAX77843_MUIC_CONTROL1_COMP2SW_MASK    (0x7 << CONTROL1_CO=
MP2SW_SHIFT)
>>> -#define MAX77843_MUIC_CONTROL1_IDBEN_MASK      BIT(CONTROL1_IDBEN_=
SHIFT)
>>> -#define MAX77843_MUIC_CONTROL2_LOWPWR_MASK     BIT(CONTROL2_LOWPWR=
_SHIFT)
>>> -#define MAX77843_MUIC_CONTROL2_ADCEN_MASK      BIT(CONTROL2_ADCEN_=
SHIFT)
>>> -#define MAX77843_MUIC_CONTROL2_CPEN_MASK       BIT(CONTROL2_CPEN_S=
HIFT)
>>> -#define MAX77843_MUIC_CONTROL2_ACC_DET_MASK    BIT(CONTROL2_ACC_DE=
T_SHIFT)
>>> -#define MAX77843_MUIC_CONTROL2_USBCPINT_MASK   BIT(CONTROL2_USBCPI=
NT_SHIFT)
>>> -#define MAX77843_MUIC_CONTROL2_RCPS_MASK       BIT(CONTROL2_RCPS_S=
HIFT)
>>> -#define MAX77843_MUIC_CONTROL3_JIGSET_MASK     (0x3 << CONTROL3_JI=
GSET_SHIFT)
>>> -#define MAX77843_MUIC_CONTROL4_ADCDBSET_MASK   (0x3 << CONTROL4_AD=
CDBSET_SHIFT)
>>> -#define MAX77843_MUIC_CONTROL4_USBAUTO_MASK    BIT(CONTROL4_USBAUT=
O_SHIFT)
>>> -#define MAX77843_MUIC_CONTROL4_FCTAUTO_MASK    BIT(CONTROL4_FCTAUT=
O_SHIFT)
>>> -#define MAX77843_MUIC_CONTROL4_ADCMODE_MASK    (0x3 << CONTROL4_AD=
CMODE_SHIFT)
>>> +#define MAX77843_MUIC_CONTROL1_COMP1SW_SHIFT   0
>>> +#define MAX77843_MUIC_CONTROL1_COMP2SW_SHIFT   3
>>> +#define MAX77843_MUIC_CONTROL1_IDBEN_SHIFT     7
>>> +#define MAX77843_MUIC_CONTROL2_LOWPWR_SHIFT    0
>>> +#define MAX77843_MUIC_CONTROL2_ADCEN_SHIFT     1
>>> +#define MAX77843_MUIC_CONTROL2_CPEN_SHIFT      2
>>> +#define MAX77843_MUIC_CONTROL2_ACC_DET_SHIFT   5
>>> +#define MAX77843_MUIC_CONTROL2_USBCPINT_SHIFT  6
>>> +#define MAX77843_MUIC_CONTROL2_RCPS_SHIFT      7
>>> +#define MAX77843_MUIC_CONTROL3_JIGSET_SHIFT    0
>>> +#define MAX77843_MUIC_CONTROL4_ADCDBSET_SHIFT  0
>>> +#define MAX77843_MUIC_CONTROL4_USBAUTO_SHIFT   4
>>> +#define MAX77843_MUIC_CONTROL4_FCTAUTO_SHIFT   5
>>> +#define MAX77843_MUIC_CONTROL4_ADCMODE_SHIFT   6
>>> +
>>> +#define MAX77843_MUIC_CONTROL1_COMP1SW_MASK    (0x7 << MAX77843_MU=
IC_CONTROL1_COMP1SW_SHIFT)
>>> +#define MAX77843_MUIC_CONTROL1_COMP2SW_MASK    (0x7 << MAX77843_MU=
IC_CONTROL1_COMP2SW_SHIFT)
>>> +#define MAX77843_MUIC_CONTROL1_IDBEN_MASK      BIT(MAX77843_MUIC_C=
ONTROL1_IDBEN_SHIFT)
>>> +#define MAX77843_MUIC_CONTROL2_LOWPWR_MASK     BIT(MAX77843_MUIC_C=
ONTROL2_LOWPWR_SHIFT)
>>> +#define MAX77843_MUIC_CONTROL2_ADCEN_MASK      BIT(MAX77843_MUIC_C=
ONTROL2_ADCEN_SHIFT)
>>> +#define MAX77843_MUIC_CONTROL2_CPEN_MASK       BIT(MAX77843_MUIC_C=
ONTROL2_CPEN_SHIFT)
>>> +#define MAX77843_MUIC_CONTROL2_ACC_DET_MASK    BIT(MAX77843_MUIC_C=
ONTROL2_ACC_DET_SHIFT)
>>> +#define MAX77843_MUIC_CONTROL2_USBCPINT_MASK   BIT(MAX77843_MUIC_C=
ONTROL2_USBCPINT_SHIFT)
>>> +#define MAX77843_MUIC_CONTROL2_RCPS_MASK       BIT(MAX77843_MUIC_C=
ONTROL2_RCPS_SHIFT)
>>> +#define MAX77843_MUIC_CONTROL3_JIGSET_MASK     (0x3 << MAX77843_MU=
IC_CONTROL3_JIGSET_SHIFT)
>>> +#define MAX77843_MUIC_CONTROL4_ADCDBSET_MASK   (0x3 << MAX77843_MU=
IC_CONTROL4_ADCDBSET_SHIFT)
>>> +#define MAX77843_MUIC_CONTROL4_USBAUTO_MASK    BIT(MAX77843_MUIC_C=
ONTROL4_USBAUTO_SHIFT)
>>> +#define MAX77843_MUIC_CONTROL4_FCTAUTO_MASK    BIT(MAX77843_MUIC_C=
ONTROL4_FCTAUTO_SHIFT)
>>> +#define MAX77843_MUIC_CONTROL4_ADCMODE_MASK    (0x3 << MAX77843_MU=
IC_CONTROL4_ADCMODE_SHIFT)
>>>
>>>  /* MAX77843 switch port */
>>>  #define COM_OPEN                               0
>>> @@ -383,38 +383,38 @@ enum max77843_irq_muic {
>>>  #define COM_AUX_USB                            4
>>>  #define COM_AUX_UART                           5
>>>
>>> -#define CONTROL1_COM_SW \
>>> +#define MAX77843_MUIC_CONTROL1_COM_SW \
>>>         ((MAX77843_MUIC_CONTROL1_COMP1SW_MASK | \
>>>          MAX77843_MUIC_CONTROL1_COMP2SW_MASK))
>>>
>>> -#define CONTROL1_SW_OPEN \
>>> -       ((COM_OPEN << CONTROL1_COMP1SW_SHIFT | \
>>> -        COM_OPEN << CONTROL1_COMP2SW_SHIFT))
>>> -#define CONTROL1_SW_USB \
>>> -       ((COM_USB << CONTROL1_COMP1SW_SHIFT | \
>>> -        COM_USB << CONTROL1_COMP2SW_SHIFT))
>>> -#define CONTROL1_SW_AUDIO \
>>> -       ((COM_AUDIO << CONTROL1_COMP1SW_SHIFT | \
>>> -        COM_AUDIO << CONTROL1_COMP2SW_SHIFT))
>>> -#define CONTROL1_SW_UART \
>>> -       ((COM_UART << CONTROL1_COMP1SW_SHIFT | \
>>> -        COM_UART << CONTROL1_COMP2SW_SHIFT))
>>> -#define CONTROL1_SW_AUX_USB \
>>> -       ((COM_AUX_USB << CONTROL1_COMP1SW_SHIFT | \
>>> -        COM_AUX_USB << CONTROL1_COMP2SW_SHIFT))
>>> -#define CONTROL1_SW_AUX_UART \
>>> -       ((COM_AUX_UART << CONTROL1_COMP1SW_SHIFT | \
>>> -        COM_AUX_UART << CONTROL1_COMP2SW_SHIFT))
>>> +#define MAX77843_MUIC_CONTROL1_SW_OPEN \
>>> +       ((COM_OPEN << MAX77843_MUIC_CONTROL1_COMP1SW_SHIFT | \
>>> +        COM_OPEN << MAX77843_MUIC_CONTROL1_COMP2SW_SHIFT))
>>> +#define MAX77843_MUIC_CONTROL1_SW_USB \
>>> +       ((COM_USB << MAX77843_MUIC_CONTROL1_COMP1SW_SHIFT | \
>>> +        COM_USB << MAX77843_MUIC_CONTROL1_COMP2SW_SHIFT))
>>> +#define MAX77843_MUIC_CONTROL1_SW_AUDIO \
>>> +       ((COM_AUDIO << MAX77843_MUIC_CONTROL1_COMP1SW_SHIFT | \
>>> +        COM_AUDIO << MAX77843_MUIC_CONTROL1_COMP2SW_SHIFT))
>>> +#define MAX77843_MUIC_CONTROL1_SW_UART \
>>> +       ((COM_UART << MAX77843_MUIC_CONTROL1_COMP1SW_SHIFT | \
>>> +        COM_UART << MAX77843_MUIC_CONTROL1_COMP2SW_SHIFT))
>>> +#define MAX77843_MUIC_CONTROL1_SW_AUX_USB \
>>> +       ((COM_AUX_USB << MAX77843_MUIC_CONTROL1_COMP1SW_SHIFT | \
>>> +        COM_AUX_USB << MAX77843_MUIC_CONTROL1_COMP2SW_SHIFT))
>>> +#define MAX77843_MUIC_CONTROL1_SW_AUX_UART \
>>> +       ((COM_AUX_UART << MAX77843_MUIC_CONTROL1_COMP1SW_SHIFT | \
>>> +        COM_AUX_UART << MAX77843_MUIC_CONTROL1_COMP2SW_SHIFT))
>>
>> You add "MAX77843_MUIC_" prefix but, I think that "MUIC_" prefix is
>> not necessary.
>> You don't add the "MUIC_" prefix on similar patch6.
>=20
> The MAX77843_MUIC_ prefix is already used in that file, e.g.:
> MAX77843_MUIC_STATUS1_ADC_MASK
>=20
> Adding only "MAX77843_" makes sense but it would make the file
> inconsistent. Do you want me to add such inconsistent MAX77843_
> prefix?

OK, I understand why you add "MAX77843_MUIC_" prefix unlike the patch6.

Acked-by: Chanwoo Choi <cw00.choi@samsung.com>

Thanks,
Chanwoo Choi


