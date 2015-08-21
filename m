From: Mike Mestnik <cheako@mikemestnik.net>
Subject: Asus T300CHI: Likes and dislikes about the state of input devices.
Date: Fri, 21 Aug 2015 17:36:30 -0500
Message-ID: <CAF8px55JTg3D92kUs+Jd8JeixnXWsXjMW_uUO=ZX0Wdm7X1ROA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lb0-f180.google.com ([209.85.217.180]:35742 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750970AbbHUWgc (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 21 Aug 2015 18:36:32 -0400
Received: by lbcbn3 with SMTP id bn3so51771083lbc.2
        for <linux-input@vger.kernel.org>; Fri, 21 Aug 2015 15:36:30 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hello,
  I've one of these new 2in1s that's more of a tablet than a laptop,
but has an amd64 instead of an arm CPU.  I've installed Debian /w
Gnome and have had a difficult time with the current support and lack
of support for input devices.

On boot this device has a touchscrren and 5 buttons(if you count sleep
and power as two)  Currently grub is useless, meaning the install
requiers boot media that default boots to what you want booted.  I
worked around this by hexediting the grub config files on the iso.


The current devices not-working items:
1. Touchscreen does not survive suspend/resume in X11.
2. Touchscreen does not work for X11 apps running in wayland.
After setting up blutooth dock, must be done in X11 on first
suspend/resume session.
3. 2nd button is impossible to access.  The touch pad has a clicker
underneeth that's used for 3rd button and click-drag.  There is a
center line on the bottom marking these two zones.

Things currently working flaulessly.
1. The docks keyboard.

Feuture device needs and items that need addressing for finishing the drivers.
3-axis gyroscope  /w  3-axis accelerometer, the inv-mpu6050 driver
exposes these to sysfs and AFAICT each component works.
magnetometer, not sure how many axis but 3-axis exists.
GPS device (two axis location?)

1. From what I can tell no current input device 'wraps arround' That
is to say that max and min are one step from eachother and there needs
to be a way to indecate what direction the movement happened in.
2. Physical Displaycement.  I'm not sure if the gyroscope is centered
on the screen and even if it is there is still a displacement off the
z axis that might effect the x and y measurments.
3. 6 axis device, with a 3 axis precedent.

Not needed for this project but display to device mappings, for
example a dual monitor touchscreen setup.
