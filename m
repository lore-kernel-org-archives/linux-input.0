From: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 4/5] input: touchscreen: support Allwinner SoCs'
 touchscreen
Date: Tue, 27 Sep 2016 20:59:48 +0100
Message-ID: <6cb6c9b7-2a8e-4d79-973c-2ebe6151be1b@kernel.org>
References: <1469003351-15263-1-git-send-email-quentin.schulz@free-electrons.com>
 <1469003351-15263-5-git-send-email-quentin.schulz@free-electrons.com>
 <8174039f-777e-b4b8-58c9-3509748f2799@kernel.org>
 <db3ab94a-9dbb-3bd6-fe43-e530b42c9246@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <db3ab94a-9dbb-3bd6-fe43-e530b42c9246-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Quentin Schulz <quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, knaack.h-Mmb7MZpHnFY@public.gmane.org, lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org, pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Cc: antoine.tenart-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On 25/09/16 20:44, Quentin Schulz wrote:
> On 24/07/2016 13:24, Jonathan Cameron wrote:
>> On 20/07/16 09:29, Quentin Schulz wrote:
>>> This adds support for Allwinner SoCs' (A10, A13 and A31) resistive
>>> touchscreen. This driver is probed by the MFD sunxi-gpadc-mfd.
>>>
>>> This driver uses ADC channels exposed through the IIO framework by
>>> sunxi-gpadc-iio to get its data. When opening this input device, it will
>>> start buffering in the ADC driver and enable a TP_UP_PENDING irq. The ADC
>>> driver will fill in a buffer with all data and call the callback the input
>>> device associated with this buffer. The input device will then read the
>>> buffer two by two and send X and Y coordinates to the input framework based
>>> on what it received from the ADC's buffer. When closing this input device,
>>> the buffering is stopped.
>>>
>>> Note that locations in the first received buffer after an TP_UP_PENDING irq
>>> occurred are unreliable, thus dropped.
>>>
>> I think I now understand what you are doing.
>>
>> The channel grab is grabbing 4 channels, when there are only two real
>> ones (x and y) then you are abusing the callback interface from IIO.
> 
> Actually, I need an IIO channel only for registering the callback from
> the consumer but I never use the IIO channel in an other way from
> consumer side (everything's done in the provider by reading the FIFO
> register and sending data to the callback via iio_buffer).
Whilst it 'would work' to just hook in and deal with the data if it
came through a single channel with enough space, that would be an
abuse of the interface which is very much designed to ship 'scans'
(e.g. sets of data taken at the same time ish).

There is a demux unit in the path which is designed to pull out
only the channels wanted by the consumer.  If the combination
of available_scan_masks in the provider and the channels requested
by the consumer (via the map) are right then you'll only 'get'
the data you want and the rest will disappear into thin air ;)

> 
>> That transmits only one scan (e.g. here (x,y)) per call. Because you
>> have added a sideband route for the buffer size what you have wil work.
>>
>> However, it is not how the interface should be used.  Please fix that.
>> Using it correctly is not a big issue.
>>
>> On the channels front, I'd be tempted to do this as follows:
>>
>> 6 Channels, not 4.
>>
>> First 4 are standard ADC channels
>> Next 2 are the touch screen channels with appropriate descriptions
>> (guessing these are actually differential channels across the various
>> wires of the first two?)
>>
> 
> Yes they are differential channels.
> 
> However, I think there is actually no sense in using several channels
> for the touchscreen as everything is handled by the hardware. You only
> select the touchscreen mode by setting a register and then X and Y
> coordinates will be added to the FIFO register when touching the
> touchscreen. I would not mind not having IIO channel at all since we do
> not read from the consumer. But I need a way to register a callback to
> get data from the provider. I don't know if I make myself clear enough?
If you want to do it another way (I'd rather you didn't!) then you'll
need to create an mfd style base driver and register the touch screen
on that with custom callback registration etc.
> 
>> Then you set the map up to apply to the last two channels only.
>> By setting available_scan_masks to the relevant options in the IIO driver
>> you'll be able to automatically lock the device when ever the
>> touch screeen driver is loaded.
>>
>> That map will be something like (in binary
>> 000000
>> 000011
>> 000100
>> 001000
>> 010000
>> 100000
>> 001100
>> 010100
>> 011000
>> 100100
>> 101000
>> 110000
>> 011100
>> 101100
>> 110100
>> 111000
>> 111100
>>
>> thus any combination of the ADC channels, but always all or none of the
>> touchscreen (none when ever the ADC channels are on) the order above
>> ensures we always turn on the minimum possible for a given requirement.
>>
>> Hence whenever the touch screen is there it'll lock out the ADC usage.
>> Your postenable can look at what is there and put it in the right mode.
>>
> 
> I'll dive more into that.
> 
>> After that, break your fifo read up into individual pairs of readings
>> and push those out.
>>
>> That way we end up using the interface in the standard fashion.
>>
>> You'll also need fix the usage of the fifo for ADC mode which suffers
>> from the same problem.  There all sorts of nasty crashes might occur
>> or you might just loose data
>>
> [...]
>>> +/*
>>> + * This function will be called by iio_push_to_buffers from another driver
>>> + * (namely sunxi-gpadc-iio). It will be passed the buffer filled with input
>>> + * values (X value then Y value) and the sunxi_gpadc_ts structure representing
>>> + * the device.
>>> + */
>>> +static int sunxi_gpadc_ts_callback(const void *data, void *private)
>>> +{
>>> +	const struct sunxi_gpadc_buffer *buffer = data;
>>> +	struct sunxi_gpadc_ts *info = private;
>>> +	int i = 0;
>>> +
>>> +	/* Locations in the first buffer after an up event are unreliable */
>>> +	if (info->ignore_fifo_data) {
>>> +		info->ignore_fifo_data = false;
>>> +		return 0;
>>> +	}
>>> +
>> It doesn't work like this at all. You'll get one scan only on each call of
>> this function.  As I said in the previous driver, if there is a true reason
>> to do this (and I'm unconvinced as yet) then we need to add support in the
>> iio core etc for this (and emulating it when multiple scan passing isn't
>> happening).
>>
>> I guess this will work, as you are passing the buffer size as a side
>> band, but it is definitely not how that ABI is meant to be used.
>>
>> Also, you grab 4 channels, and only two are used here.  Please explain...
>>
> 
> Hum. Actually, that's a mistake. I'm quiet confused about how I should
> do it while I never read channels from the consumer. I still "need" one
> for "linking" the consumer and the provider but in the meantime, I'm
> never using that channel.
You are, because the demux is only sending you the channels you
are registered for.  Thus the provider should push whatever it
gets to the buffers and by the time it hits the consumer it should
get only what it needs.

It's not so interesting with this hardware because you can't do
general purpose reads at the same time as the touchscreen stuff is
running (annoyingly).  With hardware that can do any combination of
channels you end up with for example:

Provider - pushing out a superset of all the channels anyone cares
about.

Consumer 1 (touch screen) gets just the x and y coordinates when pen
is down.

Consumer 2 (temperature - thermal) gets just the temperature.

Consumer 3 (e.g. battery monitory) gets just the charger voltages etc.

Consumer 4 (stretching here - analog accelerometer) gets just
accelerations for the input bridge I never get round to finally
submitting.

Jonathan
