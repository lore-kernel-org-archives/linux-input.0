From: Michael Leuchtenburg <michael@slashhome.org>
Subject: Re: Windows Precision Touchpad support
Date: Sun, 29 Mar 2015 11:23:51 -0400
Message-ID: <CABfYTXTNVTDT2SxqMakJd=RMMG9=FM5RziBBorj3-kR0wPfM2Q@mail.gmail.com>
References: <CABfYTXR4T2udK1dX2j9FhOUFkQKQ35P4Ra4SqixgqYqkNoMXPQ@mail.gmail.com>
	<CAN+gG=FDEGasZQixmATQ-jSe2we6uEez_c6wocii+GTxwi-orw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from vervet.isomerica.net ([216.93.242.12]:36778 "EHLO
	vervet.isomerica.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752327AbbC2PXx (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 29 Mar 2015 11:23:53 -0400
Received: from mail-ig0-f177.google.com (mail-ig0-f177.google.com [209.85.213.177])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by vervet.isomerica.net (Postfix) with ESMTPSA id 8409620E2AE7A
	for <linux-input@vger.kernel.org>; Sun, 29 Mar 2015 11:23:52 -0400 (EDT)
Received: by ignm3 with SMTP id m3so58309048ign.0
        for <linux-input@vger.kernel.org>; Sun, 29 Mar 2015 08:23:51 -0700 (PDT)
In-Reply-To: <CAN+gG=FDEGasZQixmATQ-jSe2we6uEez_c6wocii+GTxwi-orw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: linux-input <linux-input@vger.kernel.org>

Hi Benjamin,

On Sat, Mar 28, 2015 at 8:09 PM, Benjamin Tissoires
<benjamin.tissoires@gmail.com> wrote:
> Hi Michael,
>
> On Sat, Mar 28, 2015 at 6:11 PM, Michael Leuchtenburg
> <michael@slashhome.org> wrote:
>> I have been trying to figure out how to get palm detection working on
>> my new Dell XPS 13 9343. It has a Windows Precision Touchpad (PTP)
>> compliant touchpad; I think it's a Synaptics rebrand. DLL0665:01
>> 06CB:76AD UNKNOWN; that 06CB definitely indicates it's Synaptics under
>> there.
>>
>> I've been trying to figure out if it's not sending information along
>> that could be used to determine if a touch is intentional or
>> unintentional or if the Linux drivers - either kernel or userspace -
>> just don't support what it's sending. PTP devices must send at least
>> "confidence", which is used to indicate that a touch is not a finger.
>> They may also send width and height which could be used for detection.
>> It doesn't look like confidence is supported by Linux currently.
>
> Oh. It looks like I should have spent more time looking into this
> spec. I did not notice that Confidence know has a palm rejection
> meaning. Sigh. For touchscreens, this used to be that until the bit is
> set, the touch might not be an actual touch...

That's based only on the description at
https://msdn.microsoft.com/en-us/library/windows/hardware/dn467314(v=vs.85).aspx
saying "Set when a contact is too large to be a finger". I don't know
if there's a more detailed spec somewhere; if there is, I haven't
found it yet. It's strange that the sense would be inverted for
touchpads vs touchscreens.

Looking at the reports from events in debugfs, I do see confidence set
to 0 when I use my palm and to 1 when I use a finger, so it seems like
it would be useful for unintentional touch detection. Sadly no width,
so user-driven tuning won't be possible. Too bad since it definitely
doesn't catch all sorts of palm touches that I tested.

>>
>> In trying to figure this out, I looked at the HID descriptor and
>> noticed that it's not reporting itself as a PTP but rather as a mouse.
>> This is actually as expected for an PTP compliant device which hasn't
>> been initialized fully - according to
>> https://msdn.microsoft.com/en-us/library/windows/hardware/dn467314(v=vs.85).aspx
>> devices are supposed to use the Mouse Collection for input reporting
>> until the input mode is set to touchpad, after which they're supposed
>> to switch to the Windows Precision Touchpad Collection.
>>
>> It looks like the hid-multitouch driver generally doesn't set the
>> input mode on devices to MT_INPUTMODE_TOUCHPAD (0x3). By default it
>> sets it to MT_INPUTMODE_TOUCHSCREEN (0x2) in mt_probe. It does also
>> set it to MT_INPUTMODE_TOUCHAD (0x3) in mt_touch_input_mapping, though
>> I haven't traced through to see if that actually gets written out to
>> the device or is just used by the driver to determine how to interpret
>> various events.
>
> Well, we do not export the mouse collection, so I can guarantee that
> we are using the PTP collection :)
> You can also be sure by checking at the input node, by running
> evemu-record, and you'll see that we forward the raw touches (like a
> touchscreen), and not the relative axes (like any plain mouse).
>>
>> Have I missed something? Is it actually being initialized to PTP mode
>> and rdesc just isn't being updated? That would probably lead to
>> misinterpreting some events since the event collections are very
>> different, so it seems unlikely. Is there some condition under which
>> it does get initialized to PTP mode?
>
> No, I think you misread the report descriptors. There should be at
> least 2 collections, one for the mouse and one for the raw touchpad.
> We do not change the report descriptors in hid-multitouch so it should
> still be there.

It's true, I do see ABS_X/Y and ABS_MT_POSITION_X/Y. You're right - I
was confused by the continued presence of the mouse collection. Which
I shouldn't have been, since there's one in MS's example, though at
the end rather than the beginning as it is for my device. Sorry, I'm
new to reading HID descriptors. I'm not sure how the driver is telling
it the right mode, but it seems to be. I don't ever see the driver
issuing an input mode feature report to the touchpad when I load
i2c_hid with debug=1, though. It could be that the firmware and
platform designers have special cased Linux in some way. Or I could be
misreading the logs. Regardless, it gets figured out somehow. I do
wonder if it might have a "PTP" and "actually talking to Windows PTP"
mode. The amount of other hardware on this system that has some
detection of Linux vs. Windows is remarkable, so Synaptics having some
special case for Linux wouldn't surprise me at all.

>>
>> If I'm right and this mode just isn't supported currently, is anyone
>> working on this functionality? I'd rather not duplicate effort.
>
> The chromium guys just got their MT_TOOL_PALM patch merged in Dmitri's tree:
> https://git.kernel.org/cgit/linux/kernel/git/dtor/input.git/commit/?h=for-linus&id=a736775db683174269c65c7c5cc8e5ee534e7681
>
> I don't know if they plan to make hid-multitouch aware of it, but that
> seems legitimate to me.
> You are welcome to work on such patches :)

I thought that was just for one particular piece of hardware that was
going to send that tool explicitly. I'll take a closer look at what
they're doing, thanks.

Cheers,
Michael
