From: Todd Showalter <todd@electronjump.com>
Subject: Re: Game Controllers
Date: Fri, 3 May 2013 13:12:12 -0400
Message-ID: <CAFmpkygph_YtrPCVEvYZVdPztXOVDv=_pRNs3PUqBWjRbtRYaA@mail.gmail.com>
References: <CAFmpkyiqcwhbJc2A+Ntyisc_CD2z9ssBUQDv6TKvQCX4ES8DOQ@mail.gmail.com>
	<CANq1E4RRFNPZ-z86yny89hViMWREpG1f1in5O3kT8usHO57YAQ@mail.gmail.com>
	<CAFmpkygadXbwtyD0Pcc_K4EPqsqRq0EudX=ge6KFoaykR4CHVA@mail.gmail.com>
	<3024546.hGDLPfhqRN@f17simon>
	<CAFmpkyhiDp6ji=9P6XtCwvNWFvw+DNAc3p+sJ06QOPAL_ewQhQ@mail.gmail.com>
	<20130503160142.GC5567@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qc0-f175.google.com ([209.85.216.175]:48524 "EHLO
	mail-qc0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934345Ab3ECRMQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 3 May 2013 13:12:16 -0400
Received: by mail-qc0-f175.google.com with SMTP id u28so332589qcs.34
        for <linux-input@vger.kernel.org>; Fri, 03 May 2013 10:12:15 -0700 (PDT)
In-Reply-To: <20130503160142.GC5567@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Simon Farnsworth <simon.farnsworth@onelan.com>, David Herrmann <dh.herrmann@gmail.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>

On Fri, May 3, 2013 at 12:01 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:

> Actually not all input devices have to be accessible to root only. We
> definitely need this for now for keyboards (since we do not have
> revoke() yet) so that one user would not snoop another users keystrokes,
> but I think we could relax the restriction for certain devices such as:
>
> "A device that emits ABS_X and ABS_Y events and button events in
> BTN_JOYSTICK - BTN_GAMEPAD ranges and no other key events can be considered
> a gamepad or joystick device and should be available for read/write by
> the current console owner".

    I don't have the device to actually test this, but:

http://www.slipperybrick.com/2007/04/xbox-360-keyboard-controller/
http://www.itechnews.net/wp-content/uploads/2008/08/sony-ps3-wireless-keypad-1.jpg

    Depending on whether that gets exposed as a separate device or
part of the xbox gamepad, you may have cases where plugging the
keyboard in means you need root access to read the gamepad, unplugging
it means you don't, which is a little counterintuitive for users.

    I would hope the keyboard would just turn up as a separate device,
since IIRC the pad is actually a hub, but it's a potential
complication if that isn't the case.

    Single-seat is really the norm for people playing games, and I
thought ConsoleKit was fading and systemd still controversial, so I
think I'll put that on my list of future mountains to move rather than
current mountains.  :)

                                      Todd.

--
 Todd Showalter, President,
 Electron Jump Games, Inc.
