From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [git pull] Input updates for 4.4-rc0 (round 2)
Date: Fri, 13 Nov 2015 16:55:37 -0800
Message-ID: <20151114005537.GA8682@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:34991 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751658AbbKNAzk (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 13 Nov 2015 19:55:40 -0500
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

Hi Linus,

Please pull from:

	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus

to receive updates for the input subsystem. You will get an update to
tsc2005 driver that allows it to support tsc2004 (basically the same
controller, but uses i2c instead of spi bus), and a couple of bug fixes.

Note that there will be a minor conflict in
drivers/input/touchscreen/tsc2005.c due to the recently merged change
removing setting of owner in SPI drivers.

Changelog:
---------

Geert Uytterhoeven (1):
      Input: parkbd - drop bogus __init from parkbd_allocate_serio()

Michael Welling (3):
      Input: tsc2005 - separate SPI and core functions
      Input: tsc200x-core - rename functions and variables
      Input: tsc2004 - add support for tsc2004

Takashi Iwai (1):
      Input: elantech - add Fujitsu Lifebook U745 to force crc_enabled


Diffstat:
--------

 .../bindings/input/touchscreen/tsc2005.txt         |  34 +-
 drivers/input/mouse/elantech.c                     |   7 +
 drivers/input/serio/parkbd.c                       |   2 +-
 drivers/input/touchscreen/Kconfig                  |  17 +
 drivers/input/touchscreen/Makefile                 |   2 +
 drivers/input/touchscreen/tsc2004.c                |  83 +++
 drivers/input/touchscreen/tsc2005.c                | 714 +--------------------
 drivers/input/touchscreen/tsc200x-core.c           | 665 +++++++++++++++++++
 drivers/input/touchscreen/tsc200x-core.h           |  78 +++
 9 files changed, 899 insertions(+), 703 deletions(-)
 create mode 100644 drivers/input/touchscreen/tsc2004.c
 create mode 100644 drivers/input/touchscreen/tsc200x-core.c
 create mode 100644 drivers/input/touchscreen/tsc200x-core.h

-- 
Dmitry

