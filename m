From: srinivas pandruvada <srinivas.pandruvada-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH, 0/7] HID Sensor Driver
Date: Wed,  6 Jun 2012 08:39:17 -0700
Message-ID: <1338997164-5077-1-git-send-email-srinivas.pandruvada@intel.com>
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, srinivas pandruvada <srinivas.pandruvada-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-input@vger.kernel.org

This submits a set of patches to enable USB HID Sensor driver.
It is implemented as a HID driver and exports sensor interface
via Linux IIO interfaces. This implements a basic usage id processing
for Accelerometer 3D, Gyro 3D, Magnetometer 3D and ALS.

Srinivas pandruvada (5):
  HID-Sensors: Common attributes and interfaces
  HID-Sensors: Added accelerometer 3D
  HID-Sensors: Added Gyro 3D
  HID-Sensors: Added Compass 3D
  HID-Sensors: Added ALS

srinivas pandruvada (2):
  HID-Sensors: Add Intel HID sensor
  HID-Sensors: Sensor framework

 drivers/hid/hid-core.c                             |    6 +
 drivers/hid/hid-ids.h                              |    5 +
 drivers/staging/Kconfig                            |    2 +
 drivers/staging/Makefile                           |    1 +
 drivers/staging/hid-sensors/Kconfig                |   19 +
 drivers/staging/hid-sensors/Makefile               |   16 +
 drivers/staging/hid-sensors/hid-sensor-accel-3d.c  |  387 +++++++++++
 drivers/staging/hid-sensors/hid-sensor-als.c       |  326 +++++++++
 .../staging/hid-sensors/hid-sensor-attributes.c    |  203 ++++++
 .../staging/hid-sensors/hid-sensor-attributes.h    |   67 ++
 .../staging/hid-sensors/hid-sensor-compass-3d.c    |  385 +++++++++++
 drivers/staging/hid-sensors/hid-sensor-gyro-3d.c   |  384 +++++++++++
 drivers/staging/hid-sensors/hid-sensor-hub.c       |  709 ++++++++++++++++++++
 drivers/staging/hid-sensors/hid-sensor-ids.h       |  117 ++++
 drivers/staging/hid-sensors/hid-sensor-interface.h |   93 +++
 drivers/staging/hid-sensors/hid-sensor-ring.c      |  104 +++
 drivers/staging/hid-sensors/hid-sensor-trigger.c   |   81 +++
 17 files changed, 2905 insertions(+), 0 deletions(-)
 create mode 100644 drivers/staging/hid-sensors/Kconfig
 create mode 100644 drivers/staging/hid-sensors/Makefile
 create mode 100644 drivers/staging/hid-sensors/hid-sensor-accel-3d.c
 create mode 100644 drivers/staging/hid-sensors/hid-sensor-als.c
 create mode 100644 drivers/staging/hid-sensors/hid-sensor-attributes.c
 create mode 100644 drivers/staging/hid-sensors/hid-sensor-attributes.h
 create mode 100644 drivers/staging/hid-sensors/hid-sensor-compass-3d.c
 create mode 100644 drivers/staging/hid-sensors/hid-sensor-gyro-3d.c
 create mode 100644 drivers/staging/hid-sensors/hid-sensor-hub.c
 create mode 100644 drivers/staging/hid-sensors/hid-sensor-ids.h
 create mode 100644 drivers/staging/hid-sensors/hid-sensor-interface.h
 create mode 100644 drivers/staging/hid-sensors/hid-sensor-ring.c
 create mode 100644 drivers/staging/hid-sensors/hid-sensor-trigger.c

-- 
1.7.7.6
