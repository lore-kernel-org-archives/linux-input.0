From: Pantelis Antoniou <panto-wVdstyuyKrO8r51toPun2/C9HSW9iNxf@public.gmane.org>
Subject: Re: [PATCH 12/22] iio/ti_tscadc: Update with IIO map interface
Date: Mon, 10 Jun 2013 11:33:35 +0300
Message-ID: <232886C6-415E-4C69-BE28-C402F1864D62@antoniou-consulting.com>
References: <1370449495-29981-1-git-send-email-bigeasy@linutronix.de> <1370449495-29981-13-git-send-email-bigeasy@linutronix.de> <51B4B024.8070102@metafoo.de> <51B582D3.1050501@linutronix.de> <429732E1-5AEE-45AD-9BA8-3B5C6CD85867@antoniou-consulting.com> <51B58F39.7020405@metafoo.de>
Mime-Version: 1.0 (Apple Message framework v1085)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <51B58F39.7020405-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Cc: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Hi Lars,

On Jun 10, 2013, at 11:32 AM, Lars-Peter Clausen wrote:

> On 06/10/2013 10:10 AM, Pantelis Antoniou wrote:
>> Hi Sebastian,
>> 
>> On Jun 10, 2013, at 10:40 AM, Sebastian Andrzej Siewior wrote:
>> 
>>> On 06/09/2013 06:41 PM, Lars-Peter Clausen wrote:
>>>> On 06/05/2013 06:24 PM, Sebastian Andrzej Siewior wrote:
>>>> [...]
>>>>> -	return indio_dev->num_channels;
>>>>> +	adc_dev->map = kcalloc(channels + 1, sizeof(struct iio_map),
>>>>> +			GFP_KERNEL);
>>>>> +	if (adc_dev->map == NULL)
>>>>> +		goto err_free_chan;
>>>>> +
>>>>> +	for (i = 0; i < channels; i++) {
>>>>> +		adc_dev->map[i].adc_channel_label =
>>>>> +			chan_array[i].datasheet_name;
>>>>> +		adc_dev->map[i].consumer_dev_name = "any";
>>>>> +		adc_dev->map[i].consumer_channel = chan_array[i].datasheet_name;
>>>>> +	}
>>>> 
>>>> This is not the way the IIO map interface is supposed to be used and I doubt it
>>>> will actually work at all. The map either needs to be provided by board code
>>>> with the proper consumer device and channel name filled in or in your case
>>>> where you use devicetree you don't need to provide a map at all since this will
>>>> all be handled by the generic IIO devicetree bindings. So I'd just drop this patch.
>>> 
>>> The channels are not described in the device tree. If so how would that
>>> be the case? Right now, I don't have any consumer. How do I test this
>>> easily if this is done correctly?
>>> If in doubt it will probably drop this until someone comes along who
>>> actually needs this.
>>> 
>> 
>> Please don't remove this immediately. We need the hardcoded names until
>> we use DT bindings that get a handle of the IIO channels.
>> 
>> I realize this is a temporary solution though until the driver is reworked
>> to use DT properly.
> 
> It's not a solution at all, since it simply won't work.
> 
> You have two options, either specify the mapping in your board code based on
> the consumers, or use devicetree to get a handle to device and channel. Btw.
> from the consumers side it won't matter which way is used, the same code will
> work with both, so there is no need to add DT support to the consumer.
> 

Well, when we did this initially there was no other way. I'll check out mainline
and see if it will work for our case. We're slowly working towards rebasing all
our stuff against mainline again.

> - Lars
