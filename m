From: Jiri Kosina <jikos-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] hid-sensor-hub: Force logical minimum to 1 for power
 and report state
Date: Tue, 8 Aug 2017 10:26:58 +0200 (CEST)
Message-ID: <alpine.LSU.2.20.1708081026200.30597@cbobk.fhfr.pm>
References: <20170807045201.3286-1-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170807045201.3286-1-srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Sun, 6 Aug 2017, Srinivas Pandruvada wrote:

> In the reference HID sensor hub firmware all Named array enums were
> 0-based. There is no description of the default base of enums in HID
> sensor hub specification as logical minimum should have set this base
> value.
> 
> Every sensor hub implemented enum as 1-based, without explicitly setting
> logical minimum to 1, because of the implementation by one of the major
> OS vendor. In Linux we used logical minimum to decide the enum base.
> 
> Some sensor hub FWs already changed logical minimum from 0 to 1. We hoped
> that every other vendor will follow. But that didn't happen and we had to
> fix the report header for every sensor hub to change logical minimum to 1
> by using .report_fixup() callback. So for every new sensor hub we had to
> modify source code by adding this quirk based on the vendor and device id.
> This is becoming a maintenance burden.
> 
> This patch hardcodes the logical minimum of power and report state
> attributes to 1. In this way we can remove the existing quirks and also
> we don't have to add more quirks.
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>

Jonathan, are you ok with me taking this through hid.git? Thanks,

-- 
Jiri Kosina
SUSE Labs
