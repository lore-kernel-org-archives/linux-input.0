From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [RFC PATCH] Input: tm2-touchkey - add hardware dependency
Date: Tue, 25 Apr 2017 10:28:09 -0700
Message-ID: <20170425172809.GC30843@dtor-ws>
References: <CGME20170424074240epcas3p2f90e0507afab25e9bfa48fe564936198@epcas3p2.samsung.com>
 <20170424094231.435f82de@endymion>
 <20170425022817.kee4h4wje3dzeilq@gangnam.samsung>
 <20170425115500.6d5c8bee@endymion>
 <20170425110056.5aw5ce6b74z6txl2@gangnam.samsung>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f50.google.com ([74.125.83.50]:36455 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1952096AbdDYR2N (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 25 Apr 2017 13:28:13 -0400
Received: by mail-pg0-f50.google.com with SMTP id g2so31456791pge.3
        for <linux-input@vger.kernel.org>; Tue, 25 Apr 2017 10:28:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170425110056.5aw5ce6b74z6txl2@gangnam.samsung>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andi Shyti <andi.shyti@samsung.com>
Cc: Jean Delvare <jdelvare@suse.de>, linux-input@vger.kernel.org, Jaechul Lee <jcsing.lee@samsung.com>, Beomho Seo <beomho.seo@samsung.com>, Javier Martinez Canillas <javier@osg.samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>

On Tue, Apr 25, 2017 at 08:00:56PM +0900, Andi Shyti wrote:
> Hi Jean,
> 
> > > On Mon, Apr 24, 2017 at 09:42:31AM +0200, Jean Delvare wrote:
> > > > The tm2-touchkey driver is only useful on specific platforms. Add the
> > > > missing hardware dependency so that the driver is not proposed on
> > > > systems where the device does not exist.
> > > 
> > > I'm sorry, I don't see any connection between Exynos and the
> > > TM2-touchkey (which is manufactured by cypress, btw).
> > > 
> > > It surely does have connections with the TM2 board which happens
> > > to have an Exynos SoC, but that cannot be fixed from the Kconfig.
> > 
> > Thanks for your constructive contribution to this discussion.
> > 
> > The KEYBOARD_TM2_TOUCHKEY option name, description and help text as
> > well as the driver name all make it sound highly hardware specific. If
> > this driver is for a "generic" part from Cypress then the driver should
> > be renamed and the Kconfig option name and description should be
> > updated to reflect that. The help text should also first mention the
> > chip vendor and name, and only then mention that it is used on the
> > Exynos5433 TM2 board.
> > 
> > That being said, I took a look at the driver, and while "cypress" is
> > indeed being mentioned as the vendor name, the chip name itself is
> > referred to as "tm2-touchkey", which isn't generic at all. You can't
> > identify the hardware under the name "tm2 touchkey" everywhere in the
> > driver and expect people to understand it is not board specific.
> > 
> > So it really boils down to this question: is that chip a generic part
> > from Cypress, and if so, what is the real part number? Or was is
> > designed privately by Cypress specifically for Samsung for this one
> > board (and possibly others to come)?
> 
> I knew that the naming was bringing confusion and we had a
> previous discussion about it with Chanwoo [1].
> 
> This is indeed a generic device from Cypress. The driver has been
> ported from Android's Kernel [2]; it says that the device
> part is cy8cmbr3xxx, but the datasheet [3] doesn't have any
> connection with what the TM2 board has (i.e. the registers don't
> match). That's why we suspected that (as you said) this might be
> a touch key sensor specifically designed for the TM2 board.
> 
> Cypress was not that helpful.
> 
> The alternative was to not provide support, but it didn't look
> right.

So this looks like we are dealing with a device designed for a specific
board, but not architecture or board-specific. Similar to
atmel_captouch, ims_pcu, or all drivers living in platform/x86 (I
understand that they do not bother Jean simply because he cares mostly
about x86 and, with SUSE being generic distro, he needs to enable all
the drivers there anyway, but a person configuring "their" kernel still
has to go and consider all options).

I am all for adding dependencies for drivers that are parts of
particular SoCs (you probably not going to have Broardcom IPROC
touchscreen on your x86 device), but external to SoC peripherals is a
different story.

Thanks.

-- 
Dmitry
