From: Onkalo Samu <samu.p.onkalo@nokia.com>
Subject: Re: [PATCH 1/1] TWL4030 keypad: keypad lock / unlock
Date: Mon, 23 Nov 2009 14:05:55 +0200
Message-ID: <1258977955.5272.37.camel@4fid08082>
References: <1257841448-12757-1-git-send-email-samu.p.onkalo@nokia.com>
	 <1257841448-12757-2-git-send-email-samu.p.onkalo@nokia.com>
	 <20091110134329.GB30911@sirena.org.uk>
	 <20091110172637.GB15263@core.coreip.homeip.net>
	 <1257933456.3507.42.camel@4fid08082>
	 <20091111100837.GA6263@rakim.wolfsonmicro.main>
Reply-To: samu.p.onkalo@nokia.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:48352 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757206AbZKWMGE (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 23 Nov 2009 07:06:04 -0500
In-Reply-To: <20091111100837.GA6263@rakim.wolfsonmicro.main>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: ext Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: ext Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Wed, 2009-11-11 at 11:08 +0100, ext Mark Brown wrote:
> On Wed, Nov 11, 2009 at 11:57:36AM +0200, Onkalo Samu wrote:
> > On Tue, 2009-11-10 at 18:26 +0100, ext Dmitry Torokhov wrote:
> 
> > > It seems that Samu's patch is a bit different - it completely disables
> > > the keypad. But I wonder if it needs the special attribute or the same
> > > can be simply achieved by simply closing event device when it is not
> > > needed. Or maybe unbinding driver through sysfs.
> 
> > Yes, purpose is to provide keylock feature which totally disables the
> > keymatrix. This way system is not even aware that some key was pressed.
> > It also helps to save power since unnecessary interrupts are not
> > received.
> 
> OK, that's not what your patch description sounded like - it was talking
> specifically about preventing resume so I thought it was focused on
> suspend and resume.
> 
> > It seems that several userspace programs are reading the device. I have
> > no idea how to get all the users to close the device when keylock is
> > needed. Could be quite big number of changes to here and there in
> > userspace side.
> 
> This sounds like something that should have a generic API for - keylock
> functionality is a very common feature.

Hi

I agree that patch description was much too short and inaccurate.
Description must be updated to cover changes better and to tell clearly
that purpose is to provide master switch for disabling keypad HW without
closing all users of the device.

I'm wondering if the implementation is otherwise ok?
twl4030 keypad is more or less connected to omap based systems and this
kind of disabling and enabling feature is clearly targetted to embedded
systems. One more generic way could be to add ioctl to evdev driver
which calls chip-specific driver for disabling / enabling the keypad.
It is then up to chip specific driver to setup necessary callback
functions which makes actual job. Does this sound bad?

-Samu



