From: Andi Shyti <andi.shyti@samsung.com>
Subject: Re: [PATCH v2 3/4] arm64: dts: exynos: make tm2 and tm2e independent
 from each other
Date: Thu, 05 Jan 2017 18:23:15 +0900
Message-ID: <20170105092315.swensammin4wbgx5@gangnam.samsung>
References: <1483604833-29746-1-git-send-email-jcsing.lee@samsung.com>
 <CGME20170105082716epcas1p1f2a6eea40d842e2d8f7f7f54c029bc82@epcas1p1.samsung.com>
 <1483604833-29746-4-git-send-email-jcsing.lee@samsung.com>
 <586E0E56.6050608@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-disposition: inline
In-reply-to: <586E0E56.6050608@samsung.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Chanwoo Choi <cw00.choi@samsung.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, Jaechul Lee <jcsing.lee@samsung.com>, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Rob Herring <robh+dt@kernel.org>, Kukjin Kim <kgene@kernel.org>, linux-input@vger.kernel.org, galaxyra@gmail.com, beomho.seo@samsung.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-input@vger.kernel.org

Hi Chanwoo,

> I add the some comment as following:
> - ldo23/25/31/38 have the different value between tm2 and tm2e.

Thanks for pointing this out. I planned to do this already in a
following patch as for now I think it's out from the scope of this
particular patch.

> - The patch[1] was alread posted. I think you better to rebase this patch on patch[1].
> [1] https://patchwork.kernel.org/patch/9491769/
> - ("ARM64: dts: TM2: comply to the samsung pinctrl naming convention")

Yes, I also thought about this, but I didn't know whether it was
already picked by anyone. I didn't want to stop Jaechul that's
why I was planning to rebase the other rather than this.
But you are right, because some bits of the other patches I know
that have been merged. Thank you!

Krzysztof, do you mind if I send patch 3 as a reply to this
e-mail? The changes should not affect patch 4, anyway.

Thanks,
Andi
