From: =?UTF-8?Q?Ksenija_Stanojevi=C4=87?= <ksenija.stanojevic-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 3/3] input: touchscreen: mxs-lradc: Add support for touchscreen
Date: Sun, 29 May 2016 20:00:42 +0200
Message-ID: <CAL7P5jJYptf4OQE+d1AFLy92uajDTUD-B5Qsk-noBx36k3rGsg@mail.gmail.com>
References: <cover.1461930102.git.ksenija.stanojevic@gmail.com>
	<61fe1da2e8d82921f3222ec939047b6823f695e1.1461930102.git.ksenija.stanojevic@gmail.com>
	<bad220c7-7f72-55e8-fe41-e3a6ae7d7d2f@kernel.org>
	<CAL7P5jKukmxbK92oei+hOtsqcHjiBjKs2g7d7B7JsjgUxKRYAA@mail.gmail.com>
	<e2e0aa2d-dc26-cd23-1d45-837456104286@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <e2e0aa2d-dc26-cd23-1d45-837456104286-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Peter Meerwald-Stadler <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, =?UTF-8?B?TWFyZWsgVmHFoXV0?= <marex-ynQEQJNshbs@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Harald Geyer <harald-95f8Dae0BrPYtjvyW6yDsg@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Sun, May 29, 2016 at 6:49 PM, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wr=
ote:
> On 28/05/16 18:45, Ksenija Stanojevi=C4=87 wrote:
>> On Sun, May 1, 2016 at 6:47 PM, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> =
wrote:
>>> On 29/04/16 12:49, Ksenija Stanojevic wrote:
>>>> Add mxs-lradc touchscreen driver.
>>>>
>>>> Signed-off-by: Ksenija Stanojevic <ksenija.stanojevic-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>>> The only real thing this raises for me is why we are grabbing IRQs =
that I
>>> don't think this driver even cares about...
>>>
>>> Jonathan
>>>> ---
>>>>  drivers/input/touchscreen/Kconfig        |  14 +-
>>>>  drivers/input/touchscreen/Makefile       |   1 +
>>>>  drivers/input/touchscreen/mxs-lradc-ts.c | 729 ++++++++++++++++++=
+++++++++++++
>>>>  3 files changed, 742 insertions(+), 2 deletions(-)
>>>>  create mode 100644 drivers/input/touchscreen/mxs-lradc-ts.c
>>>>
>>>> diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/tou=
chscreen/Kconfig
>>>> index 8ecdc38..d614d248 100644
>>>> --- a/drivers/input/touchscreen/Kconfig
>>>> +++ b/drivers/input/touchscreen/Kconfig
>>>> @@ -566,7 +566,7 @@ config TOUCHSCREEN_HP600
>>>>       depends on SH_HP6XX && SH_ADC
>>>>       help
>>>>         Say Y here if you have a HP Jornada 620/660/680/690 and wa=
nt to
>>>> -          support the built-in touchscreen.
>>>> +       support the built-in touchscreen.
>>>>
>>>>         To compile this driver as a module, choose M here: the
>>>>         module will be called hp680_ts_input.
>>>> @@ -685,7 +685,7 @@ config TOUCHSCREEN_UCB1400
>>>>         This enables support for the Philips UCB1400 touchscreen i=
nterface.
>>>>         The UCB1400 is an AC97 audio codec.  The touchscreen inter=
face
>>>>         will be initialized only after the ALSA subsystem has been
>>>> -       brought up and the UCB1400 detected.  You therefore have t=
o
>>>> +       brought up and the UCB1400 detected.  You therefore have t=
o
>>>>         configure ALSA support as well (either built-in or modular=
,
>>>>         independently of whether this driver is itself built-in or
>>>>         modular) for this driver to work.
>>>> @@ -842,6 +842,16 @@ config TOUCHSCREEN_MX25
>>>>         To compile this driver as a module, choose M here: the
>>>>         module will be called fsl-imx25-tcq.
>>>>
>>>> +config TOUCHSCREEN_MXS_LRADC
>>>> +     tristate "Freescale i.MX23/i.MX28 LRADC touchscreen"
>>>> +     depends on MFD_MXS_LRADC
>>>> +     help
>>>> +       Say Y here if you have a touchscreen connected to the low-=
resolution
>>>> +       analog-to-digital converter (LRADC) on an i.MX23 or i.MX28=
 processor.
>>>> +
>>>> +       To compile this driver as a module, choose M here: the mod=
ule will be
>>>> +       called mxs-lradc-ts.
>>>> +
>>>>  config TOUCHSCREEN_MC13783
>>>>       tristate "Freescale MC13783 touchscreen input driver"
>>>>       depends on MFD_MC13XXX
>>>> diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/to=
uchscreen/Makefile
>>>> index f42975e..513a6ff 100644
>>>> --- a/drivers/input/touchscreen/Makefile
>>>> +++ b/drivers/input/touchscreen/Makefile
>>>> @@ -54,6 +54,7 @@ obj-$(CONFIG_TOUCHSCREEN_MIGOR)             +=3D=
 migor_ts.o
