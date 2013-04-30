From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [RFC] Should make Elo TouchSystems 2216 to use hid-multitouch ?
Date: Tue, 30 Apr 2013 20:10:29 +0200
Message-ID: <CAN+gG=GzJxU_Q-YC9xRzZ5mFZ8zaEZzXoVasWEQRb1nkbc24FA@mail.gmail.com>
References: <CAPDwgkMeUZWKq2ciOeCVzNvxOW6ER55cdU+khDWzxPgcuvgFoQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-la0-f52.google.com ([209.85.215.52]:40238 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760723Ab3D3SKb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 30 Apr 2013 14:10:31 -0400
Received: by mail-la0-f52.google.com with SMTP id fd20so693489lab.39
        for <linux-input@vger.kernel.org>; Tue, 30 Apr 2013 11:10:29 -0700 (PDT)
In-Reply-To: <CAPDwgkMeUZWKq2ciOeCVzNvxOW6ER55cdU+khDWzxPgcuvgFoQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Yufeng Shen <miletus@chromium.org>
Cc: linux-input <linux-input@vger.kernel.org>, Henrik Rydberg <rydberg@euromail.se>

On Tue, Apr 30, 2013 at 3:10 AM, Yufeng Shen <miletus@chromium.org> wro=
te:
> So I have got an Elo 7"  USB Touchscreen. With default generic-usb
> driver, the touchscreen
> reports both BTN event & ABS event.
>
> evtest shows something like:
>
> Input device ID: bus 0x3 vendor 0x4e7 product 0x50 version 0x100
> Input device name: "EloTouchSystems,Inc Elo TouchSystems 2216 AccuTou=
ch=C2=AE
> USB Touchmonitor Interface"
> Supported events:
>   Event type 0 (EV_SYN)
>   Event type 1 (EV_KEY)
>     Event code 272 (BTN_LEFT)
>   Event type 3 (EV_ABS)
>     Event code 0 (ABS_X)
>       Value   1831
>       Min      184
>       Max     3932
>     Event code 1 (ABS_Y)
>       Value   1898
>       Min      184
>       Max     3932
>     Event code 40 (ABS_MISC)
>       Value      0
>       Min        0
>       Max      256
>   Event type 4 (EV_MSC)
>     Event code 4 (MSC_SCAN)
>
> When one touches the screen, BTN press event is sent, then ABS_X/Y ev=
ents
> are sent for finger move, and last BTN release event is sent for fing=
er lift.

Yes, that's expected. The only trouble you may get (making assumptions
here) is that your device relies on BTN_LEFT and not BTN_TOUCH. This
leads udev to tag your device as a mouse and not a touchscreen.

>
> The way the device uses BTN/ABS events make the device functionality =
quite
> confusing and limited -- It can only be used for point-to-click witho=
ut special
> handling in userspace.

Can you detail the special handling in user-space please?
As for "point-to-click", that's expected given your device capabilities=
=2E

>
> So I am wondering if it is better to make this device to use
> hid-multitouch driver
> and add quirks for :
> 1) set maxcontact =3D 1 (the device can only track 1 finger)
> 2) convert ABS_X/ABS_Y to MT_ABS_X/Y
> 3) use BTN press/release to indicate touch down/release

I'd rather fix the BTN_LEFT problem than adding single touch devices
to hid-multitouch, as they are already handled quite correctly in
hid-core.

Please provide me some hid-replay[1] captures so that I can fix the
hid-core handling.

>
> The benefit for doing this in my opinion is more clear and multi-touc=
h standard
> complying events for userspace. And userspace multitouch library can =
naturally

It reminds me that I already got a complain about a single touch
device not handled by multitouch libs. IMO, it's a problem in the
multitouch libs implementation and not in the kernel reporting.
adding the multitouch protocol to single touch device is feasible, but
it will only duplicate the events sent by the input node, so not a
huge benefit.

> use the multi-touch data to do like software based multi finger
> tracking, tap-to-click,
> scrolling and other gestures.

If your device reports only 1 finger, I can not see how you will be
able to track several fingers.

Cheers,
Benjamin

[1] http://bentiss.github.io/hid-replay-docs/
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
