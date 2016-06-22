From: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
Subject: Re: [PATCH 4/4] HID: remove ThingM blink(1) driver
Date: Wed, 22 Jun 2016 16:03:59 -0400
Message-ID: <871t3pkn2o.fsf@ketchup.mtl.sfl>
References: <f8c59082-d76c-73aa-70b6-7454b731a055@gmail.com> <alpine.LNX.2.00.1606221520340.6874@cbobk.fhfr.pm> <87twglqlfq.fsf@ketchup.mtl.sfl> <f9d5885f-b0a2-6343-f88d-693b891b0464@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.savoirfairelinux.com ([208.88.110.44]:48248 "EHLO
	mail.savoirfairelinux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750787AbcFVUEG (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 22 Jun 2016 16:04:06 -0400
In-Reply-To: <f9d5885f-b0a2-6343-f88d-693b891b0464@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Heiner Kallweit <hkallweit1@gmail.com>, Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Heiner,

Heiner Kallweit <hkallweit1@gmail.com> writes:

>>> Also adding Vivien Didelot to CC, as the author of the original driver. 
>>> Vivien, the full set can be found in linux-input archives ( 
>>> http://marc.info/?l=linux-input&r=1&b=201606&w=2 )
>> 
>> Thanks a lot for the follow-up Jiri.
>> 
>> If you guys decide to remove hid-thingm.c, you need to update the
>> MAINTAINERS entry, checkpatch.pl should have warned about that.
>> 
> Right, thanks for the hint.
>
>> I can hardly test the patchset now. Heiner, can you confirm me that with
>> your patchset, we will still see 3 led_classdev in sysfs for the
>> blink(1) mk1 (which has one RGB chip) and 6 for mk2 (which has 2 chips)?
>> 
> Yes, this will still be the case.

Looks good to me then! Please Cc' me in the v2 so I can hack the change.

Thanks,

        Vivien
