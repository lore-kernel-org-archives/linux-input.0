From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 12/22] iio/ti_tscadc: Update with IIO map interface
Date: Mon, 10 Jun 2013 09:40:03 +0200
Message-ID: <51B582D3.1050501@linutronix.de>
References: <1370449495-29981-1-git-send-email-bigeasy@linutronix.de> <1370449495-29981-13-git-send-email-bigeasy@linutronix.de> <51B4B024.8070102@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:54355 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751708Ab3FJHkH (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 10 Jun 2013 03:40:07 -0400
In-Reply-To: <51B4B024.8070102@metafoo.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Samuel Ortiz <sameo@linux.intel.com>, Felipe Balbi <balbi@ti.com>, linux-iio@vger.kernel.org, linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jonathan Cameron <jic23@cam.ac.uk>, Pantelis Antoniou <panto@antoniou-consulting.com>

On 06/09/2013 06:41 PM, Lars-Peter Clausen wrote:
> On 06/05/2013 06:24 PM, Sebastian Andrzej Siewior wrote:
> [...]
>> -	return indio_dev->num_channels;
>> +	adc_dev->map = kcalloc(channels + 1, sizeof(struct iio_map),
>> +			GFP_KERNEL);
>> +	if (adc_dev->map == NULL)
>> +		goto err_free_chan;
>> +
>> +	for (i = 0; i < channels; i++) {
>> +		adc_dev->map[i].adc_channel_label =
>> +			chan_array[i].datasheet_name;
>> +		adc_dev->map[i].consumer_dev_name = "any";
>> +		adc_dev->map[i].consumer_channel = chan_array[i].datasheet_name;
>> +	}
> 
> This is not the way the IIO map interface is supposed to be used and I doubt it
> will actually work at all. The map either needs to be provided by board code
> with the proper consumer device and channel name filled in or in your case
> where you use devicetree you don't need to provide a map at all since this will
> all be handled by the generic IIO devicetree bindings. So I'd just drop this patch.

The channels are not described in the device tree. If so how would that
be the case? Right now, I don't have any consumer. How do I test this
easily if this is done correctly?
If in doubt it will probably drop this until someone comes along who
actually needs this.

> 
> - Lars

Sebastian
