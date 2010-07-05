From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] hid-magicmouse: Correct parsing of large X and Y motions.
Date: Mon, 5 Jul 2010 15:51:40 -0700
Message-ID: <2EBF06A7-D4C9-4123-B4C6-89B737F2FF79@gmail.com>
References: <878w5qaspq.fsf@troilus.org> <AANLkTim9R0ur7r2Y3r3bOMIRSM7JYVcZdGZ0QMaYvK4X@mail.gmail.com>
Mime-Version: 1.0 (iPhone Mail 7E18)
Content-Type: text/plain;
	charset=us-ascii;
	format=flowed;
	delsp=yes
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:62850 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754453Ab0GEWvx (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 5 Jul 2010 18:51:53 -0400
Received: by pxi14 with SMTP id 14so1838380pxi.19
        for <linux-input@vger.kernel.org>; Mon, 05 Jul 2010 15:51:53 -0700 (PDT)
In-Reply-To: <AANLkTim9R0ur7r2Y3r3bOMIRSM7JYVcZdGZ0QMaYvK4X@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: Michael Poole <mdpoole@troilus.org>, Jiri Kosina <jkosina@suse.cz>, Chase Douglas <chase.douglas@canonical.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Jul 5, 2010, at 12:54 PM, Ping Cheng <pinglinux@gmail.com> wrote:

> On Mon, Jul 5, 2010 at 10:50 PM, Michael Poole <mdpoole@troilus.org>  
> wrote:
>> The X and Y values have two more significant bits in the same byte
>> that contains click status.  Include these in the reported value.
>> Thanks to Iain Hibbert of NetBSD for pointing this out.
>>
>> Signed-off-by: Michael Poole <mdpoole@troilus.org>
>> ---
>>  drivers/hid/hid-magicmouse.c |    4 ++--
>>  1 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/hid/hid-magicmouse.c b/drivers/hid/hid- 
>> magicmouse.c
>> index 0b89c1c..7cdda23 100644
>> --- a/drivers/hid/hid-magicmouse.c
>> +++ b/drivers/hid/hid-magicmouse.c
>> @@ -267,8 +267,8 @@ static int magicmouse_raw_event(struct  
>> hid_device *hdev,
>>                 * to have the current touch information before
>>                 * generating a click event.
>>                 */
>> -               x = (signed char)data[1];
>> -               y = (signed char)data[2];
>> +               x = (int)(((data[3] & 0x0c) << 28) | (data[1] <<  
>> 22)) >> 22;
>> +               y = (int)(((data[3] & 0x30) << 26) | (data[2] <<  
>> 22)) >> 22;
>
> Will the following give us the same result?
>
> +               x = (int)(((data[3] & 0x0c) << 6) | data[1]);
> +               y = (int)(((data[3] & 0x30) << 4) | data[2]);

I'd think you'd run into endianness issues.

-- 
Dmitry

