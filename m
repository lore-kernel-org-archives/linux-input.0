From: Andi Shyti <andi@etezian.org>
Subject: Re: [PATCH 3/4] arm64: dts: exynos: make tm2 and tm2e independent
 from each other
Date: Tue, 3 Jan 2017 23:40:56 +0900
Message-ID: <20170103144056.4ft2ohmhgmezeney@jack.zhora.eu>
References: <CGME20170103075734epcas5p43a9743131f63affd0a438d2ed342f22e@epcas5p4.samsung.com>
 <1483430237-26823-1-git-send-email-jcsing.lee@samsung.com>
 <1483430237-26823-4-git-send-email-jcsing.lee@samsung.com>
 <CAJKOXPev9m07_dQWAvJ+=MKnbT0TFERKOtjWUDU+WXdGAiRyDA@mail.gmail.com>
 <20170103095842.h3hl64amje4qv4ts@gangnam.samsung>
 <CAJKOXPeEE1VwAUSAOpfyX+t58zKeAT1fe3ybp0BoQiiDBb4Uqg@mail.gmail.com>
 <20170103102548.73jg6qddlcthe2mu@gangnam.samsung>
 <CAGTfZH3ez4DPTE7-bDeayjhSGxJ_8Mj1MQz1M7O1qhwOGOnmMQ@mail.gmail.com>
 <20170103115530.zhjwn7bzmqmumy23@gangnam.samsung>
 <ff876454-b49f-3d63-d76e-012dd303b0e7@osg.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <ff876454-b49f-3d63-d76e-012dd303b0e7@osg.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: Andi Shyti <andi.shyti@samsung.com>, Chanwoo Choi <cwchoi00@gmail.com>, Mark Rutland <mark.rutland@arm.com>, devicetree <devicetree@vger.kernel.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, Jaechul Lee <jcsing.lee@samsung.com>, Will Deacon <will.deacon@arm.com>, linux-kernel <linux-kernel@vger.kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Chanwoo Choi <cw00.choi@samsung.com>, Rob Herring <robh+dt@kernel.org>, Kukjin Kim <kgene@kernel.org>, linux-input@vger.kernel.org, galaxyra@gmail.com, beomho.seo@samsung.com, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-input@vger.kernel.org

Hi,

> FWIW, I also agree with Chanwoo that the difference is too small to
> need a common .dtsi file.

in principle I don't like "switching on and off" properties by
overwriting them with "status = disable", unless it's really
necessary (and this case is not). Even for small differences. It
makes the DTS harder to read and duplicates nodes with different
values throughout the DTS include chain.

In my opinion this approach should be discouraged.

Besides, there are other overwritten differences in tm2e.dts that
I think should be separated as well. The "common" file approach is
widely used in arm/boot/dts/exynos* files.

The "status = disable" looks to me more like a temporary hack
rather than a permanent solution.

In any case, still up to you :)

Andi
