From: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Subject: Re: [PATCH 21/22] iio/ti_am335x_adc: Allow to specify input line
Date: Tue, 11 Jun 2013 09:55:28 +0200
Message-ID: <51B6D7F0.8020906@linutronix.de>
References: <1370449495-29981-1-git-send-email-bigeasy@linutronix.de> <1370449495-29981-22-git-send-email-bigeasy@linutronix.de> <51B4B2CE.3020300@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <51B4B2CE.3020300-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Cc: Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On 06/09/2013 06:52 PM, Lars-Peter Clausen wrote:
>> @@ -199,8 +213,11 @@ static int tiadc_probe(struct platform_device *pdev)
>>  	struct tiadc_device	*adc_dev;
>>  	struct ti_tscadc_dev	*tscadc_dev = ti_tscadc_dev_get(pdev);
>>  	struct device_node	*node = tscadc_dev->dev->of_node;
>> +	struct property		*prop;
>> +	const __be32		*cur;
>>  	int			err;
>> -	u32			val32;
>> +	u32			val;
>> +	int channels		= 0;
> 
> The indention here looks a bit strange.
fixed

>>  
>>  	if (!node) {
>>  		dev_err(&pdev->dev, "Could not find valid DT data.\n");
>> @@ -222,11 +239,13 @@ static int tiadc_probe(struct platform_device *pdev)
>>  		err = -EINVAL;
>>  		goto err_free_device;
>>  	}
>> -	err = of_property_read_u32(node,
>> -			"ti,adc-channels", &val32);
>> -	if (err < 0)
>> -		goto err_free_device;
>> -	adc_dev->channels = val32;
>> +
>> +	of_property_for_each_u32(node, "ti,adc-channels", prop, cur, val) {
>> +
> 
> No need for the extra new line
fixed

>> +		adc_dev->channel_line[channels] = val;
>> +		channels++;
> 
> You should make sure that channels is never >= 8

This is done in the mfd part where it is also checked for adc channels
+ touch channles not > 8.

Sebastian
