From: srinivas pandruvada <srinivas.pandruvada@intel.com>
Subject: [PATCH 0/8] HID-Sensor v4
Date: Wed,  4 Jul 2012 12:52:04 -0700
Message-ID: <1341431532-15060-1-git-send-email-srinivas.pandruvada@intel.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:29210 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932242Ab2GDUCq (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 4 Jul 2012 16:02:46 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-iio@vger.kernel.org
Cc: linux-input@vger.kernel.org, jkosina@suse.cz, lars@metafoo.de, jic23@cam.ac.uk, srinivas pandruvada <srinivas.pandruvada@intel.com>

v4:
Addressed comments from Lars-Peter Clausen and Jiri Kosina.
- Added Documentation/hid/hid-sensor.txt
- As suggested, created iio/common folder which can contain common code for iio sensor driver.This contain common module to process trigger and attributes
- Removed empty callback functions.
- Duplicating channel structure for an IIO driver instance.

v3 :
- Using TRIGGERRED BUFFER
- Using MFD framework
The sensor hub driver is submiited to drivers/hid. This contains core processing of hid sensor
usage table, registers as an hid driver and adds registration function for routing data
to individual sensor driver. So core driver independent of user mode interface method (IIO/input etc.)

- Submiiting four drivers for Accelerometer-3D, Gyro-3D, Compass-3D and ALS. These uses IIO triggered
buffer interface. They are childrens of hid sensor hub driver.
They reside in iio/accel, iio/gyro iio/magnetometer and iio/light.

- Still using driver/staging/iio. Not able to test with driver/iio.

v2 :
- Replaced Ring-SW with KFiFO
- Accel-3d, Gyro-3D and Compass-3D uses 3 different channels for X, Y and Z
- SysFS (
--- Changed "polling_interval" to sampling_frequency (IIO_DEV_ATTR_SAMP_FREQ) with units HZ
--- Changed "sensitivity" to hyst_raw, which is already used by some ADC modules
--- Removed "Activate". No longer need this. Using trigger state to activate/deactivate
)
- Removed sysfs attributes for "xxx_offset". Instead using mask 0 in read_raw. So each
sensor have only channels, sampling_frequency and hyst_raw as the ABI.
- Additional patch to enable ST Micro sensor hub-

v1:
Base implementation for comments


srinivas pandruvada (8):
  HID-Sensors: Documentation
  HID Sensors: Add to special driver list
  HID-Sensors: Sensor framework
  HID-Sensors: Common attribute and trigger
  HID-Sensors: Added accelerometer 3D
  HID-Sensors: Added Gyroscope 3D
  HID-Sensors: Added Compass/Magnetometer 3D
  HID-Sensors: Added ALS

 Documentation/hid/hid-sensor.txt                   |  139 +++++
 drivers/hid/Kconfig                                |   12 +
 drivers/hid/Makefile                               |    1 +
 drivers/hid/hid-core.c                             |   10 +
 drivers/hid/hid-ids.h                              |    6 +
 drivers/hid/hid-sensor-hub.c                       |  630 ++++++++++++++++++++
 drivers/staging/iio/Kconfig                        |    1 +
 drivers/staging/iio/Makefile                       |    1 +
 drivers/staging/iio/accel/Kconfig                  |   10 +
 drivers/staging/iio/accel/Makefile                 |    3 +
 drivers/staging/iio/accel/hid-sensor-accel-3d.c    |  451 ++++++++++++++
 drivers/staging/iio/common/Kconfig                 |    6 +
 drivers/staging/iio/common/Makefile                |    5 +
 drivers/staging/iio/common/hid-sensors/Kconfig     |   21 +
 drivers/staging/iio/common/hid-sensors/Makefile    |    6 +
 .../iio/common/hid-sensors/hid-sensor-attributes.c |  182 ++++++
 .../iio/common/hid-sensors/hid-sensor-attributes.h |   60 ++
 .../iio/common/hid-sensors/hid-sensor-trigger.c    |  104 ++++
 .../iio/common/hid-sensors/hid-sensor-trigger.h    |   27 +
 drivers/staging/iio/gyro/Kconfig                   |   10 +
 drivers/staging/iio/gyro/Makefile                  |    3 +
 drivers/staging/iio/gyro/hid-sensor-gyro-3d.c      |  451 ++++++++++++++
 drivers/staging/iio/light/Kconfig                  |   10 +
 drivers/staging/iio/light/Makefile                 |    3 +
 drivers/staging/iio/light/hid-sensor-als.c         |  380 ++++++++++++
 drivers/staging/iio/magnetometer/Kconfig           |   10 +
 drivers/staging/iio/magnetometer/Makefile          |    3 +
 .../staging/iio/magnetometer/hid-sensor-magn-3d.c  |  451 ++++++++++++++
 include/linux/hid-sensor-hub.h                     |   72 +++
 include/linux/hid-sensor-ids.h                     |  116 ++++
 30 files changed, 3184 insertions(+), 0 deletions(-)
 create mode 100755 Documentation/hid/hid-sensor.txt
 create mode 100644 drivers/hid/hid-sensor-hub.c
 create mode 100644 drivers/staging/iio/accel/hid-sensor-accel-3d.c
 create mode 100644 drivers/staging/iio/common/Kconfig
 create mode 100644 drivers/staging/iio/common/Makefile
 create mode 100644 drivers/staging/iio/common/hid-sensors/Kconfig
 create mode 100644 drivers/staging/iio/common/hid-sensors/Makefile
 create mode 100644 drivers/staging/iio/common/hid-sensors/hid-sensor-attributes.c
 create mode 100644 drivers/staging/iio/common/hid-sensors/hid-sensor-attributes.h
 create mode 100644 drivers/staging/iio/common/hid-sensors/hid-sensor-trigger.c
 create mode 100644 drivers/staging/iio/common/hid-sensors/hid-sensor-trigger.h
 create mode 100644 drivers/staging/iio/gyro/hid-sensor-gyro-3d.c
 create mode 100644 drivers/staging/iio/light/hid-sensor-als.c
 create mode 100644 drivers/staging/iio/magnetometer/hid-sensor-magn-3d.c
 create mode 100644 include/linux/hid-sensor-hub.h
 create mode 100644 include/linux/hid-sensor-ids.h

-- 
1.7.7.6

