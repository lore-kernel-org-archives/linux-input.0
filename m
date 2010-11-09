From: Marek Vasut <marek.vasut@gmail.com>
Subject: Re: hi marek
Date: Tue, 9 Nov 2010 19:36:13 +0100
Message-ID: <201011091936.13781.marek.vasut@gmail.com>
References: <20101109184220.00003433@unknown>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:50376 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753820Ab0KISfT (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 9 Nov 2010 13:35:19 -0500
Received: by gyh4 with SMTP id 4so4545231gyh.19
        for <linux-input@vger.kernel.org>; Tue, 09 Nov 2010 10:35:19 -0800 (PST)
In-Reply-To: <20101109184220.00003433@unknown>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dylan cristiani <d.cristiani@idem-tech.it>
Cc: linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org

On Tuesday 09 November 2010 18:42:20 dylan cristiani wrote:
> We heard some month ago, about ucb1400 irq passing, via
> ucb1400_platform_data; then you wrote the patch, that is currently into
> mainline; i've a little problem, probably due to my infinite ignorance:
> i'm writing a sort of my_pm.c driver to check whether the ac line is
> plugged or not, check the main battery voltage and so on (similar to
> arch/arm/mach-pxa/sharpsl_pm.c and corgi_pm.c if you know it); the
> problem is that the battery voltages are tied to the ucb1400 ADC
> inputs, and in my_pm.c driver i don't know how to find the ucb1400_ts
> structure address to call the functions i need to read these ADC input
> i.e.:

1) CC lists

2) Can you post the driver source you have ?

without seeing the source, I can't help you

> unsigned long read_mainbattery_value(void){
> 	....
> 	ucb1400_adc_enable(ucb->ac97);
> 	return ucb1400_adc_read(ucb->ac97, UCB_ADC_INP_AD0, adcsync);
> 	ucb1400_adc_disable(ucb->ac97);
> 	....
> }
> 
> 
> Wwhere can i find info to set (into my_pm.c module) the
> 	struct ucb1400_ts *ucb = ???
> 
> to be passed to the above function read_mainbattery_value()? the fact
> is that the "ucb1400_ts" device platform is already allocked, added and
> the driver registred by the driver/mfd/ucb1400_core.c module so i don't
> know how to find this structure...
> 
> if it's too stupid question please sorry for the noise...
> 
> thanks a million
> 
> dylan
