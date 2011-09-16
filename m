From: Jason Gerecke <killertofu@gmail.com>
Subject: Re: [PATCH] Input: wacom - Add POINTER and DIRECT device properties
Date: Fri, 16 Sep 2011 14:45:20 -0700
Message-ID: <CANRwn3TstEAhgt5=Sxu6KMOyu3rtC9CCeQWU7Qa5-jRXUfgBdw@mail.gmail.com>
References: <1314892843-1475-1-git-send-email-killertofu@gmail.com>
	<20110913080911.GA4986@polaris.bitmath.org>
	<CAPHpN5OAPdPQ1SmwrGT6pMvgWESBOSnRvb0jKUszkU_31MFXWg@mail.gmail.com>
	<20110914071524.GA3422@polaris.bitmath.org>
	<CAF8JNhKFz8-bJ4HMguU2qReageX4WBB1bWR0amRbYmaujNVX8A@mail.gmail.com>
	<20110916105036.GA4455@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:65472 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754865Ab1IPVpV (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 16 Sep 2011 17:45:21 -0400
Received: by wwf22 with SMTP id 22so5617822wwf.1
        for <linux-input@vger.kernel.org>; Fri, 16 Sep 2011 14:45:20 -0700 (PDT)
In-Reply-To: <20110916105036.GA4455@polaris.bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Ping Cheng <pinglinux@gmail.com>, Mohamed Ikbel Boulabiar <boulabiar@gmail.com>, Linux Input <linux-input@vger.kernel.org>

On Fri, Sep 16, 2011 at 3:50 AM, Henrik Rydberg <rydberg@euromail.se> wrote:
>> > I think the bottom line is that even if the "directness" of a device
>> > is configurable, it still needs to have a default. Moreover, the
>> > notion of kernel mode settings could be applicable here too.
>>
>> Talking about default mode, there are cases that the mode is decided
>> by the tools running on the device/tablet, instead of the tablet
>> itself.
>>
>> Take Wacom's Intuos and Graphire series for example, those tablets
>> support both styli and mice. For styli, the default is absolute mode;
>> while for mice, it is relative. So, only valid property the tablet can
>> tell the user-land is: I am a tablet, i.e., not a touchscreen. Clients
>> have to check the tool types to set the default mode to relative
>> (BTN_TOOL_MOUSE/LENS) or absolute (BTN_TOOL_PEN/AIRBRUSH/RUBBER...).
>
> And those modes can be determined using the available axes. However,
> when all axes are the same, a statement like "I am a tablet" does not
> exist. In that case, distinguishing between touchscreen, touchpad and
> tablet becomes a question of interpreting the properties. Such a
> distinction cannot be achieved using a single bit of information, and
> that was never the intention.
>
It is certainly true that you cannot separate out the different cases
with a single bit. The more properties and hints we can expose to
userspace the better. However, at the device level, there's only so
much information we *can* expose. We know if its a direct input device
or not. We don't know if its relative or absolute, since that depends
on the tool in use at any given moment.

To be honest, I'm not sure why we need to further disambiguate
touchpads and tablets (though I'd be interested in finding out). From
what I can tell, the difference between a touchpad and a tablet is in
the tools they use; identical tools (i.e. BTN_TOOL_FINGER) should have
identical absoluteness. The absoluteness of tool would depends on what
it is (BTN_TOOL_FINGER is relative, BTN_TOOL_PEN is absolute) and if
the underlying device is a direct input device (if it is, all tools
are absolute) -- not on some arbitrarily distinction between
"touchpad" and "tablet".

On Tue, Sep 13, 2011 at 1:54 PM, Chris Bagwell <chris@cnpbagwell.com> wrote:
>> Reporting it as DIRECT indicates it can only be used as DIRECT. We
>> don't want client to make that assumption. User-land clients can
> > distinguish a touch POINTER from a pen POINTER by the tool types.
>
> I see your logic now and patch does follow that logic.
>
> I can actually buy into that although it seems to make the need for
> both POINTER and DIRECT redundant. Touchscreen = DIRECT while Tablet
> (pen, touch, or both) = POINTER.  No overlap.

I agree that this interpretation makes having both POINTER and DIRECT
set somewhat redundant. However, displaying a pointer for direct input
devices can be useful provided the tool does not obscure the pointer.
Devices which are designed for use with fine-tipped tools but suffer
from parallax error may wish to display the pointer by default to
improve usability.

Jason

---
Day xee-nee-svsh duu-'ushtlh-ts'it;
nuu-wee-ya' duu-xan' 'vm-nvshtlh-ts'it.
Huu-chan xuu naa~-gha.
