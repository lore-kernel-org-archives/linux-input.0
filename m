From: Jonathan Cameron <jic23-tko9wxEg+fIOOJlXag/Snyp2UmYkHbXO@public.gmane.org>
Subject: Re: hid-sensor-accel-3d: Delete an error message for a failed memory allocation in hid_accel_3d_probe()
Date: Mon, 05 Feb 2018 21:51:44 +0000
Message-ID: <87DF341A-1356-4B1B-8D25-14D5B0AAB01D@jic23.retrosnub.co.uk>
References: <0406765c-bdd1-1a82-cf66-1c248063ae4f@users.sourceforge.net> <20180204112346.0977e938@archlinux> <9420fc82-1a37-3601-bafe-f57ef953bfcd@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <9420fc82-1a37-3601-bafe-f57ef953bfcd-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: SF Markus Elfring <elfring-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, Jiri Kosina <jikos-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Peter Meerwald-Stadler <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org



On 5 February 2018 18:26:59 GMT, SF Markus Elfring <elfring-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org> wrote:
>> If making changes like this I would suggest only sending one until
>> you have have a response from the relevant maintainer.
>
>The corresponding feedback can become more positive for such
>a transformation pattern after a while, can't it?

Not in that sort of time period.
>
>
>> It would save you time as often these sorts of changes are
>> a matter of personal taste and weighing up of costs vs gains
>> - hence it is not obvious that they will be accepted.
>
>Can the wording “WARNING: Possible unnecessary 'out of memory' message”
>(from the script “checkpatch.pl”) be another incentive?

No. The key word is possible. Check patch is dumb and often gives false positives.
>
>Regards,
>Markus

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
