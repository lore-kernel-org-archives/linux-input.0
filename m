From: Chanwoo Choi <cwchoi00@gmail.com>
Subject: Re: [PATCH 3/4] arm64: dts: exynos: make tm2 and tm2e independent
 from each other
Date: Wed, 4 Jan 2017 00:29:23 +0900
Message-ID: <CAGTfZH0tnjkqF_7DChLSvzs3C369mkb_HZmyrf3cc0T-UcBZ4A@mail.gmail.com>
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
 <20170103144056.4ft2ohmhgmezeney@jack.zhora.eu>
Reply-To: cwchoi00@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170103144056.4ft2ohmhgmezeney@jack.zhora.eu>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Andi Shyti <andi@etezian.org>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree <devicetree@vger.kernel.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, Kukjin Kim <kgene@kernel.org>, Chanwoo Choi <cw00.choi@samsung.com>, Catalin Marinas <catalin.marinas@arm.com>, Jaechul Lee <jcsing.lee@samsung.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Will Deacon <will.deacon@arm.com>, linux-kernel <linux-kernel@vger.kernel.org>, Andi Shyti <andi.shyti@samsung.com>, Javier Martinez Canillas <javier@osg.samsung.com>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, linux-input@vger.kernel.org, galaxyra@gmail.com, beomho.seo@samsung.com, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-input@vger.kernel.org

Hi Andi,

2017-01-03 23:40 GMT+09:00 Andi Shyti <andi@etezian.org>:
> Hi,
>
>> FWIW, I also agree with Chanwoo that the difference is too small to
>> need a common .dtsi file.
>
> in principle I don't like "switching on and off" properties by
> overwriting them with "status = disable", unless it's really
> necessary (and this case is not). Even for small differences. It
> makes the DTS harder to read and duplicates nodes with different
> values throughout the DTS include chain.
>
> In my opinion this approach should be discouraged.
>
> Besides, there are other overwritten differences in tm2e.dts that
> I think should be separated as well. The "common" file approach is
> widely used in arm/boot/dts/exynos* files.
>
> The "status = disable" looks to me more like a temporary hack
> rather than a permanent solution.
>
> In any case, still up to you :)
>
> Andi

I think that "status=disabled" of hsi2c_9 is not hack. The overwrite
is possible for Device-tree. But, there is just difference how to
support them with some method.

Except for touchkey, all peripheral device are same on both tm2 and
tm2e. There are only small difference for a few property value.

To understand the difference between tm2 and tm2e, I made the patch
(it is not complete version). If we implement the following patch, we
support both tm2 and tm2e. So, I think that it is not complex to
understand the h/w difference between tm2 and tm2e.

diff --git a/arch/arm64/boot/dts/exynos/exynos5433-tm2e.dts
b/arch/arm64/boot/dts/exynos/exynos5433-tm2e.dts
index 1db4e7f..09b6935 100644
--- a/arch/arm64/boot/dts/exynos/exynos5433-tm2e.dts
+++ b/arch/arm64/boot/dts/exynos/exynos5433-tm2e.dts
@@ -18,6 +18,17 @@
        compatible = "samsung,tm2e", "samsung,exynos5433";
 };

+&display_timings {
+       clock-frequency = <16523724>;
+       hactive = <1600>;
+};
+
+&hsi2c_9 {
+        /* TM2E don't use the separate touchkey device. Instead, touchscreen
+         * device support the touchkey device.*/
+       status = "disabled";
+};
+
 &ldo23_reg {
        regulator-name = "CAM_SEN_CORE_1.025V_AP";
        regulator-max-microvolt = <1050000>;
@@ -39,3 +50,7 @@
        regulator-min-microvolt = <3300000>;
        regulator-max-microvolt = <3300000>;
 };
+
+&touchscreen {
+       x-size = "1599";
+};

-- 
Best Regards,
Chanwoo Choi
