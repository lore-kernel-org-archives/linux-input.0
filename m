From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: Re: [PATCH v4 2/5] arm64: dts: exynos: make tm2 and tm2e independent
 from each other
Date: Fri, 6 Jan 2017 09:43:46 -0300
Message-ID: <705c08b2-e9f4-7998-c927-aa165ba7a102@osg.samsung.com>
References: <20170106114114.19321-1-andi.shyti@samsung.com>
 <CGME20170106114120epcas5p2dde13ec37b7e53f65b6899da9e7c7e60@epcas5p2.samsung.com>
 <20170106114114.19321-3-andi.shyti@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170106114114.19321-3-andi.shyti@samsung.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Andi Shyti <andi.shyti@samsung.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Chanwoo Choi <cw00.choi@samsung.com>, Beomho Seo <beomho.seo@samsung.com>
Cc: devicetree@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Jaechul Lee <jcsing.lee@samsung.com>, linux-kernel@vger.kernel.org, Andi Shyti <andi@etezian.org>, linux-input@vger.kernel.org, Jaechul Lee <galaxyra@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-input@vger.kernel.org

Hello Andi,

On 01/06/2017 08:41 AM, Andi Shyti wrote:
> Currently tm2e dts includes tm2 but there are some differences
> between the two boards and tm2 has some properties that tm2e
> doesn't have.
> 
> That's why it's important to keep the two dts files independent
> and put all the commonalities in a tm2-common.dtsi file.
> 
> At the current status the only two differences between the two
> dts files (besides the board name) are ldo31 and ldo38.
> 
> Signed-off-by: Andi Shyti <andi.shyti@samsung.com>
> ---

Patch looks good to me.

Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

I've some comments though:

> diff --git a/arch/arm64/boot/dts/exynos/exynos5433-tm2.dts b/arch/arm64/boot/dts/exynos/exynos5433-tm2.dts
> dissimilarity index 98%
> index e8971f4a5977..d30b45a9c0d4 100644
> --- a/arch/arm64/boot/dts/exynos/exynos5433-tm2.dts
> +++ b/arch/arm64/boot/dts/exynos/exynos5433-tm2.dts
> @@ -1,1120 +1,33 @@

[snip]

> -
> -/ {
> -	model = "Samsung TM2 board";
> -	compatible = "samsung,tm2", "samsung,exynos5433";
> -

[snip]

> +
> +/ {
> +	model = "Samsung TM2E board";
> +	compatible = "samsung,tm2e", "samsung,exynos5433";
> +};
> +

You ended with the wrong model and compatible for TM2.

Speaking about these, I noticed that the common .dtsi has the TM2 model and
compatible. I think those don't belong to .dtsi files and instead should be
defined on each .dts file.

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
