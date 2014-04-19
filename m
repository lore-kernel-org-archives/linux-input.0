From: Tomas Sokorai <tsokorai@gmail.com>
Subject: Issues with hid-multitouch driver
Date: Sat, 19 Apr 2014 20:02:04 -0300
Message-ID: <CAEQQWc5My-QBoiX7Yqx_-Rer-OdaD7OxJgci5DScJf012s15Aw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qc0-f170.google.com ([209.85.216.170]:50677 "EHLO
	mail-qc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754353AbaDSXCG (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 19 Apr 2014 19:02:06 -0400
Received: by mail-qc0-f170.google.com with SMTP id x13so2895652qcv.15
        for <linux-input@vger.kernel.org>; Sat, 19 Apr 2014 16:02:04 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hi guys,

I'm having issues with the hid-multitouch driver in kernel 3.14.
I have the following touchscreen device:

Bus 001 Device 003: ID 03fc:05d8 Elitegroup Computer Systems

The thing is that the driver detects the device correctly and even
works seemingly OK, until you start doing multi-touch taps on the
screen.

At some point, the input to the Xorg server stops.

I investigated this further, and using evtest, I can see that the events
ABS_X and ABS_Y stop being generated, and also that BTN_TOUCH event
gets a "value 1" for the touch before the freeze, but it is never
released: no "value 0" for the touch release event, ever.

After the driver gets braindamaged, it only generates
ABS_MT_POSITION_Y, ABS_MT_POSITION_X and ABS_MT_TRACKING_ID events,
and therefore no further clicks or normal Xorg pointer movement
on-screen.

I even tried backporting the lastest version from the HID git, with
the same results.

Thanks in advance,
-- 
Tomas J. Sokorai Sch.
