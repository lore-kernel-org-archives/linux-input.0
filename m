From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 00/18] Input - Fix make coccicheck warnings
Date: Fri,  2 Oct 2015 15:40:11 +0200
Message-ID: <1443793229-22363-1-git-send-email-javier@osg.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Javier Martinez Canillas <javier@osg.samsung.com>, Ferruh Yigit <fery@cypress.com>, Axel Lin <axel.lin@ingics.com>, Pramod Gurav <pramod.gurav@smartplayin.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Heiko Stuebner <heiko.stuebner@bq.com>, Fabio Estevam <fabio.estevam@freescale.com>, Hans de Goede <hdegoede@redhat.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Rob Herring <robh@kernel.org>, Dirk Behme <dirk.behme@de.bosch.com>, Benson Leung <bleung@chromium.org>, Shailendra Verma <shailendra.capricorn@gmail.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, linux-input@vger.kernel.org, Duson Lin <dusonlin@emc.com.tw>, Jingoo Han <jg1.han@samsung.com>, Wolfram Sang <wsa@the-dreams.de>, Wei Yongjun <yongjun_wei@trendmicro.com.cn>, Henrik Rydberg <rydberg@bitmath.org>, Daniel Mack <linux@zonque.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Ni
List-Id: linux-input@vger.kernel.org

Hello Dmitry,

This series contains trivial patches with fixes to different warnings
reported by make coccichek M=drivers/input.

The patches don't contain functional changes but makes the functions
simpler and removes unnecessary lines of code.

Best regards,
Javier


Javier Martinez Canillas (18):
  Input: joydev - use memdup_user() to duplicate memory from user-space
  Input: ads7846 - use PTR_ERR_OR_ZERO()
  Input: cyttsp - use PTR_ERR_OR_ZERO()
  Input: kxtj9 - remove unneeded retval variable
  Input: retu-pwrbutton - simplify function return logic
  Input: zforce - simplify function return logic
  Input: cap11xx - simplify function return logic
  Input: goldfish - simplify function return logic
  Input: jornada720_ts - simplify function return logic
  Input: intel-mid-touch - simplify function return logic
  Input: da9034-ts - simplify function return logic
  Input: pxa27x_keypad - simplify function return logic
  Input: atmel_mxt_ts - simplify function return logic
  Input: synaptics_i2c - simplify function return logic
  Input: auo-pixcir-ts - simplify function return logic
  Input: elan_i2c - simplify function return logic
  Input: cypress_ps2 - simplify function return logic
  Input: tps6507x-ts - simplify function return logic

 drivers/input/joydev.c                      | 18 ++++++-----------
 drivers/input/keyboard/cap11xx.c            |  8 ++------
 drivers/input/keyboard/goldfish_events.c    |  6 +-----
 drivers/input/keyboard/pxa27x_keypad.c      | 12 ++++--------
 drivers/input/misc/kxtj9.c                  |  3 +--
 drivers/input/misc/retu-pwrbutton.c         |  6 +-----
 drivers/input/mouse/cypress_ps2.c           |  6 +-----
 drivers/input/mouse/elan_i2c_smbus.c        |  6 +-----
 drivers/input/mouse/synaptics_i2c.c         |  6 +-----
 drivers/input/touchscreen/ads7846.c         |  4 +---
 drivers/input/touchscreen/atmel_mxt_ts.c    | 30 +++++------------------------
 drivers/input/touchscreen/auo-pixcir-ts.c   |  7 +------
 drivers/input/touchscreen/cyttsp4_i2c.c     |  5 +----
 drivers/input/touchscreen/da9034-ts.c       |  7 +------
 drivers/input/touchscreen/intel-mid-touch.c |  6 +-----
 drivers/input/touchscreen/jornada720_ts.c   |  6 +-----
 drivers/input/touchscreen/tps6507x-ts.c     |  9 +--------
 drivers/input/touchscreen/zforce_ts.c       |  7 +------
 18 files changed, 31 insertions(+), 121 deletions(-)

-- 
2.4.3
