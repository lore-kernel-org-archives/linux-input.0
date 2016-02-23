From: Henrik Rydberg <rydberg@bitmath.org>
Subject: Re: Question about ABS_DISTANCE's intended usage.
Date: Tue, 23 Feb 2016 23:42:03 +0100
Message-ID: <56CCE03B.9070408@bitmath.org>
References: <CAJ34Pp7OM7DAiA1gZqQ0dtgXZ=z6p+LEVD5aeMiYOecHCbcfLw@mail.gmail.com>
 <20160218181930.GA34407@dtor-ws> <20160221220426.GA20055@jelly.redhat.com>
 <CAJ34Pp70HjQsCo-pCdHXo7FmN8KXgOAT5NKFVS-13z2c_MPzPw@mail.gmail.com>
 <20160222220432.GB11173@jelly.redhat.com> <20160223220245.GA3971@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailrelay7.public.one.com ([91.198.169.215]:50284 "EHLO
	mailrelay7.public.one.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753816AbcBWW6H (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 23 Feb 2016 17:58:07 -0500
In-Reply-To: <20160223220245.GA3971@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Peter Hutterer <peter.hutterer@who-t.net>
Cc: Charles Mooney <charliemooney@google.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Linux Input <linux-input@vger.kernel.org>

Hi Dmitry, Charles, Peter,

> I wonder if this will not confuse clients that do not pay attention to
> ABS_DISTANCE though... I take it that libinput and x synaptics drivers
> won't be confused, mousedev in kernel relies on BTN_TOUCH, what about
> others?

It looks quite ok with BTN_TOUCH added. So for n the number of detected fingers
and d the collective distance to the surface:

BTN_DISTANCE = d
BTN_TOUCH = (d == 0)
BTN_TOOL_FINGER = (n == 1)
BTN_TOOL_DOUBLETAP = (n == 2)
BTN_TOOL_TRIPLE...

This will work for:

1. The simplest touchscreen driver which only looks at BTN_TOUCH.
2. Touchpad drivers that distinguish between fingers present (BTN_TOOL_FINGER)
and fingers touching (BTN_TOUCH).
3. Drivers that already understand BTN_DISTANCE, as per Peter's description.

Charles' three states are then encoded as

#1 (d = 0, n > 0)
#2 (d > 0, n > 0)
#3 (d = ?, n = 0)

I don't recall any kernel or userland driver working any differently either.

Henrik

