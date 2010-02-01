From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v6] input: IMX: add imx-keypad driver to support the
 Keypad Port present in the imx application processors family.
Date: Sun, 31 Jan 2010 18:01:17 -0800
Message-ID: <20100201020117.GA24188@core.coreip.homeip.net>
References: <1264852407.2587.4.camel@realization>
 <20100131090802.GD12320@core.coreip.homeip.net>
 <1264945351.2433.10.camel@realization>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-px0-f182.google.com ([209.85.216.182]:44489 "EHLO
	mail-px0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750940Ab0BACBX (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 31 Jan 2010 21:01:23 -0500
Received: by pxi12 with SMTP id 12so3699585pxi.33
        for <linux-input@vger.kernel.org>; Sun, 31 Jan 2010 18:01:22 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1264945351.2433.10.camel@realization>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alberto Panizzo <maramaopercheseimorto@gmail.com>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Lothar =?iso-8859-1?Q?Wa=DFmann?= <LW@KARO-electronics.de>, H Hartley Sweeten <hartleys@visionengravers.com>, Sascha linux-arm <s.hauer@pengutronix.de>, linux-input <linux-input@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

Hi Alberto,

On Sun, Jan 31, 2010 at 02:42:31PM +0100, Alberto Panizzo wrote:
> On dom, 2010-01-31 at 01:08 -0800, Dmitry Torokhov wrote:
> > Hi Alberto,
> > 
> > On Sat, Jan 30, 2010 at 12:53:27PM +0100, Alberto Panizzo wrote:
> > > 
> > > Changes in v6:
> > > -MXC to IMX pattern change (apart of Kconfig dependencies)
> > > -Comment style fixes
> > > -Greater check delay in debouncing process (10). 
> > > -Improve the usage of keypad->exit_flag: now it is false only
> > between open and 
> > >  close functions. And if we handle an interrupt out there, leave all
> > interrupts
> > >  masked, and wait for another open to re enable they.
> > > -Remove unnecessary "free events" mechanism (tested with evtest).
> > > 
> > 
> > I took the liberty of making some changes to the driver, could you
> > please give the patch below a try and if I did not mess it up I will
> > fold it into your v6 version and apply to next.
> > 
> > Thank you.
> > 
> > -- 
> > Dmitry 
> 
> For me it is ok. Your patch looks good and I tested your changes and all
> goes well.

Great, thanks a lot.

> I have to work on my English and other changes make the 
> source code more readable.
> Dmitry, put also your Signed-off line in v6 patch after merge if you
> feel to wont this. (I've already thought to ask you this before this
> patch fix) You help me a lot on building this version and an Acked-by
> maybe is not fair about your work.

Yes, I will fold this patch into your original v6 patch and will add my
sign-off. BTW, adding sign-off does not imply in any way that a person
had more or less involvement in the development of a driver/feature;
this is just to track the path of patricular code reaching mainline.
I am adding my sign-offs to all patches that are applied to my tree as
do all the other maintainers, the authorship of the patch is conveyed
via git's 'author' field.

OK, so the driver is applied to the 'next' branch of my tree and should
be in mainline when 2.6.34 merge window opens.

Thank you.

-- 
Dmitry
