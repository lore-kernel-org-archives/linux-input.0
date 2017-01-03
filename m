From: Chanwoo Choi <cwchoi00@gmail.com>
Subject: Re: [PATCH 3/4] arm64: dts: exynos: make tm2 and tm2e independent
 from each other
Date: Tue, 3 Jan 2017 20:47:23 +0900
Message-ID: <CAGTfZH3ez4DPTE7-bDeayjhSGxJ_8Mj1MQz1M7O1qhwOGOnmMQ@mail.gmail.com>
References: <CGME20170103075734epcas5p43a9743131f63affd0a438d2ed342f22e@epcas5p4.samsung.com>
 <1483430237-26823-1-git-send-email-jcsing.lee@samsung.com>
 <1483430237-26823-4-git-send-email-jcsing.lee@samsung.com>
 <CAJKOXPev9m07_dQWAvJ+=MKnbT0TFERKOtjWUDU+WXdGAiRyDA@mail.gmail.com>
 <20170103095842.h3hl64amje4qv4ts@gangnam.samsung> <CAJKOXPeEE1VwAUSAOpfyX+t58zKeAT1fe3ybp0BoQiiDBb4Uqg@mail.gmail.com>
 <20170103102548.73jg6qddlcthe2mu@gangnam.samsung>
Reply-To: cwchoi00@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qk0-f196.google.com ([209.85.220.196]:33534 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932685AbdACLro (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Tue, 3 Jan 2017 06:47:44 -0500
In-Reply-To: <20170103102548.73jg6qddlcthe2mu@gangnam.samsung>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andi Shyti <andi.shyti@samsung.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Jaechul Lee <jcsing.lee@samsung.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Kukjin Kim <kgene@kernel.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, beomho.seo@samsung.com, galaxyra@gmail.com, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-input@vger.kernel.org, devicetree <devicetree@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>

Dear all,

2017-01-03 19:25 GMT+09:00 Andi Shyti <andi.shyti@samsung.com>:
>> >> > Currently tm2e dts includes tm2 but there are some differences
>> >> > between the two boards and tm2 has some properties that tm2e
>> >> > doesn't have.
>> >> >
>> >> > That's why it's important to keep the two dts files independent
>> >> > and put all the commonalities in a tm2-common.dtsi file.
>> >> >
>> >> > Signed-off-by: Andi Shyti <andi.shyti@samsung.com>
>> >> > Signed-off-by: Jaechul Lee <jcsing.lee@samsung.com>
>> >> > ---
>> >> >  .../boot/dts/exynos/exynos5433-tm2-common.dtsi     | 1046 ++++++++++++++++++++
>> >> >  arch/arm64/boot/dts/exynos/exynos5433-tm2.dts      | 1033 +------------------
>> >> >  arch/arm64/boot/dts/exynos/exynos5433-tm2e.dts     |    2 +-
>> >> >  3 files changed, 1049 insertions(+), 1032 deletions(-)
>> >> >  create mode 100644 arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
>> >>
>> >> I would like to see here the rename and diff from it. Not entire delta
>> >> (deletions and addons). It is not possible to compare it... I think
>> >> git supports it by default with similarity of 50%.
>> >
>> > I understand, it's indeed quite cryptic to understand. But all
>> > the diff algorithms (patience, minimal, histogram, myers) give
>> > the same result. I don't know how to make it better.
>> >
>> > I could split this patch, but this also means breaking tm2's
>> > functionality, which looks worse.
>> >
>> > Please tell me if you know a better way for generating the patch.
>>
>> git format-patch -M95%?
>
> Same thing with all M values.
>
> Because exynos5433-tm2.dts results modified, while
> exynos5433-tm2-common.dtsi is new. Even though I did:
>
> 1. mv exynos5433-tm2.dts exynos5433-tm2-common.dtsi
> 2. copied pieces from exynos5433-tm2-common.dtsi to a new
>    exynos5433-tm2.dts

I think that exynos5433-tm2-common.dtsi is not necessary because there
is small difference between TM2 and TM2E.

I explain the detailed difference between TM2 and TM2E and then reply
how to support the TM2E board with existing exynos5433-tm2.dts file
without exynos5433-tm2-common.dtsi.

Difference and the way to support TM2E with existing
exynos5433-tm2.dts file as following:
- hsi2c_9 is either used or not. TM2 uses the hsi2c_9 node for
touchkey. but TM2E do not use the hsi2c_9.
   : We can just disable the hsi2c_9 node on tm2e.dts as following:

   &hsi2c_9 {
         status = "disable";
   };

- The difference name and voltage of regulators.
   : Already modified on tm2e.dts.
- The size of touchscreen between tm2 and tm2e ('x-size', 'y-size')
   : We can update the x/y size on tm2e.dts.
- The timing value of display-timing between tm2 and tm2e
('clock-frequency', 'hactive')
   : We can update the 'clock-frequency' and 'hactive'  on tm2e.dts.

-- 
Best Regards,
Chanwoo Choi
