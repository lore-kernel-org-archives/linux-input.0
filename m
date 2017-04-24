From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [RFC PATCH] Input: tm2-touchkey - add hardware dependency
Date: Mon, 24 Apr 2017 11:48:41 +0200
Message-ID: <20170424114841.130cad35@endymion>
References: <20170424094231.435f82de@endymion>
        <CAJKOXPc6EW-yF923_TfK56ukutF6HtCs=odbtCBVTFbHq8WL+g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:44752 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1168142AbdDXJsp (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 24 Apr 2017 05:48:45 -0400
In-Reply-To: <CAJKOXPc6EW-yF923_TfK56ukutF6HtCs=odbtCBVTFbHq8WL+g@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-input@vger.kernel.org, Jaechul Lee <jcsing.lee@samsung.com>, Beomho Seo <beomho.seo@samsung.com>, Javier Martinez Canillas <javier@osg.samsung.com>, Andi Shyti <andi.shyti@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Rob Herring <robh@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

Hi Krzysztof,

Thanks for your quick answer.

On Mon, 24 Apr 2017 10:00:32 +0200, Krzysztof Kozlowski wrote:
> On Mon, Apr 24, 2017 at 9:42 AM, Jean Delvare <jdelvare@suse.de> wrote:
> > The tm2-touchkey driver is only useful on specific platforms. Add the
> > missing hardware dependency so that the driver is not proposed on
> > systems where the device does not exist.
> 
> Although the device exists in only two upstreamed Exynos boards but
> there is no hardware dependency on Exynos. The hardware does not
> depend on Exynos.

I understand that, and this is the reason why there was no dependency
expressed so far. But this is irrelevant to the problem I am trying to
solve, which is that people configuring a kernel for platforms where
this device is known to NOT exist shouldn't be bothered with a question
about its driver. This is what I meant with "hardware dependency" but
you can call it "hardware focus" or "intended hardware target" if you
prefer. This is still expressed in terms of dependency in Kconfig terms
(but a soft one, thus the || COMPILE_TEST.)

> > Signed-off-by: Jean Delvare <jdelvare@suse.de>
> > Fixes: 72d1f2346ded ("Input: tm2-touchkey - add touchkey driver support for TM2")
> 
> I do not see a bug to fix. Even if we agree that driver building
> should be limited to Exynos then definitely there is no missing
> dependency to fix.

I can drop the Fixes tag, no problem.

> > Cc: Jaechul Lee <jcsing.lee@samsung.com>
> > Cc: Beomho Seo <beomho.seo@samsung.com>
> > Cc: Javier Martinez Canillas <javier@osg.samsung.com>
> > Cc: Andi Shyti <andi.shyti@samsung.com>
> > Cc: Chanwoo Choi <cw00.choi@samsung.com>
> > Cc: Krzysztof Kozlowski <krzk@kernel.org>
> > Cc: Rob Herring <robh@kernel.org>
> > Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > ---
> > Note: I am not familar with the hardware in question so I'm not sure
> > if this is the right dependency to add, or if ARM64 would be more
> > appropriate, or something else, or a combination thereof. Please
> > advise.
> >
> >  drivers/input/keyboard/Kconfig |    1 +
> >  1 file changed, 1 insertion(+)
> >
> > --- linux-4.11-rc8.orig/drivers/input/keyboard/Kconfig  2017-04-03 02:23:54.000000000 +0200
> > +++ linux-4.11-rc8/drivers/input/keyboard/Kconfig       2017-04-24 09:26:43.314252700 +0200
> > @@ -670,6 +670,7 @@ config KEYBOARD_TM2_TOUCHKEY
> >         tristate "TM2 touchkey support"
> >         depends on I2C
> >         depends on LEDS_CLASS
> > +       depends on ARCH_EXYNOS || COMPILE_TEST
> >         help
> >           Say Y here to enable device driver for tm2-touchkey with
> >           LED control for the Exynos5433 TM2 board.
> >
> >
> > --
> > Jean Delvare
> > SUSE L3 Support
