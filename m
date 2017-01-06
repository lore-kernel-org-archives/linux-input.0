From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: Re: [PATCH v4 1/5] arm64: dts: exynos5433: TM2/E: Fix wrong values
 foe ldo23 and ldo25
Date: Fri, 6 Jan 2017 09:09:21 -0300
Message-ID: <5f0740a0-8799-f414-38bc-d40911613ae3@osg.samsung.com>
References: <20170106114114.19321-1-andi.shyti@samsung.com>
 <CGME20170106114120epcas5p21ed16e8f71152245f12fd00a8d73df0a@epcas5p2.samsung.com>
 <20170106114114.19321-2-andi.shyti@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
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
To: Andi Shyti <andi.shyti@samsung.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Chanwoo Choi <cw00.choi@samsung.com>, Beomho Seo <beomho.seo@samsung.com>
Cc: devicetree@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Jaechul Lee <jcsing.lee@samsung.com>, linux-kernel@vger.kernel.org, Andi Shyti <andi@etezian.org>, linux-input@vger.kernel.org, Jaechul Lee <galaxyra@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-input@vger.kernel.org

Hello Andi,

On 01/06/2017 08:41 AM, Andi Shyti wrote:
> From: Chanwoo Choi <cw00.choi@samsung.com>
> 
> This patch fixes wrong values assigned to ldo23 and ldo25 on both TM2 and TM2E.
> 
> Fixes: 01e5d2352152 ("arm64: dts: exynos: Add dts file for Exynos5433-based TM2 board")
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> Signed-off-by: Andi Shyti <andi.shyti@samsung.com>
> ---

I don't have the schematics to check, but the patch looks good to me
besides the "regulator-always-off" property as Krzysztof mentioned.

Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
