From: Nishanth Menon <nm@ti.com>
Subject: Re: randconfig build error with next-20140915, in drivers/input/misc/palmas-pwrbutton.c
Date: Mon, 15 Sep 2014 14:15:22 -0500
Message-ID: <54173ACA.1010709@ti.com>
References: <CA+r1ZhjG4oSVSWnO4SXomJArxJdnUpdSHeGxV41Z4Hw1B8eEaQ@mail.gmail.com> <5417222E.30201@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5417222E.30201@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jim Davis <jim.epost@gmail.com>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-next <linux-next@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On 09/15/2014 12:30 PM, Nishanth Menon wrote:
> On 09/15/2014 09:40 AM, Jim Davis wrote:
>> Building with the attached random configuration file,
>>
>> FATAL: modpost: GPL-incompatible module palmas-pwrbutton.ko uses GPL-only symbol
>>  'platform_driver_unregister'
>> make[1]: *** [__modpost] Error 1
>>
> For some reason, I was unable to reproduce this in my build with ARM
> OMAP5 configuration... but with the x86 configuration, I was.
> 
> https://git.kernel.org/cgit/linux/kernel/git/dtor/input.git/commit/?h=next&id=adff5962fdd2f29bac943bc014ebd529444b2153
> 
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/include/linux/module.h#n101
> 
> I used MODULE_LICENSE("GPL V2")
> 
> Looks like a typo crept in. And s/V/v seems to squelch the warning(at
> least in the x86 build) for the randconfig. I will post a patch
> accordingly. Thanks for catching the same.
> 
>  diff --git a/drivers/input/misc/palmas-pwrbutton.c
> b/drivers/input/misc/palmas-pwrbutton.c
>  index 3f90211..06ffe04 100644
>  --- a/drivers/input/misc/palmas-pwrbutton.c
>  +++ b/drivers/input/misc/palmas-pwrbutton.c
>  @@ -326,5 +326,5 @@ module_platform_driver(palmas_pwron_driver);
> 
>   MODULE_ALIAS("platform:palmas-pwrbutton");
>   MODULE_DESCRIPTION("Palmas Power Button");
>  -MODULE_LICENSE("GPL V2");
>  +MODULE_LICENSE("GPL v2");
>   MODULE_AUTHOR("Texas Instruments Inc.");
> 

To close this thread, posted:
https://patchwork.kernel.org/patch/4907121/


-- 
Regards,
Nishanth Menon
