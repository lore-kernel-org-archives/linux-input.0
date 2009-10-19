From: Juergen Beisert <jbe@pengutronix.de>
Subject: Re: [PATCH] input/touchscreen: add S3C24XX SoC touchscreen input driver
Date: Mon, 19 Oct 2009 16:34:10 +0200
Message-ID: <200910191634.11341.jbe@pengutronix.de>
References: <mailman.4020.1255949705.2256.linux-arm-kernel@lists.infradead.org> <4ADC4D4D.5020508@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:55539 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756134AbZJSOeY (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 19 Oct 2009 10:34:24 -0400
In-Reply-To: <4ADC4D4D.5020508@gmail.com>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Cc: Maurus Cuelenaere <mcuelenaere@gmail.com>, Shine Liu <shinel@foxmail.com>, Nelson Castillo <arhuaco@freaks-unidos.net>, dtor@mail.ru, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org

On Montag, 19. Oktober 2009, Maurus Cuelenaere wrote:
> Op 19-10-09 12:55, linux-arm-kernel-request@lists.infradead.org schreef:
> > This touchscreen driver is for touchscreen controller on Samsung
> > S3C2410/S3C2440 SoC chip. S3C2410/S3C2440 has the on chip touchscreen
> > controller based on it's analog to digital converter(8-channel analog
> > inputs, touchscreen uses 4 of them). This driver uses the exsiting S3C
> > ADC driver to make the touchscreen controller of S3C2410/S3C2440 work
> > well together with other ADC devices connected to the S3C24XX SoC chip.
> >
> > The patch is created against kernel 2.6.32-rc4 and tested with S3C2440
> > SoC and Samsung LTE430WQ-F0C touchscreen.
> >
> >
> > Signed-off-by: Shine Liu<liuxian@redflag-linux.com>
> > Signed-off-by: Shine Liu<shinel@foxmail.com>
>
> Do you know that there's another patch (at Openmoko) created by Nelson
> Castillo that does the same, but also has support for kernel-space
> touchscreen filters? (I think [1] is his latest version)
> I don't know how your patch performs, but according to [2] the filters
> should help a lot avoiding jitter etc.
>
> I'm not sure whether Nelson has submitted his patches for mainline
> review yet and what the status is on the kernel filters, but IMHO doing
> some filtering in kernel space (see the "Why are we doing filtering in
> kernel space?" part of [2]) which results in a "cleaner" output is
> preferred over reporting possible "jittery" data.

Filtering can be done perfectly in userland (like all the other ts do). IMHO I 
can't see any need to do it in kernel space.

jbe

-- 
Pengutronix e.K.                              | Juergen Beisert             |
Linux Solutions for Science and Industry      | Phone: +49-8766-939 228     |
Vertretung Sued/Muenchen, Germany             | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686              | http://www.pengutronix.de/  |