>>>>  obj-$(CONFIG_TOUCHSCREEN_MMS114)     +=3D mms114.o
>>>>  obj-$(CONFIG_TOUCHSCREEN_MTOUCH)     +=3D mtouch.o
>>>>  obj-$(CONFIG_TOUCHSCREEN_MK712)              +=3D mk712.o
>>>> +obj-$(CONFIG_TOUCHSCREEN_MXS_LRADC)  +=3D mxs-lradc-ts.o
>>>>  obj-$(CONFIG_TOUCHSCREEN_HP600)              +=3D hp680_ts_input.=
o
>>>>  obj-$(CONFIG_TOUCHSCREEN_HP7XX)              +=3D jornada720_ts.o
>>>>  obj-$(CONFIG_TOUCHSCREEN_IPAQ_MICRO) +=3D ipaq-micro-ts.o
>>>> diff --git a/drivers/input/touchscreen/mxs-lradc-ts.c b/drivers/in=
put/touchscreen/mxs-lradc-ts.c
>>>> new file mode 100644
>>>> index 0000000..27abb8e
>>>> --- /dev/null
>>>> +++ b/drivers/input/touchscreen/mxs-lradc-ts.c
>>>> @@ -0,0 +1,729 @@
>>>> +/*
>>>> + * Freescale MXS LRADC driver
>>>> + *
>>>> + * Copyright (c) 2012 DENX Software Engineering, GmbH.
>>>> + * Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
>>>> + *
>>>> + * This program is free software; you can redistribute it and/or =
modify
>>>> + * it under the terms of the GNU General Public License as publis=
hed by
>>>> + * the Free Software Foundation; either version 2 of the License,=
 or
>>>> + * (at your option) any later version.
>>>> + *
>>>> + * This program is distributed in the hope that it will be useful=
,
>>>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>>>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
>>>> + * GNU General Public License for more details.
>>>> + */
>>>> +
>>>> +#include <linux/module.h>
>>>> +#include <linux/mfd/mxs-lradc.h>
>>>> +#include <linux/platform_device.h>
>>>> +
>>>> +/*
>>>> + * Touchscreen handling
>>>> + */
>>>> +enum mxs_lradc_ts_plate {
>>>> +     LRADC_TOUCH =3D 0,
>>>> +     LRADC_SAMPLE_X,
>>>> +     LRADC_SAMPLE_Y,
>>>> +     LRADC_SAMPLE_PRESSURE,
>>>> +     LRADC_SAMPLE_VALID,
>>>> +};
>>>> +
>>>> +struct mxs_lradc_ts {
>>>> +     struct mxs_lradc        *lradc;
>>>> +     struct device           *dev;
>>>> +     /*
>>>> +      * When the touchscreen is enabled, we give it two private v=
irtual
>>>> +      * channels: #6 and #7. This means that only 6 virtual chann=
els (instead
>>>> +      * of 8) will be available for buffered capture.
>>>> +      */
>>>> +#define TOUCHSCREEN_VCHANNEL1                7
>>>> +#define TOUCHSCREEN_VCHANNEL2                6
>>>> +
>>>> +     struct input_dev        *ts_input;
>>>> +
>>>> +     enum mxs_lradc_ts_plate cur_plate; /* state machine */
>>>> +     bool                    ts_valid;
>>>> +     unsigned                ts_x_pos;
>>>> +     unsigned                ts_y_pos;
>>>> +     unsigned                ts_pressure;
>>>> +
>>>> +     /* handle touchscreen's physical behaviour */
>>>> +     /* samples per coordinate */
>>>> +     unsigned                over_sample_cnt;
>>>> +     /* time clocks between samples */
>>>> +     unsigned                over_sample_delay;
>>>> +     /* time in clocks to wait after the plates where switched */
>>>> +     unsigned                settling_delay;
>>>> +};
>>>> +
>>>> +static u32 mxs_lradc_plate_mask(struct mxs_lradc *lradc)
>>>> +{
>>>> +     if (lradc->soc =3D=3D IMX23_LRADC)
>>>> +             return LRADC_CTRL0_MX23_PLATE_MASK;
>>>> +     return LRADC_CTRL0_MX28_PLATE_MASK;
>>>> +}
>>>> +
>>>> +static u32 mxs_lradc_touch_detect_bit(struct mxs_lradc *lradc)
>>>> +{
>>>> +     if (lradc->soc =3D=3D IMX23_LRADC)
>>>> +             return LRADC_CTRL0_MX23_TOUCH_DETECT_ENABLE;
>>>> +     return LRADC_CTRL0_MX28_TOUCH_DETECT_ENABLE;
>>>> +}
>>>> +
>>>> +static u32 mxs_lradc_drive_x_plate(struct mxs_lradc *lradc)
>>>> +{
>>>> +     if (lradc->soc =3D=3D IMX23_LRADC)
>>>> +             return LRADC_CTRL0_MX23_XP | LRADC_CTRL0_MX23_XM;
>>>> +     return LRADC_CTRL0_MX28_XPPSW | LRADC_CTRL0_MX28_XNNSW;
>>>> +}
>>>> +
>>>> +static u32 mxs_lradc_drive_y_plate(struct mxs_lradc *lradc)
>>>> +{
>>>> +     if (lradc->soc =3D=3D IMX23_LRADC)
>>>> +             return LRADC_CTRL0_MX23_YP | LRADC_CTRL0_MX23_YM;
>>>> +     return LRADC_CTRL0_MX28_YPPSW | LRADC_CTRL0_MX28_YNNSW;
>>>> +}
>>>> +
>>>> +static u32 mxs_lradc_drive_pressure(struct mxs_lradc *lradc)
>>>> +{
>>>> +     if (lradc->soc =3D=3D IMX23_LRADC)
>>>> +             return LRADC_CTRL0_MX23_YP | LRADC_CTRL0_MX23_XM;
>>>> +     return LRADC_CTRL0_MX28_YPPSW | LRADC_CTRL0_MX28_XNNSW;
>>>> +}
>>>> +
>>>> +static bool mxs_lradc_check_touch_event(struct mxs_lradc *lradc)
>>>> +{
>>>> +     return !!(readl(lradc->base + LRADC_STATUS) &
>>>> +                                     LRADC_STATUS_TOUCH_DETECT_RA=
W);
>>>> +}
>>>> +
>>>> +static void mxs_lradc_map_ts_channel(struct mxs_lradc *lradc, uns=
igned vch,
>>>> +                                  unsigned ch)
>>>> +{
>>>> +     mxs_lradc_reg_clear(lradc, LRADC_CTRL4_LRADCSELECT_MASK(vch)=
,
>>>> +                         LRADC_CTRL4);
>>>> +     mxs_lradc_reg_set(lradc, LRADC_CTRL4_LRADCSELECT(vch, ch), L=
RADC_CTRL4);
>>>> +}
>>>> +
>>>> +static void mxs_lradc_setup_ts_channel(struct mxs_lradc_ts *ts, u=
nsigned ch)
>>>> +{
>>>> +     struct mxs_lradc *lradc =3D ts->lradc;
>>>> +
>>>> +     /*
>>>> +      * prepare for oversampling conversion
>>>> +      *
>>>> +      * from the datasheet:
>>>> +      * "The ACCUMULATE bit in the appropriate channel register
>>>> +      * HW_LRADC_CHn must be set to 1 if NUM_SAMPLES is greater t=
hen 0;
>>>> +      * otherwise, the IRQs will not fire."
>>>> +      */
>>>> +     mxs_lradc_reg_wrt(lradc, LRADC_CH_ACCUMULATE |
>>>> +                       LRADC_CH_NUM_SAMPLES(ts->over_sample_cnt -=
 1),
>>>> +                       LRADC_CH(ch));
>>>> +
>>>> +     /* from the datasheet:
>>>> +      * "Software must clear this register in preparation for a
>>>> +      * multi-cycle accumulation.
>>>> +      */
>>>> +     mxs_lradc_reg_clear(lradc, LRADC_CH_VALUE_MASK, LRADC_CH(ch)=
);
>>>> +
>>>> +     /*
>>>> +      * prepare the delay/loop unit according to the oversampling=
 count
>>>> +      *
>>>> +      * from the datasheet:
>>>> +      * "The DELAY fields in HW_LRADC_DELAY0, HW_LRADC_DELAY1,
>>>> +      * HW_LRADC_DELAY2, and HW_LRADC_DELAY3 must be non-zero; ot=
herwise,
>>>> +      * the LRADC will not trigger the delay group."
>>>> +      */
>>>> +     mxs_lradc_reg_wrt(lradc, LRADC_DELAY_TRIGGER(1 << ch) |
>>>> +                       LRADC_DELAY_TRIGGER_DELAYS(0) |
>>>> +                       LRADC_DELAY_LOOP(ts->over_sample_cnt - 1) =
|
>>>> +                       LRADC_DELAY_DELAY(ts->over_sample_delay - =
1),
>>>> +                       LRADC_DELAY(3));
>>>> +
>>>> +     mxs_lradc_reg_clear(lradc, LRADC_CTRL1_LRADC_IRQ(ch), LRADC_=
CTRL1);
>>>> +
>>>> +     /*
>>>> +      * after changing the touchscreen plates setting
>>>> +      * the signals need some initial time to settle. Start the
>>>> +      * SoC's delay unit and start the conversion later
>>>> +      * and automatically.
>>>> +      */
>>>> +     mxs_lradc_reg_wrt(
>>>> +             lradc,
>>>> +             LRADC_DELAY_TRIGGER(0) | /* don't trigger ADC */
>>>> +             LRADC_DELAY_TRIGGER_DELAYS(BIT(3)) | /* trigger DELA=
Y unit#3 */
>>>> +             LRADC_DELAY_KICK |
>>>> +             LRADC_DELAY_DELAY(ts->settling_delay),
>>>> +             LRADC_DELAY(2));
>>>> +}
>>>> +
>>>> +/*
>>>> + * Pressure detection is special:
>>>> + * We want to do both required measurements for the pressure dete=
ction in
>>>> + * one turn. Use the hardware features to chain both conversions =
and let the
>>>> + * hardware report one interrupt if both conversions are done
>>>> + */
>>>> +static void mxs_lradc_setup_ts_pressure(struct mxs_lradc_ts *ts, =
unsigned ch1,
>>>> +                                     unsigned ch2)
>>>> +{
>>>> +     struct mxs_lradc *lradc =3D ts->lradc;
>>>> +     u32 reg;
>>>> +
>>>> +     /*
>>>> +      * prepare for oversampling conversion
>>>> +      *
>>>> +      * from the datasheet:
>>>> +      * "The ACCUMULATE bit in the appropriate channel register
>>>> +      * HW_LRADC_CHn must be set to 1 if NUM_SAMPLES is greater t=
hen 0;
>>>> +      * otherwise, the IRQs will not fire."
>>>> +      */
>>>> +     reg =3D LRADC_CH_ACCUMULATE |
>>>> +             LRADC_CH_NUM_SAMPLES(ts->over_sample_cnt - 1);
>>>> +     mxs_lradc_reg_wrt(lradc, reg, LRADC_CH(ch1));
>>>> +     mxs_lradc_reg_wrt(lradc, reg, LRADC_CH(ch2));
>>>> +
>>>> +     /* from the datasheet:
>>>> +      * "Software must clear this register in preparation for a
>>>> +      * multi-cycle accumulation.
>>>> +      */
>>>> +     mxs_lradc_reg_clear(lradc, LRADC_CH_VALUE_MASK, LRADC_CH(ch1=
));
>>>> +     mxs_lradc_reg_clear(lradc, LRADC_CH_VALUE_MASK, LRADC_CH(ch2=
));
>>>> +
>>>> +     /* prepare the delay/loop unit according to the oversampling=
 count */
>>>> +     mxs_lradc_reg_wrt(
>>>> +                 lradc,
>>>> +                 LRADC_DELAY_TRIGGER(1 << ch1) |
>>>> +                 LRADC_DELAY_TRIGGER(1 << ch2) | /* start both ch=
annels */
>>>> +                 LRADC_DELAY_TRIGGER_DELAYS(0) |
>>>> +                 LRADC_DELAY_LOOP(ts->over_sample_cnt - 1) |
>>>> +                 LRADC_DELAY_DELAY(ts->over_sample_delay - 1),
>>>> +                 LRADC_DELAY(3));
>>>> +
>>>> +     mxs_lradc_reg_clear(lradc, LRADC_CTRL1_LRADC_IRQ(ch2), LRADC=
_CTRL1);
>>>> +
>>>> +     /*
>>>> +      * after changing the touchscreen plates setting
>>>> +      * the signals need some initial time to settle. Start the
>>>> +      * SoC's delay unit and start the conversion later
>>>> +      * and automatically.
>>>> +      */
>>>> +     mxs_lradc_reg_wrt(
>>>> +             lradc,
>>>> +             LRADC_DELAY_TRIGGER(0) | /* don't trigger ADC */
>>>> +             LRADC_DELAY_TRIGGER_DELAYS(BIT(3)) | /* trigger DELA=
Y unit#3 */
>>>> +             LRADC_DELAY_KICK |
>>>> +             LRADC_DELAY_DELAY(ts->settling_delay), LRADC_DELAY(2=
));
>>>> +}
>>>> +
>>>> +static unsigned mxs_lradc_ts_read_raw_channel(struct mxs_lradc_ts=
 *ts,
>>>> +                                           unsigned channel)
>>>> +{
>>>> +     u32 reg;
>>>> +     unsigned num_samples, val;
>>>> +     struct mxs_lradc *lradc =3D ts->lradc;
>>>> +
>>>> +     reg =3D readl(lradc->base + LRADC_CH(channel));
>>>> +     if (reg & LRADC_CH_ACCUMULATE)
>>>> +             num_samples =3D ts->over_sample_cnt;
>>>> +     else
>>>> +             num_samples =3D 1;
>>>> +
>>>> +     val =3D (reg & LRADC_CH_VALUE_MASK) >> LRADC_CH_VALUE_OFFSET=
;
>>>> +     return val / num_samples;
>>>> +}
>>>> +
>>>> +static unsigned mxs_lradc_read_ts_pressure(struct mxs_lradc_ts *t=
s,
>>>> +                                        unsigned ch1, unsigned ch=
2)
>>>> +{
>>>> +     u32 reg, mask;
>>>> +     unsigned pressure, m1, m2;
>>>> +     struct mxs_lradc *lradc =3D ts->lradc;
>>>> +
>>>> +     mask =3D LRADC_CTRL1_LRADC_IRQ(ch1) | LRADC_CTRL1_LRADC_IRQ(=
ch2);
>>>> +     reg =3D readl(lradc->base + LRADC_CTRL1) & mask;
>>>> +
>>>> +     while (reg !=3D mask) {
>>>> +             reg =3D readl(lradc->base + LRADC_CTRL1) & mask;
>>>> +             dev_dbg(ts->dev, "One channel is still busy: %X\n", =
reg);
>>>> +     }
>>>> +
>>>> +     m1 =3D mxs_lradc_ts_read_raw_channel(ts, ch1);
>>>> +     m2 =3D mxs_lradc_ts_read_raw_channel(ts, ch2);
>>>> +
>>>> +     if (m2 =3D=3D 0) {
>>>> +             dev_warn(ts->dev, "Cannot calculate pressure\n");
>>>> +             return 1 << (LRADC_RESOLUTION - 1);
>>>> +     }
>>>> +
>>>> +     /* simply scale the value from 0 ... max ADC resolution */
>>>> +     pressure =3D m1;
>>>> +     pressure *=3D (1 << LRADC_RESOLUTION);
>>>> +     pressure /=3D m2;
>>>> +
>>>> +     dev_dbg(ts->dev, "Pressure =3D %u\n", pressure);
>>>> +     return pressure;
>>>> +}
>>>> +
>>>> +#define TS_CH_XP 2
>>>> +#define TS_CH_YP 3
>>>> +#define TS_CH_XM 4
>>>> +#define TS_CH_YM 5
>>>> +
>>>> +/*
>>>> + * YP(open)--+-------------+
>>>> + *        |             |--+
>>>> + *        |             |  |
>>>> + *    YM(-)--+-------------+  |
>>>> + *          +--------------+
>>>> + *          |              |
>>>> + *      XP(weak+)        XM(open)
>>>> + *
>>>> + * "weak+" means 200k Ohm VDDIO
>>>> + * (-) means GND
>>>> + */
>>>> +static void mxs_lradc_setup_touch_detection(struct mxs_lradc_ts *=
ts)
>>>> +{
>>>> +     struct mxs_lradc *lradc =3D ts->lradc;
>>>> +
>>>> +     /*
>>>> +      * In order to detect a touch event the 'touch detect enable=
' bit
>>>> +      * enables:
>>>> +      *  - a weak pullup to the X+ connector
>>>> +      *  - a strong ground at the Y- connector
>>>> +      */
>>>> +     mxs_lradc_reg_clear(lradc, mxs_lradc_plate_mask(lradc), LRAD=
C_CTRL0);
>>>> +     mxs_lradc_reg_set(lradc, mxs_lradc_touch_detect_bit(lradc),
>>>> +                       LRADC_CTRL0);
>>>> +}
>>>> +
>>>> +/*
>>>> + * YP(meas)--+-------------+
>>>> + *        |             |--+
>>>> + *        |             |  |
>>>> + * YM(open)--+-------------+  |
>>>> + *          +--------------+
>>>> + *          |              |
>>>> + *        XP(+)          XM(-)
>>>> + *
>>>> + * (+) means here 1.85 V
>>>> + * (-) means here GND
>>>> + */
>>>> +static void mxs_lradc_prepare_x_pos(struct mxs_lradc_ts *ts)
>>>> +{
>>>> +     struct mxs_lradc *lradc =3D ts->lradc;
>>>> +
>>>> +     mxs_lradc_reg_clear(lradc, mxs_lradc_plate_mask(lradc), LRAD=
C_CTRL0);
>>>> +     mxs_lradc_reg_set(lradc, mxs_lradc_drive_x_plate(lradc), LRA=
DC_CTRL0);
>>>> +
>>>> +     ts->cur_plate =3D LRADC_SAMPLE_X;
>>>> +     mxs_lradc_map_ts_channel(lradc, TOUCHSCREEN_VCHANNEL1, TS_CH=
_YP);
>>>> +     mxs_lradc_setup_ts_channel(ts, TOUCHSCREEN_VCHANNEL1);
>>>> +}
>>>> +
>>>> +/*
>>>> + *   YP(+)--+-------------+
>>>> + *       |             |--+
>>>> + *       |             |  |
>>>> + *   YM(-)--+-------------+  |
>>>> + *         +--------------+
>>>> + *         |              |
>>>> + *      XP(open)        XM(meas)
>>>> + *
>>>> + * (+) means here 1.85 V
>>>> + * (-) means here GND
>>>> + */
>>>> +static void mxs_lradc_prepare_y_pos(struct mxs_lradc_ts *ts)
>>>> +{
>>>> +     struct mxs_lradc *lradc =3D ts->lradc;
>>>> +
>>>> +     mxs_lradc_reg_clear(lradc, mxs_lradc_plate_mask(lradc), LRAD=
C_CTRL0);
>>>> +     mxs_lradc_reg_set(lradc, mxs_lradc_drive_y_plate(lradc), LRA=
DC_CTRL0);
>>>> +
>>>> +     ts->cur_plate =3D LRADC_SAMPLE_Y;
>>>> +     mxs_lradc_map_ts_channel(lradc, TOUCHSCREEN_VCHANNEL1, TS_CH=
_XM);
>>>> +     mxs_lradc_setup_ts_channel(ts, TOUCHSCREEN_VCHANNEL1);
>>>> +}
>>>> +
>>>> +/*
>>>> + *    YP(+)--+-------------+
>>>> + *        |             |--+
>>>> + *        |             |  |
>>>> + * YM(meas)--+-------------+  |
>>>> + *          +--------------+
>>>> + *          |              |
>>>> + *       XP(meas)        XM(-)
>>>> + *
>>>> + * (+) means here 1.85 V
>>>> + * (-) means here GND
>>>> + */
>>>> +static void mxs_lradc_prepare_pressure(struct mxs_lradc_ts *ts)
>>>> +{
>>>> +     struct mxs_lradc *lradc =3D ts->lradc;
>>>> +
>>>> +     mxs_lradc_reg_clear(lradc, mxs_lradc_plate_mask(lradc), LRAD=
C_CTRL0);
>>>> +     mxs_lradc_reg_set(lradc, mxs_lradc_drive_pressure(lradc), LR=
ADC_CTRL0);
>>>> +
>>>> +     ts->cur_plate =3D LRADC_SAMPLE_PRESSURE;
>>>> +     mxs_lradc_map_ts_channel(lradc, TOUCHSCREEN_VCHANNEL1, TS_CH=
_YM);
>>>> +     mxs_lradc_map_ts_channel(lradc, TOUCHSCREEN_VCHANNEL2, TS_CH=
_XP);
>>>> +     mxs_lradc_setup_ts_pressure(ts, TOUCHSCREEN_VCHANNEL2,
>>>> +                                 TOUCHSCREEN_VCHANNEL1);
>>>> +}
>>>> +
>>>> +static void mxs_lradc_enable_touch_detection(struct mxs_lradc_ts =
*ts)
>>>> +{
>>>> +     mxs_lradc_setup_touch_detection(ts);
>>>> +
>>>> +     ts->cur_plate =3D LRADC_TOUCH;
>>>> +     mxs_lradc_reg_clear(ts->lradc, LRADC_CTRL1_TOUCH_DETECT_IRQ =
|
>>>> +                         LRADC_CTRL1_TOUCH_DETECT_IRQ_EN, LRADC_C=
TRL1);
>>>> +     mxs_lradc_reg_set(ts->lradc, LRADC_CTRL1_TOUCH_DETECT_IRQ_EN=
,
>>>> +                       LRADC_CTRL1);
>>>> +}
>>>> +
>>>> +static void mxs_lradc_start_touch_event(struct mxs_lradc_ts *ts)
>>>> +{
>>>> +     mxs_lradc_reg_clear(ts->lradc,
>>>> +                         LRADC_CTRL1_TOUCH_DETECT_IRQ_EN,
>>>> +                         LRADC_CTRL1);
>>>> +     mxs_lradc_reg_set(ts->lradc,
>>>> +                       LRADC_CTRL1_LRADC_IRQ_EN(TOUCHSCREEN_VCHAN=
NEL1),
>>>> +                       LRADC_CTRL1);
>>>> +     /*
>>>> +      * start with the Y-pos, because it uses nearly the same pla=
te
>>>> +      * settings like the touch detection
>>>> +      */
>>>> +     mxs_lradc_prepare_y_pos(ts);
>>>> +}
>>>> +
>>>> +static void mxs_lradc_report_ts_event(struct mxs_lradc_ts *ts)
>>>> +{
>>>> +     input_report_abs(ts->ts_input, ABS_X, ts->ts_x_pos);
>>>> +     input_report_abs(ts->ts_input, ABS_Y, ts->ts_y_pos);
>>>> +     input_report_abs(ts->ts_input, ABS_PRESSURE, ts->ts_pressure=
);
>>>> +     input_report_key(ts->ts_input, BTN_TOUCH, 1);
>>>> +     input_sync(ts->ts_input);
>>>> +}
>>>> +
>>>> +static void mxs_lradc_complete_touch_event(struct mxs_lradc_ts *t=
s)
>>>> +{
>>>> +     struct mxs_lradc *lradc =3D ts->lradc;
>>>> +
>>>> +     mxs_lradc_setup_touch_detection(ts);
>>>> +     ts->cur_plate =3D LRADC_SAMPLE_VALID;
>>>> +     /*
>>>> +      * start a dummy conversion to burn time to settle the signa=
ls
>>>> +      * note: we are not interested in the conversion's value
>>>> +      */
>>>> +     mxs_lradc_reg_wrt(lradc, 0, LRADC_CH(TOUCHSCREEN_VCHANNEL1))=
;
>>>> +     mxs_lradc_reg_clear(lradc,
>>>> +                         LRADC_CTRL1_LRADC_IRQ(TOUCHSCREEN_VCHANN=
EL1) |
>>>> +                         LRADC_CTRL1_LRADC_IRQ(TOUCHSCREEN_VCHANN=
EL2),
>>>> +                         LRADC_CTRL1);
>>>> +     mxs_lradc_reg_wrt(
>>>> +                 lradc,
>>>> +                 LRADC_DELAY_TRIGGER(1 << TOUCHSCREEN_VCHANNEL1) =
|
>>>> +                 LRADC_DELAY_KICK | LRADC_DELAY_DELAY(10), /* was=
te 5 ms */
>>>> +                 LRADC_DELAY(2));
>>>> +}
>>>> +
>>>> +/*
>>>> + * in order to avoid false measurements, report only samples wher=
e
>>>> + * the surface is still touched after the position measurement
>>>> + */
>>>> +static void mxs_lradc_finish_touch_event(struct mxs_lradc_ts *ts,=
 bool valid)
