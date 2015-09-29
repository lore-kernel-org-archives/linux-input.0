From: Nick Bowler <nbowler@draconx.ca>
Subject: Re: PROBLEM: Missing events on thinkpad trackpoint buttons
Date: Mon, 28 Sep 2015 20:22:02 -0400
Message-ID: <CAN_QmVztquGWimB=5tppOY23onoGdPtrb_YZhVcQnPeHOvG=xQ@mail.gmail.com>
References: <CAMmwwr-7fQcMa=DiiCO+GU7R1ZLgh6o2SD40q+gTPmcu=A_8uA@mail.gmail.com>
	<20150820213526.GA10980@localhost>
	<CAMmwwr-uYWurxAQnDdy9hVO-A3PGK92uSmHjYagp5eTXmPnZ_Q@mail.gmail.com>
	<20150820225633.GA12900@localhost>
	<CAKdAkRQwOhQ7ysyAQ3QV=mRfXBvVxC=wrqOhhK1J4YLpWh2hRA@mail.gmail.com>
	<CAMmwwr8ycdXKbrsfe_ameK+ZmdH2yZbUtMtcZrrceSAfsgz_0g@mail.gmail.com>
	<20150820230840.GB12900@localhost>
	<20150820231339.GA7236@localhost>
	<CAN+gG=H88uVbRun=Vs1r1b8jM=wpnC1285BquFpDsh8HQdr07Q@mail.gmail.com>
	<CAN+gG=Hrcw=YKGf_No8=FptL3zTGmrR39n1pwk4q0d5Po8RFDg@mail.gmail.com>
	<CAKdAkRTC2uvmZNwyZbd5sjPFy5T1s+a=R8YGyg9wevajz8r3HQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yk0-f177.google.com ([209.85.160.177]:32793 "EHLO
	mail-yk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753089AbbI2AWD (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 28 Sep 2015 20:22:03 -0400
Received: by ykft14 with SMTP id t14so198958555ykf.0
        for <linux-input@vger.kernel.org>; Mon, 28 Sep 2015 17:22:02 -0700 (PDT)
In-Reply-To: <CAKdAkRTC2uvmZNwyZbd5sjPFy5T1s+a=R8YGyg9wevajz8r3HQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>, Gabor Balla <gaborwho@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Stephen Chandler Paul <thatslyude@gmail.com>, Andrew Duggan <andrew.duggan@gmail.com>

On 9/28/15, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> On Sun, Sep 27, 2015 at 5:14 AM, Benjamin Tissoires <benjamin.tissoires@gmail.com> wrote:
>>  I believe the fix is worse than the original situation given that this
>>  also removes all gestures support we can have in libinput.
>
> Umm, I guess I have to claim temporary insanity or something like that
> with this one: we do need extended W mode to handle multiple touches
> in the driver and  the patch disabled it ;(
>
> Before we revert this, Nick, Gabor, can you tell me what capability
> bits your touchpads report (in dmesg)?

Is this the info you're looking for?

  [    1.225243] psmouse serio1: synaptics: queried max coordinates: x
[..5712], y [..4780]
  [    1.256725] psmouse serio1: synaptics: queried min coordinates: x
[1232..], y [1074..]
  [    1.316644] psmouse serio1: synaptics: Touchpad model: 1, fw:
8.1, id: 0x1e2b1, caps: 0xf002a3/0x943300/0x12e800/0x10000, board id:
3075, fw id: 2560
  [    1.318089] psmouse serio1: synaptics: serio: Synaptics
pass-through port at isa0060/serio1/input0
  [    1.356859] input: SynPS/2 Synaptics TouchPad as
/devices/platform/i8042/serio1/input/input5
  [    5.135450] psmouse serio2: trackpoint: IBM TrackPoint firmware:
0x0e, buttons: 3/3
  [    5.329582] input: TPPS/2 IBM TrackPoint as
/devices/platform/i8042/serio1/serio2/input/input7

Cheers,
  Nick
