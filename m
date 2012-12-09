From: Alexander Holler <holler-SXC+2es9fhnfWeYVQQPykw@public.gmane.org>
Subject: Re: [PATCH 1/2] HID: autodetect HID sensor hubs.
Date: Sun, 09 Dec 2012 12:37:53 +0100
Message-ID: <50C47811.7010503@ahsoftware.de>
References: <1355015544-31579-1-git-send-email-holler@ahsoftware.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1355015544-31579-1-git-send-email-holler-SXC+2es9fhnfWeYVQQPykw@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexander Holler <holler-SXC+2es9fhnfWeYVQQPykw@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>, Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>, srinivas pandruvada <srinivas.pandruvada-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Am 09.12.2012 02:12, schrieb Alexander Holler:
> It should not be necessary to add IDs for HID sensor hubs to lists
> in hid-core.c and hid-sensor-hub.c. So instead of a whitelist,
> autodetect such sensor hubs, based on a collection of type
> physical inside a useage page of type sensor. If some sensor hubs
> stil must be usable as raw devices, a blacklist might be created.

That patch didn't check if the device is a USB device and therfor
blutooth hid sensor hubs wouldn't still be handled as raw devices.

I send another patch 1/2 which checks the bus too.
Patch 2/2 still should be applied.

Regards,

Alexander
