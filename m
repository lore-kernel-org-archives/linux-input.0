From: Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH 0/9] Asynchronous attribute reads
Date: Wed,  7 Jan 2015 10:47:54 -0800
Message-ID: <1420656483-7093-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: jkosina-AlSwsSmVLrQ@public.gmane.org, jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org
Cc: linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, holler-SXC+2es9fhnfWeYVQQPykw@public.gmane.org, rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Patches related to asynchronous attribute reads. This series
enhances core and driver using this API.

Srinivas Pandruvada (9):
  HID: hid-sensor-hub: Extend API for async reads
  iio: hid-sensor-accel-3d: Adjust parameter for attribute read
  iio: hid-sensor-gyro-3d: Adjust parameter for attribute read
  iio: hid-sensor-als: Adjust parameter for attribute read
  iio: hid-sensor-prox: Adjust parameter for attribute read
  iio: hid-sensor-magn-3d: Adjust parameter for attribute read
  iio: hid-sensor-incl-3d: Adjust parameter for attribute read
  iio: hid-sensor-press: Adjust parameter for attribute read
  drivers/rtc/rtc-hid-sensor-time.c: Adjust parameter for attribute read

 drivers/hid/hid-sensor-hub.c                  | 15 ++++++++++++++-
 drivers/iio/accel/hid-sensor-accel-3d.c       |  3 ++-
 drivers/iio/gyro/hid-sensor-gyro-3d.c         |  3 ++-
 drivers/iio/light/hid-sensor-als.c            |  3 ++-
 drivers/iio/light/hid-sensor-prox.c           |  3 ++-
 drivers/iio/magnetometer/hid-sensor-magn-3d.c |  3 ++-
 drivers/iio/orientation/hid-sensor-incl-3d.c  |  3 ++-
 drivers/iio/pressure/hid-sensor-press.c       |  3 ++-
 drivers/rtc/rtc-hid-sensor-time.c             |  2 +-
 include/linux/hid-sensor-hub.h                | 19 +++++++++++++------
 10 files changed, 42 insertions(+), 15 deletions(-)

-- 
1.9.3
