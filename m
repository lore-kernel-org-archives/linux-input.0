From: Ping Cheng <pinglinux@gmail.com>
Subject: Re: [RFC] Multi-Touch (MT) support - arbitration or not
Date: Sun, 7 Nov 2010 15:32:09 -0800
Message-ID: <AANLkTimHmFhAden9SvJMOFWtdodzyYWK+ePi2sqKuWsa@mail.gmail.com>
References: <AANLkTin1svszp87Pysi5OCt5=JTSB-yVaAWF-42gfn9T@mail.gmail.com>
	<AANLkTin+S_jJAdw6gLH1RnbyD1EB6ChHCo9yNheLb_sg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:54758 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753735Ab0KGXcL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 7 Nov 2010 18:32:11 -0500
Received: by wyb36 with SMTP id 36so2907866wyb.19
        for <linux-input@vger.kernel.org>; Sun, 07 Nov 2010 15:32:10 -0800 (PST)
In-Reply-To: <AANLkTin+S_jJAdw6gLH1RnbyD1EB6ChHCo9yNheLb_sg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Michal Suchanek <hramrach@centrum.cz>
Cc: "X.Org Devel List" <xorg-devel@lists.freedesktop.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Daniel Stone <daniel@fooishbar.org>, linux-input <linux-input@vger.kernel.org>

On Sat, Nov 6, 2010 at 8:53 AM, Michal Suchanek <hramrach@centrum.cz> w=
rote:
>
> As a tablet user, not X developer I don't think it is desirable and
> expected to register pen touch and finger touch together as a
> multitouch. That is, if I wanted to trigger a multitouch feature I
> would use fingers, not pen and finger. While it would be technically
> possible to use the pen touch and finger touch together to trigger
> multitouch I don't think it makes much sense.
>
> Also it is a good idea to turn off (single) touch when pen is in
> proximity because it is quite easy to accidentally touch the surface
> while moving the pen.
>
> This means that the protocol that sends abs events from pen when in
> proximity and from finger otherwise would work well.
>
> However, there is one feature that makes sort of sense and does not
> work when touch is completely off. It might be possible to use touch
> for button and pen for moving the cursor. I tried to use the pad
> button on my Bamboo together with pen motion for right drags and it
> seems somewhat easier than using the pen button.

Thank you for sharing your thoughts. This is the kind of "third party"
feedback that I wished for. So, you do see the value of reporting and
using both MT and pen data simultaneously.

> So I would say that protocol that allows events from both pen and
> touch at the same time is desirable in the long run but with some
> options to filter the events when both pen and touch are used
> together.
>
> This gives basically three options
>
> 1) leave as is, turn off touch when pen is in proximity
>
> 2) report everything by kernel, put some filter on the touch events i=
n
> the =A0X driver (which defaults to killing most touch stuff when pen =
is
> in proximity)
>
> 3) the same as above but put the filter in the kernel driver
>
>
> 2 or 3 is more flexible as people with some special uses can just tur=
n
> off the filter and get all events.

Then, which option, 2 or 3, do you prefer? To share where I am with
you: I am 60% with option 2 and 40% with 3 (I was 100% with 3 before)

> WRT X ease of development I would suggest that the same device should
> never report different events based on pen proximity. Either the
> device is in some "compatibility mode" and reports only one pointer a=
s
> per 1 or there are two separate pointers and they are just reported
> out of proximity when the pointer positioning is not desirable (ie
> when pen is out or when touch is off due to pen being in).
>
> If somebody wants to have multitouch combining two different pointers
> there is nothing stopping them, either with P&T pen and touch pointer=
s
> or completely unrelated devices.

We'll take care of this step once we know how to report the data.

Ping
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
