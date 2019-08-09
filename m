From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [git pull] Input updates for v5.3-rc3
Date: Fri, 9 Aug 2019 15:20:30 -0700
Message-ID: <20190809222030.GA20442@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Linus,

Please pull from:

	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus

to receive updates for the input subsystem. You will get:

- newer systems with Elan touchpads will be switched over to SMBus
- HP Spectre X360 will be using SMbus/RMI4
- checks for invalid USB descriptors in kbtab and iforce
- build fixes for applespi driver (misconfigs)

Thanks!

Changelog:
---------

Arnd Bergmann (1):
      Input: applespi - select CRC16 module

Dmitry Torokhov (2):
      Input: elantech - annotate fall-through case in elantech_use_host_notify()
      Input: synaptics - enable RMI mode for HP Spectre X360

Gustavo A. R. Silva (1):
      Input: applespi - use struct_size() helper

Kai-Heng Feng (1):
      Input: elantech - enable SMBus on new (2018+) systems

Nikolas Nyby (1):
      Input: applespi - fix trivial typo in struct description

Oliver Neukum (3):
      Input: usbtouchscreen - initialize PM mutex before using it
      Input: kbtab - sanity check for endpoint type
      Input: iforce - add sanity checks

Ronald Tschalär (1):
      Input: applespi - fix warnings detected by sparse

YueHaibing (1):
      Input: applespi - add dependency on LEDS_CLASS

Diffstat:
--------

 drivers/input/joystick/iforce/iforce-usb.c |  5 +++
 drivers/input/keyboard/Kconfig             |  2 ++
 drivers/input/keyboard/applespi.c          | 29 +++++++++-------
 drivers/input/mouse/elantech.c             | 55 ++++++++++++++----------------
 drivers/input/mouse/synaptics.c            |  1 +
 drivers/input/tablet/kbtab.c               |  6 ++--
 drivers/input/touchscreen/usbtouchscreen.c |  2 ++
 7 files changed, 56 insertions(+), 44 deletions(-)

Thanks.


-- 
Dmitry
