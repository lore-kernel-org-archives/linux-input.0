From: Chase Douglas <chase.douglas@canonical.com>
Subject: Re: New multitouch touchscreen over serial support
Date: Wed, 26 May 2010 20:10:12 -0400
Message-ID: <1274919012.317.57.camel@mini>
References: <1274912965.4128.43.camel@cndougla-ubuntu>
	 <AANLkTilRYhWUlR57ZdVIb0wH-8zKwNDXnUQAu1vFLGpz@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from adelie.canonical.com ([91.189.90.139]:35427 "EHLO
	adelie.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753862Ab0E0AKS (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 26 May 2010 20:10:18 -0400
In-Reply-To: <AANLkTilRYhWUlR57ZdVIb0wH-8zKwNDXnUQAu1vFLGpz@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: linux-input <linux-input@vger.kernel.org>

On Wed, 2010-05-26 at 15:52 -0700, Ping Cheng wrote:
> On Wed, May 26, 2010 at 3:29 PM, Chase Douglas
> <chase.douglas@canonical.com> wrote:
> > IMHO, the best support for this driver would be as a
> > kernel module that could use the input subsystem to send multitouch
> > events up through the evdev interface.
> 
> Sure, you can add yours and a bunch of the other serial WACfxxx
> devices into the kernel under input/touchscreen (I believe Jaya Kumar
> <jayakumar.lkml@gmail.com> has added the pen-only one there already).
> But you would need to update the Wacom X driver as well.  Without the
> proper X driver to work with it, kernel driver is pretty much useless.
>  Or you may be able to let X evdev driver take care of it as a generic
> touch screen device. I don't know how good the X evdev driver handles
> the touch events though.

This is actually why I think it should be in the kernel instead of in X.
The kernel has an interface for multitouch events through evdev. It's
standardized, and the X multitouch support will be predicated on it. So
if we want any multitouch support for these devices in linux, it will
have to go through the kernel input subsystem one way or another.

Also, an evdev based driver shouldn't require any new X support.

(I'm new to linux input stuff, if anyone feels I've mischaracterized
multitouch support in linux, please speak up :)

> > Do you have any information on this device?
> 
> What kind of information do you need?  I have the protocol and you can
> get one if you sign an NDA with Wacom.
> 
> > Would it be possible to write a driver?
> 
> Anything is possible on Linux :).  Someone has to do the work though.
> I do not have time to work on it. That is the reality.

Sure. I am personally interested in writing the driver. I need to do
some work on my end before I can commit to anything, but I will get back
to you with more details.

Thanks,

-- Chase

