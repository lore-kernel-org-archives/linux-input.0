From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [RFC PATCH] Input: tm2-touchkey - add hardware dependency
Date: Mon, 24 Apr 2017 20:49:32 +0200
Message-ID: <20170424204932.7672d2a3@endymion>
References: <20170424094231.435f82de@endymion>
        <CAJKOXPc6EW-yF923_TfK56ukutF6HtCs=odbtCBVTFbHq8WL+g@mail.gmail.com>
        <20170424114841.130cad35@endymion>
        <CAJKOXPdOAkpDNrgk_3Lk+GvTQm8=_e45ydTXUkVFardacJ3PEQ@mail.gmail.com>
        <20170424133414.1395ba3d@endymion>
        <CAJKOXPdSTyygm3MAP0EjVm8QWM3aC_M_DGnTVcBMWNUtwhSjqw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:43390 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1172983AbdDXStm (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 24 Apr 2017 14:49:42 -0400
In-Reply-To: <CAJKOXPdSTyygm3MAP0EjVm8QWM3aC_M_DGnTVcBMWNUtwhSjqw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-input@vger.kernel.org, Jaechul Lee <jcsing.lee@samsung.com>, Beomho Seo <beomho.seo@samsung.com>, Javier Martinez Canillas <javier@osg.samsung.com>, Andi Shyti <andi.shyti@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Rob Herring <robh@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

On Mon, 24 Apr 2017 13:56:06 +0200, Krzysztof Kozlowski wrote:
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
> compile testing of everything, not selecting "soft dependencies".

Think again and you'll realize this is exactly the same.

> It
> allows you to build kernel which will not even work in certain cases.

This is an extreme theoretical case, which has nothing to do with the
problem at hand.

> Also it does not bring any information about wanted or unwanted links
> - like "imply".

I have no idea what you mean here, sorry.

> > To be honest, I have also considered the possibility of a dedicated
> > keyword to express these "intended hardware target" soft dependencies.
> > Maybe it would make things clearer. But I never had the time to look
> > into it. Feel free to propose something if you are interested.
> 
> Workaround might be using default = N, unless ARCH_EXYNOS. Something like:
> default y if ARCH_EXYNOS

Maybe this is a good idea, maybe not, I don't know as I am not familiar
with this platform nor the ARM world in general. What I am sure of is
that this has nothing to do with the problem I was originally
discussing. I want to change the visibility on non-Exynos build, you
propose to change the default on Exynos builds. That's not helping (not
me, at least.)

-- 
Jean Delvare
SUSE L3 Support
