From: Beomho Seo <beomho.seo@samsung.com>
Subject: Re: [PATCH v6 2/5] power: max77843_charger: Add Max77843 charger
 device driver
Date: Mon, 02 Mar 2015 09:05:19 +0900
Message-ID: <54F3A93F.3050609@samsung.com>
References: <1424741348-8728-1-git-send-email-jaewon02.kim@samsung.com>
 <1424741348-8728-3-git-send-email-jaewon02.kim@samsung.com>
 <1425153821.24292.65.camel@x220>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:29689 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751313AbbCBAFW (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 1 Mar 2015 19:05:22 -0500
In-reply-to: <1425153821.24292.65.camel@x220>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Paul Bolle <pebolle@tiscali.nl>, Jaewon Kim <jaewon02.kim@samsung.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux-input@vger.kernel.org, Inki Dae <inki.dae@samsung.com>, SangBae Lee <sangbae90.lee@samsung.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Lee Jones <lee.jones@linaro.org>, Chanwoo Choi <cw00.choi@samsung.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, beomho.seo@samsung.com

On 03/01/2015 05:03 AM, Paul Bolle wrote:
> On Tue, 2015-02-24 at 10:29 +0900, Jaewon Kim wrote:
>> diff --git a/drivers/power/max77843_charger.c b/drivers/power/max77843_charger.c
>> new file mode 100644
>> index 0000000..392eebc1a
>> --- /dev/null
>> +++ b/drivers/power/max77843_charger.c
>> @@ -0,0 +1,508 @@
>> +/*
>> + * Charger driver for Maxim MAX77843
>> + *
>> + * Copyright (C) 2015 Samsung Electronics, Co., Ltd.
>> + * Author: Beomho Seo <beomho.seo@samsung.com>
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published bythe Free Software Foundation.
> 
> There's "bythe" again.
> 
>> + */
> 
> [...]
> 

OK, I will add spacer.

>> +MODULE_LICENSE("GPL");
> 
> And that should probably be
>     MODULE_LICENSE("GPL v2");
> 
> 
> Paul Bolle
> 
> 

OK, I will change license.
Thank you for your review.

Thanks,
Beomho Seo

