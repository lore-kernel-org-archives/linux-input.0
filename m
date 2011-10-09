From: Daniel Drake <dsd@laptop.org>
Subject: Re: [PATCH] synaptics: add support for Relative mode
Date: Sun, 9 Oct 2011 09:07:35 +0100
Message-ID: <CAMLZHHQPQ+kFF2zeb8QQpA_YDVUrvGyMpxNC6cPkLV=OURQLng@mail.gmail.com>
References: <20111008182047.40BD19D401E@zog.reactivated.net>
	<CAGS+omCNwR9Sm64zJqV_h-2dmTYHxGkbofGaMMx2WgafYhrqhw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:62255 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751018Ab1JIIHf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 9 Oct 2011 04:07:35 -0400
Received: by ggnv2 with SMTP id v2so3765270ggn.19
        for <linux-input@vger.kernel.org>; Sun, 09 Oct 2011 01:07:35 -0700 (PDT)
In-Reply-To: <CAGS+omCNwR9Sm64zJqV_h-2dmTYHxGkbofGaMMx2WgafYhrqhw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Kurtz <djkurtz@google.com>
Cc: dmitry.torokhov@gmail.com, dtor@mail.ru, linux-input@vger.kernel.org, pgf@laptop.org

On Sun, Oct 9, 2011 at 6:04 AM, Daniel Kurtz <djkurtz@google.com> wrote=
:
> This patch seems reasonable, but I don't think your explanation is
> quite right. =A0It is quite common for a user to move their finger
> around on a trackpad for several seconds continuously. =A0This genera=
tes
> exactly the same "huge and uninterrupted stream of interrupts at a
> high rate" as fingers near the pad, idle on the pad, or after the pad
> is lifted. =A0In other words, the peak *packet rate* is the same in
> absolute or relative mode.

You are right in that the peak packet rate is the same in both modes,
but you are missing the key behavioural difference that is the reason
for this patch. Here is an experiment you can do to see this for
yourself:

1. Put the mouse in Absolute mode and enable packet logging
2. Without putting your finger near the pad, press and hold the left
mouse button for exactly 1 second
3. Release the mouse button
4. Count how many packets were sent by the device.

Now do the same for Relative mode.

The results are that in the Absolute mode you will get 80 identical
packets saying "the left mouse button is pressed" and then you will
get 80 identical packets saying "no mouse buttons are pressed".

In Relative mode you will get exactly two packets: mouse button
pressed, followed by a pause, followed by mouse button unpressed.

The same applies for movement. In Absolute mode, if you have your
finger on or near the pad, the device will spam you with packets at
the maximum rate, even if the new packet being sent is identical to
the old one, or identical to the last hundred (i.e. no movement or
pressure change). In Relative mode, the mouse only sends packets if it
has some kind of change (in movement or button state) to communicate.

Even when moving your finger very fast over the pad it is difficult to
get Relative mode to hit the full packet rate. There are always a few
points where the device takes a breather because it hasn't got
movement to report, so the transmitted packet rate is a little less
than the maximum available. This is really useful for us because we
share the communication channel with the keyboard, so when the mouse
takes a breather it's a good time for the keyboard packets to come
through.

I have confirmed with Synaptics that this behaviour is by design, it
is even clearly documented in section 3.2 of the document you link to.
They also confirmed that you can't turn this spammy behaviour off in
absolute mode, and suggested that if we wanted to avoid this then we
should use relative mode.

I'm also aware of the packet size option - we want to reduce that to
40 even with relative mode, again for lower processing and power
saving reasons, I guess there are other embedders who will want the
same. Thats another advantage of this patch - previously you couldn't
run the mouse in relative mode (i.e. no synaptics driver) while being
able to reduce the mouse rate (which is done by the synaptics driver
via the mechanism you describe).

Thanks,
Daniel
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
