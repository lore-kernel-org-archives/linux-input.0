From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 2/2] mfd: twl4030: add twl4030-pwrbutton as our child
Date: Fri, 27 Feb 2009 15:42:20 -0800
Message-ID: <20090227154220.7099f339.akpm@linux-foundation.org>
References: <1235762883-20870-1-git-send-email-me@felipebalbi.com>
	<200902271358.46863.david-b@pacbell.net>
	<20090227141212.a2bc4a01.akpm@linux-foundation.org>
	<200902271520.56696.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:36333 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752488AbZB0Xmw (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 27 Feb 2009 18:42:52 -0500
In-Reply-To: <200902271520.56696.david-b@pacbell.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: me@felipebalbi.com, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, felipe.balbi@nokia.com, sameo@openedhand.com

On Fri, 27 Feb 2009 15:20:56 -0800
David Brownell <david-b@pacbell.net> wrote:

> On Friday 27 February 2009, Andrew Morton wrote:
> > > > 
> > > > What has gone wrong here?
> > > 
> > > Not much I can see. __It's registering a platform_device,
> > > but only if it could be used on this system.
> > 
> > Again, that all gets fixed if this is done the right way around. __Run
> > your probe function. __If the hardware is there, register with the core
> > and all the nodes appear. __If the hardware is not present: bale.
> 
> Right.  If there's no button hooked up to its "power button"
> signal, don't register that "twl4030-pwrbutton" node.
> 
> 
> > The design of the whole subsystem appears to be upside down :(
> 
> You seem to be missing something.  Is it only the lack of that
> tweak Felipe sent?

I generally just delete unchangelogged patches.

<goes back and finds it>


That doesn't address the problem at all.  A function called
"add_children" just shouldn't exist.  The general kernel design is for
client drivers to register themselves with the core, so the core does
not have any hard-wired knowledge of any client drivers.

IOW, twl4030_pwrbutton_probe() should call into twl4030-core,
registering the powerbutton driver.

