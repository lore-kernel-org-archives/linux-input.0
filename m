From: Quentin Schulz <quentin.schulz@free-electrons.com>
Subject: Re: [PATCH 3/5] iio: adc: sunxi-gpadc-iio: enable iio_buffers
Date: Wed, 20 Jul 2016 10:57:38 +0200
Message-ID: <4c9b92e6-d481-8efe-81d6-31595618171d@free-electrons.com>
References: <1469003351-15263-1-git-send-email-quentin.schulz@free-electrons.com>
 <1469003351-15263-4-git-send-email-quentin.schulz@free-electrons.com>
 <alpine.DEB.2.02.1607201034450.18224@pmeerw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:42580 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753151AbcGTI5l (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 20 Jul 2016 04:57:41 -0400
In-Reply-To: <alpine.DEB.2.02.1607201034450.18224@pmeerw.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de, maxime.ripard@free-electrons.com, wens@csie.org, dmitry.torokhov@gmail.com, lee.jones@linaro.org, antoine.tenart@free-electrons.com, thomas.petazzoni@free-electrons.com, linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org

On 20/07/2016 10:38, Peter Meerwald-Stadler wrote:
> 
>> This enables the use of buffers on ADC channels of sunxi-gpadc-iio driver.
>> It also prepares the code which will be used by the touchscreen driver
>> named sunxi-gpadc-ts.
>>
>> The GPADC on Allwinner SoCs (A10, A13 and A31) has a 12 bits register for
>> conversion's data. The GPADC uses the same ADC channels for the ADC and the
>> touchscreen therefore exposes these channels to the sunxi-gpadc-ts iio
>> consumer which will be in charge of reading data from these channels for
>> the input framework.
>>
>> The temperature can only be read when in touchscreen mode. This means if
>> the buffers are being used for the ADC, the temperature sensor cannot be
>> read.
>>
>> When a FIFO_DATA_PENDING irq occurs, its handler will read the entire FIFO
>> and fill a buffer before sending it to the consumers which registered in
>> IIO for the ADC channels.
>>
>> When a consumer starts buffering ADC channels,
>> sunxi_gpadc_buffer_postenable is called and will enable FIFO_DATA_PENDING
>> irq and select the mode in which the GPADC should run (ADC or touchscreen)
>> depending on a property of the DT ("allwinner,ts-attached").
>> When the consumer stops buffering, it disables the same irq.
> 
> comments below
>  
[...]
>> @@ -101,19 +104,43 @@ struct sunxi_gpadc_dev {
>>  	unsigned int			fifo_data_irq;
>>  	unsigned int			temp_data_irq;
>>  	unsigned int			flags;
>> +	struct iio_dev			*indio_dev;
>> +	struct sunxi_gpadc_buffer	buffer;
>> +	bool				ts_attached;
>> +	bool				buffered;
> 
> why add buffered, duplicate state and not query iio_buffer_enabled()?
> 
>>  };
>>  
>> -#define SUNXI_GPADC_ADC_CHANNEL(_channel, _name) {		\
>> +#define SUNXI_GPADC_ADC_CHANNEL(_channel, _name, _index) {	\
>>  	.type = IIO_VOLTAGE,					\
>>  	.indexed = 1,						\
>>  	.channel = _channel,					\
>>  	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
>>  	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
>>  	.datasheet_name = _name,				\
>> +	.scan_index = _index,					\
>> +	.scan_type = {						\
>> +		.sign = 'u',					\
>> +		.realbits = 12,					\
>> +		.storagebits = 16,				\
>> +		.shift = 0,					\
> 
> shift not strictly needed
> 

ACK.

[...]
>>  static int sunxi_gpadc_read_raw(struct iio_dev *indio_dev,
>> @@ -219,15 +253,22 @@ static int sunxi_gpadc_read_raw(struct iio_dev *indio_dev,
>>  				int *val, int *val2, long mask)
>>  {
>>  	int ret;
>> +	struct sunxi_gpadc_dev *info = iio_priv(indio_dev);
>>  
>>  	switch (mask) {
>>  	case IIO_CHAN_INFO_PROCESSED:
>> +		if (info->buffered && !info->ts_attached)
>> +			return -EBUSY;
> 
> there would be iio_device_claim_direct_mode()
> 

OK, iio_device_claim_direct_mode() and iio_device_release_direct_mode()
are new functions which are not yet in the Linux Cross Reference
(http://lxr.free-electrons.com/), I didn't know they existed. I'll use
that, iio_buffer_enabled() when needed and get rid of the buffered
boolean variable.

[...]
Thanks.

Quentin
