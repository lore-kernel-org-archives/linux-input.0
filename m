From: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 5/6] Staging/iio/adc/touchscreen/MXS: add interrupt driven
 touch detection
Date: Sun, 15 Sep 2013 17:10:18 +0100
Message-ID: <5235DBEA.7030402@kernel.org>
References: <1378887511-24530-1-git-send-email-jbe@pengutronix.de> <1378887511-24530-6-git-send-email-jbe@pengutronix.de> <52359259.8010202@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <52359259.8010202-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Juergen Beisert <jbe-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devel-gWbeCf7V1WCQmaza687I9mD2FQJk+8+b@public.gmane.org, marex-ynQEQJNshbs@public.gmane.org, fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org, Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On 09/15/13 11:56, Jonathan Cameron wrote:
> On 09/11/13 09:18, Juergen Beisert wrote:
>> For battery driven systems it is a very bad idea to collect the touchscreen
>> data within a kernel busy loop.
>>
>> This change uses the features of the hardware to delay and accumulate samples in
>> hardware to avoid a high interrupt and CPU load.
>>
>> Note: this is only tested on an i.MX23 SoC yet.
>>
>> Signed-off-by: Juergen Beisert <jbe-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
>> CC: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
>> CC: devel-gWbeCf7V1WCQmaza687I9mD2FQJk+8+b@public.gmane.org
>> CC: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
>> CC: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
>> CC: Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
> While this driver is placed in IIO within staging at the moment, these changes are definitely
> input related.  Hence I have cc'd Dmitry and the input list.
>
> I am personaly a little uncomfortable that we have such a complex bit of input code sat
> within an IIO driver but such is life.

The logic in here looks reasonable to me. I am far from a specialist in how these touch
screens are normally handled though.

One thing to note is that you really want to get a proposed device tree spec out asap
as that can take longer to review than the driver.  If you are proposing to do that as a future
patch, then take into account that you'll need to ensure these are the defaults if
it is not specified in the device tree for ever more (which is more painful than
hammering out he device tree stuff now!)
...
>> +static int mxs_lradc_probe_touchscreen(struct mxs_lradc *lradc,
>> +						struct device_node *lradc_node)
>> +{
>> +	/* TODO retrieve from device tree */
>> +	lradc->over_sample_cnt = 4;
>> +	lradc->over_sample_delay = 2;
>> +	lradc->settling_delay = 10;
>> +
>> +	return 0;
>> +}
>> +
...
