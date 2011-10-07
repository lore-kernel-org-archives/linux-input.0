From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] input: Fix USB autosuspend on bcm5974
Date: Fri, 7 Oct 2011 17:27:56 +0100
Message-ID: <20111007162756.GA12136@srcf.ucam.org>
References: <1317936997-20438-1-git-send-email-mjg@redhat.com>
 <20111006223835.GA30738@core.coreip.homeip.net>
 <20111006231954.GA32029@srcf.ucam.org>
 <201110070837.46926.oliver@neukum.org>
 <20111007123653.GA7325@srcf.ucam.org>
 <20111007162027.GA25307@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:54614 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753291Ab1JGQ16 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 7 Oct 2011 12:27:58 -0400
Content-Disposition: inline
In-Reply-To: <20111007162027.GA25307@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Oliver Neukum <oliver@neukum.org>, linux-input@vger.kernel.org, rydberg@euromail.se

On Fri, Oct 07, 2011 at 09:20:27AM -0700, Dmitry Torokhov wrote:
> On Fri, Oct 07, 2011 at 01:36:53PM +0100, Matthew Garrett wrote:
> > On Fri, Oct 07, 2011 at 08:37:46AM +0200, Oliver Neukum wrote:
> > 
> > > Please also note that for a device to generate wakeup events the kernel has to
> > > enable them which drivers have to request, like the usbhid driver does.
> > > If you do this you better have a test device, because I found that most
> > > generic mice generate wakeup events only if you press a button, not move
> > > the mouse. We are simply not equipped in our API to use that capability.
> > 
> > This hardware generates wakeups events on touch.
> 
> Is it true for all generations that the driver supports?

As far as I can tell.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
