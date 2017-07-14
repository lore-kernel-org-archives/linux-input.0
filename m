From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [git pull] Input updates for v4.13-rc0 (round 2)
Date: Fri, 14 Jul 2017 11:07:10 -0700
Message-ID: <20170714180710.GA35630@dtor-ws>
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

to receive the 2nd round of updates for the input subsystem. You will
get:

- multit-touch handling for Xen

- fix for long-standing bug causing crashes in i8042 on boot

- change to gpio_keys to better handle key presses during system state
  stransition.

Changelog:
---------

Chen Hong (1):
      Input: i8042 - fix crash at boot time

Joseph Lo (1):
      Input: gpio_keys - handle the missing key press event in resume phase

Oleksandr Andrushchenko (1):
      Input: xen-kbdfront - add multi-touch support

Diffstat:
--------

 drivers/input/keyboard/gpio_keys.c |  17 ++-
 drivers/input/misc/xen-kbdfront.c  | 219 ++++++++++++++++++++++++++++++-------
 drivers/input/serio/i8042.c        |  12 +-
 3 files changed, 204 insertions(+), 44 deletions(-)

Thanks.


-- 
Dmitry
