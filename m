From: Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>
Subject: Re: [PATCH RFT 4/5] iio: mxs-lradc: disable only mapped channels in
 mxs_lradc_hw_stop
Date: Mon, 18 Apr 2016 08:36:48 +0200
Message-ID: <57148080.4010200@i2se.com>
References: <1460648909-2657-1-git-send-email-stefan.wahren@i2se.com>
 <1460648909-2657-5-git-send-email-stefan.wahren@i2se.com>
 <571369AA.8060106@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <571369AA.8060106-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Peter Meerwald-Stadler <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Cc: Ksenija Stanojevic <ksenija.stanojevic-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Fabio Estevam <fabio.estevam-3arQi8VN3Tc@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Hi Jonathan,

Am 17.04.2016 um 12:47 schrieb Jonathan Cameron:
> On 14/04/16 16:48, Stefan Wahren wrote:
>> Disabling of the touchscreen IRQs is already done in
>> mxs_lradc_disable_ts. There is no need to disable them in
>> mxs_lradc_hw_stop again.
> We could do with a little more documentation in the driver on
> which bits in this register are doing what.
>
> The disable_ts deals with bits 22-24... 
> The only other bit I think is ever used by the driver currently is
> 16 (channel 0).  
>
> So whilst this change probably works, I'm not sure of the logic behind it.
> As far as I can tell your new clear is fine but in reality you could
> just clear (0x3f << 16) and get the same result (which would be clearer
> to my mind).
>
> The key think here is that we don't support the higher bits on i.mx28
> yet... Which are for button detection and threshold detection.
>
> Have I understood this correctly?

Yes, you are. I've have looked to long in the reference manual instead
of the code.
I've missed the point that virtual channel 6 and 7 are used in case of a
connected touchscreen.

I should use the member buffer_vchans for masking the enable IRQs.

Regards
Stefan

>
> Jonathan
>  So we only need to care of the
