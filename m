From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v5 1/5] arm64: dts: exynos5433: TM2/E: Fix wrong values
 for ldo23 and ldo25
Date: Fri, 6 Jan 2017 16:01:57 +0200
Message-ID: <20170106140157.6xn34r5kkuattzsh@kozik-lap>
References: <20170106134350.32428-1-andi.shyti@samsung.com>
 <CGME20170106134355epcas1p1c201edf5dabed68506eb6bf9f9e0a1ee@epcas1p1.samsung.com>
 <20170106134350.32428-2-andi.shyti@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20170106134350.32428-2-andi.shyti@samsung.com>
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

On Fri, Jan 06, 2017 at 10:43:46PM +0900, Andi Shyti wrote:
> From: Chanwoo Choi <cw00.choi@samsung.com>
> 
> This patch fixes wrong values assigned to ldo23 and ldo25 on both TM2 and TM2E.
> 
> Fixes: 01e5d2352152 ("arm64: dts: exynos: Add dts file for Exynos5433-based TM2 board")
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>
> Signed-off-by: Andi Shyti <andi.shyti@samsung.com>
> ---
>  arch/arm64/boot/dts/exynos/exynos5433-tm2.dts  | 6 +++---
>  arch/arm64/boot/dts/exynos/exynos5433-tm2e.dts | 9 ---------
>  2 files changed, 3 insertions(+), 12 deletions(-)
> 

Thanks, applied.

Best regards,
Krzysztof
