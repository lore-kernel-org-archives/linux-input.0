From: Pantelis Antoniou <panto-wVdstyuyKrO8r51toPun2/C9HSW9iNxf@public.gmane.org>
Subject: Re: [PATCH 12/19] iio & mfd & input: ti_tscadc: Match mfd sub devices to regmap interface
Date: Tue, 4 Jun 2013 13:54:48 +0300
Message-ID: <4AA621AD-5273-444C-875C-05486CC810A8@antoniou-consulting.com>
References: <1369681926-22185-1-git-send-email-bigeasy@linutronix.de> <1369681926-22185-13-git-send-email-bigeasy@linutronix.de> <51AB84F5.2030405@kernel.org> <20130604102318.GC1151@linutronix.de> <F58DCC19-20B7-4385-B323-C1A2E5F22641@antoniou-consulting.com> <20130604105210.GI1151@linutronix.de>
Mime-Version: 1.0 (Apple Message framework v1085)
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130604105210.GI1151-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Cc: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
List-Id: linux-input@vger.kernel.org

What make you think I am the original author?

I just fixed whatever I had to fix to get it working.

Namely that the multi function device was using regmap in one place and
not in another, which had the nice effect of the regmap cache getting o=
ut of sync.

Regards

-- Pantelis

On Jun 4, 2013, at 1:52 PM, Sebastian Andrzej Siewior wrote:

> * Pantelis Antoniou | 2013-06-04 13:25:28 [+0300]:
>=20
>>>>> diff --git a/drivers/mfd/ti_am335x_tscadc.c b/drivers/mfd/ti_am33=
5x_tscadc.c
>>>>> index bd127bd..a27401a 100644
>>>>> --- a/drivers/mfd/ti_am335x_tscadc.c
>>>>> +++ b/drivers/mfd/ti_am335x_tscadc.c
>>>>> @@ -31,6 +31,7 @@ static unsigned int tscadc_readl(struct ti_tsca=
dc_dev *tsadc, unsigned int reg)
>>>>> {
>>>>> 	unsigned int val;
>>>>>=20
>>>> ????  What is this doing here? It's not doing the move to regmap b=
ut rather setting a default value.
>>>=20
>>> No lo s=E9 :) I saw that and was wondering myself a little and plan=
ned the
>>> romval of this default for later. Now I think I do this earlier.
>>>=20
>>=20
>> The tscadc_read function doesn't have a failure mode; doesn't return=
 an error in case of a regmap_read
>> fail. Rather that change all the callers, we make sure we don't ever=
 return an uninitialized value=20
>> in case of an error (when val should be unchanged).
>=20
> One stupid question: Why did you start using regmap in the first plac=
e?
>=20
>>>>> +	val =3D (unsigned int)-1;
>>>>> 	regmap_read(tsadc->regmap_tscadc, reg, &val);
>>>>> 	return val;
>>>>> }
>=20
> Sebastian
