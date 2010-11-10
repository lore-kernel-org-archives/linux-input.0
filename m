From: dylan cristiani <d.cristiani@idem-tech.it>
Subject: Re: hi marek
Date: Wed, 10 Nov 2010 12:09:12 +0100
Message-ID: <20101110120912.000073d3@unknown>
References: <20101109184220.00003433@unknown>
	<201011091936.13781.marek.vasut@gmail.com>
	<20101110100709.00003d84@unknown>
	<AANLkTi=TupY6Equaifzs6qX8_1y-tNrPFtVB+0=k_Xyh@mail.gmail.com>
	<1289382751.16575.2.camel@konomi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from authsmtp04.register.it ([81.88.48.54]:43295 "EHLO
	authsmtp.register.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751072Ab0KJLJR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 10 Nov 2010 06:09:17 -0500
In-Reply-To: <1289382751.16575.2.camel@konomi>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Marek Vasut <marek.vasut.n900@gmail.com>
Cc: Haojian Zhuang <haojian.zhuang@gmail.com>, Marek Vasut <marek.vasut@gmail.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-input <linux-input@vger.kernel.org>

On Wed, 10 Nov 2010 10:52:31 +0100
Marek Vasut <marek.vasut.n900@gmail.com> wrote:

> > On Wed, Nov 10, 2010 at 5:07 PM, dylan cristiani
> > <d.cristiani@idem-tech.it> wrote:
> > > On Tue, 9 Nov 2010 19:36:13 +0100
> > > Marek Vasut <marek.vasut@gmail.com> wrote:
> > >=20
> > > > On Tuesday 09 November 2010 18:42:20 dylan cristiani wrote:
> > > > > We heard some month ago, about ucb1400 irq passing, via
> > > > > ucb1400_platform_data; then you wrote the patch, that is
> > > > > currently into mainline; i've a little problem, probably due
> > > > > to my infinite ignorance: i'm writing a sort of my_pm.c
> > > > > driver to check whether the ac line is plugged or not, check
> > > > > the main battery voltage and so on (similar to
> > > > > arch/arm/mach-pxa/sharpsl_pm.c and corgi_pm.c if you know
> > > > > it); the problem is that the battery voltages are tied to the
> > > > > ucb1400 ADC inputs, and in my_pm.c driver i don't know how to
> > > > > find the ucb1400_ts structure address to call the functions i
> > > > > need to read these ADC input i.e.:
> > > >=20
> > > > 1) CC lists
> > > >=20
> > > > 2) Can you post the driver source you have ?
> > > >=20
> > > > without seeing the source, I can't help you
> > > here it comes but please close your nose before reading....;-)
> > >=20
> > > arch/arm/mach-pxa/nilux_pm.c
> > >=20
> > > /*
> > > =A0* Based on spitz_pm.c and sharp code.
> > > =A0*
> > > =A0* Distributed under term of GPLv2.
> > > =A0*
> > > =A0*/
> > >=20
> > > #include <linux/module.h>
> > > #include <linux/stat.h>
> > > #include <linux/init.h>
> > > #include <linux/completion.h>
> > > #include <linux/kernel.h>
> > > #include <linux/delay.h>
> > > #include <linux/gpio.h>
> > > //#include <linux/input.h>
> > > #include <linux/device.h>
> > > #include <linux/interrupt.h>
> > > #include <linux/suspend.h>
> > > #include <linux/apm-emulation.h>
> > > #include <linux/platform_device.h>
> > > #include <linux/ucb1400.h>
> > >=20
> > > #include <asm/irq.h>
> > > #include <asm/mach-types.h>
> > > #include <mach/hardware.h>
> > >=20
> > > #include <mach/pm.h>
> > > #include <mach/pxa2xx-regs.h>
> > > #include <mach/regs-rtc.h>
> > > #include <mach/sharpsl_pm.h>
> > >=20
> > >=20
> > > #define AC_IN_INT =A0 =A0 =A0 =A0 =A0 =A0 =A0 17
> > > #define NYLUX_BATT_VOLT =A0 =A0 =A0 =A0 1
> > > #define NYLUX_STATUS_ACIN =A0 =A0 =A0 4
> > > #define NYLUX_BKUPBATT_TEMP =A0 =A0 2
> > > #define NYLUX_CHARGE_STATUS =A0 =A0 3
> > >=20
> > >=20
> > > static struct ucb1400_ts *ucb;
> > >=20
> > > static void nylux_charger_init(void)
> > > {
> > > }
> > >=20
> > > static void nylux_charger_exit(void)
> > > {
> > > }
> > >=20
> > > unsigned long nylux_read_main_battery(void)
> > > {
> > > // =A0 =A0 =A0struct ucb1400_ts *ucb;
> > > =A0 =A0 =A0 =A0unsigned int voltage =3D 0;
> > >=20
> > > =A0 =A0 =A0 =A0printk(KERN_INFO "Reading_Main_Battery\n");
> > >=20
> > > =A0 =A0 =A0 =A0ucb1400_adc_enable(ucb->ac97);
> > >=20
> > > // =A0 =A0 =A0printk(KERN_INFO "Post adc_enable\n");
> > >=20
> > > =A0 =A0 =A0 =A0mdelay(1);
> > > =A0 =A0 =A0 =A0voltage =3D ucb1400_adc_read(ucb->ac97, UCB_ADC_IN=
P_AD0, 0);
> > > =A0 =A0 =A0 =A0printk(KERN_INFO "\nVVVVVVvoltage %d\n", voltage);
> > >=20
> > > =A0 =A0 =A0 =A0ucb1400_adc_disable(ucb->ac97);
> > >=20
> > > =A0 =A0 =A0 =A0return voltage;
> > > }
> > >=20
> > > unsigned long nylux_read_bkup_battery(void)
> > > {
> > > // =A0 =A0 =A0struct ucb1400_ts *ucb;
> > > =A0 =A0 =A0 =A0unsigned int voltage;
> > >=20
> > > =A0 =A0 =A0 =A0ucb1400_adc_enable(ucb->ac97);
> > >=20
> > > =A0 =A0 =A0 =A0mdelay(1);
> > > =A0 =A0 =A0 =A0voltage =3D ucb1400_adc_read(ucb->ac97, UCB_ADC_IN=
P_AD1, 0);
> > >=20
> > > =A0 =A0 =A0 =A0ucb1400_adc_disable(ucb->ac97);
> > > =A0 =A0 =A0 =A0//printk(KERN_INFO "Battery_bkup value =3D %d\n", =
voltage);
> > >=20
> > > =A0 =A0 =A0 =A0return voltage;
> > > }
> > >=20
> > > unsigned long nylux_charge_status(void)
> > > {
> > > // =A0 =A0 =A0struct ucb1400_ts *ucb;
> > > =A0 =A0 =A0 =A0unsigned int status;
> > >=20
> > > =A0 =A0 =A0 =A0//printk(KERN_INFO "Charge_status\n");
> > > =A0 =A0 =A0 =A0ucb1400_adc_enable(ucb->ac97);
> > > =A0 =A0 =A0 =A0mdelay(1);
> > > =A0 =A0 =A0 =A0status =3D ucb1400_adc_read(ucb->ac97, UCB_ADC_INP=
_AD2, 0);
> > > =A0 =A0 =A0 =A0//printk(KERN_INFO "Charge status=3D %d\n", status=
);
> > > =A0 =A0 =A0 =A0ucb1400_adc_disable(ucb->ac97);
> > >=20
> > > =A0 =A0 =A0 =A0return status;
> > >=20
> > > }
> > >=20
> > > static unsigned long nylux_read_devdata(int which)
> > > {
> > > =A0 =A0 =A0 =A0unsigned long ret =3D ~0;
> > >=20
> > > =A0 =A0 =A0 =A0switch (which) {
> > > =A0 =A0 =A0 =A0case NYLUX_BATT_VOLT:
> > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret =3D nylux_read_main_battery();
> > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0//printk(KERN_INFO "read_main_batt=
ery: %d\n", ret);
> > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> > > =A0 =A0 =A0 =A0//case NYLUX_BKUPBATT_TEMP:
> > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0//ret =3D nylux_read_bkup_battery(=
);
> > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0//break;
> > > =A0 =A0 =A0 =A0//case NYLUX_CHARGE_STATUS:
> > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0//ret =3D nylux_charge_status();
> > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0//break;
> > > =A0 =A0 =A0 =A0case NYLUX_STATUS_ACIN: {
> > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret =3D GPLR(AC_IN_INT) & GPIO_bit=
(AC_IN_INT);
> > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0//printk(KERN_INFO "AC_IN =3D %d\n=
", ret);
> > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0//ret =3D read_ac_status();
> > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0//printk(KERN_INFO "read_ac_status=
: %d\n", ret);
> > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> > > =A0 =A0 =A0 =A0}
> > >=20
> > > =A0 =A0 =A0 =A0default:
> > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret =3D ~0;
> > > =A0 =A0 =A0 =A0}
> > >=20
> > > =A0 =A0 =A0 =A0return ret;
> > >=20
> > > }
> > >=20
> > > //******
> > > struct battery_thresh battery_levels[] =3D {
> > > =A0 =A0 =A0 =A0{ 550, 100},
> > > =A0 =A0 =A0 =A0{ 544, =A097},
> > > =A0 =A0 =A0 =A0{ 541, =A093},
> > > =A0 =A0 =A0 =A0{ 536, =A088},
> > > =A0 =A0 =A0 =A0{ 531, =A083},
> > > =A0 =A0 =A0 =A0{ 526, =A078},
> > > =A0 =A0 =A0 =A0{ 522, =A073},
> > > =A0 =A0 =A0 =A0{ 517, =A068},
> > > =A0 =A0 =A0 =A0{ 514, =A063},
> > > =A0 =A0 =A0 =A0{ 510, =A058},
> > > =A0 =A0 =A0 =A0{ 506, =A053},
> > > =A0 =A0 =A0 =A0{ 503, =A048},
> > > =A0 =A0 =A0 =A0{ 499, =A043},
> > > =A0 =A0 =A0 =A0{ 497, =A038},
> > > =A0 =A0 =A0 =A0{ 495, =A033},
> > > =A0 =A0 =A0 =A0{ 493, =A028},
> > > =A0 =A0 =A0 =A0{ 492, =A023},
> > > =A0 =A0 =A0 =A0{ 491, =A018},
> > > =A0 =A0 =A0 =A0{ 489, =A013},
> > > =A0 =A0 =A0 =A0{ 488, =A0 8},
> > > =A0 =A0 =A0 =A0{ 484, =A0 3},
> > > =A0 =A0 =A0 =A0{ 478, =A0 0}
> > > };
> > >=20
> > > struct sharpsl_charger_machinfo nylux_pm_machinfo =3D {
> > > =A0 =A0 =A0 =A0.init =A0 =A0 =A0 =A0 =A0 =A0 =3D nylux_charger_in=
it,
> > > =A0 =A0 =A0 =A0.exit =A0 =A0 =A0 =A0 =A0 =A0 =3D nylux_charger_ex=
it,
> > > =A0 =A0 =A0 =A0.gpio_acin =A0 =A0 =A0 =A0=3D AC_IN_INT,
> > > =A0 =A0 =A0 =A0.read_devdata =A0 =A0 =3D nylux_read_devdata,
> > > =A0 =A0 =A0 =A0.discharge =A0 =A0 =A0 =A0=3D 0,
> > > =A0 =A0 =A0 =A0.discharge1 =A0 =A0 =A0 =3D 0,
> > > =A0 =A0 =A0 =A0.charge =A0 =A0 =A0 =A0 =A0 =3D 0,
> > > =A0 =A0 =A0 =A0.measure_temp =A0 =A0 =3D 0,
> > > =A0 =A0 =A0 =A0.presuspend =A0 =A0 =A0 =3D 0,
> > > =A0 =A0 =A0 =A0.postsuspend =A0 =A0 =A0=3D 0,
> > > =A0 =A0 =A0 =A0.charger_wakeup =A0 =3D 0,
> > > =A0 =A0 =A0 =A0.should_wakeup =A0 =A0=3D 0,
> > > =A0 =A0 =A0 =A0.bat_levels =A0 =A0 =A0 =3D 22,
> > > =A0 =A0 =A0 =A0.bat_levels_noac =A0=3D battery_levels,
> > > =A0 =A0 =A0 =A0.bat_levels_acin =A0=3D 0,
> > > =A0 =A0 =A0 =A0.status_high_acin =3D 510,
> > > =A0 =A0 =A0 =A0.status_low_acin =A0=3D 490,
> > > =A0 =A0 =A0 =A0.status_high_noac =3D 510,
> > > =A0 =A0 =A0 =A0.status_low_noac =A0=3D 490,
> > > =A0 =A0 =A0 =A0.charge_on_volt =A0 =3D 0,
> > > =A0 =A0 =A0 =A0.charge_on_temp =A0 =3D 0,
> > > =A0 =A0 =A0 =A0.charge_acin_high =3D 0,
> > > =A0 =A0 =A0 =A0.charge_acin_low =A0=3D 0,
> > > =A0 =A0 =A0 =A0.fatal_acin_volt =A0=3D 0,
> > > =A0 =A0 =A0 =A0.fatal_noacin_volt =3D 0,
> > >=20
> > > =A0 =A0 =A0 =A0.batfull_irq =A0 =A0 =A0=3D 1
> > > };
> > >=20
> > >=20
> > > /*
> > > static int __init collie_pm_ucb_add(struct ucb1x00_dev *pdev)
> > > {
> > > =A0 =A0 =A0 =A0sharpsl_pm.machinfo =3D &nylux_pm_machinfo;
> > > =A0 =A0 =A0 =A0ucb =3D pdev->ucb;
> > > =A0 =A0 =A0 =A0return 0;
> > > }
> > >=20
> > > static struct ucb1x00_driver collie_pm_ucb_driver =3D {
> > > =A0 =A0 =A0 =A0.add =A0 =A0 =A0 =A0 =A0 =A0=3D collie_pm_ucb_add,
> > > };
> > > */
> > >=20
> > > static struct platform_device *nyluxpm_device;
> > >=20
> > > static int __devinit nyluxpm_init(void)
> > > {
> > > =A0 =A0 =A0 =A0int ret;
> > >=20
> > > =A0 =A0 =A0 =A0nyluxpm_device =3D platform_device_alloc("sharpsl-=
pm", -1);
> > > =A0 =A0 =A0 =A0if (!nyluxpm_device)
> > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -ENOMEM;
> > >=20
> > > =A0 =A0 =A0 =A0nyluxpm_device->dev.platform_data =3D &nylux_pm_ma=
chinfo;
> > > =A0 =A0 =A0 =A0ret =3D platform_device_add(nyluxpm_device);
> > >=20
> > > =A0 =A0 =A0 =A0if (ret)
> > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0platform_device_put(nyluxpm_device=
);
> > >=20
> > > // =A0 =A0 =A0if (!ret)
> > > // =A0 =A0 =A0 =A0 =A0 =A0 =A0ret =3D
> > > ucb1x00_register_driver(&collie_pm_ucb_driver);
> > >=20
> > > =A0 =A0 =A0 =A0return ret;
> > > }
> > >=20
> > > static void nyluxpm_exit(void)
> > > {
> > > // =A0 =A0 =A0ucb1x00_unregister_driver(&collie_pm_ucb_driver);
> > > =A0 =A0 =A0 =A0platform_device_unregister(nyluxpm_device);
> > > }
> > >=20
> > > module_init(nyluxpm_init);
> > > module_exit(nyluxpm_exit);
> > >=20
> > >=20
> > > thanks
> > > dylan
> > >=20
> > > _______________________________________________
> > > linux-arm-kernel mailing list
> > > linux-arm-kernel@lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> > >=20
> >=20
> > You should append your power driver into drivers/power directory.
> > There's an example of colie_battery.c. It's also based on udc.
>=20
> That's basically what I said a few lines above ;-)
>=20
> btw I think he's also intermixing ucb1x00 (ucb < 1400) and ucb1400

first of all thanks for the hint:
i digged a bit into collie_battery.c and i noticed that it uses struct
like 'ucb1x00' and 'ucb1x00_dev' while with ucb1400 i don't have
anything similar just struct 'ucb1400' that is sum of 'ucb1400_ts' and
'ucb1400_gpio', but i don't see how to use these strusctures properly
with my driver in fact 'ucb1x00' has a 'device' member into it while fo=
r
instance ucb1400_ts has an 'input_dev' member
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
