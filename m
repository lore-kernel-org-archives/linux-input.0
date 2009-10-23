From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [REGRESSION] "bind" a device to a driver doesn't not work
	anymore
Date: Thu, 22 Oct 2009 19:01:50 -0700
Message-ID: <20091023020150.GA26723@core.coreip.homeip.net>
References: <20091011030029.GA6526@suse.de> <200910112135.29384.dmitry.torokhov@gmail.com> <4AD31709.4000103@tremplin-utc.net> <20091012154846.GB7996@core.coreip.homeip.net> <20091012173551.GC10557@suse.de> <20091012183313.GC8345@core.coreip.homeip.net> <20091012185417.GA30342@suse.de> <20091013031741.GB2887@core.coreip.homeip.net> <20091018075127.GH3935@core.coreip.homeip.net> <20091018080238.GA13810@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pw0-f42.google.com ([209.85.160.42]:52539 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750840AbZJWCBw (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 22 Oct 2009 22:01:52 -0400
Content-Disposition: inline
In-Reply-To: <20091018080238.GA13810@suse.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Greg KH <gregkh@suse.de>
Cc: ?ric Piel <eric.piel@tremplin-utc.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org

On Sun, Oct 18, 2009 at 01:02:38AM -0700, Greg KH wrote:
> On Sun, Oct 18, 2009 at 12:51:27AM -0700, Dmitry Torokhov wrote:
> > On Mon, Oct 12, 2009 at 08:17:41PM -0700, Dmitry Torokhov wrote:
> > > On Mon, Oct 12, 2009 at 11:54:17AM -0700, Greg KH wrote:
> > > > On Mon, Oct 12, 2009 at 11:33:13AM -0700, Dmitry Torokhov wrote:
> > > > > On Mon, Oct 12, 2009 at 10:35:51AM -0700, Greg KH wrote:
> > > > > > On Mon, Oct 12, 2009 at 08:48:46AM -0700, Dmitry Torokhov wrote:
> > > > > > > > So at least, unbind should fail as well as bind.
> > > > > > > >
> > > > > > > 
> > > > > > > That would be Greg's domain s it is driver core decision whether to
> > > > > > > allow unbinding platform devices registered with
> > > > > > > platform_driver_probe().
> > > > > > 
> > > > > > No, I do not see why that should not be allowed.
> > > > > > 
> > > > > 
> > > > > Because once you did unbind the device you are stuck (unless the driver
> > > > > is compiled as a module, but then you could just unload the module
> > > > > instead of unbinding). Disallowing unbind would allow discarding not
> > > > > only __devinit but __devexit sections when driver is built in which
> > > > > would make ebedded people happy[^Hier].
> > > > 
> > > > Yeah, good point.
> > > > 
> > > > Does anyone do bind/unbind with platform devices today?
> > > > 
> > > > If not, a patch changing this would be welcome.
> > > > 
> > > 
> > > How about this one?
> > > 
> > 
> > *ping* We need to resolve this, otherwise everyone who likes to rebind
> > i8042 in couse of STR/STD will be in trouble.
> 
> Sorry, am in Tokyo right now.
> 
> I like this patch, and will queue it up, but it's too late for .32, it
> will have to wait for .33.
> 

Greg,

I hope you will reconsider. The patch is extremely small but without it
I am afraid many people whose distributions blindly rebind i8042 on
suspend/resume will lose their keyboards and mice now that i8042 uses
platform_driver_probe()...

Thanks.

-- 
Dmitry
