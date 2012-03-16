From: Thorsten Wissmann <re06huxa@stud.informatik.uni-erlangen.de>
Subject: Re: Mixed "pen" and multitouch input devices
Date: Fri, 16 Mar 2012 18:33:32 +0100
Message-ID: <20120316173332.GA28620@stud.informatik.uni-erlangen.de>
References: <20120315155235.GA6783@stud.informatik.uni-erlangen.de>
 <CAGzDe_b0XPUBZKAGnj9kxzuRb9Fw7aph_Q+VgmdVbpVNU2Sf3w@mail.gmail.com>
 <20120315175635.GA23155@stud.informatik.uni-erlangen.de>
 <4F623511.3040907@gmail.com>
 <20120316015224.GA8230@stud.informatik.uni-erlangen.de>
 <4F629F60.7010600@gmail.com>
 <CAGzDe_ZVUSu+zFq8giOJfOTYzYWrf=2+Z64KASTE_MpVQ1yMzw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:34101 "EHLO
	faui03.informatik.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751515Ab2CPRdf (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 16 Mar 2012 13:33:35 -0400
Content-Disposition: inline
In-Reply-To: <CAGzDe_ZVUSu+zFq8giOJfOTYzYWrf=2+Z64KASTE_MpVQ1yMzw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chris Bagwell <chris@cnpbagwell.com>
Cc: Chase Douglas <chasedouglas@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, linux-input@vger.kernel.org, Maximilian =?iso-8859-1?Q?Kr=FCger?= <maxfragg@gmail.com>, i4passt@lists.informatik.uni-erlangen.de

On Thu, Mar 15, 2012 at 09:57:30PM -0500, Chris Bagwell wrote:
> On Thu, Mar 15, 2012 at 9:03 PM, Chase Douglas <chasedouglas@gmail.co=
m> wrote:
> > On 03/15/2012 06:52 PM, Thorsten Wissmann wrote:
> >> It turned out xf86-input-evdev really discards all non-multitouch =
events
> >> (especially ABS_X and ABS_Y) events in EvdevProcessAbsoluteMotionE=
vent()
> >> in evdev.c, if the device is configured as a multitouch device. So=
 there
> >> is a quick fix (or only workaround?), which processes ABS_X and AB=
S_Y
> >> events even if it is a multitouch device:
> >>
> >> diff --git a/src/evdev.c b/src/evdev.c
> >> index d540b87..b857b83 100644
> >> --- a/src/evdev.c
> >> +++ b/src/evdev.c
> >> @@ -832,7 +832,7 @@ EvdevProcessAbsoluteMotionEvent(InputInfoPtr p=
Info,
> >> struct input_event *ev)
> >> =A0 =A0 =A0if (ev->code >=3D ABS_MT_SLOT) {
> >> =A0 =A0 =A0 =A0 =A0EvdevProcessTouchEvent(pInfo, ev);
> >> =A0 =A0 =A0 =A0 =A0pEvdev->abs_queued =3D 1;
> >> - =A0 =A0} else if (!pEvdev->mt_mask) {
> >> + =A0 =A0} else if (!pEvdev->mt_mask || ev->code =3D=3D ABS_X || e=
v->code =3D=3D
> >> ABS_Y) {
> >> =A0 =A0 =A0 =A0 =A0map =3D pEvdev->axis_map[ev->code];
> >> =A0 =A0 =A0 =A0 =A0valuator_mask_set(pEvdev->vals, map, value);
> >> =A0 =A0 =A0 =A0 =A0pEvdev->abs_queued =3D 1;
> >>
> >> This patch already is submitted to the xorg bugtracker and can be =
found
> >> at [1].
> >>
> >> The only remaining question is: Does it break other drivers?
> >>
> >> [1] https://bugs.freedesktop.org/show_bug.cgi?id=3D47382
> >
> > Great!
> >
> > I haven't fully thought about it enough to give a reviewed-by, but =
it
> > seems sane.
> >
> > I suggest sending the patch to xorg-devel@lists.x.org. That's where=
 most
> > patch reviews are handled. You will likely get faster results there=
=2E
>=20
> Yep, agree thats also a great way to go.

Thanks!

> One thing I might suggest is to include with patch your thinking on
> how a pen+multitouch device should send events to help in review of
> the patch.  Just the basics.  For example, from above patch I have an
> assumption that your sending ABS_X/Y only for PEN events and
> ABS_MT_POSITION_X/Y only for touch events; but then again I'm not 100=
%
> sure of that.

That's correct. In our case, it's ABS_X/Y for pen, ABS_MT_* for fingers
(normal touches). But maybe other devices behave different. So we shoul=
d
send something like this as an addition to the patch on the x.org list?

# finger touch
    ABS_MT_SLOT 0
    ABS_MT_TRACKING_ID 42
    ABS_MT_POSITION_X finger_x
    ABS_MT_POSITION_Y finger_y
    SYN_MT_REPORT
    SYN_REPORT
# finger release
    ABS_MT_SLOT 0
    ABS_MT_TRACKING_ID -1
    SYN_REPORT
# pen motion
    ABS_X pen_x
    ABS_Y pen_y
    SYN_REPORT

> If ABS_X/Y is only for PEN events, then pEvdev->in_proximity in
> xf86-input-evdev may be a less restrictive check to allow even
> BTN_STYLUS and ABS_X/Y events to be processed.

The actual event source (if PEN or STYLUS or ...) shouldn't matter. (Or
I just don't get your point)


    Thorsten
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
