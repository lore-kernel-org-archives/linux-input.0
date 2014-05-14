From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH] HID: i2c-hid: Support batch read of input events from fifo
Date: Wed, 14 May 2014 09:43:16 -0400
Message-ID: <CAN+gG=Fm+EZiJL2A-SfKnUoKMsEpxJ3NFZ34LJZ1pUaROag-2A@mail.gmail.com>
References: <1399555929-10870-1-git-send-email-archana.patni@linux.intel.com>
	<CAN+gG=HQwkqcyvDfK_unSuKRVOt4dyoPDK5Rz0GswrTKL1OMEg@mail.gmail.com>
	<536E7473.4080502@linux.intel.com>
	<CAN+gG=ECCTnyqK0nTuGQXLSOEfZB7JkCAzYtvG-wE9MYL6mAag@mail.gmail.com>
	<5370FDA9.90309@linux.intel.com>
	<52040.10.223.188.192.1400065472.squirrel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lb0-f171.google.com ([209.85.217.171]:60077 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755440AbaENNnS (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 14 May 2014 09:43:18 -0400
Received: by mail-lb0-f171.google.com with SMTP id 10so1427540lbg.2
        for <linux-input@vger.kernel.org>; Wed, 14 May 2014 06:43:16 -0700 (PDT)
In-Reply-To: <52040.10.223.188.192.1400065472.squirrel@linux.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Archana Patni <archana.patni@linux.intel.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Jiri Kosina <jkosina@suse.cz>, Jonathan Cameron <jic23@kernel.org>, linux-input <linux-input@vger.kernel.org>, Mika Westerberg <mika.westerberg@intel.com>, "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>, Archana Patni <archana.patni@intel.com>, Subramony Sesha <subramony.sesha@intel.com>

On Wed, May 14, 2014 at 7:04 AM,  <archana.patni@linux.intel.com> wrote:
>> On 05/12/2014 09:03 AM, Benjamin Tissoires wrote:
>>> Hi Srinivas,
>>>
>>> On Sat, May 10, 2014 at 2:48 PM, Srinivas Pandruvada
>>> <srinivas.pandruvada@linux.intel.com> wrote:
>>>> Hi Benjamin,
>>>>
>>>> On 05/08/2014 07:28 AM, Benjamin Tissoires wrote:
>>>>> On Thu, May 8, 2014 at 9:32 AM, Archana Patni
>>>>> <archana.patni@linux.intel.com> wrote:
>>>>>> Some i2c_hid devices like a sensor hub have built-in fifos which
>>>>>> can accumulate input events in their buffers and trigger an interrupt
>>>>>> at end of a user defined event like fifo full or a timeout. The
>>>>>> current
>>>>>> implementation reads one event at a time in the IRQ handler leading
>>>>>> to
>>>>>> several hundred interrupts being necessary to flush the fifo.
>>>>>>
>>>>>> This patch changes the threaded IRQ handler to keep input events
>>>>>> until
>>>>>> there are no input events left to read. In the normal case, this will
>>>>>> invoke one additional call to fetch an input event to check for no
>>>>>> pending
>>>>>> events and terminate the loop.
>>>>> I must say, I don't like this patch.
>>>>> It seems to me that it will solve your problem but will break other
>>>>> devices. Nothing in the spec says what happens if the host tries to
>>>>> read while the interrupt line is *not* asserted. I can easily imagine
>>>>> several scenarios where the device would hang until the next available
>>>>> data, or will just fail.
>>>>>
>>>>> So the proper way according to the spec is to check the status of the
>>>>> interrupt line. This line is the responsibility of the device to be
>>>>> asserted and we should rely on it to know if we can read again.
>>>>>
>>>>> However, a quick check on the interrupt API did not provide me the
>>>>> function I would like, so I guess this is something to be work on.
>>>>>
>>>>> I can not ack this one until we can be sure not breaking other stuff.
>>>>>
>>>>> So: NACK.
>>>> I understand your reason, there may be some HID device which will have
>>>> issue
>>>> with this change.
>>>> I am interested in throwing some idea, as I am trying to keep the
>>>> devices in
>>>> deepest idle states as
>>>> long as possible. Sensors are one of the offenders.
>>>> - This driver can register i2c_driver, command callback. We can define
>>>> one
>>>> of the command to set the set the max size dynamically or fire this
>>>> logic to
>>>> empty buffers. This way, we can only enable such logic, when a sensor
>>>> hub
>>>> has capability and notifies this capability dynamically without
>>>> affecting
>>>> any other hid devices.
>>> I am OK with the logic as long as the i2c calls are independent of the
>>> HID layer. Remember that if the advertised bus is BUS_I2C, it might as
>>> well be an uhid device which will not handle the i2c calls.
>>>
>>> Another solution could be to add a HID quirk which triggers the "empty
>>> while input are here" and set this quirk in hid-sensor-hub. This way,
>>> you will be in control of it and other devices might use it as well if
>>> they support it.
>>>
>>> I am not a big fan of quirks, so I would still prefer your solution if
>>> you can control it without disturbing the HID subsystem. This will all
>>> depend where you can enable the functionality on the device.
>> I also don't like quirks as they start becoming de facto solutions.
>>
>> Archana,
>>
>> Can you prototype this using i2c_client_commands by keeping above
>> constraints?
>>
>> Thanks,
>> Srinivas
>
> Benjamin,
>
> The i2c_clients_command callback hook seems to be deprecated and not
> widely used. We had a quick check with Srinivas and he asked us to fall
> back to a quirk based approach.
>
> We will create a device specific quirk (using vendor ID) which sets up a
> batched read IRQ handler if it sees a device capable of supporting batch
> reads from the fifo. In the normal case, the current IRQ handler will
> continue to be used. As more devices support this feature, they can turn
> on the batched handler via the quirk.
>
> Does this look ok to you ?

Yep, fine by me.

Cheers,
Benjamin
