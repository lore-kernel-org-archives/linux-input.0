From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [RFC PATCH] Input: tm2-touchkey - add hardware dependency
Date: Wed, 3 May 2017 11:42:23 +0200
Message-ID: <20170503114223.1c3e08f7@endymion>
References: <CGME20170424074240epcas3p2f90e0507afab25e9bfa48fe564936198@epcas3p2.samsung.com>
        <20170424094231.435f82de@endymion>
        <20170425022817.kee4h4wje3dzeilq@gangnam.samsung>
        <20170425115500.6d5c8bee@endymion>
        <20170425110056.5aw5ce6b74z6txl2@gangnam.samsung>
        <20170425172809.GC30843@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:48852 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752289AbdECJm1 (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 3 May 2017 05:42:27 -0400
In-Reply-To: <20170425172809.GC30843@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Andi Shyti <andi.shyti@samsung.com>, linux-input@vger.kernel.org, Jaechul Lee <jcsing.lee@samsung.com>, Beomho Seo <beomho.seo@samsung.com>, Javier Martinez Canillas <javier@osg.samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>

Hi Dmitry,

On Tue, 25 Apr 2017 10:28:09 -0700, Dmitry Torokhov wrote:
> So this looks like we are dealing with a device designed for a specific
> board, but not architecture or board-specific. Similar to
> atmel_captouch, ims_pcu, or all drivers living in platform/x86 (I
> understand that they do not bother Jean simply because he cares mostly
> about x86 and, with SUSE being generic distro, he needs to enable all
> the drivers there anyway, but a person configuring "their" kernel still
> has to go and consider all options).

Actually they do bother me at times (some of them can't be built as
modules.) Also while I indeed care mostly about x86, openSUSE supports
various other architectures, so I would be equally worried about
x86-specific drivers being proposed on these architectures, for
example. The only difference is that I typically do not catch these
myself.

> I am all for adding dependencies for drivers that are parts of
> particular SoCs (you probably not going to have Broardcom IPROC
> touchscreen on your x86 device), but external to SoC peripherals is a
> different story.

I understand that there is no direct relation between this TM2 touchkey
driver and Exynos as a platform.

My reasoning is as follows: given that at this point this driver is
only useful on the Samsung TM2 board, it should only be presented to
users configuring a kernel for that board. Then the question becomes:
what other kernel option will definitely be enabled on any kernel
running on that board? As the TM2 is based on an Exynos5433 SoC,
ARCH_EXYNOS will have to be enabled, so it seems a convenient way to
limit the visibility of KEYBOARD_TM2_TOUCHKEY.

There are certainly other options that will also be always enabled for
a TM2 board kernel, but ARCH_EXYNOS seems to be a good choice because
it is both generic enough that it doesn't need to be changed if a
variation of the TM2 board is released using a slightly different SoC,
and specific enough that we will skip the question for most users.

The alternative would be to add another option SAMSUNG_TM2 ("Support for
the Samsung TM2 board"), just to let KEYBOARD_TM2_TOUCHKEY depend on it,
but that's really only moving the problem, as there is no point in
asking people about SAMSUNG_TM2 if they are building a kernel that can't
support it anyway. And while I agree it would be somewhat cleaner to
have KEYBOARD_TM2_TOUCHKEY which depends on SAMSUNG_TM2 and SAMSUNG_TM2
which depends on ARCH_EXYNOS, it also seems overly complex to me for no
benefit.

Therefore I still believe that making KEYBOARD_TM2_TOUCHKEY depend on
ARCH_EXYNOS || COMPILE_TEST makes sense from a practical perspective.

-- 
Jean Delvare
SUSE L3 Support
