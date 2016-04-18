From: Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>
Subject: Re: [PATCH RFT 2/5] iio: mxs-lradc: move TS config into suitable
 function
Date: Mon, 18 Apr 2016 08:26:25 +0200
Message-ID: <57147E11.8020201@i2se.com>
References: <1460648909-2657-1-git-send-email-stefan.wahren@i2se.com>
 <1460648909-2657-3-git-send-email-stefan.wahren@i2se.com>
 <570FF737.4050606@denx.de> <571361DD.1090001@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <571361DD.1090001-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Peter Meerwald-Stadler <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>
Cc: Ksenija Stanojevic <ksenija.stanojevic-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Fabio Estevam <fabio.estevam-3arQi8VN3Tc@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.orgdmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.orglinux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

Am 17.04.2016 um 12:13 schrieb Jonathan Cameron:
> On 14/04/16 21:01, Marek Vasut wrote:
>> On 04/14/2016 05:48 PM, Stefan Wahren wrote:
>>> This patch moves the touchscreen type configuration into
>>> a more suitable function. Btw this simplifies PM ops later.
>>>
>>> Signed-off-by: Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>
>> Looks OK
>>
>> Reviewed-by: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
> Please do CC Dmitry and linux-input on any patches 'touching' the
> touchscreen parts of the driver.  I'm happy this one is simple
> enough to apply anyway, but best to make sure everyone is in the
> loop.
>
> Something a little odd happened when applying the patch.  Automerging
> failed so I did it by hand. Not sure what had changed!
>
> Anyhow, please sanity check I haven't messed it up.

Everything is fine. There was a indention conflict between Ksenija's and
my patch.

>
> Applied to the togreg branch of iio.git - initially pushed out as
> testing for the autobuilders to play with it.
>
> Thanks,
>
>
> Jonathan
