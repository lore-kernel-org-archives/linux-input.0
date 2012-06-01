From: "Poddar, Sourav" <sourav.poddar@ti.com>
Subject: Re: ATMEL MXT224 Touch Controller
Date: Fri, 1 Jun 2012 16:06:13 +0530
Message-ID: <CAKdam54qJBkPQ7kU0pfQy_wqr1iNtioEzJunfxE3xVfdZAKdOA@mail.gmail.com>
References: <CAKdam56qoB4uKg4_ZyOqnz=Go3Th0uVUF=xSefdTdeMGqS5JxQ@mail.gmail.com>
	<CAGS+omAn5_hGbbD1A=vpEOJRaaFc8v0BaDK10E+dt=ZgT4h-Bw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:33347 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759015Ab2FAKgP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 1 Jun 2012 06:36:15 -0400
Received: by bkcjm2 with SMTP id jm2so2162301bkc.34
        for <linux-input@vger.kernel.org>; Fri, 01 Jun 2012 03:36:13 -0700 (PDT)
In-Reply-To: <CAGS+omAn5_hGbbD1A=vpEOJRaaFc8v0BaDK10E+dt=ZgT4h-Bw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Kurtz <djkurtz@chromium.org>, Yufeng Shen <miletus@chromium.org>
Cc: linux-input@vger.kernel.org, Felipe Balbi <balbi@ti.com>

Hi Daniel,

On Thu, May 31, 2012 at 12:04 AM, Daniel Kurtz <djkurtz@chromium.org> w=
rote:
>
>
> On Tue, May 29, 2012 at 7:16 AM, Poddar, Sourav <sourav.poddar@ti.com=
>
> wrote:
>>
>> Hi,
>>
>> Did anyone have tried using atmel touchscreen controller
>> =A0driver (drivers/input/touchscreen/atmel_mxt_ts.c) for atmel mxt22=
4 chip?
>

>
> Yes. =A0It works pretty well for us.
>
Thanks for the reply.

The issue which I am facing is that there are many interrupts that come=
s during
the probe and it keeps coming after bootup even if I dont touch the tou=
ch panel.

One point which I want to clarify is the use of the RESET pin in the
controller. If I dont do a "RESET", the probe fails at the first i2c re=
ad/write.
I am doing this reset of the touchscreen controller in my board file
by the use of
a particular gpio. Are you also doing a RESET ?

I saw a lot of patches from you on this driver, which are not there in
mainline yet.
Are you using any local patches also?

Is it possible for you to share your touchscreen configuration
parameters as there
might be some parameters which I might be configuring wrong?

Any pointer on above point will be really helpful.

~Sourav


>>
>>
>> ~Sourav
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-inpu=
t" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
