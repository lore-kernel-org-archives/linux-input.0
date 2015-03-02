From: Jaewon Kim <jaewon02.kim@samsung.com>
Subject: Re: [PATCH v7 1/5] mfd: max77843: Add max77843 MFD driver core driver
Date: Mon, 02 Mar 2015 19:36:19 +0900
Message-ID: <54F43D23.80908@samsung.com>
References: <1425291038-18269-1-git-send-email-jaewon02.kim@samsung.com>
 <1425291038-18269-2-git-send-email-jaewon02.kim@samsung.com>
 <20150302102039.GC32347@x1>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
In-reply-to: <20150302102039.GC32347@x1>
Sender: linux-pm-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux-input@vger.kernel.org, Inki Dae <inki.dae@samsung.com>, SangBae Lee <sangbae90.lee@samsung.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Chanwoo Choi <cw00.choi@samsung.com>, Sebastian Reichel <sre@kernel.org>, Beomho Seo <beomho.seo@samsung.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
List-Id: linux-input@vger.kernel.org

Hi Lee Jones,

On 02/03/2015 19:20, Lee Jones wrote:
> On Mon, 02 Mar 2015, Jaewon Kim wrote:
>
>> This patch adds MAX77843 core/irq driver to support PMIC,
>> MUIC(Micro USB Interface Controller), Charger, Fuel Gauge,
>> LED and Haptic device.
>>
>> Cc: Lee Jones <lee.jones@linaro.org>
>> Signed-off-by: Jaewon Kim <jaewon02.kim@samsung.com>
>> Signed-off-by: Beomho Seo <beomho.seo@samsung.com>
>> ---
>>   drivers/mfd/Kconfig                  |   14 ++
>>   drivers/mfd/Makefile                 |    1 +
>>   drivers/mfd/max77843.c               |  243 ++++++++++++++++++
>>   include/linux/mfd/max77843-private.h |  454 ++++++++++++++++++++++++++++++++++
>>   4 files changed, 712 insertions(+)
>>   create mode 100644 drivers/mfd/max77843.c
>>   create mode 100644 include/linux/mfd/max77843-private.h
> If you have dealt with my previous review comments:
>
> Acked-by: Lee Jones <lee.jones@linaro.org>
>
> Which other Acks are you waiting for?
>

There is no dependency with other patchs.
Plz merge it first.

Thanks,
Jaewon Kim