>>>> +{
>>>> +     struct mxs_lradc *lradc =3D ts->lradc;
>>>> +
>>>> +     /* if it is still touched, report the sample */
>>>> +     if (valid && mxs_lradc_check_touch_event(lradc)) {
>>>> +             ts->ts_valid =3D true;
>>>> +             mxs_lradc_report_ts_event(ts);
>>>> +     }
>>>> +
>>>> +     /* if it is even still touched, continue with the next measu=
rement */
>>>> +     if (mxs_lradc_check_touch_event(lradc)) {
>>>> +             mxs_lradc_prepare_y_pos(ts);
>>>> +             return;
>>>> +     }
>>>> +
>>>> +     if (ts->ts_valid) {
>>>> +             /* signal the release */
>>>> +             ts->ts_valid =3D false;
>>>> +             input_report_key(ts->ts_input, BTN_TOUCH, 0);
>>>> +             input_sync(ts->ts_input);
>>>> +     }
>>>> +
>>>> +     /* if it is released, wait for the next touch via IRQ */
>>>> +     ts->cur_plate =3D LRADC_TOUCH;
>>>> +     mxs_lradc_reg_wrt(lradc, 0, LRADC_DELAY(2));
>>>> +     mxs_lradc_reg_wrt(lradc, 0, LRADC_DELAY(3));
>>>> +     mxs_lradc_reg_clear(lradc,
>>>> +                         LRADC_CTRL1_TOUCH_DETECT_IRQ |
>>>> +                         LRADC_CTRL1_LRADC_IRQ_EN(TOUCHSCREEN_VCH=
ANNEL1) |
>>>> +                         LRADC_CTRL1_LRADC_IRQ(TOUCHSCREEN_VCHANN=
EL1),
>>>> +                         LRADC_CTRL1);
>>>> +     mxs_lradc_reg_set(lradc, LRADC_CTRL1_TOUCH_DETECT_IRQ_EN, LR=
ADC_CTRL1);
>>>> +}
>>>> +
>>>> +/* touchscreen's state machine */
>>>> +static void mxs_lradc_handle_touch(struct mxs_lradc_ts *ts)
>>>> +{
>>>> +     struct mxs_lradc *lradc =3D ts->lradc;
>>>> +
>>>> +     switch (ts->cur_plate) {
>>>> +     case LRADC_TOUCH:
>>>> +             if (mxs_lradc_check_touch_event(lradc))
>>>> +                     mxs_lradc_start_touch_event(ts);
>>>> +             mxs_lradc_reg_clear(lradc, LRADC_CTRL1_TOUCH_DETECT_=
IRQ,
>>>> +                                 LRADC_CTRL1);
>>>> +             return;
>>>> +
>>>> +     case LRADC_SAMPLE_Y:
>>>> +             ts->ts_y_pos =3D
>>>> +                 mxs_lradc_ts_read_raw_channel(ts, TOUCHSCREEN_VC=
HANNEL1);
>>>> +             mxs_lradc_prepare_x_pos(ts);
>>>> +             return;
>>>> +
>>>> +     case LRADC_SAMPLE_X:
>>>> +             ts->ts_x_pos =3D
>>>> +                 mxs_lradc_ts_read_raw_channel(ts, TOUCHSCREEN_VC=
HANNEL1);
>>>> +             mxs_lradc_prepare_pressure(ts);
>>>> +             return;
>>>> +
>>>> +     case LRADC_SAMPLE_PRESSURE:
>>>> +             ts->ts_pressure =3D
>>>> +                 mxs_lradc_read_ts_pressure(ts,
>>>> +                                            TOUCHSCREEN_VCHANNEL2=
,
>>>> +                                            TOUCHSCREEN_VCHANNEL1=
);
>>>> +             mxs_lradc_complete_touch_event(ts);
>>>> +             return;
>>>> +
>>>> +     case LRADC_SAMPLE_VALID:
>>>> +             mxs_lradc_finish_touch_event(ts, 1);
>>>> +             break;
>>>> +     }
>>>> +}
>>>> +
>>>> +/*
>>>> + * IRQ Handling
>>>> + */
>>>> +static irqreturn_t mxs_lradc_ts_handle_irq(int irq, void *data)
>>>> +{
>>>> +     struct mxs_lradc_ts *ts =3D data;
>>>> +     struct mxs_lradc *lradc =3D ts->lradc;
>>>> +     unsigned long reg =3D readl(lradc->base + LRADC_CTRL1);
>>>> +     u32 clr_irq =3D mxs_lradc_irq_mask(lradc);
>>>> +     const u32 ts_irq_mask =3D
>>>> +             LRADC_CTRL1_TOUCH_DETECT_IRQ |
>>>> +             LRADC_CTRL1_LRADC_IRQ(TOUCHSCREEN_VCHANNEL1) |
>>>> +             LRADC_CTRL1_LRADC_IRQ(TOUCHSCREEN_VCHANNEL2);
>>>> +
>>>> +     if (!(reg & mxs_lradc_irq_mask(lradc)))
>>>> +             return IRQ_NONE;
>>>> +
>>>> +     if (lradc->use_touchscreen && (reg & ts_irq_mask)) {
>>>> +             mxs_lradc_handle_touch(ts);
>>>> +
>>>> +             /* Make sure we don't clear the next conversion's in=
terrupt. */
>>>> +             clr_irq &=3D ~(LRADC_CTRL1_LRADC_IRQ(TOUCHSCREEN_VCH=
ANNEL1) |
>>>> +                             LRADC_CTRL1_LRADC_IRQ(TOUCHSCREEN_VC=
HANNEL2));
>>>> +             mxs_lradc_reg_clear(lradc, reg & clr_irq, LRADC_CTRL=
1);
>>>> +     }
>>>> +
>>>> +     return IRQ_HANDLED;
>>>> +}
>>>> +
>>>> +static int mxs_lradc_ts_open(struct input_dev *dev)
>>>> +{
>>>> +     struct mxs_lradc_ts *ts =3D input_get_drvdata(dev);
>>>> +
>>>> +     /* Enable the touch-detect circuitry. */
>>>> +     mxs_lradc_enable_touch_detection(ts);
>>>> +
>>>> +     return 0;
>>>> +}
>>>> +
>>>> +static void mxs_lradc_disable_ts(struct mxs_lradc_ts *ts)
>>>> +{
>>>> +     struct mxs_lradc *lradc =3D ts->lradc;
>>>> +
>>>> +     /* stop all interrupts from firing */
>>>> +     mxs_lradc_reg_clear(lradc, LRADC_CTRL1_TOUCH_DETECT_IRQ_EN |
>>>> +             LRADC_CTRL1_LRADC_IRQ_EN(TOUCHSCREEN_VCHANNEL1) |
>>>> +             LRADC_CTRL1_LRADC_IRQ_EN(TOUCHSCREEN_VCHANNEL2), LRA=
DC_CTRL1);
>>>> +
>>>> +     /* Power-down touchscreen touch-detect circuitry. */
>>>> +     mxs_lradc_reg_clear(lradc, mxs_lradc_plate_mask(lradc), LRAD=
C_CTRL0);
>>>> +}
>>>> +
>>>> +static void mxs_lradc_ts_close(struct input_dev *dev)
>>>> +{
>>>> +     struct mxs_lradc_ts *ts =3D input_get_drvdata(dev);
>>>> +
>>>> +     mxs_lradc_disable_ts(ts);
>>>> +}
>>>> +
>>>> +static void mxs_lradc_ts_hw_init(struct mxs_lradc_ts *ts)
>>>> +{
>>>> +     struct mxs_lradc *lradc =3D ts->lradc;
>>>> +
>>>> +     /* Configure the touchscreen type */
>>>> +     if (lradc->soc =3D=3D IMX28_LRADC) {
>>>> +             mxs_lradc_reg_clear(lradc, LRADC_CTRL0_MX28_TOUCH_SC=
REEN_TYPE,
>>>> +                                 LRADC_CTRL0);
>>>> +
>>>> +             if (lradc->use_touchscreen =3D=3D MXS_LRADC_TOUCHSCR=
EEN_5WIRE)
>>>> +                     mxs_lradc_reg_set(lradc,
>>>> +                                       LRADC_CTRL0_MX28_TOUCH_SCR=
EEN_TYPE,
>>>> +                                       LRADC_CTRL0);
>>>> +     }
>>>> +}
>>>> +
>>>> +static void mxs_lradc_ts_hw_stop(struct mxs_lradc_ts *ts)
>>>> +{
>>>> +     int i;
>>>> +     struct mxs_lradc *lradc =3D ts->lradc;
>>>> +
>>>> +     mxs_lradc_reg_clear(lradc,
>>>> +                     lradc->buffer_vchans << LRADC_CTRL1_LRADC_IR=
Q_EN_OFFSET,
>>>> +                     LRADC_CTRL1);
>>>> +
>>>> +     for (i =3D 1; i < LRADC_MAX_DELAY_CHANS; i++)
>>>> +             mxs_lradc_reg_wrt(ts->lradc, 0, LRADC_DELAY(i));
>>>> +}
>>>> +
>>>> +static int mxs_lradc_ts_register(struct mxs_lradc_ts *ts)
>>>> +{
>>>> +     struct input_dev *input =3D ts->ts_input;
>>>> +     struct device *dev =3D ts->dev;
>>>> +     struct mxs_lradc *lradc =3D ts->lradc;
>>>> +
>>>> +     if (!lradc->use_touchscreen)
>>>> +             return 0;
>>>> +
>>>> +     input->name =3D DRIVER_NAME_TS;
>>>> +     input->id.bustype =3D BUS_HOST;
>>>> +     input->dev.parent =3D dev;
>>>> +     input->open =3D mxs_lradc_ts_open;
>>>> +     input->close =3D mxs_lradc_ts_close;
>>>> +
>>>> +     __set_bit(EV_ABS, input->evbit);
>>>> +     __set_bit(EV_KEY, input->evbit);
>>>> +     __set_bit(BTN_TOUCH, input->keybit);
>>>> +     __set_bit(INPUT_PROP_DIRECT, input->propbit);
>>>> +     input_set_abs_params(input, ABS_X, 0, LRADC_SINGLE_SAMPLE_MA=
SK, 0, 0);
>>>> +     input_set_abs_params(input, ABS_Y, 0, LRADC_SINGLE_SAMPLE_MA=
SK, 0, 0);
>>>> +     input_set_abs_params(input, ABS_PRESSURE, 0, LRADC_SINGLE_SA=
MPLE_MASK,
>>>> +                          0, 0);
>>>> +
>>>> +     ts->ts_input =3D input;
>>>> +     input_set_drvdata(input, ts);
>>>> +
>>>> +     return input_register_device(input);
>>>> +}
>>>> +
>>>> +static int mxs_lradc_ts_probe(struct platform_device *pdev)
>>>> +{
>>>> +     struct device *dev =3D &pdev->dev;
>>>> +     struct device_node *node =3D dev->parent->of_node;
>>>> +     struct mxs_lradc *lradc =3D dev_get_platdata(dev);
>>>> +     struct mxs_lradc_ts *ts;
>>>> +     struct input_dev *input;
>>>> +     int touch_ret, ret, i;
>>>> +     u32 ts_wires =3D 0, adapt;
>>>> +
>>>> +     ts =3D devm_kzalloc(dev, sizeof(*ts), GFP_KERNEL);
>>>> +     input =3D devm_input_allocate_device(dev);
>>>> +     if (!ts || !input)
>>>> +             return -ENOMEM;
>>>> +
>>>> +     ts->lradc =3D lradc;
>>>> +     ts->dev =3D dev;
>>>> +     ts->ts_input =3D input;
>>>> +     platform_set_drvdata(pdev, ts);
>>>> +     input_set_drvdata(input, ts);
>>>> +
>>>> +     touch_ret =3D of_property_read_u32(node, "fsl,lradc-touchscr=
een-wires",
>>>> +                                      &ts_wires);
>>>> +
>>>> +     if (of_property_read_u32(node, "fsl,ave-ctrl", &adapt)) {
>>>> +             ts->over_sample_cnt =3D 4;
>>>> +     } else {
>>>> +             if (adapt < 1 || adapt > 32) {
>>>> +                     dev_err(ts->dev, "Invalid sample count (%u)\=
n",
>>>> +                             adapt);
>>>> +                     touch_ret =3D -EINVAL;
>>>> +             } else {
>>>> +                     ts->over_sample_cnt =3D adapt;
>>>> +             }
>>>> +     }
>>>> +
>>>> +     if (of_property_read_u32(node, "fsl,ave-delay", &adapt)) {
>>>> +             ts->over_sample_delay =3D 2;
>>>> +     } else {
>>>> +             if (adapt < 2 || adapt > LRADC_DELAY_DELAY_MASK + 1)=
 {
>>>> +                     dev_err(ts->dev, "Invalid sample delay (%u)\=
n",
>>>> +                             adapt);
>>>> +                     touch_ret =3D -EINVAL;
>>>> +             } else {
>>>> +                     ts->over_sample_delay =3D adapt;
>>>> +             }
>>>> +     }
>>>> +
>>>> +     if (of_property_read_u32(node, "fsl,settling", &adapt)) {
>>>> +             ts->settling_delay =3D 10;
>>>> +     } else {
>>>> +             if (adapt < 1 || adapt > LRADC_DELAY_DELAY_MASK) {
>>>> +                     dev_err(ts->dev, "Invalid settling delay (%u=
)\n",
>>>> +                             adapt);
>>>> +                     touch_ret =3D -EINVAL;
>>>> +             } else {
>>>> +                     ts->settling_delay =3D adapt;
>>>> +             }
>>>> +     }
>>>> +
>>>> +     mxs_lradc_ts_hw_init(ts);
>>>> +     for (i =3D 0; i < lradc->irq_count; i++) {
>>>> +             ret =3D devm_request_irq(dev, lradc->irq[i],
>>>> +                                    mxs_lradc_ts_handle_irq,
>>>> +                                    IRQF_SHARED, lradc->irq_name[=
i], ts);
>>> As with the adc driver, are we actually using all of these?  I'd pr=
efer we
>>> only grab the ones that are actually relevant.
>>
>> Only irq lines relevant for touchscreen are:
>> mxs-lradc-touchscreen, mxs-lradc-channel6 and mxs-lradc-channel7
>> But not all interrupts are beiing used even when I enabled all remai=
ning
>> channels (not used by touchscreen) for bufferd capture via
>> echo 1 >/sys/bus/iio/devices/iio\:device0/scan_elements/in_voltagexx=
_en
>>
>> So I don't know if it's supposed to work like this...
>> (It works the same on the original code)
> Certainly should only grab the relevant ones to touch screen use in h=
ere..
> Original code probably being overly enthusiastic and we never noticed=
 ;)

