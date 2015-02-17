From: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: [PATCH 2/2] HID: hid-sensor-hub: Add collection device
Date: Tue, 17 Feb 2015 13:36:40 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1502171336080.2279@pobox.suse.cz>
References: <1420655051-6587-1-git-send-email-srinivas.pandruvada@linux.intel.com> <1420655051-6587-3-git-send-email-srinivas.pandruvada@linux.intel.com> <54C01FC8.2040501@kernel.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <54C01FC8.2040501-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Wed, 21 Jan 2015, Jonathan Cameron wrote:

> On 07/01/15 18:24, Srinivas Pandruvada wrote:
> > HID sensor hub exports several sensor which are fusion sensors, where
> > data is interpreted from one or more sensors. Some of them can't be
> > exported via IIO like sysfs as the user space download some firmware,
> > which defines what sensor will look like. They can be a part of a
> > collection.
> This functionality is beginning to turn up on a number of devices.
> I'd argue that where at all possible, we should try for standard
> interfaces on the resulting 'fused sensors'.  Still you do indeed
> always need a means of uploading the firmware!
> > Creating a MFD cell for a collection to write a standalone driver
> > to manage collections. Most of the time they will be propritery drivers
> > may not be even upstreamed. This patch allows framework to have
> > capability to write such drivers.

Srinivas, do you plan to respond to the comments Jonathan had on this 
patch?

Thanks.

-- 
Jiri Kosina
SUSE Labs
