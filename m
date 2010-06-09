From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: [PATCH] input: fixup X86_MRST selects
Date: Wed, 09 Jun 2010 15:42:08 -0700
Message-ID: <4C1018C0.6020304@oracle.com>
References: <20100609133443.38f1f957.sfr@canb.auug.org.au> <20100609152921.61fb7db9.randy.dunlap@oracle.com> <201006091540.43122.dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rcsinet10.oracle.com ([148.87.113.121]:32529 "EHLO
	rcsinet10.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756838Ab0FIWnX (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 9 Jun 2010 18:43:23 -0400
In-Reply-To: <201006091540.43122.dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Jacob Pan <jacob.jun.pan@intel.com>, linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org, akpm <akpm@linux-foundation.org>

On 06/09/10 15:40, Dmitry Torokhov wrote:
> On Wednesday, June 09, 2010 03:29:21 pm Randy Dunlap wrote:
>> +++ linux-next-20100609/drivers/input/keyboard/Kconfig
>> @@ -70,9 +70,10 @@ config KEYBOARD_ATARI
>>  
>>  config KEYBOARD_ATKBD
>>         tristate "AT keyboard" if EMBEDDED || !X86
>> +       depends on !X86 || (X86 && !X86_MRST)
> 
> Should it be simply 'depends on !X86_MRST' and then we could kill
> '!X86_MRST' conditionals in selects?

Duh, that sounds good, yes.

> 
>>         default y
>>         select SERIO
>> -       select SERIO_LIBPS2
>> +       select SERIO_LIBPS2 if !X86_MRST
>>         select SERIO_I8042 if X86 && !X86_MRST
>>         select SERIO_GSCPS2 if GSC
>>         help
> 
> Thanks.
> 


-- 
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your code ***
