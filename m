From: Ben Dooks <ben@simtec.co.uk>
Subject: Re: [patch 1/1] TOUCHSCREEN: S3C24XX touchscreen driver from	Arnaud
 Patard.
Date: Thu, 19 Nov 2009 12:06:11 +0000
Message-ID: <4B0534B3.20907@simtec.co.uk>
References: <20091118232939.201290297@fluff.org.uk>	<20091118232948.063635416@fluff.org.uk>	<1258609615.2676.31.camel@shinel> <20091119103717.GC15460@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from hull.simtec.co.uk ([78.105.113.97]:44901 "EHLO ben-laptop"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750715AbZKSLCd (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 19 Nov 2009 06:02:33 -0500
In-Reply-To: <20091119103717.GC15460@sirena.org.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Shine Liu <shinel@foxmail.com>, linux-samsung-soc@vger.kernel.org, dmitry.torokhov@gmail.com, Arnaud Patard <arnaud.patard@rtp-net.org>, linux-input@vger.kernel.org, Simtec Linux Team <linux@simtec.co.uk>, linux-arm-kernel@lists.infradead.org

Mark Brown wrote:
> On Thu, Nov 19, 2009 at 01:46:55PM +0800, Shine Liu wrote:
>> On Wed, 2009-11-18 at 23:29 +0000, Ben Dooks wrote:
> 
>>> +config TOUCHSCREEN_S3C2410
>>> +       tristate "Samsung S3C2410 touchscreen input driver"
>>> +       depends on ARCH_S3C2410 && INPUT && INPUT_TOUCHSCREEN
>>> +       select SERIO
>>> +       help
>>> +         Say Y here if you have the s3c2410 touchscreen.
>>> +
>>> +         If unsure, say N.
>>> +
>>> +         To compile this driver as a module, choose M here: the
>>> +         module will be called s3c2410_ts.
> 
>> S3C24XX_ADC should be added to the depends.
> 
> It's probably more friendly to select rather than depend on it to avoid
> the option being hidden.

I prefer the 'select S3C24XX_ADC' and have the symbol available.

Will update the patch.
