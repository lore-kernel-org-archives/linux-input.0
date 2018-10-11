From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [git pull] Input updates for v4.19-rc7
Date: Thu, 11 Oct 2018 16:57:36 -0700
Message-ID: <20181011235736.GA68543@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Greg,

Please pull from:

	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus

to receive updates for the input subsystem:

- we added a few scheduling points into various input interfaces to
  ensure that large writes will not cause RCU stalls

- fixed configuring PS/2 keyboards as wakeup devices on newer platforms

- added a new Xbox gamepad ID.

Changelog:
---------

Daniel Drake (1):
      Input: i8042 - enable keyboard wakeups by default when s2idle is used

Dmitry Torokhov (2):
      Input: evdev - add a schedule point in evdev_write()
      Input: uinput - add a schedule point in uinput_inject_events()

Eric Dumazet (1):
      Input: mousedev - add a schedule point in mousedev_write()

Ramses Ramírez (1):
      Input: xpad - add support for Xbox1 PDP Camo series gamepad

Diffstat:
--------

 drivers/input/evdev.c         |  1 +
 drivers/input/joystick/xpad.c |  3 +++
 drivers/input/misc/uinput.c   |  1 +
 drivers/input/mousedev.c      |  1 +
 drivers/input/serio/i8042.c   | 29 ++++++++++++++++++++---------
 include/linux/suspend.h       |  2 ++
 kernel/power/suspend.c        |  6 ++++++
 7 files changed, 34 insertions(+), 9 deletions(-)

Thanks.


-- 
Dmitry
