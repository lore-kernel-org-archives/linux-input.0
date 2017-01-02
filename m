From: Jiri Kosina <jikos-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] HID: sensor-hub: Move the memset to
 sensor_hub_get_feature()
Date: Mon, 2 Jan 2017 14:04:07 +0100 (CET)
Message-ID: <alpine.LSU.2.20.1701021403570.28985@cbobk.fhfr.pm>
References: <1482857879-161873-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1482857879-161873-1-git-send-email-srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Tue, 27 Dec 2016, Srinivas Pandruvada wrote:

> While applying patch d443a0aa3a29: "HID: hid-sensor-hub: clear memory to
> avoid random data", there was some issues in applying correct version of
> the patch. This resulted in the breakage of sensor functions as all
> request like power-up will be reset by the memset() in the function
> sensor_hub_set_feature().
> The reset of caller buffer should be in the function
> sensor_hub_get_feature(), not in the sensor_hub_set_feature().
> 
> Fixes: d443a0aa3a29 ("HID: hid-sensor-hub: clear memory to avoid random data")
> Cc: Stable <stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org> # 4.9+
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>

Applied to for-4.10/upstream-fixes, and I'll be pushing that out to Linus 
shortly. Thanks for fixing my mistake.

-- 
Jiri Kosina
SUSE Labs
