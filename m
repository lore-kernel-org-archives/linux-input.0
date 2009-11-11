From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/1] TWL4030 keypad: keypad lock / unlock
Date: Wed, 11 Nov 2009 10:08:37 +0000
Message-ID: <20091111100837.GA6263@rakim.wolfsonmicro.main>
References: <1257841448-12757-1-git-send-email-samu.p.onkalo@nokia.com>
 <1257841448-12757-2-git-send-email-samu.p.onkalo@nokia.com>
 <20091110134329.GB30911@sirena.org.uk>
 <20091110172637.GB15263@core.coreip.homeip.net>
 <1257933456.3507.42.camel@4fid08082>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:34763 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753325AbZKKKId (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 11 Nov 2009 05:08:33 -0500
Content-Disposition: inline
In-Reply-To: <1257933456.3507.42.camel@4fid08082>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Onkalo Samu <samu.p.onkalo@nokia.com>
Cc: ext Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Wed, Nov 11, 2009 at 11:57:36AM +0200, Onkalo Samu wrote:
> On Tue, 2009-11-10 at 18:26 +0100, ext Dmitry Torokhov wrote:

> > It seems that Samu's patch is a bit different - it completely disables
> > the keypad. But I wonder if it needs the special attribute or the same
> > can be simply achieved by simply closing event device when it is not
> > needed. Or maybe unbinding driver through sysfs.

> Yes, purpose is to provide keylock feature which totally disables the
> keymatrix. This way system is not even aware that some key was pressed.
> It also helps to save power since unnecessary interrupts are not
> received.

OK, that's not what your patch description sounded like - it was talking
specifically about preventing resume so I thought it was focused on
suspend and resume.

> It seems that several userspace programs are reading the device. I have
> no idea how to get all the users to close the device when keylock is
> needed. Could be quite big number of changes to here and there in
> userspace side.

This sounds like something that should have a generic API for - keylock
functionality is a very common feature.

> > Overall it seems that every input device used in embedded has it's own
> > way of disabling itself, we need a generic solution... Maybe
> > userspace-controlled PM is the answer).

> That is something which should be somehow handled. Depending on what is
> happening at the userspace, there can be different needs for input
> devices. Current way will be a mess since every driver has its own
> tricks to save power. But power saving is really needed for embedded
> devices.

It doesn't look that bad to me, to be honest - mostly it seems to be a
case of shutting down the device as much as possible when it's closed
plus other things that the particular device can get away with without
impacting actual operation.
