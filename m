From: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 2/6] input: touchscreen: imx25 tcq driver
Date: Thu, 03 Jul 2014 18:57:00 +0100
Message-ID: <53B5996C.5000204@kernel.org>
References: <1392913312-9030-1-git-send-email-mpa@pengutronix.de> <1402672899-6995-1-git-send-email-denis@eukrea.com> <1402672899-6995-3-git-send-email-denis@eukrea.com> <53A55BD8.7030905@kernel.org> <CAOMZO5BxZDX5TDZdUCbpTw2LpVC=vr4cnn4eSpzd_023wcy+Fg@mail.gmail.com> <53AFF1C4.1010402@kernel.org> <20140629114901.GO32514@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140629114901.GO32514-l+eeeJia6m9vn6HldHNs0ANdhmdF6hFW@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, =?ISO-8859-1?Q?Eric_B=E9nard?= <eric-fO0SIAKYzcbQT0dZR+AlfA@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Denis Carikli <denis-fO0SIAKYzcbQT0dZR+AlfA@public.gmane.org>, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Markus Pargmann <mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On 29/06/14 12:49, Russell King - ARM Linux wrote:
> On Sun, Jun 29, 2014 at 12:00:20PM +0100, Jonathan Cameron wrote:
>> On 21/06/14 20:55, Fabio Estevam wrote:
>>> On Sat, Jun 21, 2014 at 7:18 AM, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
>>>>> +
>>>>> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>>>>
>>>> Could this not in theory fail?
>>>
>>> Yes, but devm_ioremap_resource will take care of it, so we don't need
>>> to check for error here.
>> Nothing like counter intuitive behaviour.  Ah well.
>>
>> Thanks for explaining this!
>
> Maybe it would be better to have:
>
> 	mem = platform_ioremap_resource(pdev, IORESOURCE_MEM, 0);
>
> which wraps up both the platform_get_resource() call with
> devm_ioremap_resource() so driver writers don't have to be concerned
> about this aspect?
>
Good idea.

Something like that would certainly make more sense to me.
