From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/5] tsc2007: Add max_rt module parameter.
Date: Mon, 16 May 2011 22:58:35 -0700
Message-ID: <20110517055835.GB20428@core.coreip.homeip.net>
References: <1305534783-4917-1-git-send-email-thierry.reding@avionic-design.de>
 <1305534783-4917-2-git-send-email-thierry.reding@avionic-design.de>
 <20110516165300.GB21232@core.coreip.homeip.net>
 <20110517054620.GB9943@avionic-0098.mockup.avionic-design.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:52926 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752067Ab1EQF6l (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 17 May 2011 01:58:41 -0400
Received: by pwi15 with SMTP id 15so132337pwi.19
        for <linux-input@vger.kernel.org>; Mon, 16 May 2011 22:58:41 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110517054620.GB9943@avionic-0098.mockup.avionic-design.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Thierry Reding <thierry.reding@avionic-design.de>
Cc: linux-input@vger.kernel.org, Kwangwoo Lee <kwlee@mtekvision.com>

On Tue, May 17, 2011 at 07:46:20AM +0200, Thierry Reding wrote:
> * Dmitry Torokhov wrote:
> > Hi Thierry,
> > 
> > On Mon, May 16, 2011 at 10:33:00AM +0200, Thierry Reding wrote:
> > > Finger touch events or very quick stylus events on low-quality panels
> > > can cause the tsc2007 to read bogus values. Looking at oscilloscope
> > > snapshots, this seems to be caused by the touch event disappearing
> > > during the measurements. These bogus values result in misclicks, where
> > > the X and Y values deviate from the real position.
> > > 
> > > Most of these misclicks can be filtered out by setting a low enough
> > > threshold for the maximum resistance (which is loosely the inverse of
> > > the pressure) allowed to consider a set of values valid. Since this
> > > behaviour is largely dependent on the type and quality of the panel,
> > > this commit introduces the max_rt parameter. The default value is kept
> > > at MAX_12BIT.
> > 
> > I expect that the values, once selected, will not be changed for a given
> > panel, so why don't we pass max_rt (and poll_delay and poll_interval) vi
> > platform (board) data instead of being module parameters?
> 
> I was using module parameters because it allows the parameters to be tuned at
> runtime. You are correct however in that they don't vary after being selected
> once. I can resend an updated patch series with those parameters added to the
> platform data if you prefer.

Yes, please.

> 
> By the way, Kwangwoo's email address no longer seems to be valid. Searching
> the kernel tree, there also seems to be kwangwoo.lee@gmail.com. Do you know
> if it is current?

No, I do not.

-- 
Dmitry
