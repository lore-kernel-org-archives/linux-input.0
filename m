From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: Windows Precision Touchpad support
Date: Sat, 28 Mar 2015 20:09:37 -0400
Message-ID: <CAN+gG=FDEGasZQixmATQ-jSe2we6uEez_c6wocii+GTxwi-orw@mail.gmail.com>
References: <CABfYTXR4T2udK1dX2j9FhOUFkQKQ35P4Ra4SqixgqYqkNoMXPQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qg0-f42.google.com ([209.85.192.42]:33278 "EHLO
	mail-qg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751749AbbC2AJi (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 28 Mar 2015 20:09:38 -0400
Received: by qgfa8 with SMTP id a8so154922977qgf.0
        for <linux-input@vger.kernel.org>; Sat, 28 Mar 2015 17:09:37 -0700 (PDT)
In-Reply-To: <CABfYTXR4T2udK1dX2j9FhOUFkQKQ35P4Ra4SqixgqYqkNoMXPQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Michael Leuchtenburg <michael@slashhome.org>
Cc: linux-input <linux-input@vger.kernel.org>

Hi Michael,

On Sat, Mar 28, 2015 at 6:11 PM, Michael Leuchtenburg
<michael@slashhome.org> wrote:
> I have been trying to figure out how to get palm detection working on
> my new Dell XPS 13 9343. It has a Windows Precision Touchpad (PTP)
> compliant touchpad; I think it's a Synaptics rebrand. DLL0665:01
> 06CB:76AD UNKNOWN; that 06CB definitely indicates it's Synaptics under
> there.
>
> I've been trying to figure out if it's not sending information along
> that could be used to determine if a touch is intentional or
> unintentional or if the Linux drivers - either kernel or userspace -
> just don't support what it's sending. PTP devices must send at least
> "confidence", which is used to indicate that a touch is not a finger.
> They may also send width and height which could be used for detection.
> It doesn't look like confidence is supported by Linux currently.

Oh. It looks like I should have spent more time looking into this
spec. I did not notice that Confidence know has a palm rejection
meaning. Sigh. For touchscreens, this used to be that until the bit is
set, the touch might not be an actual touch...

>
> In trying to figure this out, I looked at the HID descriptor and
> noticed that it's not reporting itself as a PTP but rather as a mouse.
> This is actually as expected for an PTP compliant device which hasn't
> been initialized fully - according to
> https://msdn.microsoft.com/en-us/library/windows/hardware/dn467314(v=vs.85).aspx
> devices are supposed to use the Mouse Collection for input reporting
> until the input mode is set to touchpad, after which they're supposed
> to switch to the Windows Precision Touchpad Collection.
>
> It looks like the hid-multitouch driver generally doesn't set the
> input mode on devices to MT_INPUTMODE_TOUCHPAD (0x3). By default it
> sets it to MT_INPUTMODE_TOUCHSCREEN (0x2) in mt_probe. It does also
> set it to MT_INPUTMODE_TOUCHAD (0x3) in mt_touch_input_mapping, though
> I haven't traced through to see if that actually gets written out to
> the device or is just used by the driver to determine how to interpret
> various events.

Well, we do not export the mouse collection, so I can guarantee that
we are using the PTP collection :)
You can also be sure by checking at the input node, by running
evemu-record, and you'll see that we forward the raw touches (like a
touchscreen), and not the relative axes (like any plain mouse).

>
> Have I missed something? Is it actually being initialized to PTP mode
> and rdesc just isn't being updated? That would probably lead to
> misinterpreting some events since the event collections are very
> different, so it seems unlikely. Is there some condition under which
> it does get initialized to PTP mode?

No, I think you misread the report descriptors. There should be at
least 2 collections, one for the mouse and one for the raw touchpad.
We do not change the report descriptors in hid-multitouch so it should
still be there.

>
> If I'm right and this mode just isn't supported currently, is anyone
> working on this functionality? I'd rather not duplicate effort.

The chromium guys just got their MT_TOOL_PALM patch merged in Dmitri's tree:
https://git.kernel.org/cgit/linux/kernel/git/dtor/input.git/commit/?h=for-linus&id=a736775db683174269c65c7c5cc8e5ee534e7681

I don't know if they plan to make hid-multitouch aware of it, but that
seems legitimate to me.
You are welcome to work on such patches :)

Cheers,
Benjamin
