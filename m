From: Alexander Holler <holler-SXC+2es9fhnfWeYVQQPykw@public.gmane.org>
Subject: hid-sensor-hub and autoloading of HID sensor modules
Date: Mon, 10 Dec 2012 22:07:53 +0100
Message-ID: <50C64F29.9030200@ahsoftware.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, srinivas.pandruvada-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, matteo.dameno-qxv4g6HH51o@public.gmane.org
List-Id: linux-input@vger.kernel.org

Hello,

as I've just posted a patch to get rid of the vendor and device IDs for
USB HID sensor hubs, there is still one problem left: hid-sensor-hub
doesn't automatically load the necessary drivers (if they are modules).

Here is a suggestion about how to solve that:

Create HID groups HID_GROUP_SENSOR_ACCEL, HID_GROUP_SENSOR_TIME, ...)
for every type of (supported) sensor (instead of the one
HID_GROUP_SENSOR_HUB), scan for their usage pages (e.g.
HID_USAGE_SENSOR_ACCEL, HID_USAGE_SENSOR_TIME, ...) set the group and so
load the final module and not hid-sensor-hub. hid-sensor-hub will then
get loaded automatically.

As I don't have any real sensor hubs (and no business with them), I
think others should implement such, if that idea got approved to make
sense. ;)
That just would be some few lines, but I couldn't test them with
real-world stuff.

Regards,

Alexander
