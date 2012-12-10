From: Alexander Holler <holler-SXC+2es9fhnfWeYVQQPykw@public.gmane.org>
Subject: Re: hid-sensor-hub and autoloading of HID sensor modules
Date: Mon, 10 Dec 2012 22:33:15 +0100
Message-ID: <50C6551B.1030107@ahsoftware.de>
References: <50C64F29.9030200@ahsoftware.de> <4FA419E87744DF4DAECD5BCE1214B7A91C96075E@ORSMSX108.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4FA419E87744DF4DAECD5BCE1214B7A91C96075E-P5GAC/sN6hk8Ug9VwtkbtrfspsVTdybXVpNB7YpNyf8@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Pandruvada, Srinivas" <srinivas.pandruvada-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: "linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "matteo.dameno-qxv4g6HH51o@public.gmane.org" <matteo.dameno-qxv4g6HH51o@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Am 10.12.2012 22:22, schrieb Pandruvada, Srinivas:
> This will be a problem for current implementations, which are about to get shipped.
> Once I get chance, I will start looking at this idea. Meanwhile, you need to add hook to vendor and product id in the table.

Sorry, but I don't understand what that "shipped" has to do with the
implementation in the kernel. And I don't seen any problems as only the
implementation inside the kernel will change, nothing else.

Regards,

Alexander

> 
> Thanks,
> Srinivas
> 
> 
> -----Original Message-----
> From: Alexander Holler [mailto:holler-SXC+2es9fhnfWeYVQQPykw@public.gmane.org] 
> Sent: Monday, December 10, 2012 1:08 PM
> To: linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Pandruvada, Srinivas; matteo.dameno-qxv4g6HH51o@public.gmane.org
> Subject: hid-sensor-hub and autoloading of HID sensor modules
> 
> Hello,
> 
> as I've just posted a patch to get rid of the vendor and device IDs for USB HID sensor hubs, there is still one problem left: hid-sensor-hub doesn't automatically load the necessary drivers (if they are modules).
> 
> Here is a suggestion about how to solve that:
> 
> Create HID groups HID_GROUP_SENSOR_ACCEL, HID_GROUP_SENSOR_TIME, ...) for every type of (supported) sensor (instead of the one HID_GROUP_SENSOR_HUB), scan for their usage pages (e.g.
> HID_USAGE_SENSOR_ACCEL, HID_USAGE_SENSOR_TIME, ...) set the group and so load the final module and not hid-sensor-hub. hid-sensor-hub will then get loaded automatically.
> 
> As I don't have any real sensor hubs (and no business with them), I think others should implement such, if that idea got approved to make sense. ;) That just would be some few lines, but I couldn't test them with real-world stuff.
> 
> Regards,
> 
> Alexander
> 
