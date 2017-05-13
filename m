From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [git pull] Input updates for v4.11-rc0
Date: Sat, 13 May 2017 07:58:03 -0700
Message-ID: <20170513145803.GA23624@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33725 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753694AbdEMO6H (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sat, 13 May 2017 10:58:07 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

Hi Linus,

Please pull from:

	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus

to receive updates for the input subsystem. You will get an updated xpad
driver with a few more recognized device IDs, and a new psxpad-spi
driver, allowing connecting Playstation 1 and 2 joypads via SPI bus.

Changelog:
---------

Arnd Bergmann (1):
      Input: cros_ec_keyb - remove extraneous 'const'

Benjamin Valentin (3):
      Input: xpad - sort supported devices by USB ID
      Input: xpad - sync supported devices with xboxdrv
      Input: xpad - add USB IDs for Mad Catz Brawlstick and Razer Sabertooth

Tomohiro Yoshidomi (1):
      Input: add support for PlayStation 1/2 joypads connected via SPI

Diffstat:
--------

 drivers/input/joystick/Kconfig        |  21 ++
 drivers/input/joystick/Makefile       |   1 +
 drivers/input/joystick/psxpad-spi.c   | 401 ++++++++++++++++++++++++++++++++++
 drivers/input/joystick/xpad.c         |  27 ++-
 drivers/input/keyboard/cros_ec_keyb.c |   2 +-
 5 files changed, 445 insertions(+), 7 deletions(-)
 create mode 100644 drivers/input/joystick/psxpad-spi.c

Thanks.

-- 
Dmitry
