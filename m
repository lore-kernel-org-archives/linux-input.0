From: Daniel Mack <daniel@caiaq.de>
Subject: Re: [PATCH] generic driver for rotary encoders on GPIOs
Date: Fri, 27 Feb 2009 19:34:49 +0100
Message-ID: <20090227183449.GD8855@buzzloop.caiaq.de>
References: <20090227064314.GB32470@buzzloop.caiaq.de> <1235757652-16514-1-git-send-email-daniel@caiaq.de> <BD79186B4FD85F4B8E60E381CAEE190901349198@mi8nycmail19.Mi8.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from buzzloop.caiaq.de ([212.112.241.133]:54634 "EHLO
	buzzloop.caiaq.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754941AbZB0Sey (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 27 Feb 2009 13:34:54 -0500
Content-Disposition: inline
In-Reply-To: <BD79186B4FD85F4B8E60E381CAEE190901349198@mi8nycmail19.Mi8.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: hartleys <hartleys@visionengravers.com>
Cc: linux-input@vger.kernel.org

On Fri, Feb 27, 2009 at 01:30:15PM -0500, hartleys wrote:
> On Friday, February 27, 2009 11:01 AM, Daniel Mack wrote:
> > This patch adds a generic driver for rotary encoders connected to
> > GPIO pins of a system. It relies on gpiolib and generic hardware
> > irqs. The documentation that also comes with this patch explains
> > the concept and how to use the driver.
> >
> > Signed-off-by: Daniel Mack <daniel@caiaq.de>
> > ---
> >  new version as discussed on linux-input.
> 
> Works great now on the ep93xx with no changes.

Glad to hear that :)

> I have a minor patch to it that allows the platform init to configure
> the absolute/relative axis to report the encoder on.  If you would like
> to see it I can put together a patch.

Yes, and probably just post it as follow-up as soon as this one has been
commited. I'm new to this list, so I don't know who can/will/wants to do
this?

> Also, any ideas if the driver could be modified to support more that one
> rotary encoder?
> 
> It might be possible to load driver multiple times, once for each
> encoder, but then all the events show up in different /dev/input/event*
> places.

That would have been my idea as well. It doesn't really matter how many
input devices you listen to from user space and as the number of
encoders on a certain board is not dynamic, I don't see much reason to
put any efford in this ;)

Daniel

