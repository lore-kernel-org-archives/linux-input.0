From: Marek Vasut <marek.vasut@gmail.com>
Subject: Re: hi marek
Date: Wed, 10 Nov 2010 10:29:44 +0100
Message-ID: <201011101029.44942.marek.vasut@gmail.com>
References: <20101109184220.00003433@unknown> <201011091936.13781.marek.vasut@gmail.com> <20101110100709.00003d84@unknown>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:48962 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754829Ab0KJJ2v (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 10 Nov 2010 04:28:51 -0500
Received: by bwz15 with SMTP id 15so503703bwz.19
        for <linux-input@vger.kernel.org>; Wed, 10 Nov 2010 01:28:49 -0800 (PST)
In-Reply-To: <20101110100709.00003d84@unknown>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dylan cristiani <d.cristiani@idem-tech.it>, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org

On Wednesday 10 November 2010 10:07:09 dylan cristiani wrote:
> On Tue, 9 Nov 2010 19:36:13 +0100
> 
> Marek Vasut <marek.vasut@gmail.com> wrote:
> > On Tuesday 09 November 2010 18:42:20 dylan cristiani wrote:
> > > We heard some month ago, about ucb1400 irq passing, via
> > > ucb1400_platform_data; then you wrote the patch, that is currently
> > > into mainline; i've a little problem, probably due to my infinite
> > > ignorance: i'm writing a sort of my_pm.c driver to check whether
> > > the ac line is plugged or not, check the main battery voltage and
> > > so on (similar to arch/arm/mach-pxa/sharpsl_pm.c and corgi_pm.c if
> > > you know it); the problem is that the battery voltages are tied to
> > > the ucb1400 ADC inputs, and in my_pm.c driver i don't know how to
> > > find the ucb1400_ts structure address to call the functions i need
> > 
> > > to read these ADC input i.e.:
> > 1) CC lists
> > 
> > 2) Can you post the driver source you have ?
> > 
> > without seeing the source, I can't help you
> 
> here it comes but please close your nose before reading....;-)
> 
> arch/arm/mach-pxa/nilux_pm.c

1) This should go into drivers/power/...
2) Use the battery framework, there's a gazilion of examples there

