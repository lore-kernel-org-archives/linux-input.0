From: Wan ZongShun <mcuos.com@gmail.com>
Subject: Re: [PATCH] input: Rename keypad and ts platform driver for w90p910
Date: Tue, 18 Aug 2009 14:13:40 +0800
Message-ID: <e68bb3470908172313k5be5d102w33e46c19855ef6ea@mail.gmail.com>
References: <4A88D499.30302@gmail.com>
	 <20090817084848.6720F526EA5@mailhub.coreip.homeip.net>
	 <e68bb3470908170144w49cf2e44g56eba456424a9a4b@mail.gmail.com>
	 <20090818055620.73F65526EA5@mailhub.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.168]:15651 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751358AbZHRGNi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 18 Aug 2009 02:13:38 -0400
Received: by wf-out-1314.google.com with SMTP id 26so958468wfd.4
        for <linux-input@vger.kernel.org>; Mon, 17 Aug 2009 23:13:40 -0700 (PDT)
In-Reply-To: <20090818055620.73F65526EA5@mailhub.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>, linux-input@vger.kernel.org

Dear sir,

2009/8/18 Dmitry Torokhov <dmitry.torokhov@gmail.com>:
> Hi Wan,
>
> On Mon, Aug 17, 2009 at 04:44:03PM +0800, Wan ZongShun wrote:
>> Dear Dmitry,
>>
>> Sir, Due to only w90p910 was renamed, other CPUs of the series
>> originally was named after NUC9xx,
>> the ts and keypad was public use by w90p910 ,nuc950 and nuc920,
>
> OK, I see.
>
> =C2=A0so, if
>> the 'w90p910-ts' and 'w90p910-keypad' could not be renamed ,I have t=
o
>> make the platform device names of nuc920 and nuc960 named after
>> 'w90p910-ts' and 'w90p910-keypad' too, Hmm, I think it is so confuse=
d.
>
> May I suggest calling the driver/devices nuc9xx-ts and nuc9xx-ts?

Sir, I prefer these nuc9xx more than nuc900 too for representing the
series SoCs,
but, it just be my embarrassing, I have argued this Naming issue with N=
uvoton,
and they did not agree me and prefer to use nuc900.

I know well it should not have company politics in Linux community,
but I have to
consider their point of view sometimes.

>Then you should have some wiggle room. Also I think you should push ou=
t the
> patches changing driver names together with your platform code (and n=
ot
> through subsystem trees), otheriwse there will be a period when drive=
rs
> stop binding to your devices. Just make sure you get Acks from the
> maintainers and you should be set.

Sir, good idea, Can the patch be merged into my platform patch and
submit Russell's list?
I had hoped that this patches and platform patches could appear at the
same time in 2.6.32-rc1,
so ,regarding miss binding ,there 's no likelihood of it happening.
 It should be so=EF=BC=9F

> And please adjust the Kconfig entries to mention the other chipsets a=
s
> well.

Ok. thanks!

> --
> Dmitry
>



--=20
Wan z.s
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
