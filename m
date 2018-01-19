From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [git pull] Input updates for v4.15-rc8
Date: Fri, 19 Jan 2018 09:42:05 -0800
Message-ID: <20180119174205.iq76oggc2h7neymf@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
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

- a fix for use-after-free in Synaptics RMI4 driver
- correction to multitouch contact tracking on certain ALPS touchpads
  (whicj got broken when we tried to fix the 2-finger scrolling)
- touchpad on Lenovo T640p is switched over to SMbus/RMI
- a few device node refcount fixes

Changelog:
---------

Arnd Bergmann (1):
      Input: of_touchscreen - add MODULE_LICENSE

Johan Hovold (3):
      Input: twl4030-vibra - fix sibling-node lookup
      Input: twl6040-vibra - fix child-node lookup
      Input: 88pm860x-ts - fix child-node lookup

Nick Desaulniers (1):
      Input: synaptics-rmi4 - prevent UAF reported by KASAN

Nir Perry (1):
      Input: ALPS - fix multi-touch decoding on SS4 plus touchpads

王振杰 (1):
      Input: synaptics - Lenovo Thinkpad T460p devices should use RMI

Diffstat:
--------

 drivers/input/misc/twl4030-vibra.c         |  6 ++++--
 drivers/input/misc/twl6040-vibra.c         |  3 +--
 drivers/input/mouse/alps.c                 | 23 +++++++++++++----------
 drivers/input/mouse/alps.h                 | 10 ++++++----
 drivers/input/mouse/synaptics.c            |  1 +
 drivers/input/rmi4/rmi_driver.c            |  4 +++-
 drivers/input/touchscreen/88pm860x-ts.c    | 16 ++++++++++++----
 drivers/input/touchscreen/of_touchscreen.c |  4 ++++
 8 files changed, 44 insertions(+), 23 deletions(-)

Thanks.


-- 
Dmitry
