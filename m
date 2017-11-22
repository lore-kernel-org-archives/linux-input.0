From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 0/6] Input: remove unneeded MODULE_VERSION usage
Date: Wed, 22 Nov 2017 18:49:15 +0100
Message-ID: <20171122174921.20192-1-gregkh@linuxfoundation.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:46290 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751554AbdKVRtU (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 22 Nov 2017 12:49:20 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
Cc: linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Here's a short patch series against linux-next at the moment, that
removes all of the MODULE_VERSION() usage in drivers/input/ as it's not
needed at all.

Greg Kroah-Hartman (6):
  Input: rmi4: remove unneeded MODULE_VERSION() usage
  Input: keyboard: pmic8xxx: remove unneeded MODULE_VERSION() usage
  Input: mouse: elan_i2c: remove unneeded MODULE_VERSION() usage
  Input: touchscreen: remove unneeded MODULE_VERSION() usage
  Input: misc: remove unneeded MODULE_VERSION() usage
  Input: remove remaining unneeded MODULE_VERSION() usage

 drivers/input/input-polldev.c               | 1 -
 drivers/input/keyboard/pmic8xxx-keypad.c    | 1 -
 drivers/input/misc/apanel.c                 | 2 --
 drivers/input/misc/ati_remote2.c            | 2 --
 drivers/input/misc/uinput.c                 | 1 -
 drivers/input/mouse/elan_i2c_core.c         | 2 --
 drivers/input/rmi4/rmi_bus.c                | 1 -
 drivers/input/rmi4/rmi_driver.h             | 2 --
 drivers/input/rmi4/rmi_i2c.c                | 1 -
 drivers/input/rmi4/rmi_spi.c                | 1 -
 drivers/input/sparse-keymap.c               | 1 -
 drivers/input/touchscreen/colibri-vf50-ts.c | 2 --
 drivers/input/touchscreen/elants_i2c.c      | 2 --
 drivers/input/touchscreen/melfas_mip4.c     | 1 -
 drivers/input/touchscreen/wdt87xx_i2c.c     | 2 --
 15 files changed, 22 deletions(-)

-- 
2.15.0

