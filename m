From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v2 00/12] Synaptics RMI4 over SMBus
Date: Wed, 28 Sep 2016 10:35:35 +0200
Message-ID: <1475051747-25988-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lyude Paul <thatslyude@gmail.com>, Andrew Duggan <aduggan@synaptics.com>, Christopher Heiny <cheiny@synaptics.com>
Cc: Peter Hutterer <peter.hutterer@who-t.net>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi,

This is the second version of Synaptics RMI4 over SMBus. There are few
differences compared to the previous submission:
- comments from Andrew are addressed
- fixed an oops when using the "rescan" feature from serio/drvctrl
- use alloc_ordered_workqueue instead of create_singlethread_workqueue

Dmitry, Elan has a similar binding mechanism (touchpad only declared as a PS/2
device, while it can be controlled over SMBus through elan_i2c.ko). I'd like
to have your opinion on using an intermediate platform driver to do the binding
from PS/2. It seems to me that it's the cleanest solution, but you may have
other hints. Note that in the Elan case, the platform driver will get much
simpler because there is no PS/2 passthrough device handled under SMBus (the
protocol is completely defined for the trackstick).

Cheers,
Benjamin

Benjamin Tissoires (10):
  Input: synaptics-rmi4 - add SMBus support
  Input: serio - store the pt_buttons in the struct serio directly
  Input: synaptics-rmi4 - have only one struct platform data
  Input: synaptics-rmi4 - Add rmi_find_function()
  Input: synaptics-rmi4 - f30/f03: Forward mechanical buttons on
    buttonpads to PS/2 guest
  Input: synaptics - allocate a Synaptics Intertouch device
  Input: synaptics-rmi4 - add rmi_platform
  Input: synaptics-rmi4 - smbus: call psmouse_deactivate before
    binding/resume
  Input: synaptics-rmi4 - smbus: on resume, try 3 times if init fails
  Input: synaptics-rmi4 - fix documentation of
    rmi_2d_sensor_platform_data

Dennis Wassenberg (1):
  Input: synaptics-rmi4 - f03: grab data passed by transport device

Lyude Paul (1):
  Input: synaptics-rmi4 - add support for F03

 drivers/input/mouse/psmouse-base.c |  12 +
 drivers/input/mouse/psmouse.h      |   1 +
 drivers/input/mouse/synaptics.c    | 153 +++++++++++-
 drivers/input/mouse/synaptics.h    |   5 +-
 drivers/input/rmi4/Kconfig         |  33 +++
 drivers/input/rmi4/Makefile        |   3 +
 drivers/input/rmi4/rmi_bus.c       |   3 +
 drivers/input/rmi4/rmi_bus.h       |  12 +
 drivers/input/rmi4/rmi_driver.c    |  13 +
 drivers/input/rmi4/rmi_driver.h    |  15 ++
 drivers/input/rmi4/rmi_f03.c       | 272 +++++++++++++++++++++
 drivers/input/rmi4/rmi_f11.c       |   4 +-
 drivers/input/rmi4/rmi_f12.c       |   4 +-
 drivers/input/rmi4/rmi_f30.c       |  79 ++++--
 drivers/input/rmi4/rmi_platform.c  | 235 ++++++++++++++++++
 drivers/input/rmi4/rmi_smbus.c     | 478 +++++++++++++++++++++++++++++++++++++
 include/linux/rmi.h                |  19 +-
 include/linux/serio.h              |   8 +
 include/uapi/linux/serio.h         |   1 +
 19 files changed, 1314 insertions(+), 36 deletions(-)
 create mode 100644 drivers/input/rmi4/rmi_f03.c
 create mode 100644 drivers/input/rmi4/rmi_platform.c
 create mode 100644 drivers/input/rmi4/rmi_smbus.c

-- 
2.7.4
