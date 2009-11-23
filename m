From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/1] TWL4030 keypad: keypad lock / unlock
Date: Mon, 23 Nov 2009 13:54:36 +0000
Message-ID: <20091123135435.GG24326@rakim.wolfsonmicro.main>
References: <1257841448-12757-1-git-send-email-samu.p.onkalo@nokia.com>
 <1257841448-12757-2-git-send-email-samu.p.onkalo@nokia.com>
 <20091110134329.GB30911@sirena.org.uk>
 <20091110172637.GB15263@core.coreip.homeip.net>
 <1257933456.3507.42.camel@4fid08082>
 <20091111100837.GA6263@rakim.wolfsonmicro.main>
 <1258977955.5272.37.camel@4fid08082>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:35316 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751738AbZKWNya (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 23 Nov 2009 08:54:30 -0500
Content-Disposition: inline
In-Reply-To: <1258977955.5272.37.camel@4fid08082>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Onkalo Samu <samu.p.onkalo@nokia.com>
Cc: ext Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Mon, Nov 23, 2009 at 02:05:55PM +0200, Onkalo Samu wrote:

> twl4030 keypad is more or less connected to omap based systems and this
> kind of disabling and enabling feature is clearly targetted to embedded

There's rather a lot of embedded systems and off the shelf application
stacks for them so having an interface that isn't driver-specific is
also useful for them.

> systems. One more generic way could be to add ioctl to evdev driver
> which calls chip-specific driver for disabling / enabling the keypad.
> It is then up to chip specific driver to setup necessary callback
> functions which makes actual job. Does this sound bad?

Something along these lines which makes the user space interface part of
the common code, enabled if driver provides functions to implement the
behaviour does seem like a good approach.

sysfs might be easier to use than an ioctl(), though.
