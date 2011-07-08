From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: INPUT_COMPAT_TEST
Date: Fri, 08 Jul 2011 15:22:24 -0700
Message-ID: <4E178320.7050401@zytor.com>
References: <4E17504F.5070806@zytor.com> <20110708204630.GA28623@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:49287 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750717Ab1GHWWf (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 8 Jul 2011 18:22:35 -0400
In-Reply-To: <20110708204630.GA28623@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Philip Langdale <philipl@overt.org>, linux-input@vger.kernel.org, "H.J. Lu" <hjl.tools@gmail.com>

On 07/08/2011 01:46 PM, Dmitry Torokhov wrote:
> 
> One such place is evdev read/write - unfortunately "struct input_event"
> was not created 32/64 bit safe so we need to mangle it when running 32
> bit userspace with 64-bit kernels. See drivers/input/input-compat.c.
> 

So these are actually present on all the read/write path system calls.
That is truly awful.

Do you happen to know if there is any kind of passing around of file
descriptors, or if this could perhaps be tied to file descriptor state.

> We also have similar issues with uinput API and uploading force-freedack
> effects.

Those are ioctl, though, if I read the code right, or did I miss
something obvious?

>> but it looks like input also
>> does things like change the format(?!) of sysfs entries, all of which
>> makes me very concerned.
> 
> Another historical unfortunate decision. /proc/bus/input (and later
> added sysfs entries) export bitmaps in "compressed" form so that
> userspace can not figure out the size of the segment (32 or 64 bit) on
> its own so we have to convert to userspace size for longs.

"Compressed form"?  Could you give a concrete example?  They look like
they are emitted in text form.

Do you have a program that someone could run to see the differences
between compat and non-compat paths?

	-hpa
