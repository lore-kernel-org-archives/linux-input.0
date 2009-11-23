From: Mika Westerberg <ext-mika.1.westerberg@nokia.com>
Subject: [PATCH v2 0/2] Input: gpio-keys: support for disabling GPIOs
Date: Mon, 23 Nov 2009 14:39:38 +0200
Message-ID: <cover.1258976669.git.ext-mika.1.westerberg@nokia.com>
References: <20091120084054.GC3009@core.coreip.homeip.net>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:54648 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757231AbZKWMo1 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 23 Nov 2009 07:44:27 -0500
In-Reply-To: <20091120084054.GC3009@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org

Hi Dmitry,

This is second version of the patches. I'm not sure whether I was
supposed to send them again but here they are :)

The first patch now uses new field 'irqflags' which allows platform
to specify exact irq flags it wants.

Second patch is basically the one you provided (the cleaner and
simpler one) but I changed it to use this new field. Also added
some ABI documentation for the sysfs files.

I tested this with RX-51.

Thanks,
MW

Mika Westerberg (2):
  Input: gpio-keys - allow platform to specify exact irq flags
  Input: gpio-keys - added support for disabling gpios through sysfs

 Documentation/ABI/testing/sysfs-platform-gpio-keys |   44 +++
 drivers/input/keyboard/gpio_keys.c                 |  325 +++++++++++++++++++-
 include/linux/gpio_keys.h                          |    7 +
 3 files changed, 365 insertions(+), 11 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-platform-gpio-keys

