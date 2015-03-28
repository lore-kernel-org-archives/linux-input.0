From: Michael Leuchtenburg <michael@slashhome.org>
Subject: Windows Precision Touchpad support
Date: Sat, 28 Mar 2015 18:11:02 -0400
Message-ID: <CABfYTXR4T2udK1dX2j9FhOUFkQKQ35P4Ra4SqixgqYqkNoMXPQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from vervet.isomerica.net ([216.93.242.12]:47756 "EHLO
	vervet.isomerica.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752372AbbC1WLE (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 28 Mar 2015 18:11:04 -0400
Received: from mail-ig0-f176.google.com (mail-ig0-f176.google.com [209.85.213.176])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by vervet.isomerica.net (Postfix) with ESMTPSA id ECF8A20E4BF47
	for <linux-input@vger.kernel.org>; Sat, 28 Mar 2015 18:11:02 -0400 (EDT)
Received: by igbud6 with SMTP id ud6so47166261igb.1
        for <linux-input@vger.kernel.org>; Sat, 28 Mar 2015 15:11:02 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

I have been trying to figure out how to get palm detection working on
my new Dell XPS 13 9343. It has a Windows Precision Touchpad (PTP)
compliant touchpad; I think it's a Synaptics rebrand. DLL0665:01
06CB:76AD UNKNOWN; that 06CB definitely indicates it's Synaptics under
there.

I've been trying to figure out if it's not sending information along
that could be used to determine if a touch is intentional or
unintentional or if the Linux drivers - either kernel or userspace -
just don't support what it's sending. PTP devices must send at least
"confidence", which is used to indicate that a touch is not a finger.
They may also send width and height which could be used for detection.
It doesn't look like confidence is supported by Linux currently.

In trying to figure this out, I looked at the HID descriptor and
noticed that it's not reporting itself as a PTP but rather as a mouse.
This is actually as expected for an PTP compliant device which hasn't
been initialized fully - according to
https://msdn.microsoft.com/en-us/library/windows/hardware/dn467314(v=vs.85).aspx
devices are supposed to use the Mouse Collection for input reporting
until the input mode is set to touchpad, after which they're supposed
to switch to the Windows Precision Touchpad Collection.

It looks like the hid-multitouch driver generally doesn't set the
input mode on devices to MT_INPUTMODE_TOUCHPAD (0x3). By default it
sets it to MT_INPUTMODE_TOUCHSCREEN (0x2) in mt_probe. It does also
set it to MT_INPUTMODE_TOUCHAD (0x3) in mt_touch_input_mapping, though
I haven't traced through to see if that actually gets written out to
the device or is just used by the driver to determine how to interpret
various events.

Have I missed something? Is it actually being initialized to PTP mode
and rdesc just isn't being updated? That would probably lead to
misinterpreting some events since the event collections are very
different, so it seems unlikely. Is there some condition under which
it does get initialized to PTP mode?

If I'm right and this mode just isn't supported currently, is anyone
working on this functionality? I'd rather not duplicate effort.

Cheers,
Michael
