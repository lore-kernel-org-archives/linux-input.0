From: "Pandruvada, Srinivas" <srinivas.pandruvada-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [PATCH 1/2] HID: autodetect USB HID sensor hubs.
Date: Wed, 12 Dec 2012 15:37:48 +0000
Message-ID: <4FA419E87744DF4DAECD5BCE1214B7A91C960B9C@ORSMSX108.amr.corp.intel.com>
References: <50C47811.7010503@ahsoftware.de>
 <1355053470-3939-1-git-send-email-holler@ahsoftware.de>
 <alpine.LNX.2.00.1212121042100.19767@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <alpine.LNX.2.00.1212121042100.19767-ztGlSCb7Y1iN3ZZ/Hiejyg@public.gmane.org>
Content-Language: en-US
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>, Alexander Holler <holler-SXC+2es9fhnfWeYVQQPykw@public.gmane.org>
Cc: "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
List-Id: linux-input@vger.kernel.org

I also liked it. You can add my ACK.

Thanks,
Srinivas

-----Original Message-----
From: Jiri Kosina [mailto:jkosina-AlSwsSmVLrQ@public.gmane.org] 
Sent: Wednesday, December 12, 2012 1:43 AM
To: Alexander Holler
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Jonathan Cameron; Pandruvada, Srinivas
Subject: Re: [PATCH 1/2] HID: autodetect USB HID sensor hubs.

On Sun, 9 Dec 2012, Alexander Holler wrote:

> It should not be necessary to add IDs for HID sensor hubs to lists in 
> hid-core.c and hid-sensor-hub.c. So instead of a whitelist, autodetect 
> such USB HID sensor hubs, based on a collection of type physical 
> inside a useage page of type sensor. If some sensor hubs stil must be 
> usable as raw devices, a blacklist might be created.
> 
> Signed-off-by: Alexander Holler <holler-SXC+2es9fhnfWeYVQQPykw@public.gmane.org>

I like this change and would like to merge it, but I'd appreciate Ack from Srinivas first.

Srinivas?

Thanks,

--
Jiri Kosina
SUSE Labs
