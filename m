From: Chao Xie <chao.xie@marvell.com>
Subject: [PATCH V2 0/5] input: pxa27x-keypad: enhancement and device tree support
Date: Sun, 5 May 2013 23:04:03 -0400
Message-ID: <1367809448-9437-1-git-send-email-chao.xie@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, haojian.zhuang@gmail.com, xiechao.mail@gmail.com
Cc: Chao Xie <chao.xie@marvell.com>
List-Id: linux-input@vger.kernel.org

The patches include 2 parts
1. use matrix_keypad for matrix keyes support
2. add device tree support for pxa27x-keypad

V2->V1:
Do not copy the members from pdata. For device tree support,
directly allocate the pdata structure.

Chao Xie (5):
  input: pxa27x-keypad: use matrix_keymap for matrix keyes
  arm: mmp: use matrix_keymap for aspenite
  arm: mmp: use matrix_keymap for teton_bga
  input: pxa27x-keypad: remove the unused members at platform data
  input: pxa27x-keypad: add device tree support

 .../devicetree/bindings/input/pxa27x-keypad.txt    |   60 +++++
 arch/arm/mach-mmp/aspenite.c                       |   10 +-
 arch/arm/mach-mmp/teton_bga.c                      |    8 +-
 drivers/input/keyboard/Kconfig                     |    1 +
 drivers/input/keyboard/pxa27x_keypad.c             |  266 ++++++++++++++++++--
 include/linux/platform_data/keypad-pxa27x.h        |    3 +-
 6 files changed, 325 insertions(+), 23 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/pxa27x-keypad.txt

-- 
1.7.4.1
