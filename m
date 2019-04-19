From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [git pull] Input updates for v5.1-rc5
Date: Fri, 19 Apr 2019 07:31:57 +0000
Message-ID: <20190419073157.epllrynbv5ww4a7r@penguin>
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

to receive updates for the input subsystem. You will get:

- several new key mappings for HID

- a host of new ACPI IDs used to identify Elan touchpads in Lenovo
  laptops

Changelog:
---------

Anson Huang (1):
      Input: snvs_pwrkey - initialize necessary driver data before enabling IRQ

Dmitry Torokhov (7):
      Input: document meanings of KEY_SCREEN and KEY_ZOOM
      [media] doc-rst: switch to new names for Full Screen/Aspect keys
      HID: input: fix mapping of aspect ratio key
      HID: input: add mapping for Expose/Overview key
      HID: input: add mapping for keyboard Brightness Up/Down/Toggle keys
      HID: input: add mapping for "Full Screen" key
      HID: input: add mapping for "Toggle Display" key

KT Liao (1):
      Input: elan_i2c - add hardware ID for multiple Lenovo laptops

Diffstat:
--------

 Documentation/media/uapi/rc/rc-tables.rst |  4 ++--
 drivers/hid/hid-input.c                   | 17 ++++++++++++++++-
 drivers/input/keyboard/snvs_pwrkey.c      |  6 +++---
 drivers/input/mouse/elan_i2c_core.c       | 25 +++++++++++++++++++++++++
 include/uapi/linux/input-event-codes.h    |  6 ++++--
 5 files changed, 50 insertions(+), 8 deletions(-)

Thanks.


-- 
Dmitry
