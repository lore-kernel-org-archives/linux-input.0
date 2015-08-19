From: Mike Mestnik <cheako@mikemestnik.net>
Subject: Fwd: Asus T300CHI: Likes and dislikes about the state of input devices.
Date: Wed, 19 Aug 2015 13:15:18 -0500
Message-ID: <CAF8px55b2wUHyCrkbz7gF9-84JQ=WM89vfoNN_yEDirL6ou7cQ@mail.gmail.com>
References: <b5745b53-f374-4c46-b663-a17a4efb9da8@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lb0-f181.google.com ([209.85.217.181]:36775 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751020AbbHSSPU (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 19 Aug 2015 14:15:20 -0400
Received: by lbbpu9 with SMTP id pu9so8729409lbb.3
        for <linux-input@vger.kernel.org>; Wed, 19 Aug 2015 11:15:18 -0700 (PDT)
In-Reply-To: <b5745b53-f374-4c46-b663-a17a4efb9da8@chromium.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

https://groups.google.com/a/chromium.org/forum/#!topic/input-dev/GTRAmXmmLS8


---------- Forwarded message ----------
From: Mike Mestnik <cheako@mikemestnik.net>
Date: Wed, Aug 19, 2015 at 9:56 AM
Subject: Asus T300CHI: Likes and dislikes about the state of input devices.
To: input-dev <input-dev@chromium.org>


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
