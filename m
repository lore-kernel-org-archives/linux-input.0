From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 12/22] iio/ti_tscadc: Update with IIO map interface
Date: Mon, 10 Jun 2013 10:32:57 +0200
Message-ID: <51B58F39.7020405@metafoo.de>
References: <1370449495-29981-1-git-send-email-bigeasy@linutronix.de> <1370449495-29981-13-git-send-email-bigeasy@linutronix.de> <51B4B024.8070102@metafoo.de> <51B582D3.1050501@linutronix.de> <429732E1-5AEE-45AD-9BA8-3B5C6CD85867@antoniou-consulting.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailhost.informatik.uni-hamburg.de ([134.100.9.70]:40736 "EHLO
	mailhost.informatik.uni-hamburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752384Ab3FJI3g (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 10 Jun 2013 04:29:36 -0400
In-Reply-To: <429732E1-5AEE-45AD-9BA8-3B5C6CD85867@antoniou-consulting.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pantelis Antoniou <panto@antoniou-consulting.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Samuel Ortiz <sameo@linux.intel.com>, Felipe Balbi <balbi@ti.com>, linux-iio@vger.kernel.org, linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jonathan Cameron <jic23@cam.ac.uk>

On 06/10/2013 10:10 AM, Pantelis Antoniou wrote:
> Hi Sebastian,
> 
> On Jun 10, 2013, at 10:40 AM, Sebastian Andrzej Siewior wrote:
> 
>> On 06/09/2013 06:41 PM, Lars-Peter Clausen wrote:
>>> On 06/05/2013 06:24 PM, Sebastian Andrzej Siewior wrote:
>>> [...]
>>>> -	return indio_dev->num_channels;
>>>> +	adc_dev->map = kcalloc(channels + 1, sizeof(struct iio_map),
>>>> +			GFP_KERNEL);
>>>> +	if (adc_dev->map == NULL)
>>>> +		goto err_free_chan;
>>>> +
>>>> +	for (i = 0; i < channels; i++) {
>>>> +		adc_dev->map[i].adc_channel_label =
>>>> +			chan_array[i].datasheet_name;
>>>> +		adc_dev->map[i].consumer_dev_name = "any";
>>>> +		adc_dev->map[i].consumer_channel = chan_array[i].datasheet_name;
>>>> +	}
>>>
>>> This is not the way the IIO map interface is supposed to be used and I doubt it
>>> will actually work at all. The map either needs to be provided by board code
>>> with the proper consumer device and channel name filled in or in your case
>>> where you use devicetree you don't need to provide a map at all since this will
>>> all be handled by the generic IIO devicetree bindings. So I'd just drop this patch.
>>
>> The channels are not described in the device tree. If so how would that
>> be the case? Right now, I don't have any consumer. How do I test this
>> easily if this is done correctly?
>> If in doubt it will probably drop this until someone comes along who
>> actually needs this.
>>
> 
> Please don't remove this immediately. We need the hardcoded names until
> we use DT bindings that get a handle of the IIO channels.
> 
> I realize this is a temporary solution though until the driver is reworked
> to use DT properly.

It's not a solution at all, since it simply won't work.

You have two options, either specify the mapping in your board code based on
the consumers, or use devicetree to get a handle to device and channel. Btw.
from the consumers side it won't matter which way is used, the same code will
work with both, so there is no need to add DT support to the consumer.

- Lars
