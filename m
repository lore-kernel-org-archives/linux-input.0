From: Anisha Kaul <born.rebel.83@gmail.com>
Subject: fftest: Force feedback doesn't work in native mode
Date: Wed, 18 Jan 2012 13:02:49 +0530
Message-ID: <CAM1yFZ9JRgN=vU+jZLzP6rX5bY3g8W3v97BuUjWaFzGtqgjDAg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:55129 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752892Ab2ARHct (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 18 Jan 2012 02:32:49 -0500
Received: by obcva7 with SMTP id va7so6832033obc.19
        for <linux-input@vger.kernel.org>; Tue, 17 Jan 2012 23:32:49 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Simon Wood <simon@mungewell.org>

Greetz,

The wheel: Logitech Driving Force GT (DFGT)

fftest "does" help in applying the "constant effect" in the default mode.
As soon as I shift the wheel to "native mode" through the LtWheelConf
software, the fftest starts complaining
with " Function not implemented" message.

linux-dopx:/ # fftest /dev/input/event4
Force feedback test program.
HOLD FIRMLY YOUR WHEEL OR JOYSTICK TO PREVENT DAMAGES

Device /dev/input/event4 opened
Axes query:
Effects:
Number of simultaneous effects: 0
Upload effects[0]: Function not implemented
Upload effects[1]: Function not implemented
Upload effects[2]: Function not implemented
Upload effects[3]: Function not implemented
Upload effects[4]: Function not implemented
Upload effects[5]: Function not implemented
Enter effect number, -1 to exit

The platform:

linux-dopx:/ # cat /etc/issue && uname -a
Welcome to openSUSE 11.3 "Teal" - Kernel \r (\l).
Linux linux-dopx 2.6.34-12-desktop #1 SMP PREEMPT 2010-06-29 02:39:08
+0200 x86_64 x86_64 x86_64 GNU/Linux


Please guide.
-Anisha
