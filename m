From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/2] Input: DaVinci Keypad Driver
Date: Wed, 23 Sep 2009 22:40:32 -0700
Message-ID: <20090924054032.GA29786@core.coreip.homeip.net>
References: <1253654850-11983-1-git-send-email-miguel.aguilar@ridgerun.com> <200909231229.07403.david-b@pacbell.net> <20090923195113.GA16265@core.coreip.homeip.net> <200909231605.43733.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-px0-f194.google.com ([209.85.216.194]:37242 "EHLO
	mail-px0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751865AbZIXFke (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 24 Sep 2009 01:40:34 -0400
Received: by pxi32 with SMTP id 32so1282296pxi.4
        for <linux-input@vger.kernel.org>; Wed, 23 Sep 2009 22:40:38 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <200909231605.43733.david-b@pacbell.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Miguel Aguilar <miguel.aguilar@ridgerun.com>, nsnehaprabha@ti.com, davinci-linux-open-source@linux.davincidsp.com, linux-input@vger.kernel.org, todd.fischer@ridgerun.com, diego.dompe@ridgerun.com, clark.becker@ridgerun.com, santiago.nunez@ridgerun.com, Greg KH <gregkh@suse.de>

On Wed, Sep 23, 2009 at 04:05:43PM -0700, David Brownell wrote:
> On Wednesday 23 September 2009, Dmitry Torokhov wrote:
> > This is one possible design... however you are not talking about the
> > current Linux kernel but some other OS.
> 
> What other OS might it be then, which has carried around
> that exit section scrubbing mechanism for quite a few years
> now, and is distributed through www.kernel.org with labels
> such as "Linux 2.6.31" ???
> 

It can't be it since it does not exibit the behavior you are describing.

> 
> > > And thus, if any code is presuming that *every* driver
> > > can be unbound, it's wrong.
> > > 
> > > As I said:  bug in other code.
> > 
> > Not an implementation bug, the system behaves as designed.
> 
> Yes, absolutely an implementation bug.
> 
> At best you can say that there are two "designs" that
> are in conflict with each other.  And argue, for some
> reason, that the relatively-recently-introduced oops
> (OK, mid-2005, so it's been lurking for quite a while)
> is "more intended" than the previous safe-no-oops one
> (predating mid-2005 by many years).

Driver model was introduced what, 7 years ago? And since then at no
point remove methods() could be __devexit.

> 
> 
> > > Looking at this a bit more, it seems like there will need
> > > to be some "can this bus remove this driver" check, since
> > > the struct device.remove method is now managed at the bus
> > > level.  Easy enough to do instead of the null check that
> > > I mentioned below.  Provide it for platform bus, and the
> > > main potential trouble spots will be resolved.
> > 
> > 		... deletia ...
> > 
> 
> > I am talking about current design of the Linux driver code, as it is
> > present in mainline and in this particular instance probe() and remove()
> > do not do what you think they do. 
> 
> You're arguing about what it "should" do, and ignoring
> all the evidence I've provided.  So I guess "talking"
> is right, not "listening" or better yet "discussing".
>

Ok, then let me tell this once again since you snipped it off:

Until driver model is fixed so that using unbind sysfs attribute does not
cause trouble if devices discard their remove methods I will not accept
or ack drivers that mark their remove() methods as __exit.

-- 
Dmitry
