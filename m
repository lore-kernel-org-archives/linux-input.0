From: javier Martin <javier.martin@vista-silicon.com>
Subject: Re: qt1070: Why IRQF_TRIGGER_NONE?
Date: Fri, 4 May 2012 09:06:16 +0200
Message-ID: <CACKLOr1hJ5HMfN12ukrNMa3NB_d8u7-VAyJ_D4d6jOb=mB4n_w@mail.gmail.com>
References: <CACKLOr1XE+tJ92jbfOHdDQVVsXhsNASrHgENEbiuR+8aBE11cw@mail.gmail.com>
	<4FA1E237.2070404@atmel.com>
	<ABFEDD1A8D2AAF42A54E3C074D49DC720F627464@penmbx02>
	<20120503081449.065a8232@endymion.delvare>
	<ABFEDD1A8D2AAF42A54E3C074D49DC720F6279BE@penmbx02>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gh0-f174.google.com ([209.85.160.174]:61687 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752067Ab2EDHGR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 4 May 2012 03:06:17 -0400
Received: by ghrr11 with SMTP id r11so2522225ghr.19
        for <linux-input@vger.kernel.org>; Fri, 04 May 2012 00:06:16 -0700 (PDT)
In-Reply-To: <ABFEDD1A8D2AAF42A54E3C074D49DC720F6279BE@penmbx02>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Shen, Voice" <Voice.Shen@atmel.com>
Cc: Jean Delvare <khali@linux-fr.org>, "Wu, Josh" <Josh.wu@atmel.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Wolfram Sang <w.sang@pengutronix.de>, Axel Lin <axel.lin@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

Hi all,
thank you for your comments.

On 4 May 2012 04:07, Shen, Voice <Voice.Shen@atmel.com> wrote:
> Hi Jean,
>  Thank you for your information. Although the irq_flag can not be add=
ed into "struct i2c_board_info" till now, I will try to find other solu=
tion.
>
>  Thanks again.
>
> Hi Javier,
>  As to the IRQ flag depends on SOC. We try to find other solution. Pl=
ease describe you issue in detail. And what's the mode does your SOC su=
pport.

As I stated, with the current 'IRQF_TRIGGER_NONE' flag, this driver
doesn't work in i.MX27. Furthermore, I don't think it works on any
platform since as you previously pointed according to the datasheet of
qt1070, we can use either IRQF_TRIGGER_FALLING or IRQF_TRIGGER_LOW.
But I don't know what is the sense of using 'IRQF_TRIGGER_NONE' here.

My SoC, an i.MX27, theoretically supports both RQF_TRIGGER_FALLING and
IRQF_TRIGGER_LOW but I've only tested the former.

If we take a look at a similar device, a pca953x they simply use the
following flags: (IRQF_TRIGGER_LOW | IRQF_ONESHOT)
http://lxr.linux.no/#linux+v3.3.4/drivers/gpio/gpio-pca953x.c#L495

We could do the same here. It's true there can be SoC's which doesn't
support IRQF_TRIGGER_LOW flag, but if this is the case it means they
don't support this HW feature then. So you are not breaking anything.

> Best Regards,
> Voice Shen
> -----Original Message-----
> From: Jean Delvare [mailto:khali@linux-fr.org]
> Sent: Thursday, May 03, 2012 14:15 =C9=EA=B2=A8
> To: Shen, Voice
> Cc: Wu, Josh; javier Martin; linux-input@vger.kernel.org; Wolfram San=
g; Axel Lin; Dmitry Torokhov
> Subject: Re: qt1070: Why IRQF_TRIGGER_NONE?
>
> On Thu, 3 May 2012 05:15:14 +0000, Shen, Voice wrote:
>> Hi All,
>>   Some information as following,
>>
>>   According to the datasheet of qt1070, we can use IRQF_TRIGGER_FALL=
ING or IRQF_TRIGGER_LOW (I think this is the best) for IRQ flag. Howeve=
r, the IRQ line is a GPIO of a SOC. Some SOC can detect the level chang=
e of the GPIO, while can not distinguish the falling or rising. So, the=
 IRQ flag depends on the trigger mode of GPIO line.
>>
>>   Maybe use the "flags" element in "struct i2c_board_info" to pass t=
he IRQ flag, or add another element named "irqflags" into "struct i2c_b=
oard_info". I think this will be better, but I am not sure whether this=
 is a good solution.
>
> i2c_board_info.flags is for I2C client flags, please do not abuse it
> for IRQ information.
>
> I have no objection to an irq_flag member being added, however I
> remember past discussions where people argued whether it was the righ=
t
> thing to do or whether the IRQ mode was best set by platform
> initialization code. Part of that discussion was archived here:
> http://marc.info/?t=3D128743170300002&r=3D1&w=3D2
> Said discussion did not result in any code being merged as I don't
> think we came to an agreement. Feel free to restart the discussion wi=
th
> the interested people.
>
> --
> Jean Delvare



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
