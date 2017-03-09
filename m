From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 0/8] PS
Date: Thu,  9 Mar 2017 14:16:36 -0800
Message-ID: <20170309221644.17035-1-dmitry.torokhov@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:33349 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750781AbdCIWRF (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Thu, 9 Mar 2017 17:17:05 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Andrew Duggan <aduggan@synaptics.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

Hi,

This is refresh of Benjamin's patches trying to bridge PS/2 and SMbus
devices for better support of Synaptics RMI4 touchpads (and Elans later).

The main difference is that we do not have platform device, as it only
adds another indirection level, and have psmouse create SMBus companion
directly. Because serio ports complete registration asynchronously, we do
not deadlock on psmouse_mutex when even if we have a pass-through port.
(Frankly we need to revisit this whole serio and psmouse thing, use of
global serio_mutex and psmouse_mutex is hurting us; they were needed when
driver core could not recursively iterate over device and driver lists).

We also do not allow overriding serio driver, instead we teach psmouse
about "special" devices and let it continue own the serio port and make
sure nobody else touches it.

To work around issue with psmouse_reconnect() running sometimes too late,
we add "fast reconnect" option to serio. Not too pretty, but gets the job
done. We may need to revisit whole serio PM story later and stop "cheating"
and pretending that device is resumed when it is not, but for that we need
to teach PM core about devices that are OK not to wait for before resuming
userspace. Anyway, much bigger topic for later.

This seems to be working on X1 Carbon and also not breaking my HP 1040 with
forcepad (unfortunately it seems to be using some other SMBus controller
for connecting Synaptics, as I see nothing at 0x2c when loading i2c-i801).

Thanks,
Dmitry

Benjamin Tissoires (2):
  Input: psmouse - add support for SMBus companions
  Input: synaptics - add support for Intertouch devices

Dmitry Torokhov (6):
  i2c: export i2c_client_type structure
  Input: serio - add fast reconnect option
  Input: psmouse - implement fast reconnect option
  Input: psmouse - store pointer to current protocol
  Input: psmouse - introduce notion of SMBus companions
  Input: synaptics - split device info into a separate structure

 drivers/i2c/i2c-core.c              |   4 +-
 drivers/input/mouse/Kconfig         |  16 +
 drivers/input/mouse/Makefile        |   2 +
 drivers/input/mouse/psmouse-base.c  | 213 ++++++---
 drivers/input/mouse/psmouse-smbus.c | 280 ++++++++++++
 drivers/input/mouse/psmouse.h       | 106 +++--
 drivers/input/mouse/synaptics.c     | 832 +++++++++++++++++++++++-------------
 drivers/input/mouse/synaptics.h     |  33 +-
 drivers/input/serio/serio.c         |  22 +-
 include/linux/i2c.h                 |   1 +
 include/linux/serio.h               |   1 +
 11 files changed, 1100 insertions(+), 410 deletions(-)
 create mode 100644 drivers/input/mouse/psmouse-smbus.c

