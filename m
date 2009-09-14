From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: input subsystem question
Date: Mon, 14 Sep 2009 01:21:48 -0700
Message-ID: <20090914082148.GD11854@core.coreip.homeip.net>
References: <loom.20090910T101706-918@post.gmane.org> <20090910165628.CA47F526EC9@mailhub.coreip.homeip.net> <loom.20090910T195819-563@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qy0-f172.google.com ([209.85.221.172]:44096 "EHLO
	mail-qy0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750891AbZINIVt (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 14 Sep 2009 04:21:49 -0400
Received: by qyk2 with SMTP id 2so2228035qyk.21
        for <linux-input@vger.kernel.org>; Mon, 14 Sep 2009 01:21:52 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <loom.20090910T195819-563@post.gmane.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Max Sivkov <maxsivkov@gmail.com>
Cc: linux-input@vger.kernel.org

On Thu, Sep 10, 2009 at 06:15:18PM +0000, Max Sivkov wrote:
> Dmitry Torokhov <dmitry.torokhov <at> gmail.com> writes:
> 
> > 
> > Hi Max,
> > 
> > On Thursday 10 September 2009 01:20:02 am Max Sivkov wrote:
> > > Hello!
> > > I have a question about using of the input subsystem.
> > > Is there any way to filter input messages from a device (keyboard). I.e. I
> > > need to have ability to pass some messages from the device, and block
> > > others. Could community point me to the right place where I can find how to
> > > do that?
> > 
> > There are different options, we'd need more context...
> > 
> 
> 
> Dmitry,
> 
> Thanks for the response.
> 
> Driver/user mode daemon should get scancodes (events) from the input device
> (keyboard), detect particular scancodes and put them to the internal buffer to
> send to the user space later time.
> 
> I'm stucked here, because after getting event from the input subsystem I will
> need to remove the event from the input queue. 
> As I understood events mechanism is useful if one needs to gather input event's
> (keylogger) w/o modifying input queue.
> 
> Currently my driver for 2.6.x kernels is based on a atkbd driver with some
> modifications, but this method has one big disadvantage: when input subsystem
> developers change something in the input subsystem I have to do the annoying job
> once again (take atkbd.c, add my functionality, rebuild kernel, etc, etc).
> 

If you want to work on keycode level (KEY_* definitions) then you could
use a user-space program that "grabs" input device, filters out the
events it is interested in and injects events that it has no interested
in back into kernel via uinput.

If you want to work with AT keyboard scancodes and intercept them before
they reach atkbd driver - then we currently don't have such an option
although one is desired since some laptop vendors like to inject
non-keyboard data into keyboard stream.

-- 
Dmitry
