From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 00/13] RMI4 cleanups and switch hid-rmi to rmi_core
Date: Tue, 29 Nov 2016 11:08:11 +0100
Message-ID: <1480414104-8524-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jikos@kernel.org>, Andrew Duggan <aduggan@synaptics.com>, Lyude Paul <thatslyude@gmail.com>, Nick Dyer <nick@shmanahar.org>, Dennis Wassenberg <dennis.wassenberg@secunet.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi guys,

This series applies on top of Dmitry's synaptics-rmi4 branch.

Patches 1-6 are cleanups which should be applied on this branch before it
gets merged with linux-next IMO. Nick, I updated the patch since our last
tests from last week. I'd be glad if you could give an other spin at testing
(patch 3 is a brancd new one which simplifies the rest of the series).

Patches 7-10 are requirements for hid-rmi to switch to rmi4_core.
It adds the PS/2 pass-through support and the API for hid-rmi to provide
the attention data.

Patches 10-13 are the HID ones. I wish they could go in together, but given
that we are getting closer than the merge window, I don't have many hopes for
them to be taken. Anyway, they are here and I'd like to get some feedback for
them too. I am able to only test these with a Synaptics test touchpad, so any
real hardware test (with F11 or F12) would be good.

I still have few rmi4 patches to switch the Lenovo Thinkpad to rmi-smbus,
but given they are touching serio+psmouse I guess they are more v4.11 material.
(for those wondering I already submitted those as 14-17 / 18 in the v3 of
rmi4-smbus).

I have pushed the series on my github account (with the smbus/psmouse too):
https://github.com/bentiss/linux/commits/synaptics-rmi4-v4.9-rc7%2B
(branch synaptics-rmi4-v4.9-rc7+)

Cheers,
Benjamin


Andrew Duggan (3):
  HID: rmi: Make hid-rmi a transport driver for synaptics-rmi4
  HID: rmi: Handle all Synaptics touchpads using hid-rmi
  HID: rmi: Support the Lenovo Thinkpad X1 Tablet dock using hid-rmi

Benjamin Tissoires (8):
  Input: synaptics-rmi4 - fix documentation of
    rmi_2d_sensor_platform_data
  Input: synaptics-rmi4 - remove unused fields in struct rmi_driver_data
  Input: synaptics-rmi4 - add rmi_enable/disable_irq
  Input: synaptics-rmi4 - remove mutex calls while updating the firmware
  Input: synaptics-rmi4 - remove EXPORT_SYMBOL_GPL for internal
    functions
  Input: synaptics-rmi4 - have only one struct platform data
  Input: synaptics-rmi4 - allow to add attention data
  Input: synaptics-rmi4 - store the attn data in the driver

Dennis Wassenberg (1):
  Input: synaptics-rmi4 - f03: grab data passed by transport device

Lyude Paul (1):
  Input: synaptics-rmi4 - add support for F03

 drivers/hid/Kconfig                |   4 +
 drivers/hid/hid-core.c             |   4 +-
 drivers/hid/hid-ids.h              |   1 +
 drivers/hid/hid-rmi.c              | 974 ++++++-------------------------------
 drivers/input/mouse/psmouse-base.c |   6 +
 drivers/input/rmi4/Kconfig         |   9 +
 drivers/input/rmi4/Makefile        |   1 +
 drivers/input/rmi4/rmi_bus.c       |   3 +
 drivers/input/rmi4/rmi_driver.c    | 186 ++++---
 drivers/input/rmi4/rmi_driver.h    |   6 +-
 drivers/input/rmi4/rmi_f03.c       | 245 ++++++++++
 drivers/input/rmi4/rmi_f11.c       |  16 +-
 drivers/input/rmi4/rmi_f12.c       |  47 +-
 drivers/input/rmi4/rmi_f30.c       |  20 +-
 drivers/input/rmi4/rmi_f34.c       |  19 +-
 include/linux/rmi.h                |  25 +-
 include/uapi/linux/serio.h         |   1 +
 17 files changed, 609 insertions(+), 958 deletions(-)
 create mode 100644 drivers/input/rmi4/rmi_f03.c

-- 
2.7.4