> 
> /*
>  * Based on spitz_pm.c and sharp code.
>  *
>  * Distributed under term of GPLv2.
>  *
>  */
> 
> #include <linux/module.h>
> #include <linux/stat.h>
> #include <linux/init.h>
> #include <linux/completion.h>
> #include <linux/kernel.h>
> #include <linux/delay.h>
> #include <linux/gpio.h>
> //#include <linux/input.h>
> #include <linux/device.h>
> #include <linux/interrupt.h>
> #include <linux/suspend.h>
> #include <linux/apm-emulation.h>
> #include <linux/platform_device.h>
> #include <linux/ucb1400.h>
> 
> #include <asm/irq.h>
> #include <asm/mach-types.h>
> #include <mach/hardware.h>
> 
> #include <mach/pm.h>
> #include <mach/pxa2xx-regs.h>
> #include <mach/regs-rtc.h>
> #include <mach/sharpsl_pm.h>
> 
> 
> #define AC_IN_INT		17
> #define NYLUX_BATT_VOLT		1
> #define NYLUX_STATUS_ACIN	4
> #define NYLUX_BKUPBATT_TEMP	2
> #define NYLUX_CHARGE_STATUS	3
> 
> 
> static struct ucb1400_ts *ucb;
> 
> static void nylux_charger_init(void)
> {
> }
> 
> static void nylux_charger_exit(void)
> {
> }
> 
> unsigned long nylux_read_main_battery(void)
> {
> //	struct ucb1400_ts *ucb;
> 	unsigned int voltage = 0;
> 
> 	printk(KERN_INFO "Reading_Main_Battery\n");
> 
> 	ucb1400_adc_enable(ucb->ac97);
> 
> //	printk(KERN_INFO "Post adc_enable\n");
> 
> 	mdelay(1);
> 	voltage = ucb1400_adc_read(ucb->ac97, UCB_ADC_INP_AD0, 0);
> 	printk(KERN_INFO "\nVVVVVVvoltage %d\n", voltage);
> 
> 	ucb1400_adc_disable(ucb->ac97);
> 
> 	return voltage;
> }
> 
> unsigned long nylux_read_bkup_battery(void)
> {
> //	struct ucb1400_ts *ucb;
> 	unsigned int voltage;
> 
> 	ucb1400_adc_enable(ucb->ac97);
> 
> 	mdelay(1);
> 	voltage = ucb1400_adc_read(ucb->ac97, UCB_ADC_INP_AD1, 0);
> 
> 	ucb1400_adc_disable(ucb->ac97);
> 	//printk(KERN_INFO "Battery_bkup value = %d\n", voltage);
> 
> 	return voltage;
> }
> 
> unsigned long nylux_charge_status(void)
> {
> //	struct ucb1400_ts *ucb;
> 	unsigned int status;
> 
> 	//printk(KERN_INFO "Charge_status\n");
> 	ucb1400_adc_enable(ucb->ac97);
> 	mdelay(1);
> 	status = ucb1400_adc_read(ucb->ac97, UCB_ADC_INP_AD2, 0);
> 	//printk(KERN_INFO "Charge status= %d\n", status);
> 	ucb1400_adc_disable(ucb->ac97);
> 
> 	return status;
> 
> }
> 
> static unsigned long nylux_read_devdata(int which)
> {
> 	unsigned long ret = ~0;
> 
> 	switch (which) {
> 	case NYLUX_BATT_VOLT:
> 		ret = nylux_read_main_battery();
> 		//printk(KERN_INFO "read_main_battery: %d\n", ret);
> 		break;
> 	//case NYLUX_BKUPBATT_TEMP:
> 		//ret = nylux_read_bkup_battery();
> 		//break;
> 	//case NYLUX_CHARGE_STATUS:
> 		//ret = nylux_charge_status();
> 		//break;
> 	case NYLUX_STATUS_ACIN: {
> 		ret = GPLR(AC_IN_INT) & GPIO_bit(AC_IN_INT);
> 		//printk(KERN_INFO "AC_IN = %d\n", ret);
> 		//ret = read_ac_status();
> 		//printk(KERN_INFO "read_ac_status: %d\n", ret);
> 		break;
> 	}
> 
> 	default:
> 		ret = ~0;
> 	}
> 
> 	return ret;
> 
> }
> 
> //******
> struct battery_thresh battery_levels[] = {
> 	{ 550, 100},
> 	{ 544,  97},
> 	{ 541,  93},
> 	{ 536,  88},
> 	{ 531,  83},
> 	{ 526,  78},
> 	{ 522,  73},
> 	{ 517,  68},
> 	{ 514,  63},
> 	{ 510,  58},
> 	{ 506,  53},
> 	{ 503,  48},
> 	{ 499,  43},
> 	{ 497,  38},
> 	{ 495,  33},
> 	{ 493,  28},
> 	{ 492,  23},
> 	{ 491,  18},
> 	{ 489,  13},
> 	{ 488,   8},
> 	{ 484,   3},
> 	{ 478,   0}
> };
> 
> struct sharpsl_charger_machinfo nylux_pm_machinfo = {
> 	.init             = nylux_charger_init,
> 	.exit		  = nylux_charger_exit,
> 	.gpio_acin	  = AC_IN_INT,
> 	.read_devdata	  = nylux_read_devdata,
> 	.discharge        = 0,
> 	.discharge1       = 0,
> 	.charge           = 0,
> 	.measure_temp     = 0,
> 	.presuspend       = 0,
> 	.postsuspend      = 0,
> 	.charger_wakeup   = 0,
> 	.should_wakeup    = 0,
> 	.bat_levels       = 22,
> 	.bat_levels_noac  = battery_levels,
> 	.bat_levels_acin  = 0,
> 	.status_high_acin = 510,
> 	.status_low_acin  = 490,
> 	.status_high_noac = 510,
> 	.status_low_noac  = 490,
> 	.charge_on_volt	  = 0,
> 	.charge_on_temp   = 0,
> 	.charge_acin_high = 0,
> 	.charge_acin_low  = 0,
> 	.fatal_acin_volt  = 0,
> 	.fatal_noacin_volt = 0,
> 
> 	.batfull_irq	  = 1
> };
> 
> 
> /*
> static int __init collie_pm_ucb_add(struct ucb1x00_dev *pdev)
> {
> 	sharpsl_pm.machinfo = &nylux_pm_machinfo;
> 	ucb = pdev->ucb;
> 	return 0;
> }
> 
> static struct ucb1x00_driver collie_pm_ucb_driver = {
> 	.add            = collie_pm_ucb_add,
> };
> */
> 
> static struct platform_device *nyluxpm_device;
> 
> static int __devinit nyluxpm_init(void)
> {
>         int ret;
> 
>         nyluxpm_device = platform_device_alloc("sharpsl-pm", -1);
>         if (!nyluxpm_device)
>                 return -ENOMEM;
> 
>         nyluxpm_device->dev.platform_data = &nylux_pm_machinfo;
>         ret = platform_device_add(nyluxpm_device);
> 
>         if (ret)
>                 platform_device_put(nyluxpm_device);
> 
> //	if (!ret)
> //		ret = ucb1x00_register_driver(&collie_pm_ucb_driver);
> 
> 	return ret;
> }
> 
> static void nyluxpm_exit(void)
> {
> //	ucb1x00_unregister_driver(&collie_pm_ucb_driver);
>         platform_device_unregister(nyluxpm_device);
> }
> 
> module_init(nyluxpm_init);
> module_exit(nyluxpm_exit);
> 
> 
> thanks
> dylan
