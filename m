From: Sonic Zhang <sonic.adi@gmail.com>
Subject: Re: [PATCH v3 2/3] bfin_rotary: Move peripheral pinmux definition
 into platform data of bf527
Date: Thu, 5 Feb 2015 15:39:08 +0800
Message-ID: <CAJxxZ0PbX91JD_Pf_JVTgqt1NTB1+naVF_2bwzdDG2Bh2oWFXA@mail.gmail.com>
References: <1423036686-31891-1-git-send-email-sonic.adi@gmail.com>
	<20150204194442.GB15782@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ob0-f177.google.com ([209.85.214.177]:52446 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755141AbbBEHjJ (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 5 Feb 2015 02:39:09 -0500
Received: by mail-ob0-f177.google.com with SMTP id wp18so5560138obc.8
        for <linux-input@vger.kernel.org>; Wed, 04 Feb 2015 23:39:08 -0800 (PST)
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

I forgot one more replacement of variable per_cnt in
bfin_rotary_probe. I will update.

Sonic
