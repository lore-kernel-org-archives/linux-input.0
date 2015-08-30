From: Bastien Nocera <hadess@hadess.net>
Subject: Re: "Super Joy Box 7" gameport adapter
Date: Sun, 30 Aug 2015 15:45:09 +0200
Message-ID: <1440942309.6135.21.camel@hadess.net>
References: <1440932312.6135.16.camel@hadess.net> <55E304F4.10402@gmail.com>
	 <1440941989.6135.17.camel@hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from slow1-d.mail.gandi.net ([217.70.178.86]:44367 "EHLO
	slow1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753153AbbH3Nvf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 30 Aug 2015 09:51:35 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	by slow1-d.mail.gandi.net (Postfix) with ESMTP id 888B847A160
	for <linux-input@vger.kernel.org>; Sun, 30 Aug 2015 15:45:14 +0200 (CEST)
In-Reply-To: <1440941989.6135.17.camel@hadess.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?ISO-8859-1?Q?Cl=E9ment?= Vuchener <clement.vuchener@gmail.com>, linux-input@vger.kernel.org

On Sun, 2015-08-30 at 15:39 +0200, Bastien Nocera wrote:
> On Sun, 2015-08-30 at 15:28 +0200, Cl=C3=A9ment Vuchener wrote:
> > It looks like the kind of thing that would happen if the throttle
> > was
> > reported as a hat switch in the HID descriptor. But I think there
> > should be more than 4 directions. Anyway, you should look what
> > happens at the HID level to know how much the hardware is wrong and
> > if this can be fixed by the kernel.
>=20
> hid-record output attached. Doesn't look too good.

Looks like the "Steering wheel" mode of the adapter works a lot better,
but the throttle looks reversed (high values when the throttle is at
the bottom, low values when at the top).

Are those the correct values, or are they indeed supposed to be
reversed in software (in the kernel, or in user-space)?

Input driver version is 1.0.1
Input device ID: bus 0x3 vendor 0x925 product 0x1031 version 0x100
Input device name: "WiseGroup.,Ltd Gameport to USB Controller"
Supported events:
  Event type 0 (EV_SYN)
  Event type 1 (EV_KEY)
    Event code 288 (BTN_TRIGGER)
    Event code 289 (BTN_THUMB)
    Event code 290 (BTN_THUMB2)
    Event code 291 (BTN_TOP)
    Event code 292 (BTN_TOP2)
    Event code 293 (BTN_PINKIE)
    Event code 294 (BTN_BASE)
    Event code 295 (BTN_BASE2)
  Event type 3 (EV_ABS)
    Event code 0 (ABS_X)
      Value     81
      Min        0
      Max      255
      Flat      15
    Event code 1 (ABS_Y)
      Value     95
      Min        0
      Max      255
      Flat      15
    Event code 6 (ABS_THROTTLE)
      Value    181
      Min        0
      Max      255
      Flat      15
    Event code 7 (ABS_RUDDER)
      Value    128
      Min        0
      Max      255
      Flat      15
    Event code 16 (ABS_HAT0X)
      Value      0
      Min       -1
      Max        1
    Event code 17 (ABS_HAT0Y)
      Value      0
      Min       -1
      Max        1
  Event type 4 (EV_MSC)
    Event code 4 (MSC_SCAN)
Properties:
Testing ... (interrupt to exit)
Event: time 1440942130.431544, type 3 (EV_ABS), code 6 (ABS_THROTTLE), =
value 185
Event: time 1440942130.431544, -------------- SYN_REPORT ------------
Event: time 1440942130.471470, type 3 (EV_ABS), code 6 (ABS_THROTTLE), =
value 181
Event: time 1440942130.471470, -------------- SYN_REPORT ------------
Event: time 1440942130.487450, type 3 (EV_ABS), code 6 (ABS_THROTTLE), =
value 177
Event: time 1440942130.487450, -------------- SYN_REPORT ------------
Event: time 1440942130.519438, type 3 (EV_ABS), code 6 (ABS_THROTTLE), =
value 173
Event: time 1440942130.519438, -------------- SYN_REPORT ------------
Event: time 1440942130.535438, type 3 (EV_ABS), code 6 (ABS_THROTTLE), =
value 169
Event: time 1440942130.535438, -------------- SYN_REPORT ------------
Event: time 1440942130.551439, type 3 (EV_ABS), code 6 (ABS_THROTTLE), =
value 164
Event: time 1440942130.551439, -------------- SYN_REPORT ------------
Event: time 1440942130.567448, type 3 (EV_ABS), code 6 (ABS_THROTTLE), =
value 160
Event: time 1440942130.567448, -------------- SYN_REPORT ------------
Event: time 1440942130.583442, type 3 (EV_ABS), code 6 (ABS_THROTTLE), =
value 156
Event: time 1440942130.583442, -------------- SYN_REPORT ------------
Event: time 1440942130.599444, type 3 (EV_ABS), code 6 (ABS_THROTTLE), =
value 150
Event: time 1440942130.599444, -------------- SYN_REPORT ------------
Event: time 1440942130.615452, type 3 (EV_ABS), code 6 (ABS_THROTTLE), =
value 145
Event: time 1440942130.615452, -------------- SYN_REPORT ------------
Event: time 1440942130.631442, type 3 (EV_ABS), code 6 (ABS_THROTTLE), =
value 140
Event: time 1440942130.631442, -------------- SYN_REPORT ------------
Event: time 1440942130.647441, type 3 (EV_ABS), code 6 (ABS_THROTTLE), =
value 136
Event: time 1440942130.647441, -------------- SYN_REPORT ------------
Event: time 1440942130.671444, type 3 (EV_ABS), code 6 (ABS_THROTTLE), =
value 130
Event: time 1440942130.671444, -------------- SYN_REPORT ------------
Event: time 1440942130.695447, type 3 (EV_ABS), code 6 (ABS_THROTTLE), =
value 126
Event: time 1440942130.695447, -------------- SYN_REPORT ------------
Event: time 1440942130.719451, type 3 (EV_ABS), code 6 (ABS_THROTTLE), =
value 122
Event: time 1440942130.719451, -------------- SYN_REPORT ------------
Event: time 1440942130.743442, type 3 (EV_ABS), code 6 (ABS_THROTTLE), =
value 118
Event: time 1440942130.743442, -------------- SYN_REPORT ------------
Event: time 1440942130.775445, type 3 (EV_ABS), code 6 (ABS_THROTTLE), =
value 114
Event: time 1440942130.775445, -------------- SYN_REPORT ------------
Event: time 1440942130.807445, type 3 (EV_ABS), code 6 (ABS_THROTTLE), =
value 110
Event: time 1440942130.807445, -------------- SYN_REPORT ------------
Event: time 1440942130.823451, type 3 (EV_ABS), code 6 (ABS_THROTTLE), =
value 106
Event: time 1440942130.823451, -------------- SYN_REPORT ------------
Event: time 1440942130.839448, type 3 (EV_ABS), code 6 (ABS_THROTTLE), =
value 101
Event: time 1440942130.839448, -------------- SYN_REPORT ------------
Event: time 1440942130.855452, type 3 (EV_ABS), code 6 (ABS_THROTTLE), =
value 96
Event: time 1440942130.855452, -------------- SYN_REPORT ------------
Event: time 1440942130.879469, type 3 (EV_ABS), code 6 (ABS_THROTTLE), =
value 90
Event: time 1440942130.879469, -------------- SYN_REPORT ------------
Event: time 1440942130.887469, type 3 (EV_ABS), code 6 (ABS_THROTTLE), =
value 86
Event: time 1440942130.887469, -------------- SYN_REPORT ------------
Event: time 1440942130.903439, type 3 (EV_ABS), code 6 (ABS_THROTTLE), =
value 82
Event: time 1440942130.903439, -------------- SYN_REPORT ------------
Event: time 1440942130.911515, type 3 (EV_ABS), code 6 (ABS_THROTTLE), =
value 78
Event: time 1440942130.911515, -------------- SYN_REPORT ------------
Event: time 1440942130.935450, type 3 (EV_ABS), code 6 (ABS_THROTTLE), =
value 74
Event: time 1440942130.935450, -------------- SYN_REPORT ------------
Event: time 1440942130.959431, type 3 (EV_ABS), code 6 (ABS_THROTTLE), =
value 70
Event: time 1440942130.959431, -------------- SYN_REPORT ------------
Event: time 1440942130.983453, type 3 (EV_ABS), code 6 (ABS_THROTTLE), =
value 66
Event: time 1440942130.983453, -------------- SYN_REPORT ------------
Event: time 1440942131.015455, type 3 (EV_ABS), code 6 (ABS_THROTTLE), =
value 62
Event: time 1440942131.015455, -------------- SYN_REPORT ------------
Event: time 1440942131.039452, type 3 (EV_ABS), code 6 (ABS_THROTTLE), =
value 58
Event: time 1440942131.039452, -------------- SYN_REPORT ------------
Event: time 1440942131.063453, type 3 (EV_ABS), code 6 (ABS_THROTTLE), =
value 54
Event: time 1440942131.063453, -------------- SYN_REPORT ------------
Event: time 1440942131.079454, type 3 (EV_ABS), code 6 (ABS_THROTTLE), =
value 50
Event: time 1440942131.079454, -------------- SYN_REPORT ------------
Event: time 1440942131.095453, type 3 (EV_ABS), code 6 (ABS_THROTTLE), =
value 46
Event: time 1440942131.095453, -------------- SYN_REPORT ------------
Event: time 1440942131.119457, type 3 (EV_ABS), code 6 (ABS_THROTTLE), =
value 42
Event: time 1440942131.119457, -------------- SYN_REPORT ------------
Event: time 1440942131.135469, type 3 (EV_ABS), code 6 (ABS_THROTTLE), =
value 38
Event: time 1440942131.135469, -------------- SYN_REPORT ------------
Event: time 1440942131.143460, type 3 (EV_ABS), code 6 (ABS_THROTTLE), =
value 33
Event: time 1440942131.143460, -------------- SYN_REPORT ------------
Event: time 1440942131.159453, type 3 (EV_ABS), code 6 (ABS_THROTTLE), =
value 28
Event: time 1440942131.159453, -------------- SYN_REPORT ------------
Event: time 1440942131.175462, type 3 (EV_ABS), code 6 (ABS_THROTTLE), =
value 24
Event: time 1440942131.175462, -------------- SYN_REPORT ------------
Event: time 1440942131.183455, type 3 (EV_ABS), code 6 (ABS_THROTTLE), =
value 20
Event: time 1440942131.183455, -------------- SYN_REPORT ------------
Event: time 1440942131.191455, type 3 (EV_ABS), code 6 (ABS_THROTTLE), =
value 16
Event: time 1440942131.191455, -------------- SYN_REPORT ------------
Event: time 1440942131.207461, type 3 (EV_ABS), code 6 (ABS_THROTTLE), =
value 10
Event: time 1440942131.207461, -------------- SYN_REPORT ------------
Event: time 1440942131.223454, type 3 (EV_ABS), code 6 (ABS_THROTTLE), =
value 6
Event: time 1440942131.223454, -------------- SYN_REPORT ------------

Cheers
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
