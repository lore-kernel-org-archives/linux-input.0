From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] evdev: discard oldest event on buffer overflow
Date: Wed, 27 Oct 2010 17:30:48 -0700
Message-ID: <20101028003048.GB12179@core.coreip.homeip.net>
References: <1288199398-7198-1-git-send-email-bgat@billgatliff.com>
 <20101027235704.GA12179@core.coreip.homeip.net>
 <AANLkTimLK=UJRGQ_M9=4o5R4v_P6YPbJtPybCzfVqSND@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:40865 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757642Ab0J1AbC (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 27 Oct 2010 20:31:02 -0400
Received: by gxk23 with SMTP id 23so888149gxk.19
        for <linux-input@vger.kernel.org>; Wed, 27 Oct 2010 17:31:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTimLK=UJRGQ_M9=4o5R4v_P6YPbJtPybCzfVqSND@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bill Gatliff <bgat@billgatliff.com>
Cc: linux-input@vger.kernel.org

On Wed, Oct 27, 2010 at 05:11:28PM -0700, Bill Gatliff wrote:
> On Wed, Oct 27, 2010 at 4:57 PM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> > On Wed, Oct 27, 2010 at 12:09:58PM -0500, Bill Gatliff wrote:
> >> This patch moves the tail pointer up one event on a buffer
> >> overflow, which "consumes" the oldest event in the buffer
> >> to make room for the incoming event. =A0Thus, although data
> >> is lost due to the overflow (which is unavoidable), the
> >> data that remains is both recent and still time-ordered.
> >>
> >
> > It does not really matter... You are losing part of the hardware st=
ate
> > regardless so the packet is invalid anyway. What would probably mak=
e
> > more sense is to ignore all events up until next packet boundary
> > (EV_SYN/SYN_REPORT) so userspace would get most up-to-date _full_ p=
acket
> > (when it catches up).
>=20
> That's an interesting idea, actually.  Maybe the subject of a future =
patch.  :)
>=20
> I still think my patch is a genuine improvement as-is, however.

Sorry, I am unconvinced that it is an improvement.

> But
> perhaps not the final word on the issue.
>=20
> For example, how do you recall the events that userspace has already
> digested from the current packet?  One alternative is to not queue a
> packet until the whole packet is ready, but that will introduce
> latency.  I don't like that approach, either.  Hmmm...

Userspace is not supposed to act on a packet until it receives
SYN_REPORT. Userspace should also be prepared to handle events
overriding older ones. So there is no "recall" needed. Consider finger
moving on a high-speed/high-resolution touchpad (only coordinates, no
exteneded attributes for simplicity sake):

  1      2     3    4      5     6   7       8     9   10      11    12
ABS_X1 ABS_Y1 SYN ABS_X2 ABS_Y2 SYN ABS_X3 ABS_Y3 SYN ABS_X4 ABS_Y4 SYN

Imagine you overflow and lose events 5 through 9 - no big deal.
Userspace will get ABS_X2 ABS_X4 ABS_Y4 SYN which will tranlate into
(X4, Y4) - the most recent coordinates (and ones we are interested in
most of all). It is not that important where finger was a second ago as
it is important where it is _now_.

Of course you may still lose some data (key/button releases, etc) but
input devices should size buffers properly and overflows should be rare
events.

>=20
> I suppose another possibility is to always reserve enough room for an
> EV_SYN/SYN_REPORT event, and never discard those events.  Then
> userspace will always see a properly-terminated packet, but in a
> collision it would receive a partial-but-properly-terminated packet.
>=20

And what is the benefit of properly terminated but incomplete packet?
Let's say you are doing a pinch gesture with 2 fingers. Would you rathe=
r
lose one finger data (and then your pinch is not pinch anymore but a
single touch) or discard one packet completely so that the next
(complete one) allows you to continue gesture as is?

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
