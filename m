From: Reyad Attiyat <reyad.attiyat-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCHv2 3/3] IIO: hid-sensor-magn-3d: Add in support for
 True/Magnetic North HID usages
Date: Wed, 4 Jun 2014 10:23:32 -0500
Message-ID: <CA+BWVUTxnS_C+EXm1SuShywk998+E5KfTdtTrS6_a0+k+4U4ig@mail.gmail.com>
References: <1401750890-31854-1-git-send-email-reyad.attiyat@gmail.com>
 <1401750890-31854-4-git-send-email-reyad.attiyat@gmail.com> <538E092F.9040004@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <538E092F.9040004-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-input <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Hey Srinivas,

On Tue, Jun 3, 2014 at 12:43 PM, Srinivas Pandruvada
<srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org> wrote:

>
> May be we should have a field in const struct iio_chan_spec, so that we
> can dynamically enable disable channels. In this way we can statically
> define channels, but can be enabled/disabled dynamically.
>
Would this require changing iio subsystem to create sysfs entries only
when enabled? Would we need to add functions to disable and enable
later on?
>
> I think we need to present angle in radians. Are you basing change present
> in linux-next? This will automatically do in this function.
>
I'll look into this. What function should I use to make the iio chanel
to report radians?
>
>
> I don't see kfree. Try devm_kcalloc?
>
I changed kmemdup to kcalloc so there is still a kfree in the exsiting
code. I can change this to devm_kcalloc but only if we don't go with
static channels that are enabled as found.

Thanks,
Reyad Attiyat
