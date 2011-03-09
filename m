From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH] Input: wm831x-ts - Default pressure measurements on
Date: Wed, 9 Mar 2011 15:40:18 +0100
Message-ID: <20110309144018.GA5881@polaris.bitmath.org>
References: <1299679112-15245-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <20110309141139.GA5482@polaris.bitmath.org>
 <20110309142813.GA24877@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp01.sth.basefarm.net ([80.76.149.212]:37513 "EHLO
	ch-smtp01.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932243Ab1CIOjJ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 9 Mar 2011 09:39:09 -0500
Content-Disposition: inline
In-Reply-To: <20110309142813.GA24877@opensource.wolfsonmicro.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, patches@opensource.wolfsonmicro.com

On Wed, Mar 09, 2011 at 02:28:13PM +0000, Mark Brown wrote:
> On Wed, Mar 09, 2011 at 03:11:39PM +0100, Henrik Rydberg wrote:
> 
> > > -	wm831x_ts->pressure = pdata && pdata->pressure;
> > > +	if (pdata)
> > > +		wm831x_ts->pressure = pdata->pressure;
> > > +	else
> > > +		wm831x_ts->pressure = true;
> 
> > wm831x_ts->pressure = !pdata || pdata->pressure;
> 
> > should suffice.
> 
> It does have some substantial drawbacks in terms of legibility, though.

I suppose that is in the eye of the beholder.

Henrik
