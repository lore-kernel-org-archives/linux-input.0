From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [RFC PATCH] Input: tm2-touchkey - add hardware dependency
Date: Tue, 25 Apr 2017 10:58:36 +0200
Message-ID: <20170425105836.1e7be88c@endymion>
References: <20170424094231.435f82de@endymion>
        <CAJKOXPc6EW-yF923_TfK56ukutF6HtCs=odbtCBVTFbHq8WL+g@mail.gmail.com>
        <20170424114841.130cad35@endymion>
        <CAJKOXPdOAkpDNrgk_3Lk+GvTQm8=_e45ydTXUkVFardacJ3PEQ@mail.gmail.com>
        <20170424133414.1395ba3d@endymion>
        <CAJKOXPdSTyygm3MAP0EjVm8QWM3aC_M_DGnTVcBMWNUtwhSjqw@mail.gmail.com>
        <20170424170953.GB12374@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:41573 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1176999AbdDYI6k (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 25 Apr 2017 04:58:40 -0400
In-Reply-To: <20170424170953.GB12374@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, linux-input@vger.kernel.org, Jaechul Lee <jcsing.lee@samsung.com>, Beomho Seo <beomho.seo@samsung.com>, Javier Martinez Canillas <javier@osg.samsung.com>, Andi Shyti <andi.shyti@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Rob Herring <robh@kernel.org>

Hi Dmitry,

On Mon, 24 Apr 2017 10:09:53 -0700, Dmitry Torokhov wrote:
> On Mon, Apr 24, 2017 at 01:56:06PM +0200, Krzysztof Kozlowski wrote:
> > >> > On Mon, 24 Apr 2017 10:00:32 +0200, Krzysztof Kozlowski wrote:
> > >> > > On Mon, Apr 24, 2017 at 9:42 AM, Jean Delvare <jdelvare@suse.de> wrote:
> > >> > > > The tm2-touchkey driver is only useful on specific platforms. Add the
> > >> > > > missing hardware dependency so that the driver is not proposed on
> > >> > > > systems where the device does not exist.
> > >> > >
> > >> > > Although the device exists in only two upstreamed Exynos boards but
> > >> > > there is no hardware dependency on Exynos. The hardware does not
> > >> > > depend on Exynos.
> > >> > (...)
> > Workaround might be using default = N, unless ARCH_EXYNOS. Something like:
> > default y if ARCH_EXYNOS
> 
> This would strongly imply that the device is available on all Exynos
> boards. I am fairly certain that our Chromebooks, for example, do not
> have it.
> 
> Besides, I do not see what is wrong with driver being offered on a
> platform that does not have it.

It makes the life of distribution kernel maintainers a lot harder, by
asking them questions that are irrelevant. They may eventually figure
it out and say "no", but it costs them time to investigate each option.
Worst case they will accidentally say yes and bloat their kernel.

> This happens all the time.

That doesn't make it right. The trend is changing, and you should
embrace that change. What was acceptable 10 days ago when we had 7000
kernel options no longer works today with 17000.

> Consider I2C stuff:

Trying to make it personal? ;-)

> config I2C_I801
> 	tristate "Intel 82801 (ICH/PCH)"
> 	depends on PCI
> 	select CHECK_SIGNATURE if X86 && DMI
> 	select I2C_SMBUS
> 
> This is an X86 device, but is offered everywhere where we have PCI.

In fact the 82801 family of south bridges is not limited to X86, it can
be found on IA64 hardware as well. It was discussed here:

https://patchwork.ozlabs.org/patch/635865/

and as you can see I would have liked the hardware dependency to be
added, it's Andy Shevchenko who declined :-(

-- 
Jean Delvare
SUSE L3 Support
