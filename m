From: Josh Wu <josh.wu@atmel.com>
Subject: Re: [RFC] QT1070: change the trigger mode of QT1070
Date: Fri, 11 May 2012 19:33:08 +0800
Message-ID: <4FACF8F4.2090302@atmel.com>
References: <1336357653-18663-1-git-send-email-voice.shen@atmel.com> <20120507070424.GC22074@core.coreip.homeip.net> <4FACCDA6.7040506@atmel.com> <CACKLOr0_ztBXfTwa1R_yLzf6wEABENf=-MzYHd-J5YQtEmQt9w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from newsmtp5.atmel.com ([204.2.163.5]:36549 "EHLO
	sjogate2.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751759Ab2EKLdz (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 11 May 2012 07:33:55 -0400
In-Reply-To: <CACKLOr0_ztBXfTwa1R_yLzf6wEABENf=-MzYHd-J5YQtEmQt9w@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: javier Martin <javier.martin@vista-silicon.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bo Shen <voice.shen@atmel.com>, khali@linux-fr.org, w.sang@pengutronix.de, jm.lin@atmel.com, linux-input@vger.kernel.org

Hi, Javier

On 5/11/2012 5:13 PM, javier Martin wrote:

> Hi all,
> let's take a chip which presents a similar issue like the pca953x [1].
> This chip has an IRQ line that is meant to be connected to a SoC input
> like the qt1070.
>
> The flags that are used for pca953x are: (IRQF_TRIGGER_LOW | IRQF_ONESHOT)
>
> Can't we do the same for qt1070?

I did a simple test in my board in 2.6.39,  This flag doesn't work. But 
IRQF_TRIGGER_FALLING works fine.
So the question is what is different between this flag with 
IRQF_TRIGGER_FALLING?

> And even more important, can you give me an example of an architecture
> in mainline which cannot support these irq flags and still be able to
> detect a change from high to low in a GPIO as qt1070 requires?

For now, AT91SAM9M10 can only detect GPIO input change, it cannot tell 
is falling or rising. So in theory it cannot support falling flags.
The strange thing is, currently we use IRQF_TRIGGER_NONE in 2.6.39 
kernel for both AT91SAM9M10 and 9X5 chips, and they all work fine. So I 
need check the code of GPIO part.

>
> Moreover, if you try a grep for IRQ_TRIGGER_NONE in the kernel tree
> you won't find any driver doing this strange thing.
>
> Do you agree at least that we must change IRQ_TRIGGER_NONE flag into a
> more sensible choice?

Yes. I agreed.

>
> Regards.
>
> [1] http://lxr.linux.no/#linux+v3.3.4/drivers/gpio/gpio-pca953x.c#L495
>

Best Regards,
Josh Wu
