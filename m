From: Yufeng Shen <miletus@chromium.org>
Subject: [RFC] Should make Elo TouchSystems 2216 to use hid-multitouch ?
Date: Mon, 29 Apr 2013 21:10:24 -0400
Message-ID: <CAPDwgkMeUZWKq2ciOeCVzNvxOW6ER55cdU+khDWzxPgcuvgFoQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vb0-f50.google.com ([209.85.212.50]:50447 "EHLO
	mail-vb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758753Ab3D3BKZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 29 Apr 2013 21:10:25 -0400
Received: by mail-vb0-f50.google.com with SMTP id w15so895704vbb.37
        for <linux-input@vger.kernel.org>; Mon, 29 Apr 2013 18:10:25 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Henrik Rydberg <rydberg@euromail.se>, Benjamin Tissoires <benjamin.tissoires@gmail.com>

So I have got an Elo 7"  USB Touchscreen. With default generic-usb
driver, the touchscreen
reports both BTN event & ABS event.

evtest shows something like:

Input device ID: bus 0x3 vendor 0x4e7 product 0x50 version 0x100
Input device name: "EloTouchSystems,Inc Elo TouchSystems 2216 AccuTouch=
=AE
USB Touchmonitor Interface"
Supported events:
  Event type 0 (EV_SYN)
  Event type 1 (EV_KEY)
    Event code 272 (BTN_LEFT)
  Event type 3 (EV_ABS)
    Event code 0 (ABS_X)
      Value   1831
      Min      184
      Max     3932
    Event code 1 (ABS_Y)
      Value   1898
      Min      184
      Max     3932
    Event code 40 (ABS_MISC)
      Value      0
      Min        0
      Max      256
  Event type 4 (EV_MSC)
    Event code 4 (MSC_SCAN)

When one touches the screen, BTN press event is sent, then ABS_X/Y even=
ts
are sent for finger move, and last BTN release event is sent for finger=
 lift.

The way the device uses BTN/ABS events make the device functionality qu=
ite
confusing and limited -- It can only be used for point-to-click without=
 special
handling in userspace.

So I am wondering if it is better to make this device to use
hid-multitouch driver
and add quirks for :
1) set maxcontact =3D 1 (the device can only track 1 finger)
2) convert ABS_X/ABS_Y to MT_ABS_X/Y
3) use BTN press/release to indicate touch down/release

The benefit for doing this in my opinion is more clear and multi-touch =
standard
complying events for userspace. And userspace multitouch library can na=
turally
use the multi-touch data to do like software based multi finger
tracking, tap-to-click,
scrolling and other gestures.
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
