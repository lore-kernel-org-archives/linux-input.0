From: Yufeng Shen <miletus@chromium.org>
Subject: Re: ATMEL MXT224 Touch Controller
Date: Tue, 5 Jun 2012 16:47:59 -0400
Message-ID: <CAPDwgkNs6qJ7Q2PiONM1XJiTk03RGR9vuAVKVWPvp5CFu7+rLQ@mail.gmail.com>
References: <CAKdam56qoB4uKg4_ZyOqnz=Go3Th0uVUF=xSefdTdeMGqS5JxQ@mail.gmail.com>
	<CAGS+omAn5_hGbbD1A=vpEOJRaaFc8v0BaDK10E+dt=ZgT4h-Bw@mail.gmail.com>
	<CAKdam54qJBkPQ7kU0pfQy_wqr1iNtioEzJunfxE3xVfdZAKdOA@mail.gmail.com>
	<4FCE6107.8080609@itdev.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:45550 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751562Ab2FEUsB (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 5 Jun 2012 16:48:01 -0400
Received: by weyu7 with SMTP id u7so3860485wey.19
        for <linux-input@vger.kernel.org>; Tue, 05 Jun 2012 13:48:00 -0700 (PDT)
In-Reply-To: <4FCE6107.8080609@itdev.co.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Poddar, Sourav" <sourav.poddar@ti.com>
Cc: Daniel Kurtz <djkurtz@chromium.org>, linux-input@vger.kernel.org, Felipe Balbi <balbi@ti.com>, "Tiwari, Atul" <Atul.Tiwari@atmel.com>, "Bowens, Alan" <Alan.Bowens@atmel.com>, Nick Dyer <nick.dyer@itdev.co.uk>

On Tue, Jun 5, 2012 at 3:41 PM, Nick Dyer <nick.dyer@itdev.co.uk> wrote:
>> The issue which I am facing is that there are many interrupts that comes
>> during the probe and it keeps coming after bootup even if I dont touch
>> the touch panel.
>
> It sounds like your configuration may need tuning.
>

Your platform may have too much interfering noise that causes false touch
reports.

>> One point which I want to clarify is the use of the RESET pin in the
>> controller. If I dont do a "RESET", the probe fails at the first i2c
>> read/write. I am doing this reset of the touchscreen controller in my
>> board file by the use of a particular gpio. Are you also doing a RESET
>
> Try putting in a delay before the first read, eg 500ms. It may be that the
> chip is not ready, it takes some time to settle after power on.
>
>> I saw a lot of patches from you on this driver, which are not there in
>> mainline yet. Are you using any local patches also?
>
> Daniel does have some other stuff that hasn't been merged yet.
>
> You will also find some official atmel kernel updates, and some useful
> utilities here:
> https://github.com/atmel-maxtouch
>
> It would be desirable to push this work upstream, I don't know of any
> manufacturer which is shipping the unchanged mainline kernel, most of them
> have diverged considerably.
>

Chromium port of the atmel_mxt_ts can be found here

http://git.chromium.org/gitweb/?p=chromiumos/third_party/kernel.git;a=blob;f=drivers/input/touchscreen/atmel_mxt_ts.c;h=f11b3c46f82de8fea5a82674ef14e51801e8e3f5;hb=refs/heads/chromeos-3.4


>> Is it possible for you to share your touchscreen configuration
>> parameters as there might be some parameters which I might be
>> configuring wrong?
>>

Open source sample of 224e/s configuration data can be found here
http://git.chromium.org/gitweb/?p=chromiumos/third_party/kernel.git;a=blob;f=drivers/platform/x86/chromeos_laptop.c;h=8cec113768a46313b612c0fd0155ddd2bdd389fb;hb=refs/heads/chromeos-3.4

>> Any pointer on above point will be really helpful.
>
> I don't know what platform you are working on, but if you contact your
> Atmel sales representatives they can provide you with the protocol guide
> documentation on the tuning parameters. It generally requires an NDA.
>
> cheers
> --
> Nick Dyer
> Software Engineer, ITDev Ltd
> Hardware and Software Development Consultancy
> Website: http://www.itdev.co.uk
