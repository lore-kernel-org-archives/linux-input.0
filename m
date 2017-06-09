From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: Two regressions on BYT/T ASUS T100TA 4.12-rc: #2 Keyboard no
 longer works
Date: Fri, 9 Jun 2017 09:35:34 +0200
Message-ID: <0d3a087b-ee57-05be-a32a-a5610127db71@redhat.com>
References: <20170608203904.73abb5e1@lxorguk.ukuu.org.uk>
 <Pine.LNX.4.44L0.1706081545040.1949-100000@iolanthe.rowland.org>
 <CA+55aFzhO9fPORL_yKFFuS-q2WbsjeT7_f_uorUN9ZnXVkH3qw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44990 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751575AbdFIHfk (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 9 Jun 2017 03:35:40 -0400
In-Reply-To: <CA+55aFzhO9fPORL_yKFFuS-q2WbsjeT7_f_uorUN9ZnXVkH3qw@mail.gmail.com>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, Alan Stern <stern@rowland.harvard.edu>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Greg KH <greg@kroah.com>, USB list <linux-usb@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Hi,

First of all lets add the HID subsys maintainers to the To list (done).

On 08-06-17 22:17, Linus Torvalds wrote:
> On Thu, Jun 8, 2017 at 12:49 PM, Alan Stern <stern@rowland.harvard.edu> wrote:
>>
>> So maybe CONFIG_HID_ASUS should default to Y?  I'll leave it up to Hans
>> to straighten this out.
> 
> No, I think the main problem is that the hid_have_special_driver[]
> array change is garbage.
> 
> It adds the ASUS ID, regardless of whether the special driver exists or not.
> 
> We *really* shouldn't do that. We had a very similar regression wrt
> the "improved" synaptics RMI handling in commit 279967a65b32.
> 
> If you didn't have HID_RMI enabled at all, that commit made the
> regular HID driver not take care of the device, and without an RMI
> driver there was nothing else that took care of it either.
> 
> So when you add things like "don't react to this device", you damn
> well should make sure that something else *does* react to the device
> instead.
> 
> So those ASUSTEK entries that get disabled in hid-core.c should be
> protected by something like
> 
>    #if IS_ENABLED(CONFIG_HID_ASUS)
>      ...
>    #endif
> 
> exactly so that the core HID subsystem doesn't ignore them when
> nothing else picks up the slack.
> 
> I note that *some* cases do do that. Too few, apparently.
> 
> PLEASE STOP THIS MINDLESS "DISABLE GENERIC DEVICE DISCOVERY" CRAP!
> 
> It's only ok to disable a generic device if you actually have a real
> working fallback that is actually enabled!
> 
> So that commit 76dd1fbebbae ("HID: asus: Add support for T100
> keyboard") is actively buggy, because it incorrectly assumes a
> particular config.

Right, so this is not really a problem with this specific patch,
but with how the hid_have_special_driver array works in general
currently it has very few #if IS_ENABLED(CONFIG_FOO) guards
around all the devices it blacklists the generic HID driver for.

I think this is on purpose to stop things becoming one big
#ifdef party, but as you rightfully say this means that people
may end up with not having a driver at all.

Some device-specific drivers have this in their Kconfig:

         default !EXPERT

Which the HID_ASUS entry lacks.

Jiri, Benjamin, how do you want to solve this ?

Regards,

Hans


