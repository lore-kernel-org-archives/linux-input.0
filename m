From: "Kweh, Hock Leong" <hock.leong.kweh-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] iio: fix pressure data output unit in hid-sensor-attributes
Date: Mon, 29 Aug 2016 18:50:56 +0800
Message-ID: <1472467856-14526-1-git-send-email-hock.leong.kweh@intel.com>
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pandruvada Srinivas <srinivas.pandruvada-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Jiri Kosina <jikos-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: linux-iio <linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-input <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Peter Meerwald-Stadler <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, Ong Boon Leong <boon.leong.ong-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Lim Lee Booi <lee.booi.lim-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Lay Kuan Loon <kuan.loon.lay-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Ooi Joyce <joyce.ooi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Kweh, Hock Leong" <hock.leong.kweh-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-input@vger.kernel.org

From: "Kweh, Hock Leong" <hock.leong.kweh-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

According to IIO ABI definition, IIO_PRESSURE data output unit is
kilopascal:
http://lxr.free-electrons.com/source/Documentation/ABI/testing/sysfs-bus-iio

This patch fix output unit of HID pressure sensor IIO driver from pascal to
kilopascal to follow IIO ABI definition.

Signed-off-by: Kweh, Hock Leong <hock.leong.kweh-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 .../iio/common/hid-sensors/hid-sensor-attributes.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
index e81f434..dc33c1d 100644
--- a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
+++ b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
@@ -56,8 +56,8 @@ static struct {
 	{HID_USAGE_SENSOR_ALS, 0, 1, 0},
 	{HID_USAGE_SENSOR_ALS, HID_USAGE_SENSOR_UNITS_LUX, 1, 0},
 
-	{HID_USAGE_SENSOR_PRESSURE, 0, 100000, 0},
-	{HID_USAGE_SENSOR_PRESSURE, HID_USAGE_SENSOR_UNITS_PASCAL, 1, 0},
+	{HID_USAGE_SENSOR_PRESSURE, 0, 100, 0},
+	{HID_USAGE_SENSOR_PRESSURE, HID_USAGE_SENSOR_UNITS_PASCAL, 0, 1000},
 };
 
 static int pow_10(unsigned power)
-- 
1.7.9.5
