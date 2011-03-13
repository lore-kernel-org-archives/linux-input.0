From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: wm831x-ts - Default pressure measurements on
Date: Sat, 12 Mar 2011 22:28:23 -0800
Message-ID: <20110313062822.GD31566@core.coreip.homeip.net>
References: <1299679112-15245-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <20110309141139.GA5482@polaris.bitmath.org>
 <20110309142813.GA24877@opensource.wolfsonmicro.com>
 <20110309144018.GA5881@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:35311 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751195Ab1CMG21 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 13 Mar 2011 01:28:27 -0500
Received: by iyb26 with SMTP id 26so3957139iyb.19
        for <linux-input@vger.kernel.org>; Sat, 12 Mar 2011 22:28:27 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110309144018.GA5881@polaris.bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-input@vger.kernel.org, patches@opensource.wolfsonmicro.com

On Wed, Mar 09, 2011 at 03:40:18PM +0100, Henrik Rydberg wrote:
> On Wed, Mar 09, 2011 at 02:28:13PM +0000, Mark Brown wrote:
> > On Wed, Mar 09, 2011 at 03:11:39PM +0100, Henrik Rydberg wrote:
> > 
> > > > -	wm831x_ts->pressure = pdata && pdata->pressure;
> > > > +	if (pdata)
> > > > +		wm831x_ts->pressure = pdata->pressure;
> > > > +	else
> > > > +		wm831x_ts->pressure = true;
> > 
> > > wm831x_ts->pressure = !pdata || pdata->pressure;
> > 
> > > should suffice.
> > 
> > It does have some substantial drawbacks in terms of legibility, though.
> 
> I suppose that is in the eye of the beholder.
> 

Applied, thanks Mark (even though I also prefer more concise variants).

-- 
Dmitry
