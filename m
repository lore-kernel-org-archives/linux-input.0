From: Manuel Reimer <mail+linux-input@m-reimer.de>
Subject: Re: How to properly extend uinput API
Date: Mon, 2 May 2016 23:57:21 +0200
Message-ID: <74df5cb0-9bbb-835a-82ca-aa8527f4d024@m-reimer.de>
References: <51caa374-1fdc-bcc0-3aac-20292a77571b@m-reimer.de>
 <20160502183542.GC37394@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.mailbox.org ([80.241.60.215]:53168 "EHLO mx2.mailbox.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754411AbcEBV50 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 2 May 2016 17:57:26 -0400
In-Reply-To: <20160502183542.GC37394@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input <linux-input@vger.kernel.org>

On 05/02/2016 08:35 PM, Dmitry Torokhov wrote:
> I am not sure that exposing ff-memless to userspace is a good idea.

It would prevent code-duplication, as something, that already exists, 
would be usable for user mode drivers.

> Right now what we have is a supporting library for several kernel
> modules and there were considerations to change it to work differently.

But even then there would still be a need for support for input devices 
with just two rumble motors. I guess this is the most common case.

While developing my own uinput driver, I had a look at some different 
projects and all of them at least try to somehow limit the complexity of 
the existing API. Many of them doing it wrong as simulating all the 
events, ff-memless can do, on two motors isn't an easy task.

> I'd rather userspace took care of handling dumb devices if t decided to
> handle device communication instead of leaving it to the kernel.

I considered that and I don't have any clue on how to port the 
ff-memless code to work in usermode. It uses too much kernel specific 
features.


The easiest way to extend the uinput API could be to introduce a new 
ioctl call to initialize a "memless" device. This way the uinput-module 
knows it has to use ff-memless for this device.

And to get the events back to usermode, the simplest way is to just pass 
the two motor values (both 16 bits) in the value field of an input event 
(32 bits). This doesn't need all the callback stuff and probably even is 
more robust (current API tends to create non-killable processes if the 
uinput daemon exits before the last application, using the device, exits).

I already have some test code running. So far I didn't try with real 
hardware, but my current results look promising.


Does your response mean, that there is no chance to get a patch for this 
accepted? If so, my only choice would be to ship this as patch with my 
own code, requiring the user to compile his own kernel.

Manuel
