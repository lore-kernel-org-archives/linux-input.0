From: Eugen Hristev <eugen.hristev-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
Subject: Re: [PATCH 12/14] iio: adc: at91-sama5d2_adc: support for position
 and pressure channels
Date: Thu, 4 Jan 2018 17:17:54 +0200
Message-ID: <25045512-f372-3f25-e84f-ed809db9dde3@microchip.com>
References: <1513955241-10985-1-git-send-email-eugen.hristev@microchip.com>
 <1513955241-10985-13-git-send-email-eugen.hristev@microchip.com>
 <20171229170236.06bf6394@archlinux>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171229170236.06bf6394@archlinux>
Content-Language: en-US
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: nicolas.ferre-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org, ludovic.desroches-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org, alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: linux-input@vger.kernel.org



On 29.12.2017 19:02, Jonathan Cameron wrote:
> On Fri, 22 Dec 2017 17:07:19 +0200
> Eugen Hristev <eugen.hristev-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org> wrote:
> 
>> The ADC IP supports position and pressure measurements for a touchpad
>> connected on channels 0,1,2,3 for a 4-wire touchscreen with pressure
>> measurement support.
>> Using the inkern API, a driver can request a trigger and read the
>> channel values from the ADC.
>> The implementation provides a trigger named "touch" which can be
>> connected to a consumer driver.
>> Once a driver connects and attaches a pollfunc to this trigger, the
>> configure trigger callback is called, and then the ADC driver will
>> initialize pad measurement.
>> First step is to enable touchscreen 4wire support and enable
>> pen detect IRQ.
>> Once a pen is detected, a periodic trigger is setup to trigger every
>> 2 ms (e.g.) and sample the resistive touchscreen values. The trigger poll
>> is called, and the consumer driver is then woke up, and it can read the
>> respective channels for the values : X, and Y for position and pressure
>> channel.
>> Because only one trigger can be active in hardware in the same time,
>> while touching the pad, the ADC will block any attempt to use the
>> triggered buffer. Same, conversions using the software trigger are also
>> impossible (since the periodic trigger is setup).
>> If some driver wants to attach while the trigger is in use, it will
>> also fail.
>> Once the pen is not detected anymore, the trigger is free for use (hardware
>> or software trigger, with or without DMA).
>> Channels 0,1,2 and 3 are unavailable if a touchscreen is enabled.
>>
>> Some parts of this patch are based on initial original work by
>> Mohamed Jamsheeth Hajanajubudeen and Bandaru Venkateswara Swamy
>>
> OK, so comments inline.
> 
> What I'm missing currently though is an explanation of why the slightly
> more standard arrangement of using a callback buffer doesn't work here.
> The only addition I think you need to do that is to allow a consumer to
> request a particular trigger.  I also think some of the other provisions
> could be handled using standard features and slightly reducing the flexibility.
> I don't know for example if it's useful to allow other channels to be
> read when touch is not in progress or not.
> 
> So restrictions:
> 
> 1. Touch screen channels can only be read when touch is enabled.
>   - use the available_scan_masks to control this. Or the callback that lets
>     you do the same dynamically.
> 2. You need to push these channels to your consumer driver.
>   - register a callback buffer rather than jumping through the hoops to
>     insert your own pollfunc.  That will call a function in your
>     consumer, providing the data from the 3 channels directly.
> 3. You need to make sure it is using the right driver.  For that you
>     will I think need a new interface.
> 
> Various other comments inline. I may well be missing something as this is
> a fair bit of complex code to read - if so then next version should have
> a clear cover letter describing why this more standard approach can't be
> used.

Hello Jonathan and thanks for the review of my patch series,

before starting and working over the required modifications and 
suggestions that you sent me, I want to be a little more explicit about 
the design of my implementation.
Hope this will clarify some things, and maybe I can as well understand 
better what you have in mind to support this feature set.

