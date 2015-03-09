From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH v7 3/5] power: max77843_battery: Add Max77843 fuel gauge
 device driver
Date: Mon, 9 Mar 2015 11:01:38 +0100
Message-ID: <CAJKOXPcLa8jGBS9r=iAbuco5+9=XcjsEFazFtAWinYUQDArkUQ@mail.gmail.com>
References: <1425291038-18269-1-git-send-email-jaewon02.kim@samsung.com>
	<1425291038-18269-4-git-send-email-jaewon02.kim@samsung.com>
	<20150307201426.GG5233@earth>
	<54FCEB17.70809@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:47415 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753619AbbCIKBj (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 9 Mar 2015 06:01:39 -0400
In-Reply-To: <54FCEB17.70809@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Beomho Seo <beomho.seo@samsung.com>
Cc: Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, Jaewon Kim <jaewon02.kim@samsung.com>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux-input@vger.kernel.org, Inki Dae <inki.dae@samsung.com>, SangBae Lee <sangbae90.lee@samsung.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Chanwoo Choi <cw00.choi@samsung.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

2015-03-09 1:36 GMT+01:00 Beomho Seo <beomho.seo@samsung.com>:
> On 03/08/2015 05:14 AM, Sebastian Reichel wrote:
>> Hi,
>>
>> On Mon, Mar 02, 2015 at 07:10:36PM +0900, Jaewon Kim wrote:
>>> From: Beomho Seo <beomho.seo@samsung.com>
>>>
>>> This patch adds device driver of max77843 fuel gauge.
>>> The driver support for battery fuel gauge in Maxim Max77843.
>>> It is fuel-gauge systems for lithuum-ion batteries in handled and
>>> portable devices.
>>>
>>> Cc: Sebastian Reichel <sre@kernel.org>
>>> Signed-off-by: Beomho Seo <beomho.seo@samsung.com>
>>
>> Reviewed-By: Sebastian Reichel <sre@kernel.org>
>>
>> I can't take it as is, since it depends on the private header file
>> of PATCH 1.
>>
>> -- Sebastian
>>
>
> This patch reviewed by Sebastian.
> Could you Please merge that your git tree ?

Hi,

Sorry for late response, but I finally got some time to look at this.
This driver looks very similar to max17042_battery.c fuel gauge
driver. Obtaining some properties looks exactly the same. The
difference seems to be in new properties. The I2C address is the same.

I highly recommend to extend the max17042 driver instead. It already
supports also max17047, max17050 and max77693.

Best regards,
Krzysztof
