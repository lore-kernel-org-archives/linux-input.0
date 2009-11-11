From: Onkalo Samu <samu.p.onkalo@nokia.com>
Subject: Re: [PATCH 1/1] TWL4030 keypad: keypad lock / unlock
Date: Wed, 11 Nov 2009 11:57:36 +0200
Message-ID: <1257933456.3507.42.camel@4fid08082>
References: <1257841448-12757-1-git-send-email-samu.p.onkalo@nokia.com>
	 <1257841448-12757-2-git-send-email-samu.p.onkalo@nokia.com>
	 <20091110134329.GB30911@sirena.org.uk>
	 <20091110172637.GB15263@core.coreip.homeip.net>
Reply-To: samu.p.onkalo@nokia.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:19878 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756518AbZKKJ5i (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 11 Nov 2009 04:57:38 -0500
In-Reply-To: <20091110172637.GB15263@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: ext Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Tue, 2009-11-10 at 18:26 +0100, ext Dmitry Torokhov wrote:
> On Tue, Nov 10, 2009 at 01:43:30PM +0000, Mark Brown wrote:
> > On Tue, Nov 10, 2009 at 10:24:08AM +0200, Samu Onkalo wrote:
> > > Sysfs interface for disabling and enabling keypad HW and
> > > PM management functions added to twl4030 keypad driver.
> > 
> > Might be nice to have the longer explanation in your cover letter in the
> > patch description...

Definitely true. Thanks for advice.

> > 
> > > Signed-off-by: Samu Onkalo <samu.p.onkalo@nokia.com>
> > 
> > Shouldn't this be done via the existing device wakeup API?  That also
> > presents a sysfs control (power/wakeup IIRC).  The driver calls
> > device_init_wakeup() to flag support for this at startup then checks
> > device_may_wakeup() when suspending and configures the hardware
> > appropriately.
> 
> It seems that Samu's patch is a bit different - it completely disables
> the keypad. But I wonder if it needs the special attribute or the same
> can be simply achieved by simply closing event device when it is not
> needed. Or maybe unbinding driver through sysfs.

Yes, purpose is to provide keylock feature which totally disables the
keymatrix. This way system is not even aware that some key was pressed.
It also helps to save power since unnecessary interrupts are not
received.

It seems that several userspace programs are reading the device. I have
no idea how to get all the users to close the device when keylock is
needed. Could be quite big number of changes to here and there in
userspace side.

A master switch in sysfs would be quite simple way to control the
keylock. Decision can be done in one place and all the users of the
device are locked or unlocked. 

I'm not familiar with bind / unbind. I tried to play with this.
It seems that I managed to unbind the driver since the /dev/input/eventx
disappeared. Similarly bind restored the device node. Userspace
program which tried to access device node was not happy at all after
unbind.

> Overall it seems that every input device used in embedded has it's own
> way of disabling itself, we need a generic solution... Maybe
> userspace-controlled PM is the answer).

That is something which should be somehow handled. Depending on what is
happening at the userspace, there can be different needs for input
devices. Current way will be a mess since every driver has its own
tricks to save power. But power saving is really needed for embedded
devices.

Regards,
Samu





