From: Mika Westerberg <ext-mika.1.westerberg@nokia.com>
Subject: [PATCH v3 0/1] Input: gpio-keys: support for disabling GPIOs
Date: Tue,  1 Dec 2009 15:53:45 +0200
Message-ID: <cover.1259674171.git.ext-mika.1.westerberg@nokia.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:58860 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751821AbZLAN6p (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 1 Dec 2009 08:58:45 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org

Hi Dmitry,

This is third version of the series. Purpose of this patch is to allow
userland to disable GPIO buttons interrupting the CPU. There is now sysfs
interface that can be used to control the buttons by key code or by switch
code.

I merged those previous 2 patches as one. This is because it made little
sense of having separate patch for adding the 'can_disable' field.

Changes in v3:
	- merged previous 2 patches into one
	- buttons have 'can_disable' field instead of irqflags field

Tested with RX-51.

Thanks,
MW

---

Mika Westerberg (1):
  Input: gpio-keys - added support for disabling gpios through sysfs

 Documentation/ABI/testing/sysfs-platform-gpio-keys |   44 +++
 drivers/input/keyboard/gpio_keys.c                 |  318 +++++++++++++++++++-
 include/linux/gpio_keys.h                          |    1 +
 3 files changed, 352 insertions(+), 11 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-platform-gpio-keys

