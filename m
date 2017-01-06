From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v4 1/5] arm64: dts: exynos5433: TM2/E: Fix wrong values
 foe ldo23 and ldo25
Date: Fri, 6 Jan 2017 14:01:49 +0200
Message-ID: <20170106120149.n2hak4vokip75pda@kozik-lap>
References: <20170106114114.19321-1-andi.shyti@samsung.com>
 <CGME20170106114120epcas5p21ed16e8f71152245f12fd00a8d73df0a@epcas5p2.samsung.com>
 <20170106114114.19321-2-andi.shyti@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20170106114114.19321-2-andi.shyti@samsung.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Andi Shyti <andi.shyti@samsung.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>, Catalin Marinas <catalin.marinas@arm.com>, Jaechul Lee <jcsing.lee@samsung.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Andi Shyti <andi@etezian.org>, linux-input@vger.kernel.org, Jaechul Lee <galaxyra@gmail.com>, Beomho Seo <beomho.seo@samsung.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-input@vger.kernel.org

On Fri, Jan 06, 2017 at 08:41:10PM +0900, Andi Shyti wrote:
> From: Chanwoo Choi <cw00.choi@samsung.com>
> 
> This patch fixes wrong values assigned to ldo23 and ldo25 on both TM2 and TM2E.
> 
> Fixes: 01e5d2352152 ("arm64: dts: exynos: Add dts file for Exynos5433-based TM2 board")
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> Signed-off-by: Andi Shyti <andi.shyti@samsung.com>
> ---
>  arch/arm64/boot/dts/exynos/exynos5433-tm2.dts  | 7 ++++---
>  arch/arm64/boot/dts/exynos/exynos5433-tm2e.dts | 9 ---------
>  2 files changed, 4 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/exynos/exynos5433-tm2.dts b/arch/arm64/boot/dts/exynos/exynos5433-tm2.dts
> index 3b5215c40fcd..e8971f4a5977 100644
> --- a/arch/arm64/boot/dts/exynos/exynos5433-tm2.dts
> +++ b/arch/arm64/boot/dts/exynos/exynos5433-tm2.dts
> @@ -504,9 +504,9 @@
>  			};
>  
>  			ldo23_reg: LDO23 {
> -				regulator-name = "CAM_SEN_CORE_1.2V_AP";
> +				regulator-name = "CAM_SEN_CORE_1.05V_AP";
>  				regulator-min-microvolt = <1050000>;
> -				regulator-max-microvolt = <1200000>;
> +				regulator-max-microvolt = <1050000>;
>  			};
>  
>  			ldo24_reg: LDO24 {
> @@ -516,9 +516,10 @@
>  			};
>  
>  			ldo25_reg: LDO25 {
> -				regulator-name = "CAM_SEN_A2.8V_AP";
> +				regulator-name = "UNUSED_LDO25";
>  				regulator-min-microvolt = <2800000>;
>  				regulator-max-microvolt = <2800000>;
> +				regulator-always-off;

No. I mentioned in last email that this property is wrong.

When resubmitting, please fix the subject prefix.

Best regards,
Krzysztof
