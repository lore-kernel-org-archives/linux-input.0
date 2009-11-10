From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/1] TWL4030 keypad: keypad lock / unlock
Date: Tue, 10 Nov 2009 09:26:37 -0800
Message-ID: <20091110172637.GB15263@core.coreip.homeip.net>
References: <1257841448-12757-1-git-send-email-samu.p.onkalo@nokia.com> <1257841448-12757-2-git-send-email-samu.p.onkalo@nokia.com> <20091110134329.GB30911@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-px0-f173.google.com ([209.85.216.173]:45575 "EHLO
	mail-px0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752603AbZKJR0h (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 10 Nov 2009 12:26:37 -0500
Received: by pxi3 with SMTP id 3so174256pxi.22
        for <linux-input@vger.kernel.org>; Tue, 10 Nov 2009 09:26:43 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20091110134329.GB30911@sirena.org.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Samu Onkalo <samu.p.onkalo@nokia.com>, linux-input@vger.kernel.org

On Tue, Nov 10, 2009 at 01:43:30PM +0000, Mark Brown wrote:
> On Tue, Nov 10, 2009 at 10:24:08AM +0200, Samu Onkalo wrote:
> > Sysfs interface for disabling and enabling keypad HW and
> > PM management functions added to twl4030 keypad driver.
> 
> Might be nice to have the longer explanation in your cover letter in the
> patch description...
> 
> > Signed-off-by: Samu Onkalo <samu.p.onkalo@nokia.com>
> 
> Shouldn't this be done via the existing device wakeup API?  That also
> presents a sysfs control (power/wakeup IIRC).  The driver calls
> device_init_wakeup() to flag support for this at startup then checks
> device_may_wakeup() when suspending and configures the hardware
> appropriately.

It seems that Samu's patch is a bit different - it completely disables
the keypad. But I wonder if it needs the special attribute or the same
can be simply achieved by simply closing event device when it is not
needed. Or maybe unbinding driver through sysfs.

Overall it seems that every input device used in embedded has it's own
way of disabling itself, we need a generic solution... Maybe
userspace-controlled PM is the answer).

-- 
Dmitry
