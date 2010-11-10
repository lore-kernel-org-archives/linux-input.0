From: Marek Vasut <marek.vasut.n900@gmail.com>
Subject: Re: hi marek
Date: Wed, 10 Nov 2010 10:52:31 +0100
Message-ID: <1289382751.16575.2.camel@konomi>
References: <20101109184220.00003433@unknown>
	 <201011091936.13781.marek.vasut@gmail.com>
	 <20101110100709.00003d84@unknown>
	  <AANLkTi=TupY6Equaifzs6qX8_1y-tNrPFtVB+0=k_Xyh@mail.gmail.com>
Reply-To: Marek Vasut <marek.vasut.n900@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:36457 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753805Ab0KJJwj (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 10 Nov 2010 04:52:39 -0500
Received: by fxm16 with SMTP id 16so213236fxm.19
        for <linux-input@vger.kernel.org>; Wed, 10 Nov 2010 01:52:38 -0800 (PST)
In-Reply-To: <AANLkTi=TupY6Equaifzs6qX8_1y-tNrPFtVB+0=k_Xyh@mail.gmail.com>
Content-ID: <1289382750.16575.1.camel@konomi>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Haojian Zhuang <haojian.zhuang@gmail.com>, dylan cristiani <d.cristiani@idem-tech.it>
Cc: Marek Vasut <marek.vasut@gmail.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-input <linux-input@vger.kernel.org>

> On Wed, Nov 10, 2010 at 5:07 PM, dylan cristiani
> <d.cristiani@idem-tech.it> wrote:
> > On Tue, 9 Nov 2010 19:36:13 +0100
> > Marek Vasut <marek.vasut@gmail.com> wrote:
> >=20
> > > On Tuesday 09 November 2010 18:42:20 dylan cristiani wrote:
> > > > We heard some month ago, about ucb1400 irq passing, via
> > > > ucb1400_platform_data; then you wrote the patch, that is curren=
tly
> > > > into mainline; i've a little problem, probably due to my infini=
te
> > > > ignorance: i'm writing a sort of my_pm.c driver to check whethe=
r
> > > > the ac line is plugged or not, check the main battery voltage a=
nd
> > > > so on (similar to arch/arm/mach-pxa/sharpsl_pm.c and corgi_pm.c=
 if
> > > > you know it); the problem is that the battery voltages are tied=
 to
> > > > the ucb1400 ADC inputs, and in my_pm.c driver i don't know how =
to
> > > > find the ucb1400_ts structure address to call the functions i n=
eed
> > > > to read these ADC input i.e.:
> > >=20
> > > 1) CC lists
> > >=20
> > > 2) Can you post the driver source you have ?
> > >=20
> > > without seeing the source, I can't help you
> > here it comes but please close your nose before reading....;-)
> >=20
> > arch/arm/mach-pxa/nilux_pm.c
> >=20
> > /*
> > =C2=A0* Based on spitz_pm.c and sharp code.
> > =C2=A0*
> > =C2=A0* Distributed under term of GPLv2.
> > =C2=A0*
> > =C2=A0*/
> >=20
> > #include <linux/module.h>
> > #include <linux/stat.h>
> > #include <linux/init.h>
> > #include <linux/completion.h>
> > #include <linux/kernel.h>
> > #include <linux/delay.h>
> > #include <linux/gpio.h>
> > //#include <linux/input.h>
> > #include <linux/device.h>
> > #include <linux/interrupt.h>
> > #include <linux/suspend.h>
> > #include <linux/apm-emulation.h>
> > #include <linux/platform_device.h>
> > #include <linux/ucb1400.h>
> >=20
> > #include <asm/irq.h>
> > #include <asm/mach-types.h>
> > #include <mach/hardware.h>
> >=20
> > #include <mach/pm.h>
> > #include <mach/pxa2xx-regs.h>
> > #include <mach/regs-rtc.h>
> > #include <mach/sharpsl_pm.h>
> >=20
> >=20
> > #define AC_IN_INT =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
17
> > #define NYLUX_BATT_VOLT =C2=A0 =C2=A0 =C2=A0 =C2=A0 1
> > #define NYLUX_STATUS_ACIN =C2=A0 =C2=A0 =C2=A0 4
> > #define NYLUX_BKUPBATT_TEMP =C2=A0 =C2=A0 2
> > #define NYLUX_CHARGE_STATUS =C2=A0 =C2=A0 3
> >=20
> >=20
> > static struct ucb1400_ts *ucb;
> >=20
> > static void nylux_charger_init(void)
> > {
> > }
> >=20
> > static void nylux_charger_exit(void)
> > {
> > }
> >=20
> > unsigned long nylux_read_main_battery(void)
> > {
> > // =C2=A0 =C2=A0 =C2=A0struct ucb1400_ts *ucb;
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int voltage =3D 0;
> >=20
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0printk(KERN_INFO "Reading_Main_Battery\n=
");
> >=20
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0ucb1400_adc_enable(ucb->ac97);
> >=20
> > // =C2=A0 =C2=A0 =C2=A0printk(KERN_INFO "Post adc_enable\n");
> >=20
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0mdelay(1);
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0voltage =3D ucb1400_adc_read(ucb->ac97, =
UCB_ADC_INP_AD0, 0);
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0printk(KERN_INFO "\nVVVVVVvoltage %d\n",=
 voltage);
> >=20
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0ucb1400_adc_disable(ucb->ac97);
> >=20
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0return voltage;
> > }
> >=20
> > unsigned long nylux_read_bkup_battery(void)
> > {
> > // =C2=A0 =C2=A0 =C2=A0struct ucb1400_ts *ucb;
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int voltage;
> >=20
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0ucb1400_adc_enable(ucb->ac97);
> >=20
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0mdelay(1);
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0voltage =3D ucb1400_adc_read(ucb->ac97, =
UCB_ADC_INP_AD1, 0);
> >=20
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0ucb1400_adc_disable(ucb->ac97);
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0//printk(KERN_INFO "Battery_bkup value =3D=
 %d\n", voltage);
> >=20
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0return voltage;
> > }
> >=20
> > unsigned long nylux_charge_status(void)
> > {
> > // =C2=A0 =C2=A0 =C2=A0struct ucb1400_ts *ucb;
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int status;
> >=20
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0//printk(KERN_INFO "Charge_status\n");
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0ucb1400_adc_enable(ucb->ac97);
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0mdelay(1);
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0status =3D ucb1400_adc_read(ucb->ac97, U=
CB_ADC_INP_AD2, 0);
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0//printk(KERN_INFO "Charge status=3D %d\=
n", status);
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0ucb1400_adc_disable(ucb->ac97);
> >=20
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0return status;
> >=20
> > }
> >=20
> > static unsigned long nylux_read_devdata(int which)
> > {
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned long ret =3D ~0;
> >=20
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0switch (which) {
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0case NYLUX_BATT_VOLT:
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D nylu=
x_read_main_battery();
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0//printk(KER=
N_INFO "read_main_battery: %d\n", ret);
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0//case NYLUX_BKUPBATT_TEMP:
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0//ret =3D ny=
lux_read_bkup_battery();
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0//break;
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0//case NYLUX_CHARGE_STATUS:
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0//ret =3D ny=
lux_charge_status();
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0//break;
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0case NYLUX_STATUS_ACIN: {
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D GPLR=
(AC_IN_INT) & GPIO_bit(AC_IN_INT);
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0//printk(KER=
N_INFO "AC_IN =3D %d\n", ret);
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0//ret =3D re=
ad_ac_status();
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0//printk(KER=
N_INFO "read_ac_status: %d\n", ret);
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> >=20
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0default:
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D ~0;
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> >=20
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;
> >=20
> > }
> >=20
> > //******
> > struct battery_thresh battery_levels[] =3D {
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0{ 550, 100},
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0{ 544, =C2=A097},
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0{ 541, =C2=A093},
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0{ 536, =C2=A088},
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0{ 531, =C2=A083},
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0{ 526, =C2=A078},
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0{ 522, =C2=A073},
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0{ 517, =C2=A068},
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0{ 514, =C2=A063},
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0{ 510, =C2=A058},
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0{ 506, =C2=A053},
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0{ 503, =C2=A048},
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0{ 499, =C2=A043},
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0{ 497, =C2=A038},
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0{ 495, =C2=A033},
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0{ 493, =C2=A028},
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0{ 492, =C2=A023},
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0{ 491, =C2=A018},
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0{ 489, =C2=A013},
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0{ 488, =C2=A0 8},
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0{ 484, =C2=A0 3},
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0{ 478, =C2=A0 0}
> > };
> >=20
> > struct sharpsl_charger_machinfo nylux_pm_machinfo =3D {
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0.init =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =3D nylux_charger_init,
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0.exit =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =3D nylux_charger_exit,
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0.gpio_acin =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D=
 AC_IN_INT,
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0.read_devdata =C2=A0 =C2=A0 =3D nylux_re=
ad_devdata,
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0.discharge =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D=
 0,
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0.discharge1 =C2=A0 =C2=A0 =C2=A0 =3D 0,
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0.charge =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =3D 0,
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0.measure_temp =C2=A0 =C2=A0 =3D 0,
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0.presuspend =C2=A0 =C2=A0 =C2=A0 =3D 0,
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0.postsuspend =C2=A0 =C2=A0 =C2=A0=3D 0,
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0.charger_wakeup =C2=A0 =3D 0,
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0.should_wakeup =C2=A0 =C2=A0=3D 0,
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0.bat_levels =C2=A0 =C2=A0 =C2=A0 =3D 22,
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0.bat_levels_noac =C2=A0=3D battery_level=
s,
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0.bat_levels_acin =C2=A0=3D 0,
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0.status_high_acin =3D 510,
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0.status_low_acin =C2=A0=3D 490,
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0.status_high_noac =3D 510,
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0.status_low_noac =C2=A0=3D 490,
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0.charge_on_volt =C2=A0 =3D 0,
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0.charge_on_temp =C2=A0 =3D 0,
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0.charge_acin_high =3D 0,
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0.charge_acin_low =C2=A0=3D 0,
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0.fatal_acin_volt =C2=A0=3D 0,
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0.fatal_noacin_volt =3D 0,
> >=20
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0.batfull_irq =C2=A0 =C2=A0 =C2=A0=3D 1
> > };
> >=20
> >=20
> > /*
> > static int __init collie_pm_ucb_add(struct ucb1x00_dev *pdev)
> > {
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0sharpsl_pm.machinfo =3D &nylux_pm_machin=
fo;
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0ucb =3D pdev->ucb;
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;
> > }
> >=20
> > static struct ucb1x00_driver collie_pm_ucb_driver =3D {
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0.add =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0=3D collie_pm_ucb_add,
> > };
> > */
> >=20
> > static struct platform_device *nyluxpm_device;
> >=20
> > static int __devinit nyluxpm_init(void)
> > {
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0int ret;
> >=20
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0nyluxpm_device =3D platform_device_alloc=
("sharpsl-pm", -1);
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!nyluxpm_device)
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENOM=
EM;
> >=20
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0nyluxpm_device->dev.platform_data =3D &n=
ylux_pm_machinfo;
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D platform_device_add(nyluxpm_devi=
ce);
> >=20
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret)
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0platform_dev=
ice_put(nyluxpm_device);
> >=20
> > // =C2=A0 =C2=A0 =C2=A0if (!ret)
> > // =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D ucb1x00_=
register_driver(&collie_pm_ucb_driver);
> >=20
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;
> > }
> >=20
> > static void nyluxpm_exit(void)
> > {
> > // =C2=A0 =C2=A0 =C2=A0ucb1x00_unregister_driver(&collie_pm_ucb_dri=
ver);
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0platform_device_unregister(nyluxpm_devic=
e);
> > }
> >=20
> > module_init(nyluxpm_init);
> > module_exit(nyluxpm_exit);
> >=20
> >=20
> > thanks
> > dylan
> >=20
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> >=20
>=20
> You should append your power driver into drivers/power directory.
> There's an example of colie_battery.c. It's also based on udc.

That's basically what I said a few lines above ;-)

btw I think he's also intermixing ucb1x00 (ucb < 1400) and ucb1400
>=20
> Thanks
> Haojian

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
