From: Goffredo Baroncelli <kreijack@inwind.it>
Subject: Re: Driver for Logitech M560
Date: Fri, 05 Sep 2014 19:47:44 +0200
Message-ID: <5409F740.9000706@inwind.it>
References: <5404C6F4.1000800@inwind.it> <CAN+gG=HMUJBWQj65OKRfoPiyzzRPXLVveA6V2S_a1dSJXKJc3g@mail.gmail.com>
Reply-To: kreijack@inwind.it
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from outrelay06.libero.it ([212.52.84.110]:51629 "EHLO
	outrelay06.libero.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750772AbaIERlO (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 5 Sep 2014 13:41:14 -0400
In-Reply-To: <CAN+gG=HMUJBWQj65OKRfoPiyzzRPXLVveA6V2S_a1dSJXKJc3g@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: Nestor Lopez Casado <nlopezcasad@logitech.com>, HID CORE LAYER <linux-input@vger.kernel.org>

On 09/03/2014 11:36 PM, Benjamin Tissoires wrote:
> Hi Goffredo,
> 
> On Mon, Sep 1, 2014 at 3:20 PM, Goffredo Baroncelli <kreijack@inwind.it> wrote:
>> Hi Benjamin,
>>
>> following the Nestor suggestion, I rewrote the driver for the
>> mouse Logitech M560 on the basis of your work (branch "for-whot").
> 
> Just for the record. This branch is located here:
> https://github.com/bentiss/hid-logitech-dj/tree/for-whot and I
> *really* need to finish this work so that everything can go upstream
> :(

:-) For me this is not a problem. I solved my issue (I made a dkms
package for this mouse), but I want to share my effort..

> 
>>
>> The Logitech M560 is is a mouse designed for windows 8.
>> Comparing to a standard one, some buttons (the middle one and the
>> two ones placed on the side) are bounded to a key combination
>> instead of a classic "mouse" button.
>>
>> Think this mouse as a pair of mouse and keyboard. When the middle
>> button is pressed the it sends a key (as keyboard)
>> combination, the same for the other two side button.
>> Instead the left/right/wheel work correctly.
>> To complicate further the things, the middle button send a
>> key combination the odd press, and another one for the even press;
>> in the latter case it sends also a left click. But the worst thing
>> is that no event is generated when the middle button is released.
>>
>> Moreover this device is a wireless mouse which uses the unifying
>> receiver.
>>
>> I discovered that it is possible to re-configure the mouse
>> sending a command (see function m560_send_config_command()).
>> After this command the mouse sends some sequence when the
>> buttons are pressed and/or released (see comments for
>> an explanation of the mouse protocol).
>>
>> If the mouse is "silent" (no data is sent) for more than
>> PACKET_TIMEOUT seconds (currently 10), when the next packet
>> comes, the driver try to reconfigure it.
>> This because it is possible that the mouse is switched-off
>> and lost its setting. Se we need to reconfigure.
> 
> This just looks weird. I am pretty sure we managed to properly tackle
> that for the touchpads, there should not be any difference with the
> mouse. Or maybe we did not?
> Anyway, calling this every timeout is not a good solution IMO.

I looked at the wtp source, and I was not able to find anything.
Anyway I will remove the reset-by-timeout; eventually I split this
in another patch for further development
> 
> 
>>
>> Benjamin, I have to highlight three things:
>> when the dj driver detects a disconnection, it
>> sends a sequence like
>>
>>   0x01 0x00 0x00 0x00 0x00 0x00 0x00 ...
>>   0x02 0x00 0x00 0x00 0x00 0x00 0x00 ...
>>
>> because the mouse is both a keyboard (0x01) and
>> a mouse (0x02). But this sequence is a valid one
>> (when two buttons are released) due to the strangeness
>> of the protocol.
>>
>> Can I suggest to send in these case a sequence like
>>
>>   <device_type> 0xff 0xff 0xff 0xff 0xff 0xff....
>>
>> ? I suspect that this would be less common.
> 
> Nope. This does not work. The idea behind sending the "null" report is
> that this report will reset the current state of the keyboards/mice by
> sending a "all buttons are now released" event. It is _not_ designed
> as a marker that the device has been disconnected.
> 
> If you need this info, then another mechanism has to be used.

Have you any suggestions ?

> 
>>
>> Another thing that seemed strange to me is that report
>> with ID equal 0x20 and 0x21 are handled so the packet
>> are forwarded to the driver from the 3rd byte onward.
> 
> Yes. 0x20 and 0x21 are DJ reports, which encapsulate a mouse/keyboard
> report coming from the DJ device.
> To be properly handled by the final driver, we have to remove the
> encapsulation fields so that the reports are just plain HID.
> 
>> In the others cases (this mouse send also packet with
>> ID=0x11) the report id forwarded as is (without
>> by-passing the first two bytes). It is the expected
>> behaviour, or the code was written on the basis the
>> assumption that the devices send ID=0x20/0x21 and the
>> other ID are sent only by the receiver ?
> 
> No. The 0x10/0x11 reports are from the HID++ Logitech-specific
> implementation, and must be forwarded as is. They have to be handled
> as such by the final driver, and so, they must keep their report ID.

Ok, I don't have any problem about that. I want to be sure that it
is intentionally and not an hole discovered due to the M560 mouse 
protocol.

> 
>>
>> Finally I have to point out that to work, this driver
>> has to be inserted BEFORE the hid_logitech_dj
>>
>> In fact I had to add a file /etc/modprobe.d/hid-logitech_dj.conf
>> as below
>>
>> install hid_logitech_dj modprobe hid_logitech_m560; sleep 5s ; modprobe --ignore-install hid_logitech_dj
>>
>> It is possible that the "sleep 5s" is not needed.
> 
> Hmm. This might be because there are some conflicts between your
> current install and the one you just changed. I would not worry about
> that. When this work will land upstream, there will be not problems.
> 
> I still did not decided if I am going to take this right now into the
> github tree or not (and make a deeper review).
> 
> BTW, there is no need to send such patch to the LKML currently, you
> are working against my non upstream branch. What you can do is either
> setup a github clone with your patch/modifications if you want to
> share them, or I can also pull this in a separate branch.

Ok, I will prepare (I hope this week-end) a github repo for a pull.
Let me to remove the reset-by-timeout code.

> 
> Once I'll finish the changes I want to do to hid-logitech-dj and
> hid-logitech-hidpp, then we can think of merging that in my
> submission.
> Sorry, I still need a little bit of time to finish up this work.

Ok, thanks

> Cheers,
> Benjamin
> 
[... cut ... cut ... ]

G.Baroncelli

-- 
gpg @keyserver.linux.it: Goffredo Baroncelli (kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
