From: Jason Gerecke <killertofu@gmail.com>
Subject: Re: Proper representation of button touch (as opposed to button press)
Date: Mon, 5 Mar 2012 11:36:05 -0800
Message-ID: <CANRwn3SzkR9uDgOTXMgrwY_hJSNdatygnoqXMgVi8G9E2_QDeA@mail.gmail.com>
References: <CANRwn3QLhpH=W8r1fJ=xB4Dc46kdfaG+5_x0oFbEJYWjTyYyZA@mail.gmail.com>
	<20120303002137.GA11833@core.coreip.homeip.net>
	<CAGzDe_bJFanph5Gy_zCSs21mmH2DRnYUyWYrX8vW_nViBbWy4Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ww0-f42.google.com ([74.125.82.42]:46071 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757486Ab2CETgG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 5 Mar 2012 14:36:06 -0500
Received: by wgbds11 with SMTP id ds11so1584417wgb.1
        for <linux-input@vger.kernel.org>; Mon, 05 Mar 2012 11:36:05 -0800 (PST)
In-Reply-To: <CAGzDe_bJFanph5Gy_zCSs21mmH2DRnYUyWYrX8vW_nViBbWy4Q@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chris Bagwell <chris@cnpbagwell.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linux Input <linux-input@vger.kernel.org>

On Sat, Mar 3, 2012 at 7:59 AM, Chris Bagwell <chris@cnpbagwell.com> wr=
ote:
> On Fri, Mar 2, 2012 at 6:21 PM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
>> Hi Jason,
>>
>> On Fri, Mar 02, 2012 at 10:36:22AM -0800, Jason Gerecke wrote:
>>> The Intuos5 was just announced, and I'm working on adding support f=
or
>>> it to the wacom kernel module. One feature new to the Intuos5 is th=
e
>>> addition of capacitive sensors embedded in the buttons. Each
>>> ExpressKey (button) has two bits of state: one for the capacitive
>>> switch and one for the mechanical switch. These bits are synthesize=
d
>>> into three cases: released, touched, and pressed (the 4th case of
>>> "pressed with a non-capacitive object" isn't particularly
>>> interesting). My initial thought was to call input_event() with a
>>> unique value for the 'touched' case. However, the documentation onl=
y
>>> defines three values for EV_KEY: 0 (released), 1 (pressed), and 2
>>> (autorepeat).
>>>
>>> Is 'touched' a case we would want to allow for EV_KEY, or should I =
be
>>> representing things differently?
>>
>> Differently please. It looks like you have 2 independent objects the=
re -
>> one mechanical switch (persistent on/off) and one is a key (pressed
>> while touched).
I think you're confused. The buttons on
Inutos4/Intuos3/Cintiq21UX/etc. report when they've been pressed. The
Intuos5 embeds a capacitive sensor into each button so that they can
report "touched" in addition. If you ignore the capacitive sensor,
each button is exactly the same as you'd find on our other tablets, a
mouse, or a keyboard.  It should be in a "pressed" state while
sufficient force is applied, and in an "unpressed" state otherwise. It
is *not* expected to behave like a persistent toggle switch.

Since "touched" is a natural and distinct button state, it makes sense
(to me at least) to have EV_KEY define it as an additional legal
value.

>
> There is a little overlap here with clickpads and it would be nice if
> user apps could work similar for both. =C2=A0The main use (I think) o=
f this
> proposed key press is to give visual feedback were users finger is at
> before they press hard enough to activate button. =C2=A0It could be t=
he HUD
> feature of Intuos5 or the taskbar applet Windows synaptics driver has
> that gives feedback how touchpad is being touched.
>
> For clickpads, its an X/Y value that a HUD/applet would use to give
> the visual feedback. =C2=A0If these new "keys" are not exposed as a f=
ull
> blown capacitive touch strip then you could simulate that and send an
> Y=3D1 and X=3D1..4 to represent were finger is.
>
> The main negative with this is you'll have the headache clickpad user
> land has trying to detect when X/Y is buttons and when its touchpad
> movement. =C2=A0At least in your case, you could send a BTN_TOOL_STRI=
P or a
> BTN_TOOL_FINGER+serial # to let user land know this is a unique area
> of touch.
>
> Chris
I'm not sure about this... I don't think there are really any clickpad
user apps out there that would be relevant to the Intuos5 since its
buttons aren't used like one. While it'd be possible to simulate a
clickpad with the raw data, I'm having a hard time seeing the use for
anything beyond a HUD (which could be written without the
faux-position data anyway).

Jason

---
Day xee-nee-svsh duu-'ushtlh-ts'it;
nuu-wee-ya' duu-xan' 'vm-nvshtlh-ts'it.
Huu-chan xuu naa~-gha.
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
