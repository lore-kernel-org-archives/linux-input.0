From: Nick Dyer <nick.dyer@itdev.co.uk>
Subject: Re: ATMEL MXT224 Touch Controller
Date: Tue, 05 Jun 2012 12:41:59 -0700
Message-ID: <4FCE6107.8080609@itdev.co.uk>
References: <CAKdam56qoB4uKg4_ZyOqnz=Go3Th0uVUF=xSefdTdeMGqS5JxQ@mail.gmail.com> <CAGS+omAn5_hGbbD1A=vpEOJRaaFc8v0BaDK10E+dt=ZgT4h-Bw@mail.gmail.com> <CAKdam54qJBkPQ7kU0pfQy_wqr1iNtioEzJunfxE3xVfdZAKdOA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from [89.21.227.130] ([89.21.227.130]:50412 "EHLO
	mail.epsilon.itdev.co.uk" rhost-flags-FAIL-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751117Ab2FETmF (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 5 Jun 2012 15:42:05 -0400
In-Reply-To: <CAKdam54qJBkPQ7kU0pfQy_wqr1iNtioEzJunfxE3xVfdZAKdOA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Poddar, Sourav" <sourav.poddar@ti.com>
Cc: Daniel Kurtz <djkurtz@chromium.org>, Yufeng Shen <miletus@chromium.org>, linux-input@vger.kernel.org, Felipe Balbi <balbi@ti.com>, "Tiwari, Atul" <Atul.Tiwari@atmel.com>, "Bowens, Alan" <Alan.Bowens@atmel.com>

> The issue which I am facing is that there are many interrupts that comes
> during the probe and it keeps coming after bootup even if I dont touch
> the touch panel.

It sounds like your configuration may need tuning.

> One point which I want to clarify is the use of the RESET pin in the 
> controller. If I dont do a "RESET", the probe fails at the first i2c
> read/write. I am doing this reset of the touchscreen controller in my
> board file by the use of a particular gpio. Are you also doing a RESET

Try putting in a delay before the first read, eg 500ms. It may be that the
chip is not ready, it takes some time to settle after power on.

> I saw a lot of patches from you on this driver, which are not there in 
> mainline yet. Are you using any local patches also?

Daniel does have some other stuff that hasn't been merged yet.

You will also find some official atmel kernel updates, and some useful
utilities here:
https://github.com/atmel-maxtouch

It would be desirable to push this work upstream, I don't know of any
manufacturer which is shipping the unchanged mainline kernel, most of them
have diverged considerably.

> Is it possible for you to share your touchscreen configuration 
> parameters as there might be some parameters which I might be
> configuring wrong?
> 
> Any pointer on above point will be really helpful.

I don't know what platform you are working on, but if you contact your
Atmel sales representatives they can provide you with the protocol guide
documentation on the tuning parameters. It generally requires an NDA.

cheers
-- 
Nick Dyer
Software Engineer, ITDev Ltd
Hardware and Software Development Consultancy
Website: http://www.itdev.co.uk
