From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [git pull] Input updates for v5.2-rc5
Date: Tue, 18 Jun 2019 17:16:40 -0700
Message-ID: <20190619001640.GA62849@dtor-ws>
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

to receive updates for the input subsystem. Just a few small fixups;
switching a couple of Thinkpads to SMBus for touchpads as PS/2 emulation
is not working well.

Changelog:
---------

Aaron Ma (1):
      Input: elantech - enable middle button support on 2 ThinkPads

Alexander Mikhaylenko (1):
      Input: synaptics - enable SMBus on ThinkPad E480 and E580

Andrey Smirnov (1):
      Input: uinput - add compat ioctl number translation for UI_*_FF_UPLOAD

Anson Huang (1):
      Input: imx_keypad - make sure keyboard can always wake up system

Daniel Smith (1):
      Input: silead - add MSSL0017 to acpi_device_id

Jeff LaBundy (1):
      Input: iqs5xx - get axis info before calling input_mt_init_slots()

Ravi Chandra Sadineni (1):
      Input: elan_i2c - increment wakeup count if wake source

Diffstat:
--------

 drivers/input/keyboard/imx_keypad.c | 18 ++++++++++++++----
 drivers/input/misc/uinput.c         | 22 ++++++++++++++++++++--
 drivers/input/mouse/elan_i2c_core.c |  2 ++
 drivers/input/mouse/elantech.c      |  2 ++
 drivers/input/mouse/synaptics.c     |  2 ++
 drivers/input/touchscreen/iqs5xx.c  | 24 +++++++++++++-----------
 drivers/input/touchscreen/silead.c  |  1 +
 7 files changed, 54 insertions(+), 17 deletions(-)

Thanks.


-- 
Dmitry
