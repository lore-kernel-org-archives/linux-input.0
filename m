From: Ping Cheng <pinglinux@gmail.com>
Subject: Re: [PATCH] Input: wacom_w8001 - W8001_MAX_LENGTH should be 13
Date: Mon, 23 May 2016 09:41:09 -0700
Message-ID: <CAF8JNhLO=TZxM-w35EcYL5dKtZBDs9CgSu=dKXkz+nZZWDu8FA@mail.gmail.com>
References: <1463981173-9866-1-git-send-email-pingc@wacom.com> <CAObcDv9zXf9bDHgxq-Bfi1BpBEw0rNVwaE23q4L1VzOfg9pKpw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ob0-f195.google.com ([209.85.214.195]:36123 "EHLO
	mail-ob0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753178AbcEWQla (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 23 May 2016 12:41:30 -0400
Received: by mail-ob0-f195.google.com with SMTP id ds10so359706obb.3
        for <linux-input@vger.kernel.org>; Mon, 23 May 2016 09:41:29 -0700 (PDT)
In-Reply-To: <CAObcDv9zXf9bDHgxq-Bfi1BpBEw0rNVwaE23q4L1VzOfg9pKpw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chris Arges <christopherarges@gmail.com>
Cc: linux-input <linux-input@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

On Mon, May 23, 2016 at 5:29 AM, Chris Arges <christopherarges@gmail.com> wrote:
> This still causes crashes for me unless I also have the patch I submitted
> earlier applied.

Does your device support touch? Your patch would break two-finger
touch since it resets idx before reaches full packet length.

> I'll look at the crashdump in a bit to see what value idx is.

Yes, please get the idx for us. Depends on the actual value, we'll
come up with a solution. I think it will most likely be a specific
workaround for pen if the issue only happens with pen.

Cheers,

Ping


> On Mon, May 23, 2016 at 12:26 AM, Ping Cheng <pinglinux@gmail.com> wrote:
>>
>> From: wacom <wacom@localhost.localdomain>
>>
>> I guess the patch that added two-finger touch support forgot to update
>> W8001_MAX_LENGTH from 11 to 13.
>>
>> Signed-off-by: Ping Cheng <pingc@wacom.com>
>> ---
>>  drivers/input/touchscreen/wacom_w8001.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/input/touchscreen/wacom_w8001.c
>> b/drivers/input/touchscreen/wacom_w8001.c
>> index bab3c6a..b1b4127 100644
>> --- a/drivers/input/touchscreen/wacom_w8001.c
>> +++ b/drivers/input/touchscreen/wacom_w8001.c
>> @@ -27,7 +27,7 @@ MODULE_AUTHOR("Jaya Kumar <jayakumar.lkml@gmail.com>");
>>  MODULE_DESCRIPTION(DRIVER_DESC);
>>  MODULE_LICENSE("GPL");
>>
>> -#define W8001_MAX_LENGTH       11
>> +#define W8001_MAX_LENGTH       13
>>  #define W8001_LEAD_MASK                0x80
>>  #define W8001_LEAD_BYTE                0x80
>>  #define W8001_TAB_MASK         0x40
>> --
>> 1.8.3.1
>>
>
