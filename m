From: Rafi Rubin <rafi@seas.upenn.edu>
Subject: Re: calibrating a hid device
Date: Tue, 25 May 2010 03:15:42 -0700
Message-ID: <1274782542.1572.14.camel@tron>
References: <4BFB03B5.5030404@seas.upenn.edu>
	  <Pine.LNX.4.44L0.1005242151320.8440-100000@netrider.rowland.org>
Reply-To: Rafi Rubin <rafi@seas.upenn.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from LION.seas.upenn.edu ([158.130.12.194]:35257 "EHLO
	lion.seas.upenn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754911Ab0EYKQI (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 25 May 2010 06:16:08 -0400
In-Reply-To: <Pine.LNX.4.44L0.1005242151320.8440-100000@netrider.rowland.org>
Content-ID: <1274782542.1572.13.camel@tron>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input <linux-input@vger.kernel.org>, linux-usb@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>


----- Original message -----
> On Mon, 24 May 2010, Rafi Rubin wrote:
>
> > Ok, pardon that excessive attachments.=C2=A0 Attached is a snip of =
the kernel code,
> > just the sysfs function, the user space equivalent, and logs of bot=
h (with the
> > time stamps cropped out for comparison.
>
> Since the logs are the same, up to the point where the interrupt-IN
> request is cancelled, it's logical to assume that the difference was
> caused by something that happened before you began the usbmon traces.
>
> Do it again, only this time start the traces before plugging in the
> device.=C2=A0 That way we'll get a complete record.=C2=A0 And don't w=
orry about
> cropping out the timestamps; sometimes they reveal useful information=
=2E=C2=A0
> For example, here they would have told us if the interrupt-IN request
> failed because it timed out too quickly.
>
> > Also please put on slop code filter glasses before reading the code=
, I hold no
> > responsibility to damaged eyes or loss of sanity.=C2=A0 It will be =
cleaned up,
> > later.
>
> Aside from not using the predefined constants for the bRequestType
> values, what stands out most is that you're using I/O buffers allocat=
ed
> on the stack.=C2=A0 That's a no-no (not all architectures are capable=
 of
> doing DMA to stack-based locations); I/O buffers should be allocated
> dynamically using kmalloc.
>
> Alan Stern

thanks for the feedback.  The events are really fast on one of my digit=
izer, yet seem to be not returning on another.  I'm also starting to th=
ink that some of the returns that I thought were erroneous on the good =
device, might have a different meaning, such as perhaps "already well c=
alibrated, nothing interesting to report".

Sorry about the raw values for request types, I've been keeping them vi=
sually similar to the usbmon traffic for my benefit, until I'm comforta=
ble that I've got it all good enough.

As for the logs, I cropped copies for inspection with a highlighting di=
ff tool, I will make sure to send the full versions in the future.

I need to tweak it a bit more, and then should be able to give more det=
ails about what's going right and wrong.


Rafi
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
