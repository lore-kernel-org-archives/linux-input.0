From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: How to properly extend uinput API
Date: Mon, 2 May 2016 15:51:47 -0700
Message-ID: <20160502225147.GD37394@dtor-ws>
References: <51caa374-1fdc-bcc0-3aac-20292a77571b@m-reimer.de>
 <20160502183542.GC37394@dtor-ws>
 <74df5cb0-9bbb-835a-82ca-aa8527f4d024@m-reimer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f181.google.com ([209.85.192.181]:35924 "EHLO
	mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932263AbcEBWvv (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 2 May 2016 18:51:51 -0400
Received: by mail-pf0-f181.google.com with SMTP id c189so1305450pfb.3
        for <linux-input@vger.kernel.org>; Mon, 02 May 2016 15:51:51 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <74df5cb0-9bbb-835a-82ca-aa8527f4d024@m-reimer.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Manuel Reimer <mail+linux-input@m-reimer.de>
Cc: linux-input <linux-input@vger.kernel.org>

On Mon, May 02, 2016 at 11:57:21PM +0200, Manuel Reimer wrote:
> On 05/02/2016 08:35 PM, Dmitry Torokhov wrote:
> >I am not sure that exposing ff-memless to userspace is a good idea.
> 
> It would prevent code-duplication, as something, that already
> exists, would be usable for user mode drivers.
> 
> >Right now what we have is a supporting library for several kernel
> >modules and there were considerations to change it to work differently.
> 
> But even then there would still be a need for support for input
> devices with just two rumble motors. I guess this is the most common
> case.
> 
> While developing my own uinput driver, I had a look at some
> different projects and all of them at least try to somehow limit the
> complexity of the existing API. Many of them doing it wrong as
> simulating all the events, ff-memless can do, on two motors isn't an
> easy task.

ff-memless does not really care about number of motors, it just
schedules the driver to be called at given times and tries to combine
several effects into resulting one. How to handle combined event is left
up to the hardware driver.

> 
> >I'd rather userspace took care of handling dumb devices if t decided to
> >handle device communication instead of leaving it to the kernel.
> 
> I considered that and I don't have any clue on how to port the
> ff-memless code to work in usermode. It uses too much kernel
> specific features.

That's because userspace has different rules and the resulting userspace
code will probably be different from kernel side. In userspace you can,
for example, use floating point easily. Or you can create a separate
thread for handling force feedback tasks for the device. Or do something
else.

> 
> The easiest way to extend the uinput API could be to introduce a new
> ioctl call to initialize a "memless" device. This way the
> uinput-module knows it has to use ff-memless for this device.
> 
> And to get the events back to usermode, the simplest way is to just
> pass the two motor values (both 16 bits) in the value field of an
> input event (32 bits).

Nowhere in the memoryless code we have "2 motor values". You are
basically designing an API for single device and that is not a good
idea.

> This doesn't need all the callback stuff and
> probably even is more robust (current API tends to create
> non-killable processes if the uinput daemon exits before the last
> application, using the device, exits).

Hmm, it should not, can you post some traces to show where it gets
stuck so we can fix it?

> 
> I already have some test code running. So far I didn't try with real
> hardware, but my current results look promising.
> 
> 
> Does your response mean, that there is no chance to get a patch for
> this accepted? If so, my only choice would be to ship this as patch
> with my own code, requiring the user to compile his own kernel.

So far I am convinced that relying on kernel implementation is a bad
idea. You should be able to take cues from the kernel code and create
userspace library providing similar features, but in the way that is
flexible and make sense in userspace. Like I said, we might change how
ff-memless works in the kernel and we do not need to tie it up with
userspace ABI.

Thanks.

-- 
Dmitry
