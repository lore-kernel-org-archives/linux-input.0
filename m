From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [git pull] Input updates for v4.16-rc4
Date: Wed, 7 Mar 2018 15:53:11 -0800
Message-ID: <20180307235311.GB231572@dtor-ws>
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

to receive updates for the input subsystem:

- we are reverting patch that was switched touchpad on Lenovo T460P over
  to native RMI because on these boxes BIOS messes up with SMBus
  controller state. We might re-enable it later once SMBus issue is
  resolved

- disabling interrupts in matrix_keypad driver was racy

- mms114 now has SPDX header and matching MODULE_LICENSE


Changelog:
---------

Andi Shyti (2):
      Input: mms114 - fix license module information
      Input: mms114 - add SPDX identifier

Dmitry Torokhov (1):
      Revert "Input: synaptics - Lenovo Thinkpad T460p devices should use RMI"

Zhang Bo (1):
      Input: matrix_keypad - fix race when disabling interrupts

Diffstat:
--------

 drivers/input/keyboard/matrix_keypad.c |  4 +++-
 drivers/input/mouse/synaptics.c        |  1 -
 drivers/input/touchscreen/mms114.c     | 15 ++++++---------
 3 files changed, 9 insertions(+), 11 deletions(-)

Thanks.


-- 
Dmitry
