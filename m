From: Raveendra Padasalagi <raveendra.padasalagi@broadcom.com>
Subject: RE: [PATCH 1/3] input: cygnus-update touchscreen dt node document
Date: Tue, 16 Feb 2016 09:54:56 +0530
Message-ID: <766ebcaceac5e04307b48527eaeefb90@mail.gmail.com>
References: <1455008277-8312-1-git-send-email-raveendra.padasalagi@broadcom.com>
 <1455008277-8312-2-git-send-email-raveendra.padasalagi@broadcom.com>
 <2631849.GeOulu78vx@wuerfel> <3b53af6b6c6735d10cb88518c8b8a0ae@mail.gmail.com>
 <20160209174351.GC40460@dtor-ws> <979fb4dc5fba643a6780759d2a13530a@mail.gmail.com>
 <20160212150430.GA15049@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f171.google.com ([209.85.161.171]:36587 "EHLO
	mail-yw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752002AbcBPEY6 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 15 Feb 2016 23:24:58 -0500
Received: by mail-yw0-f171.google.com with SMTP id e63so35520399ywc.3
        for <linux-input@vger.kernel.org>; Mon, 15 Feb 2016 20:24:58 -0800 (PST)
In-Reply-To: <20160212150430.GA15049@rob-hp-laptop>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Russell King <linux@arm.linux.org.uk>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Jonathan Richardson <jonathar@broadcom.com>, Jon Mason <jonmason@broadcom.com>, Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com

> -----Original Message-----
> From: Rob Herring [mailto:robh@kernel.org]
> Sent: 12 February 2016 20:35
> To: Raveendra Padasalagi
> Cc: Dmitry Torokhov; Arnd Bergmann; Russell King;
devicetree@vger.kernel.org;
> linux-arm-kernel@lists.infradead.org; linux-input@vger.kernel.org; Pawel
Moll;
> Mark Rutland; Ian Campbell; Kumar Gala; Jonathan Richardson; Jon Mason;
> Florian Fainelli; Ray Jui; Scott Branden; linux-kernel@vger.kernel.org;
bcm-
> kernel-feedback-list@broadcom.com
> Subject: Re: [PATCH 1/3] input: cygnus-update touchscreen dt node
document
>
> Your mailer is not handling wrapping correctly. Generally, Outlook does
not
> work for maillists.
>
> On Wed, Feb 10, 2016 at 10:24:43AM +0530, Raveendra Padasalagi wrote:
> > > -----Original Message-----
> > > From: Dmitry Torokhov [mailto:dmitry.torokhov@gmail.com]
> > > Sent: 09 February 2016 23:14
> > > To: Raveendra Padasalagi
> > > Cc: Arnd Bergmann; Russell King; devicetree@vger.kernel.org;
> > > linux-arm- kernel@lists.infradead.org; linux-input@vger.kernel.org;
> > > Rob Herring;
> > Pawel
> > > Moll; Mark Rutland; Ian Campbell; Kumar Gala; Jonathan Richardson;
> > > Jon Mason; Florian Fainelli; Ray Jui; Scott Branden;
> > linux-kernel@vger.kernel.org;
> > > bcm-kernel-feedback-list@broadcom.com
> > > Subject: Re: [PATCH 1/3] input: cygnus-update touchscreen dt node
> > document
>
> And Outlook's reply header is non-standard.
>
> [...]
>
> > > > In Cygnus SOC, Touch screen controller registers are shared with
> > > > ADC and flex timer IP's.
> > > > Using readl/writel could lead to race condition. So this patch is
> > > > introduced to take care mutually exclusive access of register's in
> > > > such a case.
> > > >
> > > > In the platform's where touchscreen register's are not shared
> > > > normal readl/writel could be used.
> > >
> > > Are there currently platforms where the registers are not shared? If
> > > we
> > have to
> > > use regmap to correctly update registers (and thus we need
> > > syscon) then I wonder if we should even attempt to support direct
> > register
> > > access by the driver.
> >
> > Currently there are no platforms without register sharing, but we
> > would like to keep the driver generic enough to take care of future
> > SOC's if comes with dedicated registers and same touchscreen IP being
> > re-used.
>
> These future SoCs will have a different compatible string and you should
use that
> to determine whether reg or syscon is used.

Thanks Rob. I will address this in the next patch.

> Rob
