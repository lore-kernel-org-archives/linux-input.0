From: srinivas pandruvada <srinivas.pandruvada@intel.com>
Subject: [PATCH, 0/6] HID-Sensors v3
Date: Mon, 25 Jun 2012 17:54:08 -0700
Message-ID: <1340672054-16591-1-git-send-email-srinivas.pandruvada@intel.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:24029 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753507Ab2FZBEo (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 25 Jun 2012 21:04:44 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-iio@vger.kernel.org
Cc: jic23.cam.ac.uk@vger.kernel.org, jkosina@suse.cz, linux-input@vger.kernel.org, srinivas pandruvada <srinivas.pandruvada@intel.com>

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
- Additional patch to enable ST Micro sensor hub 

v1:
Base implementation for comments

srinivas pandruvada (6):
  HID Sensors: Add to special driver list
  HID-Sensors: Sensor framework
  HID-Sensors: Added accelerometer 3D
  HID-Sensors: Added Gyroscope 3D
  HID-Sensors: Added Compass 3D
  HID-Sensors: Added ALS

 drivers/hid/Kconfig                                |   18 +
 drivers/hid/Makefile                               |    1 +
 drivers/hid/hid-core.c                             |   10 +
 drivers/hid/hid-ids.h                              |    6 +
 drivers/hid/hid-sensor-hub.c                       |  883 ++++++++++++++++++++
 drivers/staging/iio/accel/Kconfig                  |   10 +
 drivers/staging/iio/accel/Makefile                 |    3 +
 drivers/staging/iio/accel/hid-sensor-accel-3d.c    |  537 ++++++++++++
 drivers/staging/iio/gyro/Kconfig                   |   10 +
 drivers/staging/iio/gyro/Makefile                  |    3 +
 drivers/staging/iio/gyro/hid-sensor-gyro-3d.c      |  537 ++++++++++++
 drivers/staging/iio/light/Kconfig                  |   10 +
 drivers/staging/iio/light/Makefile                 |    2 +
 drivers/staging/iio/light/hid-sensor-als.c         |  478 +++++++++++
 drivers/staging/iio/magnetometer/Kconfig           |   10 +
 drivers/staging/iio/magnetometer/Makefile          |    2 +
 .../iio/magnetometer/hid-sensor-compass-3d.c       |  538 ++++++++++++
 include/linux/hid-sensor-hub.h                     |   99 +++
 include/linux/hid-sensor-ids.h                     |  116 +++
 19 files changed, 3273 insertions(+), 0 deletions(-)
 create mode 100644 drivers/hid/hid-sensor-hub.c
 create mode 100644 drivers/staging/iio/accel/hid-sensor-accel-3d.c
 create mode 100644 drivers/staging/iio/gyro/hid-sensor-gyro-3d.c
 create mode 100644 drivers/staging/iio/light/hid-sensor-als.c
 create mode 100644 drivers/staging/iio/magnetometer/hid-sensor-compass-3d.c
 create mode 100644 include/linux/hid-sensor-hub.h
 create mode 100644 include/linux/hid-sensor-ids.h

-- 
1.7.7.6

