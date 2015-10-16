From: Wan ZongShun <mcuos.com@gmail.com>
Subject: Re: [PATCH] input: i8042: add quirk to implement i8042 detect for AMD
Date: Fri, 16 Oct 2015 17:35:40 +0800
Message-ID: <CAKT61h95dJjXUx9cp5kCqOvsEMQBbYZqhnoUfQbf1bJqVKi7jQ@mail.gmail.com>
References: <1445002020-12672-1-git-send-email-Vincent.Wan@amd.com> <20151016085808.GA32193@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yk0-f175.google.com ([209.85.160.175]:34070 "EHLO
	mail-yk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751509AbbJPJgB (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 16 Oct 2015 05:36:01 -0400
In-Reply-To: <20151016085808.GA32193@pd.tnic>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: Vincent Wan <Vincent.Wan@amd.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, Ray.Huang@amd.com

2015-10-16 16:58 GMT+08:00 Borislav Petkov <bp@alien8.de>:
> On Fri, Oct 16, 2015 at 09:27:00AM -0400, Vincent Wan wrote:
>> Detecting platform supports i8042 or not, AMD resorted to
>> BIOS's FADT i8042 flag.
>>
>> Signed-off-by: Vincent Wan <Vincent.Wan@amd.com>
>> ---
>>  drivers/input/serio/i8042-x86ia64io.h | 6 ++++++
>>  1 file changed, 6 insertions(+)

>>  /*
>> @@ -1047,6 +1048,11 @@ static int __init i8042_platform_init(void)
>>       /* Just return if pre-detection shows no i8042 controller exist */
>>       if (!x86_platform.i8042_detect())
>>               return -ENODEV;
>> +
>> +     if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD) {
>
> Why the vendor check if you're accessing a bit defined in the ACPI spec?

>From intel's 'x86_platform.i8042_detect' implementation, I doubt if
their BIOS is providing this i8024 flag.
So I have to implement my codes carefully.

>
>> +             if (!(acpi_gbl_FADT.boot_flags & ACPI_FADT_8042))
>> +                     return -ENODEV;
>> +     }
>
> --
> Regards/Gruss,
>     Boris.
>
> ECO tip #101: Trim your mails when you reply.



-- 
---
Vincent Wan(Zongshun)
www.mcuos.com
