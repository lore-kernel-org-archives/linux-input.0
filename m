From: Daniel Kurtz <djkurtz@google.com>
Subject: Re: Annoying touchpad behavior
Date: Sun, 13 Nov 2011 01:46:40 +0800
Message-ID: <CAGS+omA3XM9HOsPZ-UbQ8RX3bQWe9SDKYtZadfLtkdMj00E+6Q@mail.gmail.com>
References: <20111112060505.GA20411@core.coreip.homeip.net> <Pine.LNX.4.44L0.1111121210500.9110-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:65289 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752319Ab1KLRrD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 12 Nov 2011 12:47:03 -0500
Received: by iage36 with SMTP id e36so5347303iag.19
        for <linux-input@vger.kernel.org>; Sat, 12 Nov 2011 09:47:02 -0800 (PST)
In-Reply-To: <Pine.LNX.4.44L0.1111121210500.9110-100000@netrider.rowland.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

Hi Alan,

On Sun, Nov 13, 2011 at 1:15 AM, Alan Stern <stern@rowland.harvard.edu>=
 wrote:
> On Fri, 11 Nov 2011, Dmitry Torokhov wrote:
>
>> Hi Alan,
>>
>> On Fri, Nov 11, 2011 at 11:10:46PM -0500, Alan Stern wrote:
>> > Dmitry:
>> >
>> > My laptop has a Synaptics touchpad:
>> >
>> > [ =A0 =A02.528474] Synaptics Touchpad, model: 1, fw: 7.2, id: 0x1c=
0b1, caps: 0xd04731/0xa40000/0xa0000
>> > [ =A0 =A02.566383] input: SynPS/2 Synaptics TouchPad as /devices/p=
latform/i8042/serio4/input/input4
>> >
>> > Under circumstances which I can't pin down (they generally involve=
 my
>> > thumb brushing over the trackpad, which happens fairly often as I
>> > type), the touchpad reports a right-click. =A0This causes gnome-te=
rminal
>> > to pop up its menu, which is very annoying.
>> >
>> > Why does the trackpad report a right-click instead of a normal
>> > left-click? =A0How can I fix this?
>>
>> You probably have corner taps or multi-finger taps enabled on your b=
ox.
>> What does "synclient' has to say about your setup?
>
> Here's the output from "synclient -l":
>
> Parameter settings:
> =A0 =A0LeftEdge =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D 1762
> =A0 =A0RightEdge =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D 5334
> =A0 =A0TopEdge =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D 1642
> =A0 =A0BottomEdge =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D 4520
> =A0 =A0FingerLow =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D 24
> =A0 =A0FingerHigh =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D 29
> =A0 =A0FingerPress =A0 =A0 =A0 =A0 =A0 =A0 =3D 255
> =A0 =A0MaxTapTime =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D 180
> =A0 =A0MaxTapMove =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D 234
> =A0 =A0MaxDoubleTapTime =A0 =A0 =A0 =A0=3D 180
> =A0 =A0SingleTapTimeout =A0 =A0 =A0 =A0=3D 180
> =A0 =A0ClickTime =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D 100
> =A0 =A0FastTaps =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D 0
> =A0 =A0EmulateMidButtonTime =A0 =A0=3D 75
> =A0 =A0EmulateTwoFingerMinZ =A0 =A0=3D 29
> =A0 =A0EmulateTwoFingerMinW =A0 =A0=3D 7
> =A0 =A0VertScrollDelta =A0 =A0 =A0 =A0 =3D 106
> =A0 =A0HorizScrollDelta =A0 =A0 =A0 =A0=3D 106
> =A0 =A0VertEdgeScroll =A0 =A0 =A0 =A0 =A0=3D 1
> =A0 =A0HorizEdgeScroll =A0 =A0 =A0 =A0 =3D 0
> =A0 =A0CornerCoasting =A0 =A0 =A0 =A0 =A0=3D 0
> =A0 =A0VertTwoFingerScroll =A0 =A0 =3D 0
> =A0 =A0HorizTwoFingerScroll =A0 =A0=3D 0
> =A0 =A0MinSpeed =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D 1
> =A0 =A0MaxSpeed =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D 1.75
> =A0 =A0AccelFactor =A0 =A0 =A0 =A0 =A0 =A0 =3D 0.0375094
> =A0 =A0TrackstickSpeed =A0 =A0 =A0 =A0 =3D 40
> =A0 =A0EdgeMotionMinZ =A0 =A0 =A0 =A0 =A0=3D 29
> =A0 =A0EdgeMotionMaxZ =A0 =A0 =A0 =A0 =A0=3D 159
> =A0 =A0EdgeMotionMinSpeed =A0 =A0 =A0=3D 1
> =A0 =A0EdgeMotionMaxSpeed =A0 =A0 =A0=3D 426
> =A0 =A0EdgeMotionUseAlways =A0 =A0 =3D 0
> =A0 =A0TouchpadOff =A0 =A0 =A0 =A0 =A0 =A0 =3D 0
> =A0 =A0LockedDrags =A0 =A0 =A0 =A0 =A0 =A0 =3D 0
> =A0 =A0LockedDragTimeout =A0 =A0 =A0 =3D 5000
> =A0 =A0RTCornerButton =A0 =A0 =A0 =A0 =A0=3D 0
> =A0 =A0RBCornerButton =A0 =A0 =A0 =A0 =A0=3D 0
> =A0 =A0LTCornerButton =A0 =A0 =A0 =A0 =A0=3D 0
> =A0 =A0LBCornerButton =A0 =A0 =A0 =A0 =A0=3D 0
> =A0 =A0TapButton1 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D 1
> =A0 =A0TapButton2 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D 3

