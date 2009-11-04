From: Mika Westerberg <mika.westerberg@iki.fi>
Subject: Re: [RFC PATCH 1/1] Input: gpio-keys: export gpio key information
	through sysfs
Date: Wed, 4 Nov 2009 11:06:28 +0200
Message-ID: <20091104090628.GG31062@gw.healthdatacare.com>
References: <cover.1256298993.git.ext-mika.1.westerberg@nokia.com> <937a56e01181bef04c6661dc61032c1d08269cfa.1256298993.git.ext-mika.1.westerberg@nokia.com> <20091028054317.GB2368@core.coreip.homeip.net> <20091028105001.GB26199@esdhcp04058.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bw0-f227.google.com ([209.85.218.227]:39672 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754821AbZKDJG2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 4 Nov 2009 04:06:28 -0500
Received: by bwz27 with SMTP id 27so8582554bwz.21
        for <linux-input@vger.kernel.org>; Wed, 04 Nov 2009 01:06:32 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20091028105001.GB26199@esdhcp04058.research.nokia.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Wed, Oct 28, 2009 at 12:50:01PM +0200, Mika Westerberg wrote:
> Hi,
> 
> On Wed, Oct 28, 2009 at 06:43:17AM +0100, ext Dmitry Torokhov wrote:
> > 
> > On Fri, Oct 23, 2009 at 03:15:46PM +0300, Mika Westerberg wrote:
> > > From: Mika Westerberg <ext-mika.1.westerberg@nokia.com>
> > > 
> > > In some embedded devices gpio lines are used as keys/buttons
> > > through input layer and gpio-keys.  It is, however, impossible
> > > to disable gpio lines separately from waking up the cpu.  For
> > > example when device is locked we don't want accidental camera
> > > button press to cause the device to wakeup just to notice that
> > > it should continue sleeping.
> > > 
> > > This patch exports gpio-keys through sysfs and allows userland
> > > to control whether single gpio line should wakeup the cpu or not.
> > > 
> > > Sysfs interface is accessible via:
> > > 
> > > 	/sys/class/input/gpio-keys/input/input0/gpio-key.N/
> > > 
> > > Following attributes are exported per gpio key:
> > > 
> > > 	/code    ... input event code (ro)
> > > 	/type    ... input event type (ro)
> > > 	/desc    ... description of the button (ro)
> > > 	/disable ... enable/disable gpio line (rw)
> > > 
> > > Userspace should be able to find out what key to disable/enable
> > > by investigating {code, type, desc} tuple.
> > > 
> > 
> > I think registering a full-blown device for every key is way too much,
> > given that most consumers of gpio-keys driver are embedded... Besides, I
> > don't think this should be driven from userspace. Board (platform) code
> > should know what GPIO make sense as wake up sources for the particular
> > device and should set up platform data accordingly.
> 
> Thanks for the comments.
> 
> This was done because setting these from board files is not enough
> as this is something that should be dynamically configured.  For example
> when we lock the device, there are some buttons (gpio lines) that will
> wakeup the device but not all of them.  When device goes to sleep (but
> is not locked) then there are additional buttons that can be used to
> wake it up.
> 
> We have daemon that does this stuff depending on system state so we
> need some way to let userspace to control these.
> 
> Do you have any suggestions or alternative ways of doing this?  Would
> it be beneficial for other consumers to dynamically configure these
> lines (maybe not through sysfs but for example via ioctl)?

Hi Dmitry,

Sorry to bother you again.  Do you have any comments on this?  How about
adding few ioctl()s to disable/enable the keys on the input device?

Thanks,
MW
