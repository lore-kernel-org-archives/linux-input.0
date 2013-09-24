From: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: [PATCH 1/3] HID: Delay opening HID device
Date: Tue, 24 Sep 2013 11:32:17 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1309241131510.18703@pobox.suse.cz>
References: <1379524399-16995-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1379524399-16995-1-git-send-email-srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, holler-SXC+2es9fhnfWeYVQQPykw@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Wed, 18 Sep 2013, Srinivas Pandruvada wrote:

> Don't call hid_open_device till there is actually an user. This saves
> power by not opening underlying transport for HID. Also close device
> if there are no active mfd client using HID sensor hub.
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>

Signed-off-by: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>

Jonathan, I'd be good if I pass this to you to apply the whole lot.

Thanks.

-- 
Jiri Kosina
SUSE Labs
