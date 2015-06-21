From: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC] HID: hid-sony: Add basic iio-subsystem reading of SixAxis
 Accelerometers
Date: Sun, 21 Jun 2015 14:16:00 +0100
Message-ID: <5586B910.6080004@kernel.org>
References: <195dff9bd065db7e618280cb7c6eb5a9.squirrel@mungewell.org>	 <1434034458-1968-1-git-send-email-simon@mungewell.org>	 <557D9564.9090800@kernel.org>	 <d6702f5d19d2baea80132666fcf7654a.squirrel@mungewell.org>	 <557DC084.6090205@kernel.org> <1434392064.2353.77.camel@spandruv-DESK3.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1434392064.2353.77.camel-hINH/TbAiWqaJgj69oe+EDMJUdESFZ8XQQ4Iyu8u01E@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: simon-wM4F9T/ekXmXDw4h08c5KA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Frank Praznik <frank.praznik-oKii7tqusJgAvxtiuMwx3w@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On 15/06/15 19:14, Srinivas Pandruvada wrote:
> On Sun, 2015-06-14 at 18:57 +0100, Jonathan Cameron wrote:
>> On 14/06/15 18:25, simon-wM4F9T/ekXmXDw4h08c5KA@public.gmane.org wrote:
>>> Thank you for your comments, I'm just getting started with IIO so it's all
>>> good stuff...
>>>
>> Srinivas, cc'd you as a few queries came up about the hid-sensors driver.
>> (it's got me thoroughly confused ;(
>>>>> +++++++++++++++++++++++++++++++++++++++++++++++++
>>>> Hmm. This driver is already a substantial mash up of a number of different
>>>> types of driver (as far as linux is concerned), with input, battery and
>>>> led
>>>> drivers.  Might be worth considering a more formal MFD approach as it'll
>>>> break the driver up into a number of sub components that will then sit
>>>> in the various subsystems in a cleaner fashion.
>>>> Just a thought!
>>>
>>> Might be, but that sounds like more work ;-) If pushing some ideas around
>>> prompts that, it can't be a bad thing.... right?
>>>
>>>>> +	case IIO_CHAN_INFO_SCALE:
>>>>> +		switch (chan->type) {
>>>> If the scale really is 1 then don't export it.  Note the units would
>>>> have to be in m/s^2 which seems unlikely though. I'm guessing this
>>>> is a placeholder..
>>>
>>> Yes place holder, different controllers (SixAxis, DS4 and PSMove) have
>>> different values. In the far future I'd hope to use the per-device
>>> calibration stored on the PSMove.
>>>
>>> https://github.com/nitsch/moveonpc/wiki/Calibration-data
>>>
>>>>> +static const struct iio_chan_spec sony_sixaxis_channels[] = {
>>>>> +	SONY_ACC_CHANNEL(X),
>>>>> +	SONY_ACC_CHANNEL(Y),
>>>>> +	SONY_ACC_CHANNEL(Z),
>>>> No gyro channels yet?
>>>> Just to note, if the gyro frequency etc is different from the
>>>> accelerometer
>>>> (pretty common) then you'll want to register two IIO devices rather than
>>>> just the one so that the control and buffers are separate.
>>>
>>> I have a vague memory that the SixAxis has a 1-ch gyro but this is not
>>> showing on hidraw (might be 'hidden' behind MultiTouch ID/Bug).
>>>
>>> The DS4 has Accel/Gyros, and the PSMove has Accel/Gyro/Mag. I didn't
>>> expose the mags over input/joystick axis as I didn't want to corrupt
>>> stream the PSMoveAPI (it needs to be re-ordered) and it's unlikely anyone
>>> would actually use via joystick.
>>>
>>> The PSMove's report actually contains 2 frames assumed to be 1/2 sample
>>> rate apart for the Accel/Gyro, but only one Mag reading.
>>>
>>>
>>>
>>> I have further advanced the patch to include reading via buffer, but I'm
>>> having trigger 'conceptual' problems getting my head around the HID device
>>> issuing an interrupt when a input report is received. Looking at
>>> iio_dummy_event and iios_sysfs for inspiration....
>> You can skip the triggers.  It's not obligatory, you can push directly into a buffer.
>> Triggers are nice for 'data ready' type signals (which is closest to what we
>> have here) if you might want to hang other sensors off the timing (so read
>> on demand ADCs etc.  They aren't actually 'required' as such.
>>
>> Looking at the hid drivers I'm not entirely sure they are actually doing anything.
>> (been a while since I looked at these in detail!).  Srinivas, perhaps you could help
>> out with what's going on there?
>>
>> I can't find an iio_trigger_poll call so the trigger is neither used by the
>> hid sensors drivers, not usable by anything else as far as I can see..
>> Looks like it is used purely to get the device into the correct power state
>> etc.  If so that stuff should be in the buffer preenable / postdisable not
>> the trigger stuff.
>>
>> I get the feeling that this might all be a work around for a perceived need
>> for a trigger (particularly in userspace app examples?) as it predates
>> the am355x driver where we absolutely said they weren't required and the
>> userspace demo changes that were made to support that.
>>>
> The user space was developed using the iio user space demo. We could
> have done with buffer pre/post enable. But triggers provided path for
> enhancements.
Fair enough in principle, I was just getting lost on whether any actual
triggers ever occurred. That would require iio_trigger_poll to be called
somewhere.  If this isn't happening and the trigger is just used as a kind
of internal placeholder then that is fine as long as there are validate functions
so no other drivers think they can use the triggers.  In particular the trigger
validate_device callback needs to prevent this.

> We are currently looking how camera buffer sample and
> accelerometer data can be tied together by using trigger buffers. Even
> one sensor data ready can trigger read on a companion senor on the hub.
> 
> Thanks,
> Srinivas
> 
>>> On the assumption that there will be multiple devices (either same type or
>>> with different HID drivers) all trying to issue triggers, we'd need to be
>>> a little careful.
>>>
>>> Is there a 'short-cut' we can use if a HID device is only required to
>>> trigger itself (and not other iio devices)? ie. not need true interrupt
>>> system.
>> Yes, you can use the 'validate_trigger' and 'validate_device' callbacks to
>> reject either other devices trying to use the trigger, or your device trying
>> to use a different one.  Lots of drivers do this in the first place (as you
>> point out it is a short cut to get things working) then if anyone cares
>> relax the constraint later by making the true interrupt stuff work.
>>
>>
>>>
>>> Simon.
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>>> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
