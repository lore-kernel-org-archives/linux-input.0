From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH 4/4] HID: remove ThingM blink(1) driver
Date: Wed, 22 Jun 2016 21:54:14 +0200
Message-ID: <f9d5885f-b0a2-6343-f88d-693b891b0464@gmail.com>
References: <f8c59082-d76c-73aa-70b6-7454b731a055@gmail.com>
 <alpine.LNX.2.00.1606221520340.6874@cbobk.fhfr.pm>
 <87twglqlfq.fsf@ketchup.mtl.sfl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33006 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750835AbcFVTy2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 22 Jun 2016 15:54:28 -0400
In-Reply-To: <87twglqlfq.fsf@ketchup.mtl.sfl>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Vivien Didelot <vivien.didelot@savoirfairelinux.com>, Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Am 22.06.2016 um 17:42 schrieb Vivien Didelot:
> Hi,
> 
> Jiri Kosina <jikos@kernel.org> writes:
> 
>> On Tue, 21 Jun 2016, Heiner Kallweit wrote:
>>
>>> Now that support for ThingM blink(1) was merged into the hid-led driver
>>> the dedicated driver for this device can be removed.
>>>
>>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>>> ---
>>>  drivers/hid/Kconfig      |  10 --
>>>  drivers/hid/Makefile     |   1 -
>>>  drivers/hid/hid-thingm.c | 259 -----------------------------------------------
>>>  3 files changed, 270 deletions(-)
>>>  delete mode 100644 drivers/hid/hid-thingm.c
>>>
>>> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
>>> index ab22090..6b08a3b 100644
>>> --- a/drivers/hid/Kconfig
>>> +++ b/drivers/hid/Kconfig
>>> @@ -828,16 +828,6 @@ config HID_TOPSEED
>>>  	Say Y if you have a TopSeed Cyberlink or BTC Emprex or Conceptronic
>>>  	CLLRCMCE remote control.
>>>  
>>> -config HID_THINGM
>>
>> Overall the patchset looks good to me. I'd suggest we keep 
>> CONFIG_HID_THINGM as a stub though, that'd just select CONFIG_HID_LED, so 
>> that we don't cause kernel config regressions for users who had 
>> CONFIG_HID_THINGM already turned on.
>>
>> Also adding Vivien Didelot to CC, as the author of the original driver. 
>> Vivien, the full set can be found in linux-input archives ( 
>> http://marc.info/?l=linux-input&r=1&b=201606&w=2 )
> 
> Thanks a lot for the follow-up Jiri.
> 
> If you guys decide to remove hid-thingm.c, you need to update the
> MAINTAINERS entry, checkpatch.pl should have warned about that.
> 
Right, thanks for the hint.

> I can hardly test the patchset now. Heiner, can you confirm me that with
> your patchset, we will still see 3 led_classdev in sysfs for the
> blink(1) mk1 (which has one RGB chip) and 6 for mk2 (which has 2 chips)?
> 
Yes, this will still be the case.

Regards, Heiner

> Thanks,
> 
>         Vivien
> 

