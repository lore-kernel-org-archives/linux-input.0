From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: input: stop autorepeat timer on key release
Date: Mon, 12 Jan 2009 21:02:36 -0800
Message-ID: <20090113050236.GA10900@dtor-d630.eng.vmware.com>
References: <1231241184.3684.1.camel@johannes> <20090111233431.ZZRA012@mailhub.coreip.homeip.net> <1231750263.4809.3.camel@johannes>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from yx-out-2324.google.com ([74.125.44.29]:40963 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750752AbZAMFDQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 13 Jan 2009 00:03:16 -0500
Received: by yx-out-2324.google.com with SMTP id 8so3571606yxm.1
        for <linux-input@vger.kernel.org>; Mon, 12 Jan 2009 21:03:15 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1231750263.4809.3.camel@johannes>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Arjan van de Ven <arjan@infradead.org>, linux-input <linux-input@vger.kernel.org>

On Mon, Jan 12, 2009 at 09:51:03AM +0100, Johannes Berg wrote:
> On Sun, 2009-01-11 at 23:36 -0800, Dmitry Torokhov wrote:
> > Hi Johannes,
> > 
> > On Tue, Jan 06, 2009 at 12:26:24PM +0100, Johannes Berg wrote:
> > > Whenever you press and then release a key, the CPU wakes up
> > > three times:
> > >  * press
> > >  * release
> > >  * autorepeat timer exactly 250ms after press
> > > 
> > > The autorepeat timer has nothing to do, obviously, since you already
> > > have released the key, so stop it on key release.
> > > 
> > 
> > This introduces a slight change in behaviour (the key that is released
> > may not be one that is being autorepeated) but I think it still makes
> > sense to do it.
> 
> Hmm, good point, I thought it didn't, but it does when you press a, b
> wait, release a then b doesn't continue autorepeating. Seems like a
> corner case though, so I agree. We could fix that by checking which key
> is being autorepeated though, I'd think, see below (untested as of now)
> 

I actually think the original change was better - sometimes when shift or
alt or ctrl key gets stuck it takes time to figure out what happened. If
we stop autorepeat upon release of any key it will recover much quicker.

-- 
Dmitry
