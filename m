From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [git pull] Input updates for v4.20-rc0
Date: Fri, 26 Oct 2018 16:49:17 -0700
Message-ID: <20181026234917.GA196749@dtor-ws>
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

to receive updates for the input subsystem. Just random driver fixups,
nothing exiting.

Changelog:
---------

Brian Masney (1):
      Input: pwm-vibrator - correct pwms in DT binding example

Dmitry Torokhov (1):
      Input: synaptics - avoid using uninitialized variable when probing

George G. Davis (1):
      Input: atmel_mxt_ts - fix multiple <linux/property.h> includes

Gustavo A. R. Silva (3):
      Input: cyapa - mark expected switch fall-throughs
      Input: atmel_mxt_ts - mark expected switch fall-through
      Input: xen-kbdfront - mark expected switch fall-through

Hans de Goede (1):
      Input: of_touchscreen - add support for touchscreen-min-x|y

Julian Sax (1):
      Input: silead - try firmware reload after unsuccessful resume

Linus Walleij (1):
      Input: Fix DIR-685 touchkeys MAINTAINERS entry

Martin Kepplinger (1):
      Input: st1232 - set INPUT_PROP_DIRECT property

Randy Dunlap (1):
      Input: wm97xx-ts - fix exit path

Rob Herring (2):
      Input: sun4i-lradc - convert to using %pOFn instead of device_node.name
      Input: xilinx_ps2 - convert to using %pOFn instead of device_node.name

Stephen Boyd (1):
      Input: elants_i2c - use DMA safe i2c when possible

Diffstat:
--------

 .../devicetree/bindings/input/pwm-vibrator.txt     |  4 +--
 .../bindings/input/touchscreen/touchscreen.txt     |  6 ++--
 MAINTAINERS                                        |  2 +-
 drivers/input/keyboard/sun4i-lradc-keys.c          |  6 ++--
 drivers/input/misc/xen-kbdfront.c                  |  2 +-
 drivers/input/mouse/cyapa_gen3.c                   |  4 +--
 drivers/input/mouse/synaptics.c                    |  4 +--
 drivers/input/serio/xilinx_ps2.c                   |  2 +-
 drivers/input/touchscreen/atmel_mxt_ts.c           |  3 +-
 drivers/input/touchscreen/elants_i2c.c             |  7 +++--
 drivers/input/touchscreen/of_touchscreen.c         | 36 +++++++++++++++++-----
 drivers/input/touchscreen/silead.c                 | 13 ++++++++
 drivers/input/touchscreen/st1232.c                 |  1 +
 drivers/input/touchscreen/wm97xx-core.c            |  3 +-
 14 files changed, 64 insertions(+), 29 deletions(-)

Thanks.


-- 
Dmitry