The synaptics X input driver is probably interpreting large contacts
as 2-fingers, which is in turn being translated into a 2-finger tap.
To completely disable "2-finger Tap as Right Click", try setting TapBut=
ton2 =3D 0.
To temporarily change the setting, you can use the synclient program.
To make it permanent, change the value in the Synaptics section of
your xorg.conf file, and restart X.

-Dan

> =A0 =A0TapButton3 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D 2
> =A0 =A0ClickFinger1 =A0 =A0 =A0 =A0 =A0 =A0=3D 1
> =A0 =A0ClickFinger2 =A0 =A0 =A0 =A0 =A0 =A0=3D 1
> =A0 =A0ClickFinger3 =A0 =A0 =A0 =A0 =A0 =A0=3D 1
> =A0 =A0CircularScrolling =A0 =A0 =A0 =3D 0
> =A0 =A0CircScrollDelta =A0 =A0 =A0 =A0 =3D 0.1
> =A0 =A0CircScrollTrigger =A0 =A0 =A0 =3D 0
> =A0 =A0CircularPad =A0 =A0 =A0 =A0 =A0 =A0 =3D 0
> =A0 =A0PalmDetect =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D 0
> =A0 =A0PalmMinWidth =A0 =A0 =A0 =A0 =A0 =A0=3D 10
> =A0 =A0PalmMinZ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D 199
> =A0 =A0CoastingSpeed =A0 =A0 =A0 =A0 =A0 =3D 20
> =A0 =A0CoastingFriction =A0 =A0 =A0 =A0=3D 50
> =A0 =A0PressureMotionMinZ =A0 =A0 =A0=3D 29
> =A0 =A0PressureMotionMaxZ =A0 =A0 =A0=3D 159
> =A0 =A0PressureMotionMinFactor =3D 1
> =A0 =A0PressureMotionMaxFactor =3D 1
> =A0 =A0GrabEventDevice =A0 =A0 =A0 =A0 =3D 1
> =A0 =A0TapAndDragGesture =A0 =A0 =A0 =3D 1
> =A0 =A0AreaLeftEdge =A0 =A0 =A0 =A0 =A0 =A0=3D 0
> =A0 =A0AreaRightEdge =A0 =A0 =A0 =A0 =A0 =3D 0
> =A0 =A0AreaTopEdge =A0 =A0 =A0 =A0 =A0 =A0 =3D 0
> =A0 =A0AreaBottomEdge =A0 =A0 =A0 =A0 =A0=3D 0
>
> A few of the fields are suggestive, but I don't really understand muc=
h
> of it. =A0If you need anything else, let me know.
>
> Alan Stern
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>



--=20
Daniel Kurtz=A0|=A0Software Engineer=A0|=A0djkurtz@google.com=A0|=A0650=
=2E204.0722
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
