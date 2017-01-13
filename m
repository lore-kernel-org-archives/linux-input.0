From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [git pull] Input updates for 4.10-rc3
Date: Thu, 12 Jan 2017 21:51:34 -0800
Message-ID: <20170113055134.GA22630@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:32928 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750775AbdAMFw0 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 13 Jan 2017 00:52:26 -0500
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

Hi Linus,

Please pull from:

	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus

to receive updates for the input subsystem - small driver fixups.

Changelog:
---------

Andy Shevchenko (1):
      Input: adxl34x - make it enumerable in ACPI environment

Aniroop Mathur (1):
      Input: synaptics_i2c - change msleep to usleep_range for small msecs

Corentin Labbe (1):
      Input: joydev - remove unused linux/miscdevice.h include

Dmitry Torokhov (1):
      Input: synaptics-rmi4 - fix F03 build error when serio is module

Guenter Roeck (1):
      Input: elants_i2c - avoid divide by 0 errors on bad touchscreen data

Marcos Paulo de Souza (1):
      Input: i8042 - add Pegatron touchpad to noloop table

Paul Donohue (1):
      Input: ALPS - fix TrackStick Y axis handling for SS5 hardware

Pavel Rojtberg (1):
      Input: xpad - use correct product id for x360w controllers


Diffstat:
--------

 drivers/input/joydev.c                 | 1 -
 drivers/input/joystick/xpad.c          | 6 ++++++
 drivers/input/misc/adxl34x-i2c.c       | 4 +---
 drivers/input/mouse/alps.h             | 2 +-
 drivers/input/mouse/synaptics_i2c.c    | 4 ++--
 drivers/input/rmi4/Kconfig             | 3 ++-
 drivers/input/serio/i8042-x86ia64io.h  | 6 ++++++
 drivers/input/touchscreen/elants_i2c.c | 4 ++--
 8 files changed, 20 insertions(+), 10 deletions(-)

-- 
Dmitry

