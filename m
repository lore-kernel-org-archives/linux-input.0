From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [RFC PATCH] Input: tm2-touchkey - add hardware dependency
Date: Tue, 25 Apr 2017 11:37:45 +0200
Message-ID: <20170425113745.17dcb3e8@endymion>
References: <20170424094231.435f82de@endymion>
        <CAJKOXPc6EW-yF923_TfK56ukutF6HtCs=odbtCBVTFbHq8WL+g@mail.gmail.com>
        <20170424114841.130cad35@endymion>
        <CAJKOXPdOAkpDNrgk_3Lk+GvTQm8=_e45ydTXUkVFardacJ3PEQ@mail.gmail.com>
        <20170424133414.1395ba3d@endymion>
        <CAJKOXPdSTyygm3MAP0EjVm8QWM3aC_M_DGnTVcBMWNUtwhSjqw@mail.gmail.com>
        <20170424204932.7672d2a3@endymion>
        <20170424185742.vpgublaincdc5keb@kozik-lap>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:52381 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1758708AbdDYKLK (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 25 Apr 2017 06:11:10 -0400
In-Reply-To: <20170424185742.vpgublaincdc5keb@kozik-lap>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-input@vger.kernel.org, Jaechul Lee <jcsing.lee@samsung.com>, Beomho Seo <beomho.seo@samsung.com>, Javier Martinez Canillas <javier@osg.samsung.com>, Andi Shyti <andi.shyti@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Rob Herring <robh@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

Hi Krzysztof,

I'll try to stay calm but no promise :-D

On Mon, 24 Apr 2017 20:57:42 +0200, Krzysztof Kozlowski wrote:
> On Mon, Apr 24, 2017 at 08:49:32PM +0200, Jean Delvare wrote:
> > On Mon, 24 Apr 2017 13:56:06 +0200, Krzysztof Kozlowski wrote:
> > > On Mon, Apr 24, 2017 at 1:34 PM, Jean Delvare <jdelvare@suse.de> wrote:
> > > > On Mon, 24 Apr 2017 11:58:09 +0200, Krzysztof Kozlowski wrote:
> > > >> On Mon, Apr 24, 2017 at 11:48 AM, Jean Delvare <jdelvare@suse.de> wrote:
> > > > You are a bit late to the party I am afraid. COMPILE_TEST was
> > > > introduced for this very usage 4 years ago and I count 760 occurrences
> > > > of it. Not as many as I would like but I think this is going in the
> > > > right direction.
> > > 
> > > That is not the purpose of COMPILE_TEST. It serves only to allow
> > > compile testing of everything, not selecting "soft dependencies".
> > 
> > Think again and you'll realize this is exactly the same.
> 
> No, the purpose of COMPILE_TEST is to build everything whenever it is
> possible. Regardless if it is reasonable or not. For example without OF
> some drivers will not be able to bind but we can build them for build
> coverage (and static checkers coverage). That is the goal.

I will concede that the short description of COMPILE_TEST ("Compile
also drivers which will not load") can be misleading. It's not only
about "not loading." But if you take a look at the help text, it is
more verbose and accurate:

"Some drivers can be compiled on a different platform than they are
intended to be run on. Despite they cannot be loaded there (or even
when they load they cannot be used due to missing HW support),
developers still, opposing to distributors, might want to build such
drivers to compile-test them.

If you are a developer and want to build everything available, say Y
here. If you are a user/distributor, say N here to exclude useless
drivers to be distributed."

I give you a few minutes to read the whole thing.

Please pay attention to "due to missing HW support", "opposing to
distributors" and "say N here to exclude useless drivers". So, to
summarize, the purpose of COMPILE_TEST is to help distribution kernel
maintainers exclude useless drivers while still allowing a maximum
build testing coverage of such drivers.

What I am trying to do here is to help distribution kernel maintainers
exclude the tm2 touchkey driver from kernel flavors where it would be
useless (this is "depends on ARCH_EXYNOS" in my patch) while not
hurting build test coverage (this is "|| COMPILE_TEST" in my patch.)
Therefore I am clearly using COMPILE_TEST for its intended purpose. QED.

> However you want to limit the driver because of specific board existing
> in mainline (have you considered out of tree boards?). That is totally
> different meaning and use case.

I never mentioned specific boards. I proposed ARCH_EXYNOS, which to the
best of my knowledge is a sub-architecture or platform if you will.
Additionally, if you read my original post again, you will notice that
I explicitly said that I was not certain if it was the most appropriate
"level" of visibility for this driver. What seems clear to me is that
proposing this driver when I build an X86 kernel does not make sense.

> > > (...) It
> > > allows you to build kernel which will not even work in certain cases.
> > 
> > This is an extreme theoretical case, which has nothing to do with the
> > problem at hand.
> 
> That is the effect of COMPILE_TEST for which it was designed...
> but you want to use it in different way.

No. I invite you to read the help text of COMPILE_TEST again. It was
not designed to build kernels which will not work. Nobody needed that.

> (...)
> The depends/select/imply bring an information to the user about
> relationship between the Kconfig symbols.
> 
> COMPILE_TEST does not bring such relationship.

I thank you for trying to clarify what you meant, but even after
reading it 3 times, I still have no idea what you mean. Honestly.

> > > (...)
> > > Workaround might be using default = N, unless ARCH_EXYNOS. Something like:
> > > default y if ARCH_EXYNOS
>
> First of all, I am not changing the defaults.

Oh well, what can I say. I think I'll let you keep arguing with
yourself. This will save me a lot of time to devote to other tasks with
higher chances of success.

> Second, you asked for a
> hint of a better solution and now you are complaining that you do not
> like it... okay, as you wish.

I asked for suggestions on a specific point. Let me quote myself:

"I'm not sure if this is the right dependency to add, or if ARM64
would be more appropriate, or something else (...) Please advise."

I did not ask for a lesson about what COMPILE_TEST is meant for, nor
for suggestions of what the default value should be. I asked for advice
on what the visibility should be.

> The other way is to introduce a new soft dependency called whatever you
> like to (e.g. "usable on").

Again, this may be a good idea that can be discussed, but that keyword
does not exist today, and regular depends + COMPILE_TEST have been used
for the purpose since 2013. Feel free to start a separate discussion
thread about introducing "usable on" as a replacement for COMPILE_TEST,
maybe with a proof of concept, and see what people think about your
idea.

> But depends and COMPILE_TEST are not for that purpose.

... *sigh*.

This is my last reply to you on this topic, as we are clearly running
in circles.

-- 
Jean Delvare
SUSE L3 Support
