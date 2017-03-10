From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH v2 0/9] PS/2 and SMBus companions
Date: Fri, 10 Mar 2017 15:01:05 -0800
Message-ID: <20170310230114.788-1-dmitry.torokhov@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:33383 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932724AbdCJXCR (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 10 Mar 2017 18:02:17 -0500
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

This seems to be working on X1 Carbon and HP 1040 with forcepad, but
to fully support forcepad we need implementation of RMI F21, so patch #9
is more of FYI.

Thanks,
Dmitry

V2: incorporated Benjamin's change to keep platform data around until
companion device is destroyed, added enabled forcepad support. 

Benjamin Tissoires (2):
  Input: psmouse - add support for SMBus companions
  Input: synaptics - add support for Intertouch devices

Dmitry Torokhov (7):
  i2c: export i2c_client_type structure
  Input: serio - add fast reconnect option
  Input: psmouse - implement fast reconnect option
  Input: psmouse - store pointer to current protocol
  Input: psmouse - introduce notion of SMBus companions
  Input: synaptics - split device info into a separate structure
  [NEEDS F21] Input: synaptics - switch forcepad devices over to SMbus
    access

 drivers/i2c/i2c-core.c              |   4 +-
 drivers/input/mouse/Kconfig         |  16 +
 drivers/input/mouse/Makefile        |   2 +
 drivers/input/mouse/psmouse-base.c  | 213 ++++++---
 drivers/input/mouse/psmouse-smbus.c | 291 +++++++++++++
 drivers/input/mouse/psmouse.h       | 110 +++--
 drivers/input/mouse/synaptics.c     | 829 +++++++++++++++++++++++-------------
 drivers/input/mouse/synaptics.h     |  33 +-
 drivers/input/serio/serio.c         |  22 +-
 include/linux/i2c.h                 |   1 +
 include/linux/serio.h               |   1 +
 11 files changed, 1116 insertions(+), 406 deletions(-)
 create mode 100644 drivers/input/mouse/psmouse-smbus.c

-- 
2.12.0.246.ga2ecc84866-goog

