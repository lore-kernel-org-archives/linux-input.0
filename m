From: Mika Westerberg <ext-mika.1.westerberg@nokia.com>
Subject: Re: [RFC PATCH 1/1] Input: gpio-keys: export gpio key information
	through sysfs
Date: Wed, 28 Oct 2009 12:50:01 +0200
Message-ID: <20091028105001.GB26199@esdhcp04058.research.nokia.com>
References: <cover.1256298993.git.ext-mika.1.westerberg@nokia.com> <937a56e01181bef04c6661dc61032c1d08269cfa.1256298993.git.ext-mika.1.westerberg@nokia.com> <20091028054317.GB2368@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:38780 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752014AbZJ1KyF (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 28 Oct 2009 06:54:05 -0400
Content-Disposition: inline
In-Reply-To: <20091028054317.GB2368@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: ext Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Hi,

On Wed, Oct 28, 2009 at 06:43:17AM +0100, ext Dmitry Torokhov wrote:
> 
> On Fri, Oct 23, 2009 at 03:15:46PM +0300, Mika Westerberg wrote:
> > From: Mika Westerberg <ext-mika.1.westerberg@nokia.com>
> > 
> > In some embedded devices gpio lines are used as keys/buttons
> > through input layer and gpio-keys.  It is, however, impossible
> > to disable gpio lines separately from waking up the cpu.  For
> > example when device is locked we don't want accidental camera
> > button press to cause the device to wakeup just to notice that
> > it should continue sleeping.
> > 
> > This patch exports gpio-keys through sysfs and allows userland
> > to control whether single gpio line should wakeup the cpu or not.
> > 
> > Sysfs interface is accessible via:
> > 
> > 	/sys/class/input/gpio-keys/input/input0/gpio-key.N/
> > 
> > Following attributes are exported per gpio key:
> > 
> > 	/code    ... input event code (ro)
> > 	/type    ... input event type (ro)
> > 	/desc    ... description of the button (ro)
> > 	/disable ... enable/disable gpio line (rw)
> > 
> > Userspace should be able to find out what key to disable/enable
> > by investigating {code, type, desc} tuple.
> > 
> 
> I think registering a full-blown device for every key is way too much,
> given that most consumers of gpio-keys driver are embedded... Besides, I
> don't think this should be driven from userspace. Board (platform) code
> should know what GPIO make sense as wake up sources for the particular
> device and should set up platform data accordingly.

Thanks for the comments.

This was done because setting these from board files is not enough
as this is something that should be dynamically configured.  For example
when we lock the device, there are some buttons (gpio lines) that will
wakeup the device but not all of them.  When device goes to sleep (but
is not locked) then there are additional buttons that can be used to
wake it up.

We have daemon that does this stuff depending on system state so we
need some way to let userspace to control these.

Do you have any suggestions or alternative ways of doing this?  Would
it be beneficial for other consumers to dynamically configure these
lines (maybe not through sysfs but for example via ioctl)?

Thanks,
MW
