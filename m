From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH 2/2] i2c-hid: remove mostly useless parameter 'debug'
Date: Fri, 02 Aug 2013 20:42:40 +0200
Message-ID: <51FBFDA0.4010205@redhat.com>
References: <1375441636-12921-1-git-send-email-andriy.shevchenko@linux.intel.com>   <1375441636-12921-2-git-send-email-andriy.shevchenko@linux.intel.com>   <CAN+gG=Ec=jJy7HxRW08up+=Z8C0Lz4B8bhPcP+7__zuONnCAgw@mail.gmail.com>  <1375454987.31118.77.camel@smile> <51FBF71E.1040802@redhat.com> <1375468274.31118.87.camel@smile>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:28957 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753674Ab3HBSmq (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 2 Aug 2013 14:42:46 -0400
In-Reply-To: <1375468274.31118.87.camel@smile>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-input <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>, Mika Westerberg <mika.westerberg@linux.intel.com>

On 02/08/13 20:31, Andy Shevchenko wrote:
> On Fri, 2013-08-02 at 20:14 +0200, Benjamin Tissoires wrote: 
>> On 02/08/13 16:49, Andy Shevchenko wrote:
>>> On Fri, 2013-08-02 at 16:30 +0200, Benjamin Tissoires wrote: 
> 
> []
> 
>>>> Moreover, the dev_dbg calls are compiled out if DEBUG symbol is not
>>>> set.
>>>
>>> Yes, and what is the difference between previously used
>>> if (debug)
>>>   dev_dbg(...)
>>>
>>> ?
>>
>> That's because the previous code was directly using
>> dev_printk(KERN_DEBUG,...) and not dev_dbg() within the condition.
>>
>> This call does not use dynamic debugging or does not get compiled out if
>> DEBUG is not set.
> 
> Yeah, I've checked this just after I sent the message.
> 
>> Also, to my defence, I can add that I developed this driver on an ARM
>> board without dynamic debugging support enabled... :)
> 
> 
> So, the problem is DYNAMIC_DEBUG is not default option in kernel (and I
> could imagine why).
> 
> I checked few distros for that: Debian/Ubuntu - off,
> Fedora/OpenSuse/ArchLinux - on.
> 
> Just to understand what kind of user might run this with debug? Is it
> developer or person who knows the subject? If it's not a such person, it
> would be difficult  to him or her to enable dynamic debug in distros
> like Ubuntu, which sucks.

I'm afraid people reporting this kind of bugs are most of the time
regular users, who just bought a brand new laptop, and who send a bug
report through their distribution's bugzilla... :(
I'm not expecting that much of developers or person who knows the
subject to actually report the problem, because most of the time a
normal user reports "my touchpad is not working". At least, that's what
I have mostly seen in the input subsystem.

> 
>>>> So, if we ever have to change this debug variable, I would prefer
>>>> using the hid debug environment which would at least limit the number
>>>> of debug outputs to the HID subsystem.
>>>
>>> Usually when I see such code I understood it was written in
>>> pre-dynamic-debug epoch. So, my point is to switch to dynamic debug and
>>> use it efficiently.
>>
>> Ok, so if you can guarantee me that adding the proper kernel parameter
>> will allow me to retrieve all the i2c-hid logs from the boot, then I'd
>> be happy to ack this. However, I have no way to test this right now, so
>> I'll need to trust you (that's why I'm asking you to do proper testing).
> 
> With only one condition if dynamic debug is enabled in kernel.
> So, it would be nice to gather opinions, however, the decision is
> totally depends on type of user who wants to debug the module.
> 

Yep, I agree that Jiri's opinion would be helpful.

Meanwhile, we could also wait a little for more i2c-hid to hit the
market and to be widely tested, and then remove the debug flag. We
should also remove the debug events in get_i2c_hid_get_input() which
would pollute systems without dynamic debugging but with the DEBUG
config still enabled.

Cheers,
Benjamin
