From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 17/25] wm97xx: don't use [delayed_]work_pending()
Date: Sat, 9 Mar 2013 15:53:36 -0800
Message-ID: <20130309235336.GA22734@core.coreip.homeip.net>
References: <1356141435-17340-1-git-send-email-tj@kernel.org>
 <1356141435-17340-18-git-send-email-tj@kernel.org>
 <20121223095450.GA17407@core.coreip.homeip.net>
 <20121224161827.GR30837@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f44.google.com ([209.85.160.44]:46734 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751161Ab3CIXxj (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 9 Mar 2013 18:53:39 -0500
Content-Disposition: inline
In-Reply-To: <20121224161827.GR30837@opensource.wolfsonmicro.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org, Liam Girdwood <lrg@slimlogic.co.uk>, linux-input@vger.kernel.org

On Mon, Dec 24, 2012 at 04:18:27PM +0000, Mark Brown wrote:
> On Sun, Dec 23, 2012 at 01:54:50AM -0800, Dmitry Torokhov wrote:
> 
> > This is not 100% equivalent transformation as now we schedule first and
> > disable IRQ later... Anyway, I think the driver shoudl be converted to
> > threaded IRQ instead. Mark, does the patch below make any sense to you?
> 
> I'm a bit nervous about the fact that currently both the pen down IRQ
> and the coordinate read are pushed through a single workqueue so are
> serialised but after your patch they'll be split into the IRQ thread and
> the workqueue.  It *should* be fine but I'd have to sit there and study
> it to convince myself that it's safe.

Mark,

Did yo have a chance to review the patch?

Thanks!

-- 
Dmitry
