From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH resend2] Input: usbtouchscreen - initialize eGalax devices
Date: Mon, 10 Sep 2012 14:11:45 -0700
Message-ID: <3475963.zdirdksHlt@dtor-d630.eng.vmware.com>
References: <20120903132648.GC11919@newmaster.mivlgu.local> <20120905060704.GC25962@core.coreip.homeip.net> <20120907204232.GA24528@alittletooquiet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:64335 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751788Ab2IJVL7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 10 Sep 2012 17:11:59 -0400
In-Reply-To: <20120907204232.GA24528@alittletooquiet.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Forest Bond <forest@alittletooquiet.net>, Jiri Kosina <jkosina@suse.cz>
Cc: Daniel Ritz <daniel.ritz@gmx.ch>, Alan Stern <stern@rowland.harvard.edu>, Sergei Shtylyov <sshtylyov@mvista.com>, linux-input@vger.kernel.org, linux-usb@vger.kernel.org

On Friday, September 07, 2012 04:42:32 PM Forest Bond wrote:
> Hi Dmitry,
> 
> On Tue, Sep 04, 2012 at 11:07:04PM -0700, Dmitry Torokhov wrote:
> > On Mon, Sep 03, 2012 at 01:33:50PM -0400, Forest Bond wrote:
> > > From: Forest Bond <forest.bond@rapidrollout.com>
> > > 
> > > Certain eGalax devices expose an interface with class HID and protocol
> > > None.  Some work with usbhid and some work with usbtouchscreen, but
> > > there is no easy way to differentiate.  Sending an eGalax diagnostic
> > > packet seems to kick them all into using the right protocol for
> > > usbtouchscreen, so we can continue to bind them all there (as opposed to
> > > handing some off to usbhid).
> > > 
> > > This fixes a regression for devices that were claimed by (and worked
> > > with) usbhid prior to commit 139ebe8dc80dd74cb2ac9f5603d18fbf5cff049f
> > > ("Input: usbtouchscreen - fix eGalax HID ignoring"), which made
> > > usbtouchscreen claim them instead.  With this patch they will still be
> > > claimed by usbtouchscreen, but they will actually report events
> > > usbtouchscreen can understand.  Note that these devices will be limited
> > > to the usbtouchscreen feature set so e.g. dual touch features are not
> > > supported.
> > > 
> > > I have the distinct pleasure of needing to support devices of both types
> > > and have tested accordingly.
> > > 
> > > Signed-off-by: Forest Bond <forest.bond@rapidrollout.com>
> > 
> > Applied, thank you Forest.
> 
> Great, thanks a lot.
> 
> The other piece to this puzzle is that usbhid should blacklist these devices
> to avoid binding if it happens to be loaded before usbtouchscreen.  To do
> this, usbhid needs to be able to blacklist devices based on interface
> protocol (right now it only supports blacklist on VID + PID).
> 
> Would you accept a patch set that implements this?

Juri, this question is really for you...

Thanks!

-- 
Dmitry
