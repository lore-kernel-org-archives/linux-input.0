From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [git pull] Input updates for 2.6.31-rc0
Date: Tue, 7 Jul 2009 23:50:47 -0700
Message-ID: <20090708065046.GA3309@dtor-d630.eng.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.233]:60878 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750819AbZGHGuz (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 8 Jul 2009 02:50:55 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

Hi Linus,

Please pull from:

	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus
or
	master.kernel.org:/pub/scm/linux/kernel/git/dtor/input.git for-linus

to receive updates for the input subsystem. It contains a few bugfixes
and also a driver for GPIO-based matrix keyboards that's been cooking
for quite a time.

Changelog:
---------

David Brownell (1):
      Input: dm355evm_keys - fix kconfig symbol names

Dmitry Torokhov (1):
      Input: arrange keyboards alphabetically

Eric Miao (1):
      Input: add support for generic GPIO-based matrix keypad

Jani Nikula (2):
      Input: gpio-keys - revert 'change timer to workqueue'
      Input: gpio-keys - avoid possibility of sleeping in timer function

Ping Cheng (1):
      Input: wacom - add DTF720a support and fix rotation on Intuos3

Saeed Bishara (1):
      Input: gpio_mouse - use standard driver registration method

Thadeu Lima de Souza Cascardo (1):
      Input: mark serio and i8042 as suspended when hibernating too

Yan Li (1):
      Input: i8042 - more reset quirks for MSI Wind-clone netbooks


Diffstat:
--------

 drivers/input/keyboard/Kconfig         |  294 +++++++++++----------
 drivers/input/keyboard/Makefile        |   33 ++--
 drivers/input/keyboard/gpio_keys.c     |   33 ++-
 drivers/input/keyboard/matrix_keypad.c |  453 ++++++++++++++++++++++++++++++++
 drivers/input/mouse/gpio_mouse.c       |   11 +-
 drivers/input/serio/i8042-x86ia64io.h  |   28 ++
 drivers/input/serio/i8042.c            |    7 +-
 drivers/input/serio/serio.c            |    7 +-
 drivers/input/tablet/wacom_wac.c       |    6 +-
 drivers/mfd/dm355evm_msp.c             |    3 +-
 include/linux/input/matrix_keypad.h    |   65 +++++
 11 files changed, 757 insertions(+), 183 deletions(-)
 create mode 100644 drivers/input/keyboard/matrix_keypad.c
 create mode 100644 include/linux/input/matrix_keypad.h

-- 
Dmitry

