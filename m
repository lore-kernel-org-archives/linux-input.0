From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH 4/4] HID: remove ThingM blink(1) driver
Date: Wed, 22 Jun 2016 21:52:47 +0200
Message-ID: <0f67c7f3-45ee-9a6a-82a9-aa940a7faed9@gmail.com>
References: <f8c59082-d76c-73aa-70b6-7454b731a055@gmail.com>
 <alpine.LNX.2.00.1606221520340.6874@cbobk.fhfr.pm>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36684 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750787AbcFVTy0 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 22 Jun 2016 15:54:26 -0400
In-Reply-To: <alpine.LNX.2.00.1606221520340.6874@cbobk.fhfr.pm>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Vivien Didelot <vivien.didelot@savoirfairelinux.com>

Am 22.06.2016 um 15:25 schrieb Jiri Kosina:
> On Tue, 21 Jun 2016, Heiner Kallweit wrote:
> 
>> Now that support for ThingM blink(1) was merged into the hid-led driver
>> the dedicated driver for this device can be removed.
>>
>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>> ---
>>  drivers/hid/Kconfig      |  10 --
>>  drivers/hid/Makefile     |   1 -
>>  drivers/hid/hid-thingm.c | 259 -----------------------------------------------
>>  3 files changed, 270 deletions(-)
>>  delete mode 100644 drivers/hid/hid-thingm.c
>>
>> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
>> index ab22090..6b08a3b 100644
>> --- a/drivers/hid/Kconfig
>> +++ b/drivers/hid/Kconfig
>> @@ -828,16 +828,6 @@ config HID_TOPSEED
>>  	Say Y if you have a TopSeed Cyberlink or BTC Emprex or Conceptronic
>>  	CLLRCMCE remote control.
>>  
>> -config HID_THINGM
> 
> Overall the patchset looks good to me. I'd suggest we keep 
> CONFIG_HID_THINGM as a stub though, that'd just select CONFIG_HID_LED, so 
> that we don't cause kernel config regressions for users who had 
> CONFIG_HID_THINGM already turned on.
> 
OK
I'll add this and provide a v2 of the patch removing the old thingm driver.

> Also adding Vivien Didelot to CC, as the author of the original driver. 
> Vivien, the full set can be found in linux-input archives ( 
> http://marc.info/?l=linux-input&r=1&b=201606&w=2 )
> 
Sorry, forgot that.

