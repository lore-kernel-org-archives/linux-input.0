From: Jiri Kosina <jikos-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/6] Documentation: hid: Intel ISH HID document
Date: Fri, 17 Jun 2016 22:43:43 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1606172241480.6874@cbobk.fhfr.pm>
References: <1465647219-7798-1-git-send-email-srinivas.pandruvada@linux.intel.com> <1465647219-7798-2-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1465647219-7798-2-git-send-email-srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, chaya.golan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, daniel.drubin-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, A.Bhattacharya-pDTOvDb+uMmzQB+pC5nmwQ@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Sat, 11 Jun 2016, Srinivas Pandruvada wrote:

> Document explaining ISH HID operation and implementation.
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> ---
>  Documentation/hid/intel-ish-hid.txt | 417 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 417 insertions(+)
>  create mode 100644 Documentation/hid/intel-ish-hid.txt
> 
> diff --git a/Documentation/hid/intel-ish-hid.txt b/Documentation/hid/intel-ish-hid.txt
> new file mode 100644
> index 0000000..2de0ab5
> --- /dev/null
> +++ b/Documentation/hid/intel-ish-hid.txt
> @@ -0,0 +1,417 @@
> +Intel Integrated Sensor Hub (ISH)
> +===============================
> +
> +A sensor hub enables the ability to offload sensor polling and algorithm
> +processing to a dedicated low power co-processor. This allows the core
> +processor to go into low power modes more often, resulting in the increased
> +battery life.
[ ... snip ... ]

What I would like to see added here is a bit more of a higher-level 
overview of the implementation.

It's a *lot* of new code. I am still trying to make my way through it. One 
thing that I am currently trying to figure out, and which, if documented, 
would be much easier to review, would be: my current understanding is that 
this is both transport (ll) driver and a kind-of a bus at the same time.

Could yo please put some more comprehensive overview of the overall 
architecture into the documentation?

Thanks,

-- 
Jiri Kosina
SUSE Labs
