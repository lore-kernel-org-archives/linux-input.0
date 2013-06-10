From: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Subject: Re: [PATCH 12/22] iio/ti_tscadc: Update with IIO map interface
Date: Mon, 10 Jun 2013 10:38:09 +0200
Message-ID: <51B59071.9090908@metafoo.de>
References: <1370449495-29981-1-git-send-email-bigeasy@linutronix.de> <1370449495-29981-13-git-send-email-bigeasy@linutronix.de> <51B4B024.8070102@metafoo.de> <51B582D3.1050501@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <51B582D3.1050501-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Cc: Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>, Pantelis Antoniou <panto-wVdstyuyKrO8r51toPun2/C9HSW9iNxf@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On 06/10/2013 09:40 AM, Sebastian Andrzej Siewior wrote:
> On 06/09/2013 06:41 PM, Lars-Peter Clausen wrote:
>> On 06/05/2013 06:24 PM, Sebastian Andrzej Siewior wrote:
>> [...]
>>> -	return indio_dev->num_channels;
>>> +	adc_dev->map = kcalloc(channels + 1, sizeof(struct iio_map),
>>> +			GFP_KERNEL);
>>> +	if (adc_dev->map == NULL)
>>> +		goto err_free_chan;
>>> +
>>> +	for (i = 0; i < channels; i++) {
>>> +		adc_dev->map[i].adc_channel_label =
>>> +			chan_array[i].datasheet_name;
>>> +		adc_dev->map[i].consumer_dev_name = "any";
>>> +		adc_dev->map[i].consumer_channel = chan_array[i].datasheet_name;
>>> +	}
>>
>> This is not the way the IIO map interface is supposed to be used and I doubt it
>> will actually work at all. The map either needs to be provided by board code
>> with the proper consumer device and channel name filled in or in your case
>> where you use devicetree you don't need to provide a map at all since this will
>> all be handled by the generic IIO devicetree bindings. So I'd just drop this patch.
> 
> The channels are not described in the device tree. If so how would that
> be the case? Right now, I don't have any consumer. How do I test this
> easily if this is done correctly?
> If in doubt it will probably drop this until someone comes along who
> actually needs this.

You don't need to describe the channels in devicetree, except setting the
"#io-channel-cells" property of your ADC node to 1. You also need to initialize
the of_node property of your iio_device's struct's 'dev' field to the your adc
node.

After that it's just a matter of using, e.g.

	io-channels = <&adc 1>;
	io-channel-names = "voltage";

in your consumer.

- Lars
