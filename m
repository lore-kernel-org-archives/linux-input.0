From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/3 2.6.39] Input: wm831x-ts - Fix races with IRQ
 management
Date: Tue, 3 May 2011 08:49:18 -0700
Message-ID: <20110503154918.GB6509@core.coreip.homeip.net>
References: <1303237074-12878-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <20110503144618.GD2893@sirena.org.uk>
 <20110503154303.GA6509@core.coreip.homeip.net>
 <20110503154414.GX1762@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-px0-f170.google.com ([209.85.212.170]:41342 "EHLO
	mail-px0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752469Ab1ECPtZ (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 3 May 2011 11:49:25 -0400
Received: by pxi19 with SMTP id 19so146318pxi.1
        for <linux-input@vger.kernel.org>; Tue, 03 May 2011 08:49:25 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110503154414.GX1762@opensource.wolfsonmicro.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: linux-input@vger.kernel.org, patches@opensource.wolfsonmicro.com

On Tue, May 03, 2011 at 04:44:14PM +0100, Mark Brown wrote:
> On Tue, May 03, 2011 at 08:43:03AM -0700, Dmitry Torokhov wrote:
> > On Tue, May 03, 2011 at 03:46:18PM +0100, Mark Brown wrote:
> 
> > > Any updates on this?
> 
> > I sent a pull request to Linus last night, hopefully he'll pull.
> 
> Oh, OK - I hadn't noticed that you'd applied the patches at all (they
> didn't vanish in my last -next rebase on Thursday

I think I applied them on Thursday night, rigth after -next was
released.

> and you didn't reply to my mail) 

Yeah, sorry about this, a few things are going on so I am slow with my
mail.

> so I thought they'd slipped by when you were reviewing.

-- 
Dmitry
