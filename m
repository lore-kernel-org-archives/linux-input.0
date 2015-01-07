From: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: [PATCH] HID: hid-sensor-hub: Correct documentation
Date: Wed, 7 Jan 2015 17:27:46 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1501071718240.25732@pobox.suse.cz>
References: <1420592328-9942-1-git-send-email-srinivas.pandruvada@linux.intel.com>  <alpine.LNX.2.00.1501070946540.25732@pobox.suse.cz> <1420646463.4459.126.camel@spandruv-desktop.jf.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1420646463.4459.126.camel-hINH/TbAiWppyMZ9rn1DP+ejPoqOX1/hEvhb3Hwu1Ks@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Wed, 7 Jan 2015, Srinivas Pandruvada wrote:

> > Most importantly, you seem to have inter-mixed three patch series (with 
> > 4,8 and 9 patches respectively) into one thread, plus there are 4 patches 
> > which aren't marked by series numbering. All this is mixed together into 
> > one thread without any particular ordering.
> > 
> There are 7 series:
> - The four patches, which are single independent patches
> - The others 3 are multiple patches part of series.

What I see this this:

=====
 Jan  6 Srinivas Pandruvada (4379) . [PATCH] HID: hid-sensor-hub: Correct documentation
 Jan  6 Srinivas Pandruvada (4207)   |-[PATCH] HID: sensor-hub: correct dyn_callback_lock IRQ-safe change
 Jan  6 Srinivas Pandruvada (5440)   |-[PATCH 1/4] HID: hid-sensor-hub: Enhance feature report API
 Jan  6 Srinivas Pandruvada (5112)   |-[PATCH 2/4] iio: hid_sensor_hub: update parameters to get feature report
 Jan  6 Srinivas Pandruvada (5618)   |-[PATCH 1/9] HID: hid-sensor-hub: Extend API for async reads
 Jan  6 Srinivas Pandruvada (3575)   |-[PATCH 2/9] iio: hid-sensor-accel-3d: Adjust parameter for attribute read
 Jan  6 Srinivas Pandruvada (5408)   |-[PATCH 3/4] HID: hid-sensor-hub: Enhance feature report set API
 Jan  6 Srinivas Pandruvada (3561)   |-[PATCH 3/9] iio: hid-sensor-gyro-3d: Adjust parameter for attribute read
 Jan  6 Srinivas Pandruvada (5306)   |-[PATCH 4/4] iio: hid_sensor_hub: update parameters to set feature report
 Jan  6 Srinivas Pandruvada (3535)   |-[PATCH 4/9] iio: hid-sensor-als: Adjust parameter for attribute read
 Jan  6 Srinivas Pandruvada (3544)   |-[PATCH 5/9] iio: hid-sensor-prox: Adjust parameter for attribute read
 Jan  6 Srinivas Pandruvada (3599)   |-[PATCH 6/9] iio: hid-sensor-magn-3d: Adjust parameter for attribute read
 Jan  6 Srinivas Pandruvada (3600)   |-[PATCH 7/9] iio: hid-sensor-incl-3d: Adjust parameter for attribute read
 Jan  6 Srinivas Pandruvada  (11K)   |-[PATCH] HID: hid-sensor-hub: Allow parallel synchronous reads
 Jan  6 Srinivas Pandruvada (3568)   |-[PATCH 8/9] iio: hid-sensor-press: Adjust parameter for attribute read
 Jan  6 Srinivas Pandruvada (4136)   |-[PATCH 3/8] iio: hid-sensor-gyro-3d: Introduce PM
 Jan  6 Srinivas Pandruvada (3692)   |-[PATCH 9/9] drivers/rtc/rtc-hid-sensor-time.c: Adjust parameter for attribute read
 Jan  6 Srinivas Pandruvada (4192)   |-[PATCH 4/8] iio: hid-sensor-als: Introduce PM
 Jan  6 Srinivas Pandruvada (4162)   |-[PATCH 2/8] iio: hid-sensor-accel-3d: Introduce PM
 Jan  6 Srinivas Pandruvada (7791)   |-[PATCH 1/8] iio: hid_sensor_hub: Common PM functions
 Jan  6 Srinivas Pandruvada (4210)   |-[PATCH 5/8] iio: hid-sensor-prox: Introduce PM
 Jan  6 Srinivas Pandruvada (4161)   |-[PATCH 6/8] iio: hid-sensor-magn-3d: Introduce PM
 Jan  6 Srinivas Pandruvada (4174)   |-[PATCH 7/8] iio: hid-sensor-incl-3d: Introduce PM
 Jan  6 Srinivas Pandruvada (4239)   |-[PATCH 8/8] iio: hid-sensor-press: Introduce PM
 Jan  6 Srinivas Pandruvada (7319)   \-[PATCH] HID: hid-sensor-hub: Add collection device
=====

i.e. all the patches from all the seris (and some out of the series) are 
referncing just a single e-mail, and that's

	1420592328-9942-1-git-send-email-srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org

Which is a giant mess.

-- 
Jiri Kosina
SUSE Labs
