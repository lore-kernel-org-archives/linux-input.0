From: Quentin Schulz <quentin.schulz@free-electrons.com>
Subject: Re: [PATCH 3/5] iio: adc: sunxi-gpadc-iio: enable iio_buffers
Date: Sun, 25 Sep 2016 21:57:16 +0200
Message-ID: <433c4869-88ed-5821-2db2-67dbaa6541f7@free-electrons.com>
References: <1469003351-15263-1-git-send-email-quentin.schulz@free-electrons.com>
 <1469003351-15263-4-git-send-email-quentin.schulz@free-electrons.com>
 <ff7515ec-a064-95df-1118-93c7062c2237@kernel.org>
 <ffca0be9-56c0-5f84-09ee-884d5e94e9df@free-electrons.com>
 <cbf9470e-62ee-0efe-d893-5e08df33576c@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:59897 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1034491AbcIYT5V (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sun, 25 Sep 2016 15:57:21 -0400
In-Reply-To: <cbf9470e-62ee-0efe-d893-5e08df33576c@kernel.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jonathan Cameron <jic23@kernel.org>, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net, maxime.ripard@free-electrons.com, wens@csie.org, dmitry.torokhov@gmail.com, lee.jones@linaro.org
Cc: antoine.tenart@free-electrons.com, thomas.petazzoni@free-electrons.com, linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org

On 25/09/2016 11:10, Jonathan Cameron wrote:
> On 24/09/16 18:40, Quentin Schulz wrote:
>> Hi Jonathan,
>>
>> Sorry for the (long) delay, I did not have time to work on it. I'll
>> mainly work in my free time now.
>>
>> Keep in mind this patch was proposed based on the v2 of the ADC patches.
>> Since then, substantial changes have been made and I'm working on
>> rebasing this series of patches on the v6, so comments here might
>> include references to code parts added later in the ADC patch series.
>>
>> On 24/07/2016 13:03, Jonathan Cameron wrote:
>>> On 20/07/16 09:29, Quentin Schulz wrote:
>>>> This enables the use of buffers on ADC channels of sunxi-gpadc-iio driver.
>>>> It also prepares the code which will be used by the touchscreen driver
>>>> named sunxi-gpadc-ts.
>>>>
>>>> The GPADC on Allwinner SoCs (A10, A13 and A31) has a 12 bits register for
>>>> conversion's data. The GPADC uses the same ADC channels for the ADC and the
>>>> touchscreen therefore exposes these channels to the sunxi-gpadc-ts iio
>>>> consumer which will be in charge of reading data from these channels for
>>>> the input framework.
>>>>
>>>> The temperature can only be read when in touchscreen mode. This means if
>>>> the buffers are being used for the ADC, the temperature sensor cannot be
>>>> read.
>>> That may be the bizarest hardware restriction I've heard of in a while! :)
>>>>
>>>> When a FIFO_DATA_PENDING irq occurs, its handler will read the entire FIFO
>>>> and fill a buffer before sending it to the consumers which registered in
>>>> IIO for the ADC channels.
>>>>
>>>> When a consumer starts buffering ADC channels,
>>>> sunxi_gpadc_buffer_postenable is called and will enable FIFO_DATA_PENDING
>>>> irq and select the mode in which the GPADC should run (ADC or touchscreen)
>>>> depending on a property of the DT ("allwinner,ts-attached").
>>>> When the consumer stops buffering, it disables the same irq.
>>> Hmm. Might be possible to distinguish which consumer caused the start.
>>> Thus, if the touchscreen is there we would know purely based on the
>>> driver being the requester that we need to be in touchscreen mode.
>>>
>>
>> As of yet, can't see in which way I can retrieve the consumer in
>> provider code. Maybe I'm missing something, I don't know?
> I don't think we have a current way of doing this... Might be possible
> to add one, but it would be a rather odd bit of reverse looking up.
[...]
>>>> @@ -101,19 +104,43 @@ struct sunxi_gpadc_dev {
>>>>  	unsigned int			fifo_data_irq;
>>>>  	unsigned int			temp_data_irq;
>>>>  	unsigned int			flags;
>>>> +	struct iio_dev			*indio_dev;
>>> I was suprised to see this as normally it is cleaner to structure
>>> the whole code to go in one direction through the structures (which is
>>> why we don't provide a generic iio_device_from_priv bit of pointer magic).
>>>
>>> Anyhow, don't htink you are actually using it ;)
>>>
>>
>> I'm using to push to buffers from the irq handler since I pass the local
>> structure (sunxi_gpadc_dev) to the irq handler when registering it. But
>> I guess I can pass the iio_dev instead and remove this from the local
>> structure.
> I'd prefer passing the iio_dev and keep all lookups in one direction.

ACK.

>>
>> [...]
>>>>  static int sunxi_gpadc_adc_read(struct iio_dev *indio_dev, int channel,
>>>>  				int *val)
>>>>  {
>>>>  	struct sunxi_gpadc_dev *info = iio_priv(indio_dev);
>>>> +	bool buffered = info->buffered;
>>> Not worth the local version...
>>>>  	int ret = 0;
>>>> +	unsigned int reg;
>>>>  
>>>>  	mutex_lock(&indio_dev->mlock);
>>>>  
>>>>  	reinit_completion(&info->completion);
>>>> +
>>>> +	reg = SUNXI_GPADC_TP_FIFO_TRIG_LEVEL(1) | SUNXI_GPADC_TP_FIFO_FLUSH;
>>>> +	regmap_update_bits(info->regmap, SUNXI_GPADC_TP_INT_FIFOC, reg, reg);
>>> I'd put it in directly rahter than having a reg local variable.  To mind
>>> mind that would be slightly easier to understand.
>>>> +
>>>>  	if (info->flags & SUNXI_GPADC_ARCH_SUN6I)
>>>>  		regmap_write(info->regmap, SUNXI_GPADC_TP_CTRL1,
>>>>  			     SUNXI_GPADC_SUN6I_TP_MODE_EN |
>>>> @@ -153,9 +185,9 @@ static int sunxi_gpadc_adc_read(struct iio_dev *indio_dev, int channel,
>>>>  			     SUNXI_GPADC_TP_MODE_EN |
>>>>  			     SUNXI_GPADC_TP_ADC_SELECT |
>>>>  			     SUNXI_GPADC_ADC_CHAN_SELECT(channel));
>>>> -	regmap_write(info->regmap, SUNXI_GPADC_TP_INT_FIFOC,
>>>> -		     SUNXI_GPADC_TP_FIFO_TRIG_LEVEL(1) |
>>>> -		     SUNXI_GPADC_TP_FIFO_FLUSH);
>>> Whole load of infrastructure in place to lock buffered mode out and
>>> revent transitions when we can't have them.
>>>
>>> iio_claim_direct_mode etc.  I think you can just use that here?
>>> If you need to do extra checks on it being enabled that should be
>>> fine too.
>>>
>>
>> Yes, way better with iio_device_claim_direct_mode and iio_buffer_enabled!
>>
>>> As a general rule, it makes sense to simply disable polled reads
>>> if in buffered mode.  Leads to much simpler code and generally
>>> the data is already known to userspace anyway.
>>>
>>
>> That's what I try to do.
>> However, I think the temperature of the SoC is an interesting feature to
>> have. Since it ("hardwarely") works while the ADC is read in touchscreen
>> mode (even in buffer mode), I guess it could be a good idea to allow it
>> in the driver. If we don't do that, boards with a touchscreen connected
>> to the ADC of the SoC will not get SoC temperatures and can't have
>> proper thermal management. We already have one board in that case: the
>> PocketCHIP.
>>
>> Therefore, I also need to know if when the buffer is enabled, if it's
>> for buffering ADC data or touchscreen data. If it's for ADC data, then I
>> should disable temperature readings since it will return senseless
>> values (from memory, always 0 which means something like -144°C).
> Nice so no thermal management if we don't have a touch screen :)

I think that's a big constraint. I think we should be able to read the
temperature when the ADC is in either touchscreen or ADC mode but ONLY
in DIRECT_MODE. While in BUFFER_MODE, we should enable temperature
reading only when the touchscreen is present.

That might induce a problem with the thermal framework I think. I've had
some problem with temperature reading's timeout so I'm reading a
manually "cached" temperature which is updated when the temperature
reading is done. However, it will never be updated when the ADC is in
buffered ADC mode. I don't know if in that case it is better to
unregister the thermal device, to give outdated values or to notify the
thermal framework the temperature readings timed out (which is verbose).
[...]
>>>> @@ -261,7 +302,29 @@ static irqreturn_t sunxi_gpadc_temp_data_irq_handler(int irq, void *dev_id)
>>>>  static irqreturn_t sunxi_gpadc_fifo_data_irq_handler(int irq, void *dev_id)
>>>>  {
>>>>  	struct sunxi_gpadc_dev *info = dev_id;
>>>> -	int ret;
>>>> +	int ret, reg, i, fifo_count;
>>>> +
>>>> +	if (info->buffered) {
>>>> +		if (regmap_read(info->regmap, SUNXI_GPADC_TP_INT_FIFOS, &reg))
>>>> +			return IRQ_HANDLED;
>>>> +
>>>> +		fifo_count = (reg & SUNXI_GPADC_RXA_CNT) >> 8;
>>>> +		/* Sometimes, the interrupt occurs when the FIFO is empty. */
>>>> +		if (!fifo_count)
>>>> +			return IRQ_HANDLED;
>>>> +
>>>> +		for (i = 0; i < fifo_count; i++) {
>>>> +			if (regmap_read(info->regmap, SUNXI_GPADC_TP_DATA,
>>>> +					&info->buffer.buffer[i]))
>>>> +				return IRQ_HANDLED;
>>>> +		}
>>>> +
>>>> +		info->buffer.buff_size = i;
>>>> +
>>>> +		iio_push_to_buffers(info->indio_dev, &info->buffer);
>>> This is expecting a single 'scan' - e.g. set of channels read at one
>>> time.  Here I think we could have repeated sets of channels?
>>> (at least that would be what is normally meant by a fifo in such
>>> a device).
>>>
>>> If so you need to read 'whole' scans and push them one at a time.
>>> We don't yet have a bulk iio_push_to_buffers, though we can add
>>> one if it makes sense.  Care will be needed though as we'd need
>>> handle the case of different consumers either supporting or
>>> not supporting this new functionality.  Not particularly hard though
>>> if it is worth doing.
>>
>> I didn't know it was meant for only one scan. Then I need a bulk
>> iio_push_to_buffers.
> We've had a few cases where that would be handy recently. 
> The bit that makes it complex is if we are doing any demux of the channels
> to multiple consumers.  Could be done by falling back to separating
> the scan's out and pushing them one by one through the demux though.
> Not sure there is a better way to do it though...
>>
>> I have a rather big problem. The whole first FIFO at each touch is
>> unusable so I have to drop it. I can detect the beginning of a touch
>> when the TP_UP irq occurs, then I know the next full FIFO the consumer
>> receives by callback is to be dropped. If I use push_to_buffers to send
>> coordinates by coordinates, the consumer has no mean to know when the
>> second FIFO (the first to be valid) starts and can be used. Either we
>> can find a way to notify the consumer of the start of a new FIFO or I
>> have to use a bulk iio_push_to_buffers.
> Nasty indeed.
>>
>> The workaround would be to register the TP_UP irq in the provider (the
>> ADC driver) and do not send the first FIFO to the consumer. But then, we
>> need a way to know which consumer requests buffering to know when to
>> enable this irq and do all touchscreen-only logic (dropping first
>> frame). And I guess we don't have something like that yet. Or I could
>> only code a buffering in touchscreen mode and add the ADC buffering
>> later? But it doesn't feel right to do what I think should be handled
>> (TP_UP irq handler and first FIFO dropping) in the consumer, in the
>> provider.
> Would indeed by the nicer way of doing it, but we are ultimately working
> around a hardware issue (to my mind it should never return rubbish!)
> so I'd not worry too much about where the fix is.
>>
>> So it's quiet a dead-end yet if I can't use iio_push_to_buffers with a
>> whole FIFO (which you told is not how it is meant to be used).
> It only worked here because you had control of both ends of the link.
> 
> First thought is that we should add a bulk push to buffers, but
> that a little bit of fiddly code would be needed to unwind the
> data in the demux if needed.  Probably not too hard to do.  It would then
> need to repackage the data up as a bulk buffer data block to send onwards.
> 
> To do this I think you'd need to:
> 1) Add core support to have a bulk push with the right magic around to call
>    the demux code in a loop over all the elements before pushing on.
> 2) Bulk handling in the callback buffer.
> 3) Kfifo bulk handling (mostly to allow us to test the demux code).
> 
> Actually, short of stuff I haven't thought of, doesn't look too tricky
> and useful feature to have in general.
> 

Then I guess we'll have to do it :) I might need a lot of guiding though
but maybe that's more of an IRC chat or non-lkml conversation?

Thanks,
Quentin

-- 
Quentin Schulz, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
