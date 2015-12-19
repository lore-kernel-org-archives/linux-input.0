From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [git pull] Input updates for 4.4-rc5
Date: Fri, 18 Dec 2015 23:29:54 -0800
Message-ID: <20151219072954.GA37083@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:36721 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753171AbbLSH35 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 19 Dec 2015 02:29:57 -0500
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

Hi Linus,

Please pull from:

	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus

to receive updates for the input subsystem. Just a few assorted driver
fixes.

Changelog:
---------

Charles Keepax (1):
      Input: arizona-haptic - fix disabling of haptics device

Charlie Mooney (1):
      Input: elan_i2c - set input device's vendor and product IDs

Dmitry Torokhov (1):
      Input: atmel_mxt_ts - add generic platform data for Chromebooks

James Chen (1):
      Input: elants_i2c - fix wake-on-touch

Javier Martinez Canillas (1):
      Input: atmel_mxt_ts - add maxtouch to I2C table for module autoload

Karsten Merker (1):
      Input: sun4i-lradc-keys - fix typo in binding documentation

Sudip Mukherjee (5):
      Input: db9 - clear unused function pointers
      Input: gamecon - clear unused function pointers
      Input: turbografx - clear unused function pointers
      Input: walkera0701 - clear unused function pointers
      Input: parkbd - clear unused function pointers

Vladis Dronov (1):
      Input: aiptek - fix crash on detecting device without endpoints


Diffstat:
--------

 .../devicetree/bindings/input/sun4i-lradc-keys.txt |  2 +-
 drivers/input/joystick/db9.c                       |  1 +
 drivers/input/joystick/gamecon.c                   |  1 +
 drivers/input/joystick/turbografx.c                |  1 +
 drivers/input/joystick/walkera0701.c               |  1 +
 drivers/input/misc/arizona-haptics.c               |  3 +-
 drivers/input/mouse/elan_i2c_core.c                |  3 ++
 drivers/input/serio/parkbd.c                       |  1 +
 drivers/input/tablet/aiptek.c                      |  9 ++++++
 drivers/input/touchscreen/atmel_mxt_ts.c           | 34 ++++++++++++++++++++++
 drivers/input/touchscreen/elants_i2c.c             | 21 +++++++------
 11 files changed, 65 insertions(+), 12 deletions(-)

-- 
Dmitry

