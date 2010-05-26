From: Ping Cheng <pinglinux@gmail.com>
Subject: Re: New multitouch touchscreen over serial support
Date: Wed, 26 May 2010 15:52:17 -0700
Message-ID: <AANLkTilRYhWUlR57ZdVIb0wH-8zKwNDXnUQAu1vFLGpz@mail.gmail.com>
References: <1274912965.4128.43.camel@cndougla-ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:47004 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933312Ab0EZWwS (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 26 May 2010 18:52:18 -0400
Received: by pvg3 with SMTP id 3so1345909pvg.19
        for <linux-input@vger.kernel.org>; Wed, 26 May 2010 15:52:17 -0700 (PDT)
In-Reply-To: <1274912965.4128.43.camel@cndougla-ubuntu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chase Douglas <chase.douglas@canonical.com>
Cc: linux-input <linux-input@vger.kernel.org>

On Wed, May 26, 2010 at 3:29 PM, Chase Douglas
<chase.douglas@canonical.com> wrote:
> Ping,
>
> I've got one of the new HP Mini 5102 touchscreen netbooks, which has a
> wacom multitouch touchscreen over serial. I haven't found any support
> for this device in the kernel, it seems X reads from it directly using
> xf86-input-wacom.

You are right.  There is no Wacom kernel driver for the Wacom serial
ISD version 4 device you are using.  Everything is in the Wacom X
driver.

> IMHO, the best support for this driver would be as a
> kernel module that could use the input subsystem to send multitouch
> events up through the evdev interface.

Sure, you can add yours and a bunch of the other serial WACfxxx
devices into the kernel under input/touchscreen (I believe Jaya Kumar
<jayakumar.lkml@gmail.com> has added the pen-only one there already).
But you would need to update the Wacom X driver as well.  Without the
proper X driver to work with it, kernel driver is pretty much useless.
 Or you may be able to let X evdev driver take care of it as a generic
touch screen device. I don't know how good the X evdev driver handles
the touch events though.

> Do you have any information on this device?

What kind of information do you need?  I have the protocol and you can
get one if you sign an NDA with Wacom.

> Would it be possible to write a driver?

Anything is possible on Linux :).  Someone has to do the work though.
I do not have time to work on it. That is the reality.

Ping
