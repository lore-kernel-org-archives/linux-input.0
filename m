From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: MT - Add support for balanced slot assignment
Date: Mon, 2 Feb 2015 09:12:57 -0800
Message-ID: <20150202171257.GA23909@dtor-ws>
References: <1421956345-1546-1-git-send-email-rydberg@bitmath.org>
 <CAN+gG=FNJ8O-=Q4kpsVSYYY+o3KLHpfm43OT-AgTPkHYF-zVLg@mail.gmail.com>
 <20150201090323.GA12868@polaris.bitmath.org>
 <20150202153253.GA8608@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f172.google.com ([209.85.223.172]:52701 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752765AbbBBRND (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 2 Feb 2015 12:13:03 -0500
Content-Disposition: inline
In-Reply-To: <20150202153253.GA8608@mail.corp.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: Henrik Rydberg <rydberg@bitmath.org>, Peter Hutterer <peter.hutterer@who-t.net>, linux-input <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Mon, Feb 02, 2015 at 10:32:53AM -0500, Benjamin Tissoires wrote:
> On Feb 01 2015 or thereabouts, Henrik Rydberg wrote:
> > Hi Benjamin,
> > 
> > > Tested this morning, and yes, it solves the problem.
> > > I assumed that the dmax was in mm, and used "10 * priv->x_res", which
> > > seemed to do the trick:
> > > - tapping with two fingers side by side triggered the jumps
> > > - in the general case (switching from the index to the thumb to
> > > click), the jumps disappeared.
> > 
> > Great, thanks for testing.
> > 
> > > Maybe we should also add a doc telling which units the dmax should be.
> > 
> > I added an enhanced description, which hopefully clarifies the units
> > of dmax.
> > 
> > > When you'll sign this, you can add my tested-by.
> > 
> > Done, and tested against Linus' master. I take it you have a patch on
> > this coming up as well?
> 
> Yep. I have a one line patch to enable the feature in synaptics. I will
> send it as soon as Dmitry take this one.

I did so please send yours in.

-- 
Dmitry
