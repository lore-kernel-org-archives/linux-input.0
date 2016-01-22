From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [git pull] Input updates for 4.5-rc0 (round 2)
Date: Fri, 22 Jan 2016 12:56:29 -0800
Message-ID: <20160122205629.GA38479@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f181.google.com ([209.85.192.181]:34471 "EHLO
	mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754276AbcAVU4c (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 22 Jan 2016 15:56:32 -0500
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

Hi Linus,

Please pull from:

	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus

to receive second round of updates for the input subsystem, mainly
changes to xpad driver to better hanlde Xbox One controllers.

Changelog:
---------

Clement Calmels (1):
      Input: xpad - remove spurious events of wireless xpad 360 controller

Dmitry Torokhov (1):
      Input: xpad - use LED API when identifying wireless controllers

Laxman Dewangan (2):
      Input: gpio-keys - allow setting input device name in DT
      Input: gpio-keys - allow disabling individual buttons in DT

Nick Dyer (1):
      Input: atmel_mxt_ts - improve touchscreen size/orientation handling

Pavel Rojtberg (3):
      Input: xpad - correctly handle concurrent LED and FF requests
      Input: xpad - workaround dead irq_out after suspend/ resume
      Input: xpad - correct xbox one pad device name

Pierre-Loup A. Griffais (2):
      Input: xpad - handle "present" and "gone" correctly
      Input: xpad - update Xbox One Force Feedback Support


Diffstat:
--------

 .../devicetree/bindings/input/gpio-keys.txt        |   1 +
 drivers/input/joystick/xpad.c                      | 591 +++++++++++++++------
 drivers/input/keyboard/gpio_keys.c                 |   6 +-
 drivers/input/touchscreen/atmel_mxt_ts.c           |  68 +--
 4 files changed, 456 insertions(+), 210 deletions(-)

-- 
Dmitry

