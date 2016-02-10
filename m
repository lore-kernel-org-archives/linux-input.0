From: Raveendra Padasalagi <raveendra.padasalagi@broadcom.com>
Subject: RE: [PATCH 1/3] input: cygnus-update touchscreen dt node document
Date: Wed, 10 Feb 2016 10:24:43 +0530
Message-ID: <979fb4dc5fba643a6780759d2a13530a@mail.gmail.com>
References: <1455008277-8312-1-git-send-email-raveendra.padasalagi@broadcom.com>
 <1455008277-8312-2-git-send-email-raveendra.padasalagi@broadcom.com>
 <2631849.GeOulu78vx@wuerfel> <3b53af6b6c6735d10cb88518c8b8a0ae@mail.gmail.com>
 <20160209174351.GC40460@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yk0-f169.google.com ([209.85.160.169]:35035 "EHLO
	mail-yk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756484AbcBJEyp (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 9 Feb 2016 23:54:45 -0500
Received: by mail-yk0-f169.google.com with SMTP id r207so3551785ykd.2
        for <linux-input@vger.kernel.org>; Tue, 09 Feb 2016 20:54:45 -0800 (PST)
In-Reply-To: <20160209174351.GC40460@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Russell King <linux@arm.linux.org.uk>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Jonathan Richardson <jonathar@broadcom.com>, Jon Mason <jonmason@broadcom.com>, Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com

> -----Original Message-----
> From: Dmitry Torokhov [mailto:dmitry.torokhov@gmail.com]
> Sent: 09 February 2016 23:14
> To: Raveendra Padasalagi
> Cc: Arnd Bergmann; Russell King; devicetree@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; linux-input@vger.kernel.org; Rob Herring;
Pawel
> Moll; Mark Rutland; Ian Campbell; Kumar Gala; Jonathan Richardson; Jon
> Mason; Florian Fainelli; Ray Jui; Scott Branden;
linux-kernel@vger.kernel.org;
> bcm-kernel-feedback-list@broadcom.com
> Subject: Re: [PATCH 1/3] input: cygnus-update touchscreen dt node
document
>
> On Tue, Feb 09, 2016 at 10:25:26PM +0530, Raveendra Padasalagi wrote:
> > > -----Original Message-----
> > > From: Arnd Bergmann [mailto:arnd@arndb.de]
> > > Sent: 09 February 2016 16:34
> > > To: Raveendra Padasalagi
> > > Cc: Dmitry Torokhov; Russell King; devicetree@vger.kernel.org;
> > linux-arm-
> > > kernel@lists.infradead.org; linux-input@vger.kernel.org; Rob
> > > Herring;
> > Pawel
> > > Moll; Mark Rutland; Ian Campbell; Kumar Gala; Jonathan Richardson;
> > > Jon Mason; Florian Fainelli; Ray Jui; Scott Branden;
> > linux-kernel@vger.kernel.org;
> > > bcm-kernel-feedback-list@broadcom.com
> > > Subject: Re: [PATCH 1/3] input: cygnus-update touchscreen dt node
> > document
> > >
> > > On Tuesday 09 February 2016 14:27:55 Raveendra Padasalagi wrote:
> > > > +
> > > > +One of the below 2 property is mandatory.
> > > > +- ts_syscon: handler of syscon node defining physical base
> > > > +address
> > > > +  of the controller and length of memory mapped region.
> > > > +  If this property is selected please make sure MFD_SYSCON config
> > > > +  is enabled in the defconfig file.
> > > > +or
> > > > +- reg: physical base address of the controller and length of
> > > > +memory
> > > > +  mapped region.
> > > > +
> > > >  - clocks:  The clock provided by the SOC to driver the tsc
> > > >  - clock-name:  name for the clock
> > > >  - interrupts: The touchscreen controller's interrupt @@ -54,12
> > > > +62,16 @@ Optional properties:
> > > >  - touchscreen-inverted-y: Y axis is inverted (boolean)
> > > >
> > > >  Example:
> > > > +       ts_adc_syscon: ts_adc_syscon@0x180a6000 {
> > > > +               compatible = "syscon";
> > > > +               reg = <0x180a6000 0xc30>;
> > > > +       };
> > > >
> > > >         touchscreen: tsc@0x180A6000 {
> > > >                 compatible = "brcm,iproc-touchscreen";
> > > >                 #address-cells = <1>;
> > > >                 #size-cells = <1>;
> > > > -               reg = <0x180A6000 0x40>;
> > > > +               syscon = <&ts_adc_syscon>;
> > > >                 clocks = <&adc_clk>;
> > > >                 clock-names = "tsc_clk";
> > > >                 interrupts = <GIC_SPI 164 IRQ_TYPE_LEVEL_HIGH>;
> > >
> > > This doesn't seem right: For one thing, it's an incompatible binding
> > change which
> > > you should try to avoid.
> >
> > > Worse, the syscon has a name indicating that it really has a
> > > particular
> > function,
> > > but the name is completely generic (just "syscon"). Please add a
> > specific
> > > compatible string identifying the device that owns the registers,
> > > and
> > put any
> > > other associated properties (clocks, interrupts, ...) that are for
> > > that
> > device in
> > > general rather than just the touchscreen in there.
> >
> > By mistake "syscon" name is documented in "touchscreen" label above.
> > In the touchscreen driver code and .dtsi file it's named and used as
> > "ts_syscon".
> > Please refer https://lkml.org/lkml/2016/2/9/71 for the changes.
> > Let me know if this ok. I will correct the documentation in the next
> > patch.
> >
> > > Your changelog text fails to describe why you do this change in the
> > first place,
> > > and why you can't do it in a backward-compatible way, so please
> > > rewrite
> > that
> > > text.
> >
> > Yes, I will update the change log in the next patch.
> >
> > In Cygnus SOC, Touch screen controller registers are shared with ADC
> > and flex timer IP's.
> > Using readl/writel could lead to race condition. So this patch is
> > introduced to take care mutually exclusive access of register's in
> > such a case.
> >
> > In the platform's where touchscreen register's are not shared normal
> > readl/writel could be used.
>
> Are there currently platforms where the registers are not shared? If we
have to
> use regmap to correctly update registers (and thus we need
> syscon) then I wonder if we should even attempt to support direct
register
> access by the driver.

Currently there are no platforms without register sharing, but we would
like to keep
the driver generic enough to take care of future SOC's if comes with
dedicated registers
and same touchscreen IP being re-used.
> >
> > Based on the dt  property entry "reg" or "ts_syscon" register accesses
> > are handled.
> > if "reg" is provided normal readl/writel API's are used to access
> > register's else if "ts_syscon" is provided then syscon API's are used.
>
> If we decide that we still allow register access then please change the
driver so it
> instantiates its own regmap instance in this case instead of doing
checks all the
> time.

Using remap will leads to overhead of locking and unlocking for each
register access
in case if a dedicated register's present in the platform. I think current
implementation
of simple check of regs or remap is better over using regmap read/write
calls with locking
overhead. Let me know your opinion.



> Thanks.
>
> --
> Dmitry
