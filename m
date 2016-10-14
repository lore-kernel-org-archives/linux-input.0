From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [git pull] Input updates for 4.9-rc0 (part 2)
Date: Fri, 14 Oct 2016 12:36:06 -0700
Message-ID: <20161014193606.GA8678@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35697 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755821AbcJNTgK (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 14 Oct 2016 15:36:10 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

Hi Linus,

Please pull from:

	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus

to receive updates for the input subsystem. You will gen an update to
ALPS driver to support V8 protocol with touchstick, change for i8042 to
skip selftest on many Asus laptops, which helps to keep their touchpads
working after resume, and couple other driver fixes.

Changelog:
---------

Ben Gamari (5):
      Input: ALPS - add touchstick support for SS5 hardware
      Input: ALPS - handle 0-pressure 1F events
      Input: ALPS - allow touchsticks to report pressure
      Input: ALPS - set DualPoint flag for 74 03 28 devices
      Input: ALPS - add V8 protocol documentation

Dmitry Torokhov (1):
      Input: elantech - add Fujitsu Lifebook E556 to force crc_enabled

Guenter Roeck (2):
      Input: synaptics-rmi4 - fix error handling in SPI transport driver
      Input: synaptics-rmi4 - fix error handling in I2C transport driver

Marcos Paulo de Souza (2):
      Input: elantech - fix Lenovo version typo
      Input: i8042 - skip selftest on ASUS laptops

Matti Kurkela (1):
      Input: elantech - force needed quirks on Fujitsu H760

Sangwon Jee (3):
      Input: melfas_mip4 - add devicetree binding documentations
      Input: melfas_mip4 - add maintainer information
      Input: melfas_mip4 - add ic_name sysfs attribute


Diffstat:
--------

 .../bindings/input/touchscreen/melfas_mip4.txt     | 21 +++++
 .../devicetree/bindings/vendor-prefixes.txt        |  1 +
 Documentation/input/alps.txt                       | 57 +++++++++++++
 Documentation/kernel-parameters.txt                |  9 +-
 MAINTAINERS                                        |  7 ++
 drivers/input/mouse/alps.c                         | 87 +++++++++++++++++---
 drivers/input/mouse/alps.h                         |  2 +
 drivers/input/mouse/elantech.c                     | 27 +++++-
 drivers/input/rmi4/rmi_i2c.c                       | 38 ++++++---
 drivers/input/rmi4/rmi_spi.c                       | 22 ++---
 drivers/input/serio/i8042-io.h                     |  2 +-
 drivers/input/serio/i8042-ip22io.h                 |  2 +-
 drivers/input/serio/i8042-ppcio.h                  |  2 +-
 drivers/input/serio/i8042-sparcio.h                |  2 +-
 drivers/input/serio/i8042-unicore32io.h            |  2 +-
 drivers/input/serio/i8042-x86ia64io.h              | 96 +++++++++++++++++++++-
 drivers/input/serio/i8042.c                        | 55 ++++++++++---
 drivers/input/touchscreen/melfas_mip4.c            | 38 ++++++++-
 18 files changed, 411 insertions(+), 59 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/melfas_mip4.txt

-- 
Dmitry

