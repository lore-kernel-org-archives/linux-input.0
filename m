From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH] input: Fix USB autosuspend on bcm5974
Date: Fri, 7 Oct 2011 19:06:12 +0200
Message-ID: <20111007170612.GA2215@polaris.bitmath.org>
References: <1317936997-20438-1-git-send-email-mjg@redhat.com>
 <20111006223835.GA30738@core.coreip.homeip.net>
 <20111006231954.GA32029@srcf.ucam.org>
 <201110070837.46926.oliver@neukum.org>
 <20111007123653.GA7325@srcf.ucam.org>
 <20111007162027.GA25307@core.coreip.homeip.net>
 <20111007162756.GA12136@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-b12.telenor.se ([62.127.194.21]:49837 "EHLO
	smtprelay-b12.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752531Ab1JGQ7v (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 7 Oct 2011 12:59:51 -0400
Received: from iph4.telenor.se (iph4.telenor.se [195.54.127.135])
	by smtprelay-b12.telenor.se (Postfix) with ESMTP id 47CDBC719
	for <linux-input@vger.kernel.org>; Fri,  7 Oct 2011 18:59:49 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20111007162756.GA12136@srcf.ucam.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Oliver Neukum <oliver@neukum.org>, linux-input@vger.kernel.org

On Fri, Oct 07, 2011 at 05:27:56PM +0100, Matthew Garrett wrote:
> On Fri, Oct 07, 2011 at 09:20:27AM -0700, Dmitry Torokhov wrote:
> > On Fri, Oct 07, 2011 at 01:36:53PM +0100, Matthew Garrett wrote:
> > > On Fri, Oct 07, 2011 at 08:37:46AM +0200, Oliver Neukum wrote:
> > > 
> > > > Please also note that for a device to generate wakeup events the kernel has to
> > > > enable them which drivers have to request, like the usbhid driver does.
> > > > If you do this you better have a test device, because I found that most
> > > > generic mice generate wakeup events only if you press a button, not move
> > > > the mouse. We are simply not equipped in our API to use that capability.
> > > 
> > > This hardware generates wakeups events on touch.
> > 
> > Is it true for all generations that the driver supports?
> 
> As far as I can tell.

And yet, there is a complication, since the keyboard and mouse
interfaces are both present on the same device. I just ran a small
test, on an MBA3,1. While it is true that the trackpad generates
wakeup events on touch, it enters a loop of suspend/resume, presumably
due to the keyboard. Moreover, the trackpad emits some strange packets
which leave a (large) message trail.

Henrik
