From: Randy Dunlap <rdunlap@xenotime.net>
Subject: Re: disable touchpad?
Date: Fri, 24 Feb 2012 17:49:19 -0800
Message-ID: <4F483E1F.1080605@xenotime.net>
References: <4F47ED34.1070406@xenotime.net> <1396991.aDtuZKT2u4@dtor-d630.eng.vmware.com> <4F480EBA.7020509@canonical.com> <20120224223752.GA9883@ubuntu-macmini>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from oproxy3-pub.bluehost.com ([69.89.21.8]:38200 "HELO
	oproxy3-pub.bluehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1757169Ab2BYBtU (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 24 Feb 2012 20:49:20 -0500
In-Reply-To: <20120224223752.GA9883@ubuntu-macmini>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Seth Forshee <seth.forshee@canonical.com>
Cc: Chase Douglas <chase.douglas@canonical.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

On 02/24/2012 02:37 PM, Seth Forshee wrote:

> On Fri, Feb 24, 2012 at 02:27:06PM -0800, Chase Douglas wrote:
>> On 02/24/2012 01:31 PM, Dmitry Torokhov wrote:
>>> On Friday, February 24, 2012 12:04:04 PM Randy Dunlap wrote:
>>>> (b) My Toshiba Portege laptop has a touchpad on/off button.  Is that
>>>> supported?
>>>
>>> Kernel probably emits one of KEY_TOUCHPAD_* for it; whether it is handled
>>> in userspace I do not know.

showkey doesn't show me any kbd scancode when I press that little key.  :(

At least using 'xinput set-prop 15 "Device Enabled" 0' (from the Ubuntu
community web page) does work.  That's helpful.


>> I have heard from some of our engineers who have looked into this
>> that the interface for these buttons is not standardized. Sometimes
>> the buttons turn off the touchpad in hardware. Sometimes they emit
>> events that tell the OS to turn it off, and the OS needs to know how
>> to handle it.
>>
>> On top of that, LEDs are sometimes there to tell you if the trackpad
>> is on or off. These are also not standardized. Sometimes they are
>> hooked up to the hardware, and when the hardware is off they go off.
>> Sometimes they are just a plain old LED and the OS needs to turn it
>> on and off.
>>
>> Fun...
> 
> I've worked with a few Toshibas, and while there's quite a bit of
> variation within Toshiba models, all the ones I've seen report a key
> event rather than disabling the touchpad in firmware. Some of them
> report the key on the AT keyboard while others use a Toshiba-specific
> ACPI interface.
> 
> Randy, if you can't find a key event currently being emitted on your
> machine, I have some patches for toshiba_acpi to enable hotkeys for some
> Toshibas [1].  You might give them a try.
> 
> Seth
> 
> [1] https://lkml.org/lkml/2012/1/18/328


OK, I'll take a look at those patches.

Thanks, everyone.

-- 
~Randy
