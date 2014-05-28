From: Reyad Attiyat <reyad.attiyat-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 0/3] IIO: hid-sensor-magn-3d: Add support for compass north usage attribute
Date: Wed, 28 May 2014 16:06:12 -0500
Message-ID: <1401311175-12784-1-git-send-email-reyad.attiyat@gmail.com>
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jkosina-AlSwsSmVLrQ@public.gmane.org
Cc: Reyad Attiyat <reyad.attiyat-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Update hid-sensor-magn-3d to dynamically create IIO channels
Update IIO to include modifiers for true/magnetic north and
tilt compensation compass usages

Signed-off-by: Reyad Attiyat <reyad.attiyat-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>


Reyad Attiyat (3):
  IIO: Added iio magn_north ABI documentation
  IIO: Add iio_chan modifier for True/Magnetic North HID usages
  IO: hid-sensor-magn-3d: Add in support for True/Magnetic North HID
    usages

 Documentation/ABI/testing/sysfs-bus-iio       |  76 +++++++
 drivers/iio/industrialio-core.c               |   4 +
 drivers/iio/magnetometer/hid-sensor-magn-3d.c | 278 +++++++++++++++++---------
 include/linux/iio/types.h                     |   4 +
 4 files changed, 267 insertions(+), 95 deletions(-)

-- 
1.9.3