Sorry for being unclear...
The point I was trying to make was that even though touchscreen and
adc don't share irq lines, irqs mxs-lradc-channel(2,3,4,5,6) are never
being used.
So touchscreen is only use 2 out of 3 irqs assigned to it:
mxs-lradc-touchscreen and mxs-lradc-channel7  . And adc
is only using 2 irq lines mxs-lradc-channel(0,1) during buffered
capture, even when all virtal channels are enabled.
I found that odd...

>> root@cfa100xx:~# cat /proc/interrupts
>>            CPU0
>>  16:      13108         -  48 Edge      MXS Timer Tick
>>  17:       4240         -  82 Edge      mxs-dma
>>  25:          6         -  96 Edge      80010000.ssp
>> 196:          0         -  68 Edge      mxs-dma
>> 210:         13         -  10 Edge      mxs-lradc-touchscreen
>> 211:          0         -  14 Edge      mxs-lradc-thresh0
>> 212:          0         -  15 Edge      mxs-lradc-thresh1
>> 213:         10         -  16 Edge      mxs-lradc-channel0
>> 214:         10         -  17 Edge      mxs-lradc-channel1
>> 215:          0         -  18 Edge      mxs-lradc-channel2
>> 216:          0         -  19 Edge      mxs-lradc-channel3
>> 217:          0         -  20 Edge      mxs-lradc-channel4
>> 218:          0         -  21 Edge      mxs-lradc-channel5
>> 219:          0         -  22 Edge      mxs-lradc-channel6
>> 220:        412         -  23 Edge      mxs-lradc-channel7
>> 221:          0         -  24 Edge      mxs-lradc-button0
>> 222:          0         -  25 Edge      mxs-lradc-button1
>> 223:          0         -  29 Edge      RTC alarm
>> 224:          0         - 111 Edge      80058000.i2c
>> 228:        174         -  47 Edge      uart-pl011
>> 229:        439         -  93 Edge      80080000.usb
>> 230:          0         -  92 Edge      80090000.usb
>> 231:       3610         - 101 Edge      800f0000.ethernet
>> 232:         10  80050000.lradc-dev0 Edge
>> Err:          0
>>
>>>> +             if (ret)
>>>> +                     return ret;
>>>> +     }
>>>> +
>>>> +     if (!touch_ret) {
>>>> +             ret =3D mxs_lradc_ts_register(ts);
>>>> +             if (!ret)
>>>> +                     goto err_ts_register;
>>>> +     }
>>>> +
>>>> +     return 0;
>>>> +
>>>> +err_ts_register:
>>>> +     mxs_lradc_ts_hw_stop(ts);
>>>> +     return ret;
>>>> +}
>>>> +
>>>> +static int mxs_lradc_ts_remove(struct platform_device *pdev)
>>>> +{
>>>> +     struct mxs_lradc_ts *ts =3D platform_get_drvdata(pdev);
>>>> +
>>>> +     mxs_lradc_ts_hw_stop(ts);
>>>> +
>>>> +     return 0;
>>>> +}
>>>> +
>>>> +static struct platform_driver mxs_lradc_ts_driver =3D {
>>>> +     .driver =3D {
>>>> +             .name =3D DRIVER_NAME_TS,
>>>> +     },
>>>> +     .probe  =3D mxs_lradc_ts_probe,
>>>> +     .remove =3D mxs_lradc_ts_remove,
>>>> +};
>>>> +module_platform_driver(mxs_lradc_ts_driver);
>>>> +
>>>> +MODULE_LICENSE("GPL v2");
>>>>
>>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio"=
 in
>> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
