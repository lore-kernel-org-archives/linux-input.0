From: Nish Aravamudan <nish.aravamudan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: iio/hid-sensor-accel-3d: no output from /dev/iio:device*?
Date: Thu, 17 Dec 2015 15:38:22 -0800
Message-ID: <CAOhV88ODTazDA2jmn9DP5idMmXXQa9jKB9Ur_aWTD_3WYZM1fw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jiri Kosina <jikos-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Peter Meerwald <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Crt Mori <cmo-fc6wVz46lShBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-input@vger.kernel.org

[Starting a new thread from https://lkml.org/lkml/2015/12/15/663, as
now my laptop is displaying values in the sysfs *raw* files.]

So I'm trying to understand exactly how the hid-sensor-accel-3d driver works.

If I turn up debugging, when I `cat
/sys/bus/iio/devices/device*/*raw*`, I see "iio iio:device3:
accel_3d_proc_event" and I think that means that
hid_sensor_push_data() is getting called.

But read()'s on /dev/iio:device3 never produces anything, which is
what iio-sensor-proxy uses to translate events to dbus.

Is it expected that the dev-node is "silent"? Just trying to
understand if an extension to the driver to support a chardev based
output is appropriate, or if iio-sensor-proxy needs to be changed to
handle this device.

-Nish