Why have I picked a pollfunction: We discussed a while back on the 
mailing list that you do not have an inkern mechanism to expose the 
triggers to other drivers, and that it may be a good idea to have it for 
such kind of actually multi function device, instead of having a MFD 
driver, an ADC driver, and an Input driver, all sharing the same 
register map, the same IRQ , etc, with some kind of synchronization to 
avoid stepping on each other for the hardware resource.
So I considered to expose the trigger by attaching and detaching 
pollfunctions to it. Which is the main thing what we use a trigger for.

So, what I had in mind, was to create a consumer driver that will 
request triggers from the IIO device just like other drivers request 
channels (part which is already done in IIO).
In order to do this I had to somehow wake up the consumer driver when 
new data was available from the touchscreen. So, having the IRQ only in 
the ADC device, and then on Pen detect and No pen detect just start or 
stop the periodic trigger, which needs to be polled. The magic part is 
that the consumer driver has a poll function already attached to this 
trigger, so the poll function is just called every time we have new 
data. The poll function is attached as an irq handler, and then we can 
reuse all the read_raw data by using a scheduled work from the consumer 
driver, to read the channels.
To do this, the ADC registers a special trigger named "touch trigger" 
which is never enabled by the ADC driver. Instead, when a pollfunc is 
attached to it, the attach function will also configure it with enabled 
state. In the ADC, this means to start the touchscreen functionality. If 
the touch is requested, it will standby and wait for pen detect IRQ.
Once we have pen detect, we can use a periodic trigger to sample the 
touch data, and poll the "touch" trigger. The consumer driver will wake 
up and schedule a work , that will use the standard read raw interface 
(inkern) that will read three virtual channels (position + pressure). 
They are not actual hardware channels, as the touch information is being 
received on channels 0,1,2,3, but reading these virtual channels will 
read from different registers inside the ADC IP ( x position, y 
position, pressure), do some computations on the data, and feed the 
consumer with the values , hiding the behind the scenes hardware 
specific calculations.
After trigger is polled , the ADC will resume normal functionality, and 
the consumer driver will continue to sleep.
We need to have a periodic trigger to sample the data because the actual 
analog to digital conversion inside the IP block needs to be triggered. 
The touchscreen data measurements cannot happen in hardware without 
being triggered. If I try with a hrtimer to get a periodic IRQ to just 
read the data, it will never be ready. The datasheet states that the 
touchscreen measurements "will be attached to the conversion sequence". 
So the periodic trigger is forcing a conversion sequence. This could be 
done with a software trigger as well, but why the hassle to start it 
every 2 milliseconds (or other time interval), if we can do it by 
periodic trigger ?
Once we get the No pen IRQ, we stop the periodic trigger and it can be 
used in another purpose (software or external as of now in the driver, 
in the future we can add PWM trigger and Timer trigger)

In short, the ADC in Sama5D2 also supports touchscreen, and in 
touchscreen mode , 4 of the channels are being used for this purpose. 
This however, doesn't stop the ADC to use the other channels . The 
hardware has 12 total single channels and they can be paired to have 6 
more differential channels. The only thing that is blocked is the 
trigger, but only if the pen is touching (when we start the periodic 
trigger to sample the touchscreen). If the pen is not touching, an 
external trigger or software trigger can be used without any issues (so 
why limit the functionality, if this is available from hardware ?). 
Because of the reason I discussed above (touchscreen sequence must be 
triggered), we cannot use another trigger in the same time.


I see your idea with the callback buffer and it's worth exploring. 
Mainly this series was to actually show you what I had in mind about 
supporting the resistive touchscreen, and to give you some actually 
working code/patch, so we can discuss based on real implementation, not 
just suppositions.

You are right in many of the other comments that you said, and I will 
come up with a v2 to this series. For now, I need to know if this is a 
good or right direction in which I am going, or I should try to change 
all the mechanism to callback buffer ? Or maybe I am totally in a bad 
direction ?
The requirements are that the consumer driver needs to be somehow woke 
up for every new touch data available, and report to the input 
subsystem. As it was done before, the at91 old driver, just creates and 
registers an input device by itself, and then reports the position and 
touches. I was thinking that with this trigger consumer implementation, 
things can be better in terms of subsystem separation and support.

Thanks again and let me know of your thoughts,

Eugen



[...]
