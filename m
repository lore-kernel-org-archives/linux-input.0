From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [git pull] Input updates for v4.12-rc3
Date: Sat, 3 Jun 2017 14:52:56 -0700
Message-ID: <20170603215256.GA27194@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:35343 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751162AbdFCVw7 (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Sat, 3 Jun 2017 17:52:59 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

Hi Linus,

Please pull from:

	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus

to receive updates for the input subsystem. You will get a couple
regression fixes in synaptics and axp20x-pek drivers, and we will try to
ease transition from PS/2 to RMI for Synaptics touchpad users by
ensuring we do not try to activate RMI mode when RMI SMBus support is
not enabled, and nag users a bit to enable it. Plus a couple of other
changes that seemed worthwhile for this release.

Changelog:
---------

Andi Shyti (1):
      Input: tm2-touchkey - use LEN_ON as boolean value instead of LED_FULL

Benjamin Tissoires (3):
      Input: synaptics - keep PS/2 around when RMI4_SMB is not enabled
      Input: synaptics - warn the users when there is a better mode
      Input: synaptics - tell users to report when they should be using rmi-smbus

Eric Biggers (1):
      Input: synaptics - clear device info before filling in

Hans de Goede (3):
      Input: silead - disable interrupt during suspend
      Input: axp20x-pek - only check for "INTCFD9" ACPI device on Cherry Trail
      Input: axp20x-pek - switch to acpi_dev_present and check for ACPI0011 too

Diffstat:
--------

 drivers/input/keyboard/tm2-touchkey.c |  2 +-
 drivers/input/misc/axp20x-pek.c       | 44 +++++++++++++++++++++++++++++------
 drivers/input/mouse/synaptics.c       | 37 ++++++++++++++++++++++-------
 drivers/input/touchscreen/silead.c    |  3 +++
 4 files changed, 69 insertions(+), 17 deletions(-)

Thanks.


-- 
Dmitry
