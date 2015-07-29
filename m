From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH 0/4] Input: Merge max77843 haptic driver into max77693
Date: Thu, 30 Jul 2015 08:43:51 +0900
Message-ID: <CAJKOXPfdkNgc6db9Dggn=Hh_cOV7+qbBNhPG1p4qopC_E_T=Zg@mail.gmail.com>
References: <1438151490-13751-1-git-send-email-k.kozlowski@samsung.com>
	<20150729170831.GA23178@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150729170831.GA23178@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>, Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Jaewon Kim <jaewon02.kim@samsung.com>
List-Id: linux-input@vger.kernel.org

2015-07-30 2:08 GMT+09:00 Dmitry Torokhov <dmitry.torokhov@gmail.com>:
> On Wed, Jul 29, 2015 at 03:31:26PM +0900, Krzysztof Kozlowski wrote:
>> Hi,
>>
>>
>> Description
>> ===========
>> The Maxim 77843 haptic driver differs from 77693 by:
>> 1. Setting the bias.
>> 2. Different configuration register.
>> 3. Not enabling the low-sys DAC.
>> 4. Using same regmap for PMIC and haptic blocks.
>>
>> The patchset merges max77843 driver into the max77693.
>>
>>
>> Dependencies
>> ============
>> The patchset *depends on* "regulator: Merge max77843 into max77693" [0]
>> which was applied by Mark Brown (regulator tree). The mentioned
>> regulator patchset actually changed also MFD drivers and other headers
>> so the child drivers (like max77693 regulator or haptic) can be used
>> with both max77693 and max77843 main MFD drivers.
>>
>>
>> Merging ideas
>> =============
>> 0. Patches 1 and 2 can be applied directly.
>> For rest of it (patches 3 and 4):
>> 1. If this will go to v4.3, then maybe Mark Brown could prepare
>>    an immutable branch (or a tag) with the [0] patchset?
>> 2. If this will go to v4.4, then patchset can wait till MFD/regulator
>>    changes reach Linus' tree.
>
> How about 3: Mark merges it through his tree with:
>
> Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>
> for the series?

Right, this is also good solution. Thanks!

I'll respin with one signed-off-by fixed and your acks, asking Mark to
apply this.

Best regards,
Krzysztof
