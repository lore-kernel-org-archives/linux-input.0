From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [RFC PATCH] Input: tm2-touchkey - add hardware dependency
Date: Mon, 24 Apr 2017 10:09:53 -0700
Message-ID: <20170424170953.GB12374@dtor-ws>
References: <20170424094231.435f82de@endymion>
 <CAJKOXPc6EW-yF923_TfK56ukutF6HtCs=odbtCBVTFbHq8WL+g@mail.gmail.com>
 <20170424114841.130cad35@endymion>
 <CAJKOXPdOAkpDNrgk_3Lk+GvTQm8=_e45ydTXUkVFardacJ3PEQ@mail.gmail.com>
 <20170424133414.1395ba3d@endymion>
 <CAJKOXPdSTyygm3MAP0EjVm8QWM3aC_M_DGnTVcBMWNUtwhSjqw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36038 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S975315AbdDXRJ5 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 24 Apr 2017 13:09:57 -0400
Received: by mail-pf0-f193.google.com with SMTP id v14so4031387pfd.3
        for <linux-input@vger.kernel.org>; Mon, 24 Apr 2017 10:09:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAJKOXPdSTyygm3MAP0EjVm8QWM3aC_M_DGnTVcBMWNUtwhSjqw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Jean Delvare <jdelvare@suse.de>, linux-input@vger.kernel.org, Jaechul Lee <jcsing.lee@samsung.com>, Beomho Seo <beomho.seo@samsung.com>, Javier Martinez Canillas <javier@osg.samsung.com>, Andi Shyti <andi.shyti@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Rob Herring <robh@kernel.org>

On Mon, Apr 24, 2017 at 01:56:06PM +0200, Krzysztof Kozlowski wrote:
> On Mon, Apr 24, 2017 at 1:34 PM, Jean Delvare <jdelvare@suse.de> wrote:
> > On Mon, 24 Apr 2017 11:58:09 +0200, Krzysztof Kozlowski wrote:
> >> On Mon, Apr 24, 2017 at 11:48 AM, Jean Delvare <jdelvare@suse.de> wrote:
> >> > On Mon, 24 Apr 2017 10:00:32 +0200, Krzysztof Kozlowski wrote:
> >> > > On Mon, Apr 24, 2017 at 9:42 AM, Jean Delvare <jdelvare@suse.de> wrote:
> >> > > > The tm2-touchkey driver is only useful on specific platforms. Add the
> >> > > > missing hardware dependency so that the driver is not proposed on
> >> > > > systems where the device does not exist.
> >> > >
> >> > > Although the device exists in only two upstreamed Exynos boards but
> >> > > there is no hardware dependency on Exynos. The hardware does not
> >> > > depend on Exynos.
> >> >
> >> > I understand that, and this is the reason why there was no dependency
> >> > expressed so far. But this is irrelevant to the problem I am trying to
> >> > solve, which is that people configuring a kernel for platforms where
> >> > this device is known to NOT exist shouldn't be bothered with a question
> >> > about its driver. This is what I meant with "hardware dependency" but
> >> > you can call it "hardware focus" or "intended hardware target" if you
> >> > prefer.
> >>
> >> You need a depends-like version of "imply" keyword. I think it is
> >> worth adding it to solve such problems and help in configuring the
> >> system. However I am not convinced that "depends" should be used in
> >> the meaning of "intended use".
> >
> > You are a bit late to the party I am afraid. COMPILE_TEST was
> > introduced for this very usage 4 years ago and I count 760 occurrences
> > of it. Not as many as I would like but I think this is going in the
> > right direction.
> 
> That is not the purpose of COMPILE_TEST. It serves only to allow
> compile testing of everything, not selecting "soft dependencies". It
> allows you to build kernel which will not even work in certain cases.
> 
> Also it does not bring any information about wanted or unwanted links
> - like "imply".
> 
> > To be honest, I have also considered the possibility of a dedicated
> > keyword to express these "intended hardware target" soft dependencies.
> > Maybe it would make things clearer. But I never had the time to look
> > into it. Feel free to propose something if you are interested.
> 
> Workaround might be using default = N, unless ARCH_EXYNOS. Something like:
> default y if ARCH_EXYNOS

This would strongly imply that the device is available on all Exynos
boards. I am fairly certain that our Chromebooks, for example, do not
have it.

Besides, I do not see what is wrong with driver being offered on a
platform that does not have it. This happens all the time. Consider I2C
stuff:

config I2C_I801
	tristate "Intel 82801 (ICH/PCH)"
	depends on PCI
	select CHECK_SIGNATURE if X86 && DMI
	select I2C_SMBUS

This is an X86 device, but is offered everywhere where we have PCI.

Thanks.

-- 
Dmitry
