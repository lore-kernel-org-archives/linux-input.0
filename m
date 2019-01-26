From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [git pull] Input updates for v5.0-rc3
Date: Fri, 25 Jan 2019 17:11:13 -0800
Message-ID: <20190126011113.GA23858@dtor-ws>
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

to receive updates for the input subsystem. You will get a fixup for
the input_event fix for y2038 Sparc64, and couple other minor fixes.

Changelog:
---------

Anders Roxell (1):
      Input: raspberrypi-ts - fix link error

Deepa Dinamani (2):
      Input: input_event - provide override for sparc64
      Input: input_event - fix the CONFIG_SPARC64 mixup

Dmitry Torokhov (1):
      Input: uinput - fix undefined behavior in uinput_validate_absinfo()

Lubomir Rintel (1):
      Input: olpc_apsp - assign priv->dev earlier

Tom Panfil (1):
      Input: xpad - add support for SteelSeries Stratus Duo

Diffstat:
--------

 drivers/input/joystick/xpad.c     | 3 +++
 drivers/input/misc/uinput.c       | 5 +++--
 drivers/input/serio/olpc_apsp.c   | 3 ++-
 drivers/input/touchscreen/Kconfig | 2 +-
 include/uapi/linux/input.h        | 6 +++++-
 5 files changed, 14 insertions(+), 5 deletions(-)

Thanks.


-- 
Dmitry
