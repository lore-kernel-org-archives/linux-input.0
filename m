From: javier Martin <javier.martin@vista-silicon.com>
Subject: Re: [RFC] QT1070: change the trigger mode of QT1070
Date: Fri, 11 May 2012 14:47:15 +0200
Message-ID: <CACKLOr2iMGeVWQgXO7zX-qfCDAXXk+oKvpXCFck_+piOFtC_oQ@mail.gmail.com>
References: <1336357653-18663-1-git-send-email-voice.shen@atmel.com>
	<20120507070424.GC22074@core.coreip.homeip.net>
	<4FACCDA6.7040506@atmel.com>
	<CACKLOr0_ztBXfTwa1R_yLzf6wEABENf=-MzYHd-J5YQtEmQt9w@mail.gmail.com>
	<4FACF8F4.2090302@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gg0-f174.google.com ([209.85.161.174]:48283 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758964Ab2EKMrQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 11 May 2012 08:47:16 -0400
Received: by gglu4 with SMTP id u4so1697395ggl.19
        for <linux-input@vger.kernel.org>; Fri, 11 May 2012 05:47:15 -0700 (PDT)
In-Reply-To: <4FACF8F4.2090302@atmel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Josh Wu <josh.wu@atmel.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bo Shen <voice.shen@atmel.com>, khali@linux-fr.org, w.sang@pengutronix.de, jm.lin@atmel.com, linux-input@vger.kernel.org

Hi,

On 11 May 2012 13:33, Josh Wu <josh.wu@atmel.com> wrote:
> Hi, Javier
>
>
> On 5/11/2012 5:13 PM, javier Martin wrote:
>
>> Hi all,
>> let's take a chip which presents a similar issue like the pca953x [1=
].
>> This chip has an IRQ line that is meant to be connected to a SoC inp=
ut
>> like the qt1070.
>>
>> The flags that are used for pca953x are: (IRQF_TRIGGER_LOW | IRQF_ON=
ESHOT)
>>
>> Can't we do the same for qt1070?
>
>
> I did a simple test in my board in 2.6.39, =A0This flag doesn't work.=
 But
> IRQF_TRIGGER_FALLING works fine.
> So the question is what is different between this flag with
> IRQF_TRIGGER_FALLING?

I don't know but IRQF_TRIGGER_FALLING works for me too.

>> And even more important, can you give me an example of an architectu=
re
>> in mainline which cannot support these irq flags and still be able t=
o
>> detect a change from high to low in a GPIO as qt1070 requires?
>
>
> For now, AT91SAM9M10 can only detect GPIO input change, it cannot tel=
l is
> falling or rising. So in theory it cannot support falling flags.
> The strange thing is, currently we use IRQF_TRIGGER_NONE in 2.6.39 ke=
rnel
> for both AT91SAM9M10 and 9X5 chips, and they all work fine. So I need=
 check
> the code of GPIO part.
>
>
>>
>> Moreover, if you try a grep for IRQ_TRIGGER_NONE in the kernel tree
>> you won't find any driver doing this strange thing.
>>
>> Do you agree at least that we must change IRQ_TRIGGER_NONE flag into=
 a
>> more sensible choice?
>
>
> Yes. I agreed.
>
>>
>> Regards.
>>
>> [1] http://lxr.linux.no/#linux+v3.3.4/drivers/gpio/gpio-pca953x.c#L4=
95




--=20
Javier Martin
Vista Silicon S.L.
CDTUC - FASE C - Oficina S-345
Avda de los Castros s/n
39005- Santander. Cantabria. Spain
+34 942 25 32 60
www.vista-silicon.com
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
