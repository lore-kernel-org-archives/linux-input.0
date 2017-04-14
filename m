From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [git pull] Input updates for 4.11-rc3
Date: Fri, 14 Apr 2017 14:57:24 -0700
Message-ID: <20170414215724.GA32492@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Linus,

Please pull from:

	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus

to receive updates for the input subsystem. Just a small update to xpad
driver to recognize yet another gamepad, and another change making sure
userio.h is exported.

Changelog:
---------

Cameron Gutman (1):
      Input: xpad - add support for Razer Wildcat gamepad

Naohiro Aota (1):
      uapi: add missing install of userio.h


Diffstat:
--------

 drivers/input/joystick/xpad.c | 2 ++
 include/uapi/linux/Kbuild     | 1 +
 2 files changed, 3 insertions(+)


-- 
Dmitry
