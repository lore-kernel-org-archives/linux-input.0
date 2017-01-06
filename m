From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v3 1/5] arm64: dts: exynos5433: TM2/E: Fix wrong
 information of ldo23 and ldo25
Date: Fri, 6 Jan 2017 10:50:26 +0200
Message-ID: <20170106085026.5pfwyxt2qipzbjpy@kozik-lap>
References: <1483675149-32598-1-git-send-email-jcsing.lee@samsung.com>
 <CGME20170106035913epcas5p20336406863f1029ccf614520f366ddcf@epcas5p2.samsung.com>
 <1483675149-32598-2-git-send-email-jcsing.lee@samsung.com>
 <20170106070539.wd3kfhi77pa5ekcy@kozik-lap>
 <586F4554.6020206@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <586F4554.6020206@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Jaechul Lee <jcsing.lee@samsung.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Kukjin Kim <kgene@kernel.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Andi Shyti <andi.shyti@samsung.com>, beomho.seo@samsung.com, galaxyra@gmail.com, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Fri, Jan 06, 2017 at 04:20:52PM +0900, Chanwoo Choi wrote:
> On 2017년 01월 06일 16:05, Krzysztof Kozlowski wrote:
> > On Fri, Jan 06, 2017 at 12:59:05PM +0900, Jaechul Lee wrote:
> >> From: Chanwoo Choi <cw00.choi@samsung.com>
> >>
> >> This patch fixes the wrong information of ldo23 and ldo25 on both TM2 and TM2E.
> > 
> > Please describe what is exactly wrong and how it affects the
> > system/user. This is going to the fixes so it needs a good explanation.
> 
> When I posted the patch[1], I refer to the old schematic document of both TM2 and TM2E.
> [1] 01e5d2352152 ("arm64: dts: exynos: Add dts file for Exynos5433-based TM2 board")
> 
> After checking the highest version of schematic document of both TM2 and TM2E,
> there is no difference of ldo23/ldo25 on both TM2 and TM2E.
> - ldo23 is used on TM2/TM2E, but the name/max-microvolt are wrong. 
> - ldo25 isn't used on TM2/TM2E. (not connected)
> 
> Because ldo23 and lod25 are not used on other device in Exynos5433 and TM2 board.
> this patch does not affect the operation to system/user.

If it does not affect anyone (including TM2/TM2E) then this do not have
to be a fix. Am I right?

Best regards,
Krzysztof
