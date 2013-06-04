From: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Subject: Re: [PATCH 4/5] iio/ti_am335x_adc: Allow to specify input line
Date: Tue, 4 Jun 2013 12:39:11 +0200
Message-ID: <20130604103911.GH1151@linutronix.de>
References: <1369847397-27451-1-git-send-email-bigeasy@linutronix.de>
 <1369847397-27451-5-git-send-email-bigeasy@linutronix.de>
 <51AB88BE.6040109@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <51AB88BE.6040109-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org
List-Id: linux-input@vger.kernel.org

* Jonathan Cameron | 2013-06-02 19:02:38 [+0100]:

>> diff --git a/drivers/mfd/ti_am335x_tscadc.c b/drivers/mfd/ti_am335x_tscadc.c
>> index 5e4076f..b228c41 100644
>> --- a/drivers/mfd/ti_am335x_tscadc.c
>> +++ b/drivers/mfd/ti_am335x_tscadc.c
>> @@ -77,16 +81,26 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
>>
>>  	node = of_get_child_by_name(pdev->dev.of_node, "tsc");
>>  	of_property_read_u32(node, "ti,wires", &tsc_wires);
>> +	of_property_read_u32(node, "ti,coordiante-readouts", &readouts);
>>
>>  	node = of_get_child_by_name(pdev->dev.of_node, "adc");
>> -	of_property_read_u32(node, "ti,adc-channels", &adc_channels);
>> -
>> +	of_property_for_each_u32(node, "ti,adc-channels", prop, cur, val) {
>> +		adc_channels++;
>> +		if (val > 7) {
>> +			dev_err(&pdev->dev, " PIN numbers are 0..7 (not %d)\n",
>> +					val);
>> +			return -EINVAL;
>> +		}
>> +	}
>>  	total_channels = tsc_wires + adc_channels;
>> -
>Should not change this whitespace in this sort of patch.

Okay.

Sebastian
