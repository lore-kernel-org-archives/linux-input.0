From: Frank Praznik <frank.praznik@gmail.com>
Subject: Re: [PATCH] Input: mt: only perform pointer emulation on drivers
 desiring this functionality
Date: Sun, 30 Oct 2016 11:04:53 -0400
Message-ID: <ACB931EC-6682-4E17-A028-5BF31689A1D4@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 10.1 \(3251\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qk0-f196.google.com ([209.85.220.196]:36442 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752783AbcJ3PE4 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sun, 30 Oct 2016 11:04:56 -0400
Received: by mail-qk0-f196.google.com with SMTP id z190so8198828qkc.3
        for <linux-input@vger.kernel.org>; Sun, 30 Oct 2016 08:04:56 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Tim Bird <tim.bird@am.sony.com>, Roderick Colenbrander <roderick.colenbrander@sony.com>

> On Thu, Oct 27, 2016 at 4:19 PM, Dmitry Torokhov
> <dmitry.torokhov@xxxxxxxxx> wrote:
> > On Thu, Oct 27, 2016 at 02:31:13PM -0700, Roderick Colenbrander =
wrote:
> >> From: Roderick Colenbrander <roderick.colenbrander@xxxxxxxx>
> >>
> >> The input-mt driver pointer emulation from 'input_mt_sync_frame' =
regardless
> >> of the flags passed in to 'input_mt_init_slots' by device drivers.
> >
> > Right, because needing single-touch (pointer) emulation is not =
property
> > of device or driver but rather consumer. If we get to the point =
where
> > everything is ready to accept multi-touch (are we there yet) then we =
can
> > stop doing pointer emulation altogether.
> >
> >>
> >> Pointer emulation is undesired on drivers, which didn't request =
this
> >> capability like the hid-sony driver for the Dualshock 4. This =
gamepad already
> >> reports ABS_X / ABS_Y for gamepad stick purposes. Pointer emulation =
would
> >> inject touchpad values into these sticks, which is undesired.
> >
> > The driver should not be re-purposing events like that.
> > ABS_MT_POSITION_X and ABS_X should match.
> >
> > Why doesn't driver follow Documentation/input/gamepad.txt?
> >
>=20
> The original hid-sony code and the multitouch handling code for the =
Dualshock 4
> were written by the community. We are stepping in to make the hid-sony =
driver
> properly handle the Dualshock 4.
> The driver doesn't fully follow the gamepad spec yet, which we will
> try to improve. At
> least the left analog stick is reported as ABS_X and ABS_Y already,
> but the buttons
> are inconsistent and right stick is wrong as well.
> While it would be great to conform to the spec, the conflict with
> multitouch would still
> exist as the Dualshock 4 has both analog sticks and a multitouch =
touchpad.

The button and axis mappings are what the controller=E2=80=99s default =
HID descriptor provides.  The descriptors in the driver just extend the =
ones sent by the controller to allow additional functionality(i.e. =
gyro/accel and full Bluetooth mode), but the button and axis mappings =
were unchanged from the defaults so as not to introduce mapping =
discrepencies with older kernels which used the generic HID driver.  =
Note that changing them at this point *will* break a lot of software =
(SDL has had these mappings hardcoded into it=E2=80=99s controller =
database header for years now).

>=20
> Disabling the pointer emulation feature avoids the conflict. This
> issue was only exposed
> recently by adding of the input_mt_sync_frame call as recommended by =
Benjamin as
> part of some improvements we did for touchpad handling in hid-sony.
>=20

Is input_mt_sync_frame even necessary?  The original implementation =
followed the protocol for a =E2=80=9CType B=E2=80=9D device as defined =
in Documentation/input/multi-touch-protocol.txt which doesn=E2=80=99t =
require SYN_MT_REPORT messages.=
