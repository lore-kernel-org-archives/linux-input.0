From: Sonic Zhang <sonic.adi@gmail.com>
Subject: Re: [PATCH v2 2/3] bfin_rotary: Move peripheral pinmux definition
 into platform data
Date: Wed, 4 Feb 2015 14:28:14 +0800
Message-ID: <CAJxxZ0MVTNysLmRZnGeOe4ti_hA4Xi7dw0hqWGhErQOV0OTAqQ@mail.gmail.com>
References: <1421225654-27872-1-git-send-email-sonic.adi@gmail.com>
	<1421225654-27872-2-git-send-email-sonic.adi@gmail.com>
	<20150204012230.GC23942@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ob0-f176.google.com ([209.85.214.176]:54117 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750831AbbBDG2P (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 4 Feb 2015 01:28:15 -0500
Received: by mail-ob0-f176.google.com with SMTP id wo20so17833213obc.7
        for <linux-input@vger.kernel.org>; Tue, 03 Feb 2015 22:28:15 -0800 (PST)
In-Reply-To: <20150204012230.GC23942@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Michael Hennerich <michael.hennerich@analog.com>, adi-buildroot-devel@lists.sourceforge.net, Sonic Zhang <sonic.zhang@analog.com>

Hi Dmitry,

On Wed, Feb 4, 2015 at 9:22 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Wed, Jan 14, 2015 at 04:54:13PM +0800, Sonic Zhang wrote:
>> From: Sonic Zhang <sonic.zhang@analog.com>
>>
>
> Please tell me why this is needed. Also, should not this be converted to
> pinctrl infrastructure or I misunderstand what it does?
>

There is no pinctrl driver for generic BF5xx processors. BF5xx machine
code still use the legacy peripheral_request_list() and
peripheral_free_list() API defined in Blackfin archtecture. While
BF609 and BF548 has turned to a new pinctrl-adi driver, because they
have a new pinmux and gpio device. Now, the same rotary driver should
deal with both legacy pinmux API and new pinctrl API. So, I move the
board specific pinmux list to platform data. Actually, the lists are
useless for bf548 and bf609. I will send a new patch to remove them as
well.

Regards,


>
>> Signed-off-by: Sonic Zhang <sonic.zhang@analog.com>
>> ---
>>  arch/blackfin/mach-bf527/boards/ad7160eval.c |    8 ++++++++
>>  arch/blackfin/mach-bf527/boards/ezkit.c      |    8 ++++++++
>>  arch/blackfin/mach-bf548/boards/ezkit.c      |    8 ++++++++
>>  arch/blackfin/mach-bf609/boards/ezkit.c      |    8 ++++++++
>>  drivers/input/misc/bfin_rotary.c             |   12 +++---------
>>  include/linux/platform_data/bfin_rotary.h    |    1 +
>>  6 files changed, 36 insertions(+), 9 deletions(-)
>>
>> diff --git a/arch/blackfin/mach-bf527/boards/ad7160eval.c b/arch/blackfin/mach-bf527/boards/ad7160eval.c
>> index beb011b..029a050 100644
>> --- a/arch/blackfin/mach-bf527/boards/ad7160eval.c
>> +++ b/arch/blackfin/mach-bf527/boards/ad7160eval.c
>> @@ -668,6 +668,13 @@ static struct platform_device bfin_sport1_uart_device = {
>>  #if IS_ENABLED(CONFIG_INPUT_BFIN_ROTARY)
>>  #include <linux/platform_data/bfin_rotary.h>
>>
>> +static const u16 per_cnt[] = {
>> +     P_CNT_CUD,
>> +     P_CNT_CDG,
>> +     P_CNT_CZM,
>> +     0
>> +};
>> +
>>  static struct bfin_rotary_platform_data bfin_rotary_data = {
>>       /*.rotary_up_key     = KEY_UP,*/
>>       /*.rotary_down_key   = KEY_DOWN,*/
>> @@ -676,6 +683,7 @@ static struct bfin_rotary_platform_data bfin_rotary_data = {
>>       .debounce          = 10,        /* 0..17 */
>>       .mode              = ROT_QUAD_ENC | ROT_DEBE,
>>       .pm_wakeup         = 1,
>> +     .pin_list          = per_cnt,
>>  };
>>
>>  static struct resource bfin_rotary_resources[] = {
>> diff --git a/arch/blackfin/mach-bf527/boards/ezkit.c b/arch/blackfin/mach-bf527/boards/ezkit.c
>> index 728cda4..cc80c5b 100644
>> --- a/arch/blackfin/mach-bf527/boards/ezkit.c
>> +++ b/arch/blackfin/mach-bf527/boards/ezkit.c
>> @@ -1094,6 +1094,13 @@ static struct platform_device bfin_device_gpiokeys = {
>>  #if IS_ENABLED(CONFIG_INPUT_BFIN_ROTARY)
>>  #include <linux/platform_data/bfin_rotary.h>
>>
>> +static const u16 per_cnt[] = {
>> +     P_CNT_CUD,
>> +     P_CNT_CDG,
>> +     P_CNT_CZM,
>> +     0
>> +};
>> +
>>  static struct bfin_rotary_platform_data bfin_rotary_data = {
>>       /*.rotary_up_key     = KEY_UP,*/
>>       /*.rotary_down_key   = KEY_DOWN,*/
>> @@ -1102,6 +1109,7 @@ static struct bfin_rotary_platform_data bfin_rotary_data = {
>>       .debounce          = 10,        /* 0..17 */
>>       .mode              = ROT_QUAD_ENC | ROT_DEBE,
>>       .pm_wakeup         = 1,
>> +     .pin_list          = per_cnt,
>>  };
>>
>>  static struct resource bfin_rotary_resources[] = {
>> diff --git a/arch/blackfin/mach-bf548/boards/ezkit.c b/arch/blackfin/mach-bf548/boards/ezkit.c
>> index 8f70f83..0b68781 100644
>> --- a/arch/blackfin/mach-bf548/boards/ezkit.c
>> +++ b/arch/blackfin/mach-bf548/boards/ezkit.c
>> @@ -161,6 +161,13 @@ static struct platform_device bf54x_kpad_device = {
>>  #if IS_ENABLED(CONFIG_INPUT_BFIN_ROTARY)
>>  #include <linux/platform_data/bfin_rotary.h>
>>
>> +static const u16 per_cnt[] = {
>> +     P_CNT_CUD,
>> +     P_CNT_CDG,
>> +     P_CNT_CZM,
>> +     0
>> +};
>> +
>>  static struct bfin_rotary_platform_data bfin_rotary_data = {
>>       /*.rotary_up_key     = KEY_UP,*/
>>       /*.rotary_down_key   = KEY_DOWN,*/
>> @@ -169,6 +176,7 @@ static struct bfin_rotary_platform_data bfin_rotary_data = {
>>       .debounce          = 10,        /* 0..17 */
>>       .mode              = ROT_QUAD_ENC | ROT_DEBE,
>>       .pm_wakeup         = 1,
>> +     .pin_list          = per_cnt,
>>  };
>>
>>  static struct resource bfin_rotary_resources[] = {
>> diff --git a/arch/blackfin/mach-bf609/boards/ezkit.c b/arch/blackfin/mach-bf609/boards/ezkit.c
>> index f9dc64d..4ac72c6 100644
>> --- a/arch/blackfin/mach-bf609/boards/ezkit.c
>> +++ b/arch/blackfin/mach-bf609/boards/ezkit.c
>> @@ -77,6 +77,13 @@ static struct platform_device bfin_isp1760_device = {
>>  #if IS_ENABLED(CONFIG_INPUT_BFIN_ROTARY)
>>  #include <linux/platform_data/bfin_rotary.h>
>>
>> +static const u16 per_cnt[] = {
>> +     P_CNT_CUD,
>> +     P_CNT_CDG,
>> +     P_CNT_CZM,
>> +     0
>> +};
>> +
>>  static struct bfin_rotary_platform_data bfin_rotary_data = {
>>       /*.rotary_up_key     = KEY_UP,*/
>>       /*.rotary_down_key   = KEY_DOWN,*/
>> @@ -84,6 +91,7 @@ static struct bfin_rotary_platform_data bfin_rotary_data = {
>>       .rotary_button_key = KEY_ENTER,
>>       .debounce          = 10,        /* 0..17 */
>>       .mode              = ROT_QUAD_ENC | ROT_DEBE,
>> +     .pin_list          = per_cnt,
>>  };
>>
>>  static struct resource bfin_rotary_resources[] = {
>> diff --git a/drivers/input/misc/bfin_rotary.c b/drivers/input/misc/bfin_rotary.c
>> index 8f6c7cd..dd62fc9 100644
>> --- a/drivers/input/misc/bfin_rotary.c
>> +++ b/drivers/input/misc/bfin_rotary.c
>> @@ -16,13 +16,6 @@
>>
>>  #include <asm/portmux.h>
>>
>> -static const u16 per_cnt[] = {
>> -     P_CNT_CUD,
>> -     P_CNT_CDG,
>> -     P_CNT_CZM,
>> -     0
>> -};
>> -
>>  struct bfin_rot {
>>       struct input_dev *input;
>>       int irq;
>> @@ -102,7 +95,7 @@ static int bfin_rotary_probe(struct platform_device *pdev)
>>               return -EINVAL;
>>       }
>>
>> -     error = peripheral_request_list(per_cnt, dev_name(&pdev->dev));
>> +     error = peripheral_request_list(pdata->pin_list, dev_name(&pdev->dev));
>>       if (error) {
>>               dev_err(&pdev->dev, "requesting peripherals failed\n");
>>               return error;
>> @@ -197,6 +190,7 @@ out1:
>>
>>  static int bfin_rotary_remove(struct platform_device *pdev)
>>  {
>> +     struct bfin_rotary_platform_data *pdata = dev_get_platdata(&pdev->dev);
>>       struct bfin_rot *rotary = platform_get_drvdata(pdev);
>>
>>       bfin_write_CNT_CONFIG(0);
>> @@ -204,7 +198,7 @@ static int bfin_rotary_remove(struct platform_device *pdev)
>>
>>       free_irq(rotary->irq, pdev);
>>       input_unregister_device(rotary->input);
>> -     peripheral_free_list(per_cnt);
>> +     peripheral_free_list(pdata->pin_list);
>>
>>       kfree(rotary);
>>
>> diff --git a/include/linux/platform_data/bfin_rotary.h b/include/linux/platform_data/bfin_rotary.h
>> index 8895a75..9882937 100644
>> --- a/include/linux/platform_data/bfin_rotary.h
>> +++ b/include/linux/platform_data/bfin_rotary.h
>> @@ -40,6 +40,7 @@ struct bfin_rotary_platform_data {
>>       unsigned short debounce;        /* 0..17 */
>>       unsigned short mode;
>>       unsigned short pm_wakeup;
>> +     unsigned short *pin_list;
>>  };
>>
>>  /* CNT_CONFIG bitmasks */
>> --
>> 1.7.9.5
>>
>
> --
> Dmitry
