From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [git pull] Input updates for 4.5-rc3
Date: Wed, 10 Feb 2016 11:41:37 -0800
Message-ID: <20160210194137.GA5626@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:35286 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751712AbcBJTlk (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 10 Feb 2016 14:41:40 -0500
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

Hi Linus,

Please pull from:

	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus

to receive updates for the input subsystem. Just small driver fixups...

Changelog:
---------

Amitoj Kaur Chawla (1):
      Input: cap11xx - add missing of_node_put

Arnd Bergmann (2):
      Input: xpad - remove unused function
      Input: sirfsoc-onkey - allow modular build

Dmitry Torokhov (1):
      Input: vmmouse - fix absolute device registration

Geert Uytterhoeven (1):
      Input: colibri-vf50-ts - add missing #include <linux/of.h>

Grygorii Strashko (1):
      Input: serio - drop warnings in case of EPROBE_DEFER from serio_find_driver()

Lars-Peter Clausen (1):
      Input: adp5589 - fix row 5 handling for adp5589

Philipp Zabel (1):
      Input: edt-ft5x06 - fix setting gain, offset, and threshold via device tree


Diffstat:
--------

 drivers/input/joystick/xpad.c               |  1 -
 drivers/input/keyboard/adp5589-keys.c       |  7 ++++---
 drivers/input/keyboard/cap11xx.c            |  8 ++++++--
 drivers/input/misc/Kconfig                  |  2 +-
 drivers/input/misc/sirfsoc-onkey.c          |  2 +-
 drivers/input/mouse/vmmouse.c               | 13 +++++++------
 drivers/input/serio/serio.c                 |  2 +-
 drivers/input/touchscreen/colibri-vf50-ts.c |  1 +
 drivers/input/touchscreen/edt-ft5x06.c      | 18 ++++++++++++------
 9 files changed, 33 insertions(+), 21 deletions(-)

-- 
Dmitry

