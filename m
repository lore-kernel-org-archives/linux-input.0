From: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V3 0/3] iio: mxs-lradc: simplify TS handling
Date: Wed, 4 May 2016 10:40:08 +0100
Message-ID: <e0989150-8f22-4f36-fea7-65a86973833d@kernel.org>
References: <1461441479-23218-1-git-send-email-stefan.wahren@i2se.com>
 <500c5874-4ef8-b37b-e12f-80fd5205c172@kernel.org>
 <CAL7P5jJF9EL4Zk-AC9csyadfrmUp4R+6ceVAN_kNm7dKgo+ZgQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAL7P5jJF9EL4Zk-AC9csyadfrmUp4R+6ceVAN_kNm7dKgo+ZgQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?UTF-8?Q?Ksenija_Stanojevi=c4=87?= <ksenija.stanojevic-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Peter Meerwald-Stadler <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>, Fabio Estevam <fabio.estevam-3arQi8VN3Tc@public.gmane.org>, Juergen Borleis <jbe-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-input@vger.kernel.org

On 02/05/16 07:06, Ksenija Stanojevi=C4=87 wrote:
> Hi Jonathan,
>=20
> On Sun, May 1, 2016 at 10:08 PM, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> =
wrote:
>> Ksenija,
>>
>> How would you prefer we handle this interaction of this set and your=
 series.
>> Options are:
>>
>> 1. I apply these now and you rebase on top of the result.
>> 2. You pull these into your series, probably after the driver split =
making sure these
>>    improvements end up in the new drivers.
>> 3. We ask Stephan to re roll them at a later date (least preferred o=
ption as that adds
>> another person we need to chase down to get to the end of this proce=
ss!)
>>
>> No immediate rush on any of the above as we've probably missed this =
cycle now anyway.
>> I've been cut off today so not sure what Linus has said today.
>=20
> My understanding was that you will take this patch series so I alread=
y included
> changes made by this patch set in touchscreen part, I will check if I=
 missed
> something.
> I think the best is to apply these now.
Cool - that's even easier ;)

Jonathan
>=20
> Thanks,
> Ksenija
>=20
>> Jonathan
>> On 23/04/16 20:57, Stefan Wahren wrote:
>>> This patch series simplifies TS handling of mxs-lradc.
>>>
>>> These patches has been tested with i.MX23 and i.MX28 but without
>>> a touchscreen. I added only a bogus touchscreen in devicetree.
>>>
>>> It would be nice if someone with a real touchscreen could test it.
>>>
>>> Changes in V3:
>>> - remove dev.parent assignment as suggested by Dimitry
>>> - add new patch to remove mxs_lradc_ts_unregister
>>> - remove PM implementation from series in order to wait until
>>>   Ksenija has split the driver
>>>
>>> Changes in V2:
>>> - rebase on iio/testing since patch 2 and 3 from V1 has been applie=
d
>>> - also remove input_unregister_device in patch 1
>>> - use mask of virtual channels for IRQ disabling in patch 2
>>>
>>> Stefan Wahren (3):
>>>   iio: mxs-lradc: simplify TS registration
>>>   iio: mxs-lradc: remove mxs_lradc_ts_unregister
>>>   iio: mxs-lradc: disable only masked channels in
>>>     mxs_lradc_hw_stop
>>>
>>>  drivers/iio/adc/mxs-lradc.c |   34 ++++++-------------------------=
---
>>>  1 file changed, 6 insertions(+), 28 deletions(-)
>>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" =
in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
