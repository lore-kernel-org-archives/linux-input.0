From: Sonic Zhang <sonic.adi@gmail.com>
Subject: Re: [PATCH v3 2/3] bfin_rotary: Move peripheral pinmux definition
 into platform data of bf527
Date: Thu, 5 Feb 2015 13:13:57 +0800
Message-ID: <CAJxxZ0Pedshnx-N3cPB4LhOsb527py7DMZ+DXNy-W6qs8ywxVQ@mail.gmail.com>
References: <1423036686-31891-1-git-send-email-sonic.adi@gmail.com>
	<20150204194442.GB15782@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oi0-f43.google.com ([209.85.218.43]:49997 "EHLO
	mail-oi0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750706AbbBEFN6 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 5 Feb 2015 00:13:58 -0500
Received: by mail-oi0-f43.google.com with SMTP id z81so4875518oif.2
        for <linux-input@vger.kernel.org>; Wed, 04 Feb 2015 21:13:57 -0800 (PST)
In-Reply-To: <20150204194442.GB15782@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Michael Hennerich <michael.hennerich@analog.com>, adi-buildroot-devel@lists.sourceforge.net, Sonic Zhang <sonic.zhang@analog.com>

Hi Dmitry,

On Thu, Feb 5, 2015 at 3:44 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> Hi Sonic,
>
> On Wed, Feb 04, 2015 at 03:58:04PM +0800, Sonic Zhang wrote:
>> @@ -102,7 +95,7 @@ static int bfin_rotary_probe(struct platform_device *pdev)
>>               return -EINVAL;
>>       }
>>
>> -     error = peripheral_request_list(per_cnt, dev_name(&pdev->dev));
>> +     error = peripheral_request_list(pdata->pin_list, dev_name(&pdev->dev));
>
> I do not think the driver will be happy with pdata->oin_list == NULL
> here.

When pinctrl API is used in bf609 and bf548, peripheral_requst and
peripheral_free macros are defined empty in
arch/blackfin/include/asm/pinmux.h. So, pdata->oin_list == NULL is
never mind. I can add a null array point check to
peripheral_request_list() and peripheral_free_list() in a different
patch for Blackfin arch code.

#ifdef CONFIG_PINCTRL

#define peripheral_request(per, label) (0)
#define peripheral_free(per)
#define peripheral_request_list(per, label) (0)
#define peripheral_free_list(per)

#else



>
>>       if (error) {
>>               dev_err(&pdev->dev, "requesting peripherals failed\n");
>>               return error;
>> @@ -197,6 +190,7 @@ out1:
>>
>>  static int bfin_rotary_remove(struct platform_device *pdev)
>>  {
>> +     struct bfin_rotary_platform_data *pdata = dev_get_platdata(&pdev->dev);
>
> Why do you need this change?

The pdata struct is used to pass pin_list array to peripheral_free_list().

>
>>       struct bfin_rot *rotary = platform_get_drvdata(pdev);
>>
>>       bfin_write_CNT_CONFIG(0);
>> @@ -204,7 +198,7 @@ static int bfin_rotary_remove(struct platform_device *pdev)
>>
>>       free_irq(rotary->irq, pdev);
>>       input_unregister_device(rotary->input);
>> -     peripheral_free_list(per_cnt);
>> +     peripheral_free_list(pdata->pin_list);
>
> Same here: NULL will cause severe indigestion.
>

See my comment up.

Regards,

Sonic
