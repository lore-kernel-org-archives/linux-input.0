From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [RFC PATCH 1/1] Input: gpio-keys: export gpio key information
	through sysfs
Date: Thu, 5 Nov 2009 23:52:20 -0800
Message-ID: <20091106075220.GC11311@core.coreip.homeip.net>
References: <cover.1256298993.git.ext-mika.1.westerberg@nokia.com> <937a56e01181bef04c6661dc61032c1d08269cfa.1256298993.git.ext-mika.1.westerberg@nokia.com> <20091028054317.GB2368@core.coreip.homeip.net> <20091028105001.GB26199@esdhcp04058.research.nokia.com> <20091104090628.GG31062@gw.healthdatacare.com> <1257326759.21596.92.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pw0-f42.google.com ([209.85.160.42]:62242 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751270AbZKFHwU (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 6 Nov 2009 02:52:20 -0500
Received: by pwj9 with SMTP id 9so508282pwj.21
        for <linux-input@vger.kernel.org>; Thu, 05 Nov 2009 23:52:25 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1257326759.21596.92.camel@localhost>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Artem Bityutskiy <dedekind1@gmail.com>
Cc: Mika Westerberg <mika.westerberg@iki.fi>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Wed, Nov 04, 2009 at 11:25:59AM +0200, Artem Bityutskiy wrote:
> On Wed, 2009-11-04 at 11:06 +0200, Mika Westerberg wrote:
> > On Wed, Oct 28, 2009 at 12:50:01PM +0200, Mika Westerberg wrote:
> > > Hi,
> > > 
> > > On Wed, Oct 28, 2009 at 06:43:17AM +0100, ext Dmitry Torokhov wrote:
> > > > 
> > > > On Fri, Oct 23, 2009 at 03:15:46PM +0300, Mika Westerberg wrote:
> > > > > From: Mika Westerberg <ext-mika.1.westerberg@nokia.com>
> > > > > 
> > > > > In some embedded devices gpio lines are used as keys/buttons
> > > > > through input layer and gpio-keys.  It is, however, impossible
> > > > > to disable gpio lines separately from waking up the cpu.  For
> > > > > example when device is locked we don't want accidental camera
> > > > > button press to cause the device to wakeup just to notice that
> > > > > it should continue sleeping.
> > > > > 
> > > > > This patch exports gpio-keys through sysfs and allows userland
> > > > > to control whether single gpio line should wakeup the cpu or not.
> > > > > 
> > > > > Sysfs interface is accessible via:
> > > > > 
> > > > > 	/sys/class/input/gpio-keys/input/input0/gpio-key.N/
> > > > > 
> > > > > Following attributes are exported per gpio key:
> > > > > 
> > > > > 	/code    ... input event code (ro)
> > > > > 	/type    ... input event type (ro)
> > > > > 	/desc    ... description of the button (ro)
> > > > > 	/disable ... enable/disable gpio line (rw)
> > > > > 
> > > > > Userspace should be able to find out what key to disable/enable
> > > > > by investigating {code, type, desc} tuple.
> > > > > 
> > > > 
> > > > I think registering a full-blown device for every key is way too much,
> > > > given that most consumers of gpio-keys driver are embedded... Besides, I
> > > > don't think this should be driven from userspace. Board (platform) code
> > > > should know what GPIO make sense as wake up sources for the particular
> > > > device and should set up platform data accordingly.
> 
> For example, on N900 we want to disable the lens cover / proximity / etc
> gpios when the phones' screen is locked. Simply because we do not want
> the lines to generate interrupts, wakes up the CPU and waste our battery
> energy. But we do not want to disable the screen lock gpio, and some
> incoming call related gpios.
> 
> So we really do want this to be userspace-driven.
> 

OK, then maybe we should use 2 attributes, one showing gpios that can
be used for wakeup and one showing gpios that are currently set up as
wakeup sources. These can be built on using bitmap_scnlistprintf() and
bitmap_parselist() and can work with either GPIO numbers or keycodes.

-- 
Dmitry
