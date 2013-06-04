From: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Subject: Re: [PATCH 11/19] iio & mfd: ti_tscadc: Update with IIO map
 interface & deal with partial activation
Date: Tue, 4 Jun 2013 12:19:36 +0200
Message-ID: <20130604101936.GB1151@linutronix.de>
References: <1369681926-22185-1-git-send-email-bigeasy@linutronix.de>
 <1369681926-22185-12-git-send-email-bigeasy@linutronix.de>
 <51AB838B.5060602@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <51AB838B.5060602-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Pantelis Antoniou <panto-wVdstyuyKrO8r51toPun2/C9HSW9iNxf@public.gmane.org>
List-Id: linux-input@vger.kernel.org

* Jonathan Cameron | 2013-06-02 18:40:27 [+0100]:

>On 05/27/2013 08:11 PM, Sebastian Andrzej Siewior wrote:
>> From: Pantelis Antoniou <panto-wVdstyuyKrO8r51toPun2/C9HSW9iNxf@public.gmane.org>
>>
>> Add an IIO map interface that consumers can use.
>>
>> While we're here fix the mfd device in the case
>> where a subdevice might not be activated.
>Any time I read 'while we're here' it rings alarm bells.
>Two issues -> Two patches please.
>
>The level of reworking here is rather high. Probably better
>to do the structural changes in one patch then follow with the
>new functionality in another.

Okay, will try.

>Other comments inline.
>>
>> Signed-off-by: Pantelis Antoniou <panto-wVdstyuyKrO8r51toPun2/C9HSW9iNxf@public.gmane.org>
>> Signed-off-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
>> Signed-off-by: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
>> ---
>>  drivers/iio/adc/ti_am335x_adc.c      |   53 +++++++++++++++++++++++++++++-----
>>  drivers/mfd/ti_am335x_tscadc.c       |   29 ++++++++++++-------
>>  include/linux/mfd/ti_am335x_tscadc.h |    8 ++---
>>  3 files changed, 67 insertions(+), 23 deletions(-)
>>
>> diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am335x_adc.c
>> index d821d88..cceff09 100644
>> --- a/drivers/iio/adc/ti_am335x_adc.c
>> +++ b/drivers/iio/adc/ti_am335x_adc.c
>> @@ -20,16 +20,19 @@
>>  #include <linux/slab.h>
>>  #include <linux/interrupt.h>
>>  #include <linux/platform_device.h>
>> -#include <linux/io.h>
>why? Not immediately obvious this has anything to do with the rest of this patch.

Yeah, a patch later or two it is added again :P Will drop this nonsense.

>>  #include <linux/iio/iio.h>
>>  #include <linux/of.h>
>>  #include <linux/of_device.h>
>> +#include <linux/iio/machine.h>
>> +#include <linux/iio/driver.h>
>>
>>  #include <linux/mfd/ti_am335x_tscadc.h>
>>
>>  struct tiadc_device {
>>  	struct ti_tscadc_dev *mfd_tscadc;
>>  	int channels;
>> +	char *buf;
>> +	struct iio_map *map;
>>  };
>>
>>  static unsigned int tiadc_readl(struct tiadc_device *adc, unsigned int reg)
>> @@ -76,25 +79,59 @@ static void tiadc_step_config(struct tiadc_device *adc_dev)
>>  static int tiadc_channel_init(struct iio_dev *indio_dev, int channels)
>>  {
>>  	struct iio_chan_spec *chan_array;
>
>> -	int i;
>> -
>> -	indio_dev->num_channels = channels;
>> -	chan_array = kcalloc(indio_dev->num_channels,
>> -			sizeof(struct iio_chan_spec), GFP_KERNEL);
>> +	struct iio_chan_spec *chan;
>> +	char *s;
>> +	int i, len, size, ret;
>>
>
>This is less than beautiful... It'll cost you marginally more to
>allocate a separate array for the strings, but will be a lot nicer
>to read.  If we are dealing with a relatively small maximum number
>then just do it as a static const char * array of all possible
>strings.

The EVM board takes 4 and the maximum is 8. This is 20 bytes on EVM and
40 for the max. This probably does not hurt in data segment, will
change.

>
>> +	size = indio_dev->num_channels * (sizeof(struct iio_chan_spec) + 6);
>> +	chan_array = kzalloc(size, GFP_KERNEL);
>>  	if (chan_array == NULL)
>>  		return -ENOMEM;

Sebastian
