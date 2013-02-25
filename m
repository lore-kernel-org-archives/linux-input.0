From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: Question regarding multitouch input on Linux kernel
Date: Mon, 25 Feb 2013 16:56:15 +0100
Message-ID: <CAN+gG=E3UHic+SEObpcuE30KvjXcw4Wc3YFqahL=HjY9pFX_+w@mail.gmail.com>
References: <512B7C90.4010704@displax.com>
	<CAN+gG=HUhwX6EpMrO9itWJ2pC6Zc6e17aZBp4jG1PO017ew8xA@mail.gmail.com>
	<512B86C5.4020408@displax.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-la0-f41.google.com ([209.85.215.41]:60992 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759896Ab3BYP4R (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 25 Feb 2013 10:56:17 -0500
Received: by mail-la0-f41.google.com with SMTP id fo12so2847207lab.14
        for <linux-input@vger.kernel.org>; Mon, 25 Feb 2013 07:56:15 -0800 (PST)
In-Reply-To: <512B86C5.4020408@displax.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Nuno Santos <nsantos@displax.com>
Cc: linux-input@vger.kernel.org

On Mon, Feb 25, 2013 at 4:44 PM, Nuno Santos <nsantos@displax.com> wrote:
> Hi Benjamin,
>
> From my understanding, with upstreamed you mean, putting the source on the
> kernel tree.

Yeah.

>
> In fact, I would love to have the driver on the kernel source but right now
> we still rely on a internal lib for data processing and touch tracking which
> we wont make it public. If it is ok to make an the upstream of this driver
> accompanied with a static lib, we might consider that case.

Definitively not ok. I don't think this kind of things are allowed.

For the tracking, either forwards your events by following the
multitouch protocol A, or use the already in-kernel tracker (see
https://patchwork.kernel.org/patch/1395721/ )

>
> We are working on complete standalone device that will make touch data
> processing in place communicating via HID to the host. By that time that
> driver will be on kernel source.

If you are relying on HID for the communication, please use the
standard Microsoft wrote: your device will be handled for free through
hid-multitouch. I can give you some help with the protocol if you
need.

>
> Regarding the questions arised, i'm happy and sad at the same time. Happy to
> know that this is not a bug from the driver. Sad to know that this is an
> Ubuntu problem due to their decisions.
>
> Thanks for the quick reply.

You're welcome,
Benjamin


> On 02/25/2013 03:31 PM, Benjamin Tissoires wrote:
>>
>> Hi Nuno,
>>
>> On Mon, Feb 25, 2013 at 4:00 PM, Nuno Santos <nsantos@displax.com> wrote:
>>>
>>> Hi,
>>>
>>> I have been experiencing an issue with a Linux driver for multitouch
>>> input
>>> that i'm responsible for maintaining.
>>
>> Side note. Your driver does not seems to be upstreamed (or I missed
>> it). You should really consider put it upstream. If we make changes in
>> the multitouch API, we can change your driver too, whereas here, you
>> will have to maintain several releases of your driver, one per kernel
>> version.
>>
>>> The issue is basically the following:
>>>
>>> - I load the driver and the mouse works just fine
>>> - I touch the screen and the first touch input is delivered to the system
>>> - On that very same moment I can't use mouse left button down to click on
>>> folders on nautilus. I can only selected them using drag select. I also
>>> can't get a folder to get selected with a single touch input.
>>> - The user experience with the mouse gets inconsistent.
>>> - Unloading the module doesn't return the good experience
>>> - Restarting X fixes the problem until I report a touch input again with
>>> this driver
>>> - If I only use common pointer input, the issue doesn't occur.
>>>
>>> My questions resides in if the problem is due to bad touch reporting, or
>>> due
>>> to a bug in X/nautilus.
>>
>> Definitively X and nautilus problems. The very same kind of problems
>> were observed in Fedora 17 and fixed in the X.org shipped in Fedora
>> 18.
>>
>> Ubuntu is relying on an older X.org release, which contains several
>> bugs related to multitouch.
>>
>>> I have been analyzing a lot of examples under kernel tree for multitouch
>>> input under Linux an it seems I'm doing what is necessary.
>>>
>>> I'm using Ubuntu 12.04 but this happened with Ubuntu 11.XX already
>>
>> And in 12.10 also IIRC. I really hope that they will rebase X.org in
>> 13.04.
>>
>>> This what I do in order to declare device capabilities:
>>>
>>> input_set_abs_params(input_dev, ABS_X, 0, 6300, 0, 0);
>>> input_set_abs_params(input_dev, ABS_Y, 0, 6300, 0, 0);
>>>
>>> input_mt_init_slots(input_dev, DPX_TOUCH_MAX_COUNT);
>>
>> input_mt_init_slots has been changed recently, it takes an extra arg:
>> 'flags'.
>>
>>> input_set_abs_params(input_dev, ABS_MT_POSITION_X, 0, 6300, 0, 0);
>>> input_set_abs_params(input_dev, ABS_MT_POSITION_Y, 0, 6300, 0, 0);
>>
>> Not required IIRC. The params are copied from their single-touch
>> equivalent.
>>
>>> This is what I do in order to report touches:
>>>
>>> for (currentTouch=0;currentTouch<DPX_TOUCH_MAX_COUNT &&
>>> touchCount<priv->context->State.Acquisition.TouchPoints;++currentTouch)
>>>      {
>>>          Touch = priv->context->State.Touches + currentTouch;
>>>
>>>          x = Touch->CalibratedPoint.Position.X;
>>>          y = Touch->CalibratedPoint.Position.Y;
>>>
>>>          input_mt_slot(usbtouch->input, currentTouch);
>>>
>>>          // touch down
>>>          if(Touch->CurrentState==DPX_TOUCH_STATE_ACTIVE &&
>>> Touch->ReportedState==DPX_TOUCH_STATE_INACTIVE)
>>>          {
>>>              Touch->ReportedState = DPX_TOUCH_STATE_ACTIVE;
>>>
>>>              input_mt_report_slot_state(usbtouch->input, MT_TOOL_FINGER,
>>> 1);
>>>
>>>              input_report_abs(usbtouch->input, ABS_MT_POSITION_X, x);
>>>              input_report_abs(usbtouch->input, ABS_MT_POSITION_Y, y);
>>>
>>>              touchCount++;
>>>          }
>>>          // touch move
>>>          else if (Touch->CurrentState==DPX_TOUCH_STATE_ACTIVE &&
>>> Touch->ReportedState==DPX_TOUCH_STATE_ACTIVE)
>>>          {
>>>              Touch->ReportedState = DPX_TOUCH_STATE_ACTIVE;
>>>
>>>              input_mt_report_slot_state(usbtouch->input, MT_TOOL_FINGER,
>>> 1);
>>>
>>>              input_report_abs(usbtouch->input, ABS_MT_POSITION_X, x);
>>>              input_report_abs(usbtouch->input, ABS_MT_POSITION_Y, y);
>>>
>>>              touchCount++;
>>>          }
>>>          // touch up
>>>          else
>>>          {
>>>              Touch->ReportedState = DPX_TOUCH_STATE_INACTIVE;
>>>
>>>              input_mt_report_slot_state(usbtouch->input, MT_TOOL_FINGER,
>>> 0);
>>>
>>>              input_report_abs(usbtouch->input, ABS_MT_POSITION_X, x);
>>>              input_report_abs(usbtouch->input, ABS_MT_POSITION_Y, y);
>>
>> No need to update ABS_MT_POSITION_X/Y in this case: they should not be
>> sent to the user space according to the multitouch protocol.
>>
>>>              touchCount++;
>>>          }
>>>      }
>>>
>>>      if (touchCount>0)
>>
>> Looks like this test is always true.
>>
>>>      {
>>>          input_mt_report_pointer_emulation(usbtouch->input, true);
>>
>> In the latest version of the kernel tree, you should rely on the
>> input_mt_sync_frame() now. It will call
>> input_mt_report_pointer_emulation() plus other things depending of the
>> flags you passed to input_mt_init_slots().
>>
>>>          input_sync(usbtouch->input);
>>>      }
>>>
>>>
>> Cheers,
>> Benjamin
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-input" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
