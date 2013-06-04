From: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Subject: Re: [PATCH 12/19] iio & mfd & input: ti_tscadc: Match mfd sub
 devices to regmap interface
Date: Tue, 4 Jun 2013 12:23:18 +0200
Message-ID: <20130604102318.GC1151@linutronix.de>
References: <1369681926-22185-1-git-send-email-bigeasy@linutronix.de>
 <1369681926-22185-13-git-send-email-bigeasy@linutronix.de>
 <51AB84F5.2030405@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <51AB84F5.2030405-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Pantelis Antoniou <panto-wVdstyuyKrO8r51toPun2/C9HSW9iNxf@public.gmane.org>
List-Id: linux-input@vger.kernel.org

* Jonathan Cameron | 2013-06-02 18:46:29 [+0100]:

>On 05/27/2013 08:11 PM, Sebastian Andrzej Siewior wrote:
>> From: Pantelis Antoniou <panto-wVdstyuyKrO8r51toPun2/C9HSW9iNxf@public.gmane.org>
>>=20
>Some confusing splitting between this and the previous patch that defi=
nitely wants
>to be cleaned up.
>
>> diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am=
335x_adc.c
>> index cceff09..72ffe89 100644
>> --- a/drivers/iio/adc/ti_am335x_adc.c
>> +++ b/drivers/iio/adc/ti_am335x_adc.c
>> @@ -76,22 +82,24 @@ static void tiadc_step_config(struct tiadc_devic=
e *adc_dev)
>>  	tiadc_writel(adc_dev, REG_SE, STPENB_STEPENB);
>>  }
>> =20
>> -static int tiadc_channel_init(struct iio_dev *indio_dev, int channe=
ls)
>> +static int tiadc_channel_init(struct iio_dev *indio_dev,
>> +		struct tiadc_device *adc_dev)
>>  {
>>  	struct iio_chan_spec *chan_array;
>>  	struct iio_chan_spec *chan;
>>  	char *s;
>>  	int i, len, size, ret;
>> +	int channels =3D adc_dev->channels;
>This is an unconnected bit of cleanup.  If you want it put it in the p=
revious patch
>which only just introduced what you are changing.

It will be probably best.

>> diff --git a/drivers/mfd/ti_am335x_tscadc.c b/drivers/mfd/ti_am335x_=
tscadc.c
>> index bd127bd..a27401a 100644
>> --- a/drivers/mfd/ti_am335x_tscadc.c
>> +++ b/drivers/mfd/ti_am335x_tscadc.c
>> @@ -31,6 +31,7 @@ static unsigned int tscadc_readl(struct ti_tscadc_=
dev *tsadc, unsigned int reg)
>>  {
>>  	unsigned int val;
>>
>????  What is this doing here? It's not doing the move to regmap but r=
ather setting a default value.

No lo s=C3=A9 :) I saw that and was wondering myself a little and plann=
ed the
romval of this default for later. Now I think I do this earlier.

>> +	val =3D (unsigned int)-1;
>>  	regmap_read(tsadc->regmap_tscadc, reg, &val);
>>  	return val;
>>  }

Sebastian
