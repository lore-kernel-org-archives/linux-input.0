From: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 6/9] Staging/iio/adc/touchscreen/MXS: add interrupt driven
 touch detection
Date: Tue, 01 Oct 2013 12:06:49 +0100
Message-ID: <524AACC9.9080700@kernel.org>
References: <1379946998-23041-1-git-send-email-jbe@pengutronix.de> <1379946998-23041-7-git-send-email-jbe@pengutronix.de> <201310011128.38928.jbe@pengutronix.de> <524AA91F.7000906@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <524AA91F.7000906-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?ISO-8859-1?Q?J=FCrgen_Beisert?= <jbe-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devel-gWbeCf7V1WCQmaza687I9mD2FQJk+8+b@public.gmane.org, marex-ynQEQJNshbs@public.gmane.org, fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On 10/01/13 11:51, Jonathan Cameron wrote:
> On 10/01/13 10:28, J=FCrgen Beisert wrote:
>> Hi Jonathan,
>>
>> On Tuesday 01 October 2013 11:25:46 Jonathan Cameron wrote:
>>> a couple of the patch descriptions say that they are untested on i.=
MX28.
>>
>> On Monday 23 September 2013 16:36:35 Juergen Beisert wrote:
>>> For battery driven systems it is a very bad idea to collect the tou=
chscreen
>>> data within a kernel busy loop.
>>>
>>> This change uses the features of the hardware to delay and accumula=
te
>>> samples in hardware to avoid a high interrupt and CPU load.
>>>
>>> Note: this is only tested on an i.MX23 SoC yet.
>>
>> This note is no longer true. Marek tested it on his M28EVK, Lothar o=
n his TX28=20
>> and myself also on an i.MX28EVK.
>>
>> For the IIO part of the driver I tested on my i.MX23 based ChumbyOne=
 and some=20
>> customer hardware and it seems still to work (I can only guess if th=
e values I=20
>> read from the sysfs entries are correct, sorry).
>=20
> Excellent. I'll assume everyone is happy then and add some appropriat=
e
> tested-by tags. I'd missed Marek's reply saying he was fine with this=
=2E

This one is not applying cleanly.  I've merged what I think is the righ=
t
fixup, but please check.

The issue is around the error handling after mxs_lradc_ts_register whic=
h has
been changed in the meantime it seems.

Jonathan
>=20
>=20
> Thanks,
>=20
> Jonathan
>>
>> Regards,
>> Juergen
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" =
in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
