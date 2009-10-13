From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v4 1/2] Input: DaVinci Keypad Driver
Date: Tue, 13 Oct 2009 09:55:24 -0700
Message-ID: <20091013165524.GA21593@core.coreip.homeip.net>
References: <1255109225-6833-1-git-send-email-miguel.aguilar@ridgerun.com> <20091013054644.GF2887@core.coreip.homeip.net> <BD79186B4FD85F4B8E60E381CAEE190901DB800C@mi8nycmail19.Mi8.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f188.google.com ([209.85.222.188]:63750 "EHLO
	mail-pz0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760556AbZJMQ4F (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 13 Oct 2009 12:56:05 -0400
Received: by pzk26 with SMTP id 26so9143599pzk.4
        for <linux-input@vger.kernel.org>; Tue, 13 Oct 2009 09:55:29 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <BD79186B4FD85F4B8E60E381CAEE190901DB800C@mi8nycmail19.Mi8.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: H Hartley Sweeten <hartleys@visionengravers.com>
Cc: miguel.aguilar@ridgerun.com, davinci-linux-open-source@linux.davincidsp.com, nsnehaprabha@ti.com, linux-input@vger.kernel.org, todd.fischer@ridgerun.com, diego.dompe@ridgerun.com, clark.becker@ridgerun.com, santiago.nunez@ridgerun.com

On Tue, Oct 13, 2009 at 12:21:47PM -0400, H Hartley Sweeten wrote:
> On Monday, October 12, 2009 10:47 PM, Dmitry Torokhov wrote:
> > Hi Miguel,
> > 
> > On Fri, Oct 09, 2009 at 11:27:05AM -0600, miguel.aguilar@ridgerun.com wrote:
> >> From: Miguel Aguilar <miguel.aguilar@ridgerun.com>
> >> 
> >> Adds the driver for enabling keypad support for DaVinci platforms.
> >> 
> >> DM365 is the only platform that uses this driver at the moment.
> >> 
> >
> > Looks pretty good, I have one question:
> >
> >> +static void davinci_ks_write(struct davinci_ks *davinci_ks, u32 val, u32 addr)
> >> +{
> >> +	u32 base = (u32)davinci_ks->base;
> >> +
> >> +	__raw_writel(val,(u32 *)(base + addr));
> >> +}
> >
> > Do you really need these casts? I'd think that bare __raw_writel would
> > work just fine.
> 
> The address for __raw_{write/read}* should be void __iomem *, davinci_ks->base
> should already be the correct type due to ioremap().
> 
> You can probably just change the whole thing to:
> 
> +static void davinci_ks_write(struct davinci_ks *davinci_ks, u32 val, u32 addr)
> +{
> +	__raw_writel(val, davinci_ks->base + addr);
> +}
> +
> +static u32 davinci_ks_read(struct davinci_ks *davinci_ks, u32 addr)
> +{
> +	return __raw_readl(davinci_ks->base + addr);
> +}
> 

Better yet, use __raw_readl() and __raw_writel() directly - there is no
need for wrappers that just rename existig functions not adding any
additional functionality.

-- 
Dmitry
