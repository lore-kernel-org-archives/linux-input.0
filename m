From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 00/11] Synaptics RMI4 over SMBus
Date: Thu, 18 Aug 2016 11:24:38 +0200
Message-ID: <1471512289-10648-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49280 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753088AbcHRJ1L (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 18 Aug 2016 05:27:11 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lyude Paul <thatslyude@gmail.com>, Andrew Duggan <aduggan@synaptics.com>, Christopher Heiny <cheiny@synaptics.com>, Dennis Wassenberg <dennis.wassenberg@secunet.com>
Cc: Peter Hutterer <peter.hutterer@who-t.net>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

Hi,

this is finally my first whole submission of RMI4 over SMbus and the binding
of such devices found on the Thinkpad T series.

It has been a long time since we wanted to have those drivers in, but few
hiccups were on the road:
- lack of SMBus Host Notify (now merged upstream, still few fixes needed, but
  nothing preventing us to include this series).
- a unexpected behavior where the touchpad disables the SMBus commands if
  psmouse_activate has been called.
- some hairy problems with the 2 big locks found in the serio and psmouse
  driver.

This series also supports the RMI4 PS/2 pass-through required for the Thinkpad
X1 tablet even if it uses RMI4 over HID over USB.

Cheers,
Benjamin

Benjamin Tissoires (8):
  Input: synaptics-rmi4 - add SMBus support
  Input: serio - store the pt_buttons in the struct serio directly
  Input: synaptics-rmi4 - have only one struct platform data
  Input: synaptics-rmi4 - Add rmi_find_function()
  Input: synaptics - allocate a Synaptics Intertouch device
  Input: synaptics-rmi4 - add rmi_platform
  Input: synaptics-rmi4 - smbus: call psmouse_deactivate before
    binding/resume
  Input: synaptics-rmi4 - smbus: on resume, try 3 times if init fails

Dennis Wassenberg (1):
  Input: synaptics-rmi4 - f03: grab data passed by transport device

Lyude Paul (2):
  Input: synaptics-rmi4 - add support for F03
  Input: synaptics-rmi4 - f30/f03: Forward mechanical buttons on
    buttonpads to PS/2 guest

 drivers/input/mouse/psmouse-base.c |  12 +
 drivers/input/mouse/psmouse.h      |   1 +
 drivers/input/mouse/synaptics.c    | 150 +++++++++++-
 drivers/input/mouse/synaptics.h    |   5 +-
 drivers/input/rmi4/Kconfig         |  33 +++
 drivers/input/rmi4/Makefile        |   3 +
 drivers/input/rmi4/rmi_bus.c       |   3 +
 drivers/input/rmi4/rmi_bus.h       |  12 +
 drivers/input/rmi4/rmi_driver.c    |  13 +
 drivers/input/rmi4/rmi_driver.h    |  15 ++
 drivers/input/rmi4/rmi_f03.c       | 271 +++++++++++++++++++++
 drivers/input/rmi4/rmi_f11.c       |   4 +-
 drivers/input/rmi4/rmi_f12.c       |   4 +-
 drivers/input/rmi4/rmi_f30.c       |  71 +++++-
 drivers/input/rmi4/rmi_platform.c  | 235 ++++++++++++++++++
 drivers/input/rmi4/rmi_smbus.c     | 478 +++++++++++++++++++++++++++++++++++++
 include/linux/rmi.h                |  17 +-
 include/linux/serio.h              |   8 +
 include/uapi/linux/serio.h         |   1 +
 19 files changed, 1308 insertions(+), 28 deletions(-)
 create mode 100644 drivers/input/rmi4/rmi_f03.c
 create mode 100644 drivers/input/rmi4/rmi_platform.c
 create mode 100644 drivers/input/rmi4/rmi_smbus.c

-- 
2.5.5

