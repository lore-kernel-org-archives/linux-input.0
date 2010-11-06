From: Michal Suchanek <hramrach@centrum.cz>
Subject: Re: [RFC] Multi-Touch (MT) support - arbitration or not
Date: Sat, 6 Nov 2010 16:53:02 +0100
Message-ID: <AANLkTin+S_jJAdw6gLH1RnbyD1EB6ChHCo9yNheLb_sg@mail.gmail.com>
References: <AANLkTin1svszp87Pysi5OCt5=JTSB-yVaAWF-42gfn9T@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:38656 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753481Ab0KFPxY (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 6 Nov 2010 11:53:24 -0400
Received: by wyb36 with SMTP id 36so2071771wyb.19
        for <linux-input@vger.kernel.org>; Sat, 06 Nov 2010 08:53:23 -0700 (PDT)
In-Reply-To: <AANLkTin1svszp87Pysi5OCt5=JTSB-yVaAWF-42gfn9T@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: "X.Org Devel List" <xorg-devel@lists.freedesktop.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Daniel Stone <daniel@fooishbar.org>, linux-input <linux-input@vger.kernel.org>

On 5 November 2010 19:47, Ping Cheng <pinglinux@gmail.com> wrote:
> Recent changes and discussion about MT support at LKML, UDS, and
> xorg-devel encouraged me to migrate Wacom MT devices to the slot-based
> MT protocol (introduced in kernel 2.6.36). Since Wacom supports both
> digitizer and touch devices, I need to decide how to report touch data
> when the pen is in proximity.
>
> My goal is to understand how X server would like the MT data to be
> reported from the kernel. I hope to keep kernel and X server driver MT
> support in sync so we can avoid unnecessary confusion or extra work in
> the userland.
>
> The existing solution for single touch events is to arbitrate touch
> when pen is in prox. This is based on the assumption that we do not
> want to have two cursors competing on the screen.

As a tablet user, not X developer I don't think it is desirable and
expected to register pen touch and finger touch together as a
multitouch. That is, if I wanted to trigger a multitouch feature I
would use fingers, not pen and finger. While it would be technically
possible to use the pen touch and finger touch together to trigger
multitouch I don't think it makes much sense.

Also it is a good idea to turn off (single) touch when pen is in
proximity because it is quite easy to accidentally touch the surface
while moving the pen.

This means that the protocol that sends abs events from pen when in
proximity and from finger otherwise would work well.

However, there is one feature that makes sort of sense and does not
work when touch is completely off. It might be possible to use touch
for button and pen for moving the cursor. I tried to use the pad
button on my Bamboo together with pen motion for right drags and it
seems somewhat easier than using the pen button.

So I would say that protocol that allows events from both pen and
touch at the same time is desirable in the long run but with some
options to filter the events when both pen and touch are used
together.

This gives basically three options

1) leave as is, turn off touch when pen is in proximity

2) report everything by kernel, put some filter on the touch events in
the  X driver (which defaults to killing most touch stuff when pen is
in proximity)

3) the same as above but put the filter in the kernel driver


2 or 3 is more flexible as people with some special uses can just turn
off the filter and get all events.

WRT X ease of development I would suggest that the same device should
never report different events based on pen proximity. Either the
device is in some "compatibility mode" and reports only one pointer as
per 1 or there are two separate pointers and they are just reported
out of proximity when the pointer positioning is not desirable (ie
when pen is out or when touch is off due to pen being in).

If somebody wants to have multitouch combining two different pointers
there is nothing stopping them, either with P&T pen and touch pointers
or completely unrelated devices.

Thanks

Michal
