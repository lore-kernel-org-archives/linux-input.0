From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH v2 3/4] arm64: dts: exynos: make tm2 and tm2e independent
 from each other
Date: Thu, 05 Jan 2017 18:29:35 +0900
Message-ID: <586E11FF.9080707@samsung.com>
References: <1483604833-29746-1-git-send-email-jcsing.lee@samsung.com>
 <CGME20170105082716epcas1p1f2a6eea40d842e2d8f7f7f54c029bc82@epcas1p1.samsung.com>
 <1483604833-29746-4-git-send-email-jcsing.lee@samsung.com>
 <586E0E56.6050608@samsung.com>
 <20170105092315.swensammin4wbgx5@gangnam.samsung>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_aNAlkdQK0u+JrkfT9InXbw)"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:51513 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1762464AbdAEJ3j (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Thu, 5 Jan 2017 04:29:39 -0500
In-reply-to: <20170105092315.swensammin4wbgx5@gangnam.samsung>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andi Shyti <andi.shyti@samsung.com>
Cc: Jaechul Lee <jcsing.lee@samsung.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Javier Martinez Canillas <javier@osg.samsung.com>, beomho.seo@samsung.com, galaxyra@gmail.com, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org

This is a multi-part message in MIME format.

--Boundary_(ID_aNAlkdQK0u+JrkfT9InXbw)
Content-type: text/plain; charset=UTF-8
Content-transfer-encoding: 8BIT

Hi,

On 2017년 01월 05일 18:23, Andi Shyti wrote:
> Hi Chanwoo,
> 
>> I add the some comment as following:
>> - ldo23/25/31/38 have the different value between tm2 and tm2e.
> 
> Thanks for pointing this out. I planned to do this already in a
> following patch as for now I think it's out from the scope of this
> particular patch.

I think it is very simple work. If you want to make the common.dtsi,
I think that you have to separate the different thing on each exynos5433-tm2X.dts.

> 
>> - The patch[1] was alread posted. I think you better to rebase this patch on patch[1].
>> [1] https://patchwork.kernel.org/patch/9491769/
>> - ("ARM64: dts: TM2: comply to the samsung pinctrl naming convention")
> 
> Yes, I also thought about this, but I didn't know whether it was
> already picked by anyone. I didn't want to stop Jaechul that's
> why I was planning to rebase the other rather than this.
> But you are right, because some bits of the other patches I know
> that have been merged. Thank you!
> 
> Krzysztof, do you mind if I send patch 3 as a reply to this
> e-mail? The changes should not affect patch 4, anyway.

No, If exynos5433-tm2.dts includes the different value of regulator,
patch4 might be implemented based on patch3.

> 
> Thanks,
> Andi
> 
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics

--Boundary_(ID_aNAlkdQK0u+JrkfT9InXbw)
Content-type: text/x-vcard; CHARSET=EUC-KR; name=cw00_choi.vcf
Content-transfer-encoding: base64
Content-disposition: attachment; filename=cw00_choi.vcf

bnVsbA0K

--Boundary_(ID_aNAlkdQK0u+JrkfT9InXbw)--
