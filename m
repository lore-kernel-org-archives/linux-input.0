From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH RFC] hid-input: add support for HID devices reporting
 Battery Strength
Date: Wed, 23 Nov 2011 13:07:13 -0800
Message-ID: <4ECD6081.6080003@goop.org>
References: <4EC75224.7070207@goop.org> <alpine.LNX.2.00.1111191212140.15187@pobox.suse.cz> <4EC820F8.4070900@goop.org> <alpine.LNX.2.00.1111201110480.15187@pobox.suse.cz> <4ECA7E7D.80207@goop.org> <alpine.LNX.2.00.1111220028130.28728@pobox.suse.cz> <4ECAE019.4000409@goop.org> <alpine.LNX.2.00.1111220049470.28728@pobox.suse.cz> <4ECCB38A.8000503@goop.org> <4ECD20FB.7030705@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from claw.goop.org ([74.207.240.146]:53963 "EHLO claw.goop.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752957Ab1KWVHR (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 23 Nov 2011 16:07:17 -0500
In-Reply-To: <4ECD20FB.7030705@canonical.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chase Douglas <chase.douglas@canonical.com>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, vojtech@ucw.cz, Przemo Firszt <przemo@firszt.eu>

On 11/23/2011 08:36 AM, Chase Douglas wrote:
> On 11/23/2011 12:49 AM, Jeremy Fitzhardinge wrote:
>> Some HID devices, such as my Bluetooth mouse, report their battery
>> strength as an event.  Rather than passing it through as a strange
>> absolute input event, this patch registers it with the power_supply
>> subsystem as a battery, so that the device's Battery Strength can be
>> reported to usermode.
>>
>> The battery appears in sysfs names
>> /sys/class/power_supply/hid-<UNIQ>-battery, and it is a child of the
>> battery-containing device, so it should be clear what it's the battery of.
>>
>> Unfortunately on my current Fedora 16 system, while the battery does
>> appear in the UI, it is listed as a Laptop Battery with 0% charge (since
>> it ignores the "capacity" property of the battery and instead computes
>> it from the "energy*" fields, which we can't supply given the limited
>> information contained within the HID Report).
>>
>> Still, this patch is the first step.
>>
>> Signed-off-by: Jeremy Fitzhardinge <jeremy@goop.org>
>>
>> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
>> index 22a4a05..3a97f1f 100644
>> --- a/drivers/hid/Kconfig
>> +++ b/drivers/hid/Kconfig
>> @@ -31,6 +31,11 @@ config HID
>>  
>>  	  If unsure, say Y.
>>  
>> +config HID_BATTERY_STRENGTH
>> +	bool
>> +	depends on POWER_SUPPLY
>> +	default y
> This functionality will be great to have :). I'm curious why you made a
> config option for it, though. It's not a big patch, I can't think of any
> reason people wouldn't want it, and this could lead to dependency issues
> (i.e. needing to sprinkle #ifdef HID_BATTERY_STRENGTH in drivers).
>

It depends on CONFIG_POWER_SUPPLY, and I guess its possible that people
may want to unconfig it because the extra power supplies confuse
usermode (as they do Gnome 3, but non-fatally).  I'm just worried that
something might want to start hibernating my machine because the mouse
is running out :/...

However, I left it as a non-user-visible config option so that it
doesn't create any more noise on that front.

The Wacom driver's version of this also has its own user-visible config
option; I don't know if there's any reason you'd turn it off.

    J
