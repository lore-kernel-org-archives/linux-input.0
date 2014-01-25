From: Courtney Cavin <courtney.cavin@sonymobile.com>
Subject: Re: [PATCH 00/15] Input: synaptics-rmi4 - cleanup and add DT support
Date: Fri, 24 Jan 2014 17:08:50 -0800
Message-ID: <20140125010845.GC19653@sonymobile.com>
References: <1390521623-6491-1-git-send-email-courtney.cavin@sonymobile.com>
 <52E2F62B.80101@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from seldrel01.sonyericsson.com ([212.209.106.2]:3520 "EHLO
	seldrel01.sonyericsson.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751167AbaAYBHK (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 24 Jan 2014 20:07:10 -0500
Content-Disposition: inline
In-Reply-To: <52E2F62B.80101@synaptics.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Christopher Heiny <cheiny@synaptics.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>

On Sat, Jan 25, 2014 at 12:24:27AM +0100, Christopher Heiny wrote:
> On 01/23/2014 04:00 PM, Courtney Cavin wrote:
> > This is an attempt to get this driver closer to being in an upstream-able form.
> > In the process, this drops legacy callback methods for managing power and GPIO
> > configuration, in favor of the already existing frameworks.  Most of this
> > series is cleanup, but there are a few intermixed bug fixes to make it all
> > work.
> 
> Hi Courtney!
> 
> Thanks for the extensive patches.  There's a great deal of cool stuff in 
> there that we're really happy to see (as in "buy Courtney a beer! No, 
> make it two beers!" levels of happy).  We really want to get the driver 
> upstream, and your improvements will help a lot.  The device tree work 
> looks to be particularly helpful.
> 

Thanks. Glad to help!

> Unfortunately some of your cleanup is too aggressive, and winds up 
> breaking code outside of the current patch submissions.  The current 
> patch codebase is significantly reduced in size in order to be more 
> manageable, but there's a non-trivial amount of production code outside 
> that codebase that depends on things like the current GPIO/IRQ handling, 
> the debugfs infrastructure, platform suspend/resume, and so on.  This 
> code will be submitted after the core of the driver is upstreamed. 
> Tearing out the supporting code now and then putting it all back later 
> just makes more work for all concerned.

I can definitely understand that some of your production code must
manage older kernels and alternative features.  The problem I see here is
that the driver will never get upstreamed with the GPIO/IRQ handling and
unused variables in the first place.  It is unnecessary in mainline, and
therefore should not exist in mainline.  I am not the maintainer though,
so... Dmitry should probably chime in on this.

> 
> Additionally, some of your changes are redundant to, or in conflict 
> with, patches submitted over the past few weeks.  Have you been 
> following that series and discussions relating to them?  It would 
> probably be more efficient for you to offer comments on those patches, 
> rather than submitting conflicting work.
> 

I did not see any specific logical conflicts other than saving the F01
container, which was needed for testing, and was independent of IRQ
counting.  Other than that, there should only need to be rebasing
one-way or the other.  I am simply basing my patches off of what exists
in the tree, which prevents awkward patch-series dependencies.

I did look at your patches, but didn't comment because I had nothing to
say.  I'll be sure to participate in patch discussions if I have
something to add.

... and after double checking, I just noticed that 1/15 conflicts
with your PDT scan cleanup, as we both have C++ comment style cleanup.
Whoops.

> We'll be going over the new feature and bug fix parts of this patch 
> series, and will send comments in the next couple of workdays.
> 
> 				Thanks,
> 					Chris
> 

I'm looking forward to some comments.

-Courtney

> >
> > This patch series is based off of the synaptics-rmi4 branch merged into
> > Linus' 3.13.  A tree is available at [1].
> >
> > This was tested on Synaptics TM2281-001 & TM2282-001.
> >
> > [1] http://github.com/courtc/linux.git
> > 	tag for-input/synaptics-rmi4
> >
> > Courtney Cavin (15):
> >    Input: synaptics-rmi4 - fix checkpatch.pl, sparse and GCC warnings
> >    Input: synaptics-rmi4 - don't kfree devm_ alloced memory
> >    Input: synaptics-rmi4 - don't free devices directly
> >    Input: synaptics-rmi4 - remove sensor name from platform data
> >    Input: synaptics-rmi4 - remove gpio handling and polling
> >    Input: synaptics-rmi4 - remove platform suspend callbacks
> >    Input: synaptics-rmi4 - remove remaining debugfs code
> >    Input: synaptics-rmi4 - cleanup platform data
> >    Input: synaptics-rmi4 - remove unused defines and variables
> >    Input: synaptics-rmi4 - add devicetree support
> >    Input: synaptics-rmi4 - add regulator support
> >    Input: synaptics-rmi4 - don't immediately set page on probe
> >    Input: synaptics-rmi4 - properly set F01 container on PDT scan
> >    Input: synaptics-rmi4 - ensure we have IRQs before reading status
> >    Input: synaptics-rmi4 - correct RMI4 spec url
> >
> >   Documentation/devicetree/bindings/input/rmi4.txt   | 117 +++++
> >   .../devicetree/bindings/vendor-prefixes.txt        |   1 +
> >   drivers/input/rmi4/Kconfig                         |   1 -
> >   drivers/input/rmi4/rmi_bus.c                       | 131 +-----
> >   drivers/input/rmi4/rmi_bus.h                       |  18 +-
> >   drivers/input/rmi4/rmi_driver.c                    | 321 +++++--------
> >   drivers/input/rmi4/rmi_driver.h                    |  33 +-
> >   drivers/input/rmi4/rmi_f01.c                       | 163 ++++---
> >   drivers/input/rmi4/rmi_f11.c                       | 523 ++++++---------------
> >   drivers/input/rmi4/rmi_i2c.c                       |  55 +--
> >   include/linux/rmi.h                                | 219 ++-------
> >   11 files changed, 551 insertions(+), 1031 deletions(-)
> >   create mode 100644 Documentation/devicetree/bindings/input/rmi4.txt
> >
> 
> 
> -- 
> 
> Christopher Heiny
> Senior Staff Firmware Engineer
> Synaptics Incorporated
