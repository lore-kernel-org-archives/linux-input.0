From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 0/2] Provide a driver for the Apple Magic Mouse - opps
Date: Sun, 14 Feb 2010 23:11:46 -0800
Message-ID: <20100215071145.GA9135@core.coreip.homeip.net>
References: <alpine.LNX.2.00.1001291515560.356@pobox.suse.cz>
 <201002131429.29671.edt@aei.ca>
 <20100214080344.GA4423@core.coreip.homeip.net>
 <201002140922.42014.edt@aei.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f179.google.com ([209.85.211.179]:34403 "EHLO
	mail-yw0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753680Ab0BOHLw (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 15 Feb 2010 02:11:52 -0500
Content-Disposition: inline
In-Reply-To: <201002140922.42014.edt@aei.ca>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ed Tomlinson <edt@aei.ca>
Cc: Jiri Kosina <jkosina@suse.cz>, Michael Poole <mdpoole@troilus.org>, linux-input@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org

On Sun, Feb 14, 2010 at 09:22:41AM -0500, Ed Tomlinson wrote:
> On Sunday 14 February 2010 03:03:44 Dmitry Torokhov wrote:
> > On Sat, Feb 13, 2010 at 02:29:29PM -0500, Ed Tomlinson wrote:
> > > On Wednesday 10 February 2010 08:57:37 Jiri Kosina wrote:
> > > > On Tue, 9 Feb 2010, Michael Poole wrote:
> > > > 
> > > > > I think this patch is ready for real review.  The Magic Mouse requires
> > > > > that a driver send an unlock Report(Feature) command, similar to the
> > > > > Wacom wireless tablet and Sixaxis controller quirks.  This turns on an
> > > > > Input Report that isn't published in the input Report descriptor that
> > > > > contains touch data (and usually overrides the normal motion and click
> > > > > Report).
> > > > > 
> > > > > Because the mouse has only one switch and no scroll wheel, the driver
> > > > > (under control of parameters) emulates a middle button and scroll wheel.
> > > > > User space could also ignore and/or re-synthesize those events based on
> > > > > the reported events.
> > > > > 
> > > > > The first patch exports hid_register_report() so the driver can turn on
> > > > > the multitouch report.  The second patch adds the device ID and the
> > > > > driver.  Some user-space tools to talk to the mouse directly (that is,
> > > > > when it is not associated with the host's HIDP stack) are at
> > > > > http://github.com/entrope/linux-magicmouse .
> > > > 
> > > > I have applied the driver into apple_magic_mouse branch and merged this 
> > > > branch into for-next, so it should appear in the upcoming linux-next.
> > > 
> > 
> > > This driver (or the hid changes) can triggers an opps.  What I did was
> > > start X.  Turn on the magic mouse.  It connected on input7&8.  Then I
> > > powered it off and on.  This time it conneced on input9&10.  Then I
> > > exited X and got the opps.  Note my X does not hotplug the magic
> > > mouse.  I've also included a trace of the udev events that generated
> > > the log below (if there was a remove after X stopped it would not be
> > > included).  To my eyes it looks like we leak an input device (there is
> > > not a remove event for input8).
> > >
> > 
> > Indeed, we seem to be missing call to input_unregister_device() in
> > magicmouse_remove().
> 
> How does this look?  With this udevadm shows input8 being removed and
> there is no more opps.

Almost... you need to do hid_hw_stop() first and only then unregister
input device, Otherwise if you unload the module while moving the mouse
it is likely to still oops.

Thanks.

-- 
Dmitry
