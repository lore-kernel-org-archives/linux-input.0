From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [git pull] Input updates for 3.0-rc3
Date: Mon, 20 Jun 2011 01:56:22 -0700
Message-ID: <20110620085621.GA26733@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Linus,

Please pull from:

	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus
or
	master.kernel.org:/pub/scm/linux/kernel/git/dtor/input.git for-linus

to receive a couple of fixups for the input subsystem.

Changelog:
---------

Dmitry Torokhov (1):
      Input: evdev - try to wake up readers only if we have full packet

Hans Petter Selasky (1):
      Input: properly assign return value of clamp() macro.

Janusz Krzysztofik (1):
      Input: omap-keypad - add missing input_sync()

Magnus Damm (1):
      Input: sh_keysc - 8x8 MODE_6 fix


Diffstat:
--------

 drivers/input/evdev.c                |    3 ++-
 drivers/input/input.c                |    2 +-
 drivers/input/keyboard/omap-keypad.c |    1 +
 drivers/input/keyboard/sh_keysc.c    |    2 +-
 drivers/input/mousedev.c             |    4 ++--
 include/linux/input/sh_keysc.h       |    2 +-
 6 files changed, 8 insertions(+), 6 deletions(-)

-- 
Dmitry
