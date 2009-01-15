From: Ben Dooks <ben-linux@fluff.org>
Subject: Re: usbtouchscreen: Add support for Zytronic capacitive touchscreen
Date: Thu, 15 Jan 2009 15:12:28 +0000
Message-ID: <20090115151228.GU15238@trinity.fluff.org>
References: <20090109121026.052643915@fluff.org.uk> <20090111234903.ZZRA012@mailhub.coreip.homeip.net> <1231751234.23618.6.camel@petitemort> <20090112212907.ZZRA012@mailhub.coreip.homeip.net> <1231838958.30531.3.camel@petitemort> <20090114053515.GC4375@dtor-d630.eng.vmware.com> <1231954613.9219.8.camel@ataraxia>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from trinity.fluff.org ([89.145.97.151]:42168 "EHLO
	trinity.fluff.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752593AbZAOPkj (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 15 Jan 2009 10:40:39 -0500
Content-Disposition: inline
In-Reply-To: <1231954613.9219.8.camel@ataraxia>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Silverstone <dsilvers@simtec.co.uk>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Ben Dooks <ben-linux@fluff.org>, linux-input@vger.kernel.org, vince@simtec.co.uk

On Wed, Jan 14, 2009 at 05:36:53PM +0000, Daniel Silverstone wrote:
> On Tue, 2009-01-13 at 21:35 -0800, Dmitry Torokhov wrote:
> > > As I understand it; yes. (Some bits of hardware really are hideous
> > > things) Indeed if the driver fails to load quickly enough, the device
> > > might disconnect/reconnect before the driver can get hold of it.
> > Geez... you sure it wasn't just broken device/batch?
> 
> Nope, the datasheet proudly proclaims this watchdog functionality.

Would be useful to add a comment about that being the primary function
for the irq_always flag, ie:

+       /* Always service the USB devices irq not just when the input device is
+        * open. This is often for devices that have a watchdog which watches
+	 * the polling process.
+        */
 
> > > Unfortunately it's often harder to get people to change their userland
> > > than their kernel. It seems a pity to make the driver less useful during
> > > any longer-term effort to fix TSLIB. If acceptance of this patch is
> > > predicated on removing that then I guess we'll have to discuss it
> > > amongst ourselves and try and work out what we'd rather do. Is removing
> > > the fake pressure report a requirement or a would-like?
> > I just checked TSLIB and the change to recognize devices that do not
> > report pressure was applied 2 months ago so everything should work fine
> > now. I do not think that we need to implement workarounds in newly
> > added drivers just because users are not willing to upgrade their
> > TSLIB installation.
> 
> I see. I shall look into sorting out a fresh patch without fake
> pressure.

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.

