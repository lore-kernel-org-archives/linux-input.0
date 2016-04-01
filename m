From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: Re: gpio irqchip initialization race
Date: Fri, 01 Apr 2016 14:45:17 +0200
Message-ID: <19734973.Q0xUTsGU7P@ws-stein>
References: <44236018.b6N0xPzKYW@ws-stein> <1587936.Xd43Z6OAxQ@ws-stein> <CACRpkdYeMdUtqizXGFzLDwbiL7=xDM+tt0kQU5S166AL13Y_1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from webbox1416.server-home.net ([77.236.96.61]:32794 "EHLO
	webbox1416.server-home.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757259AbcDAMp1 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 1 Apr 2016 08:45:27 -0400
In-Reply-To: <CACRpkdYeMdUtqizXGFzLDwbiL7=xDM+tt0kQU5S166AL13Y_1Q@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Alexandre Courbot <gnurou@gmail.com>, Linux Input <linux-input@vger.kernel.org>

On Friday 01 April 2016 13:29:14, Linus Walleij wrote:
> On Fri, Apr 1, 2016 at 10:56 AM, Alexander Stein
> 
> <alexander.stein@systec-electronic.com> wrote:
> > [Me]
> > 
> >> And in this case (if gpio_keys handle -EPROBE_DEFER gracefully)
> >> all should be fine with my oneliner patch.
> >> 
> >> I am more uncertain about the -EINVAL (-22) we might need some
> >> more analysis there.
> > 
> > I did 10 runs and got the following results:
> >> 3x  gpio-keys user_sw: Unable to claim irq 0; error -22
> >> 2x  gpio-keys user_sw: Unable to get irq number for GPIO 376, error -517
> >> 5x  ok
> > 
> > So, for one gpio-keys seems not to handle -EPROBE_DEFER gracefully
> 
> After reading the code the only problem seems to be that it prints that
> error. A small patch to silence that print should fix it then, can you
> confirm that in these cases the gpio-keys are retried later?

Ah, yes. You're right. I just checked for the error messages, but not if the 
device are actually absent. I just had a start where a (different) gpio-keys 
device failed with error -517 but is available when loggin in. So it really is 
just fix to silence on -DEFER_PROBE.

Best regards,
Alexander

