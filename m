From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [RFC PATCH] Input: tm2-touchkey - add hardware dependency
Date: Mon, 24 Apr 2017 20:57:42 +0200
Message-ID: <20170424185742.vpgublaincdc5keb@kozik-lap>
References: <20170424094231.435f82de@endymion>
 <CAJKOXPc6EW-yF923_TfK56ukutF6HtCs=odbtCBVTFbHq8WL+g@mail.gmail.com>
 <20170424114841.130cad35@endymion>
 <CAJKOXPdOAkpDNrgk_3Lk+GvTQm8=_e45ydTXUkVFardacJ3PEQ@mail.gmail.com>
 <20170424133414.1395ba3d@endymion>
 <CAJKOXPdSTyygm3MAP0EjVm8QWM3aC_M_DGnTVcBMWNUtwhSjqw@mail.gmail.com>
 <20170424204932.7672d2a3@endymion>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33939 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1173926AbdDXS5r (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 24 Apr 2017 14:57:47 -0400
Received: by mail-wm0-f68.google.com with SMTP id z129so19689502wmb.1
        for <linux-input@vger.kernel.org>; Mon, 24 Apr 2017 11:57:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170424204932.7672d2a3@endymion>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>
Cc: linux-input@vger.kernel.org, Jaechul Lee <jcsing.lee@samsung.com>, Beomho Seo <beomho.seo@samsung.com>, Javier Martinez Canillas <javier@osg.samsung.com>, Andi Shyti <andi.shyti@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Rob Herring <robh@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

On Mon, Apr 24, 2017 at 08:49:32PM +0200, Jean Delvare wrote:
> On Mon, 24 Apr 2017 13:56:06 +0200, Krzysztof Kozlowski wrote:
> > On Mon, Apr 24, 2017 at 1:34 PM, Jean Delvare <jdelvare@suse.de> wrote:
> > > On Mon, 24 Apr 2017 11:58:09 +0200, Krzysztof Kozlowski wrote:
> > >> On Mon, Apr 24, 2017 at 11:48 AM, Jean Delvare <jdelvare@suse.de> wrote:
> > >> > On Mon, 24 Apr 2017 10:00:32 +0200, Krzysztof Kozlowski wrote:
> > > You are a bit late to the party I am afraid. COMPILE_TEST was
> > > introduced for this very usage 4 years ago and I count 760 occurrences
> > > of it. Not as many as I would like but I think this is going in the
> > > right direction.
> > 
> > That is not the purpose of COMPILE_TEST. It serves only to allow
> > compile testing of everything, not selecting "soft dependencies".
> 
> Think again and you'll realize this is exactly the same.

No, the purpose of COMPILE_TEST is to build everything whenever it is
possible. Regardless if it is reasonable or not. For example without OF
some drivers will not be able to bind but we can build them for build
coverage (and static checkers coverage). That is the goal.

However you want to limit the driver because of specific board existing
in mainline (have you considered out of tree boards?). That is totally
different meaning and use case.

> > It
> > allows you to build kernel which will not even work in certain cases.
> 
> This is an extreme theoretical case, which has nothing to do with the
> problem at hand.

That is the effect of COMPILE_TEST for which it was designed... but you
want to use it in different way.

> 
> > Also it does not bring any information about wanted or unwanted links
> > - like "imply".
> 
> I have no idea what you mean here, sorry.

The depends/select/imply bring an information to the user about
relationship between the Kconfig symbols.

COMPILE_TEST does not bring such relationship.

> 
> > > To be honest, I have also considered the possibility of a dedicated
> > > keyword to express these "intended hardware target" soft dependencies.
> > > Maybe it would make things clearer. But I never had the time to look
> > > into it. Feel free to propose something if you are interested.
> > 
> > Workaround might be using default = N, unless ARCH_EXYNOS. Something like:
> > default y if ARCH_EXYNOS
> 
> Maybe this is a good idea, maybe not, I don't know as I am not familiar
> with this platform nor the ARM world in general. What I am sure of is
> that this has nothing to do with the problem I was originally
> discussing. I want to change the visibility on non-Exynos build, you
> propose to change the default on Exynos builds. That's not helping (not
> me, at least.)

First of all, I am not changing the defaults. Second, you asked for a
hint of a better solution and now you are complaining that you do not
like it... okay, as you wish.

The other way is to introduce a new soft dependency called whatever you
like to (e.g. "usable on").

But depends and COMPILE_TEST are not for that purpose.

Best regards,
Krzysztof

