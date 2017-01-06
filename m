From: Andi Shyti <andi.shyti@samsung.com>
Subject: Re: [PATCH v3 2/5] arm64: dts: exynos: make tm2 and tm2e independent
 from each other
Date: Fri, 06 Jan 2017 18:25:41 +0900
Message-ID: <20170106092541.zpdnuesdjo5vctlz@gangnam.samsung>
References: <1483675149-32598-1-git-send-email-jcsing.lee@samsung.com>
 <CGME20170106035914epcas5p209490dfca8e8ae83c6a9b5aa1408a1ed@epcas5p2.samsung.com>
 <1483675149-32598-3-git-send-email-jcsing.lee@samsung.com>
 <20170106070911.sj6qjd5akyxnazsl@kozik-lap>
 <20170106075914.y5nuak3bz3zrvvex@gangnam.samsung>
 <20170106083729.4odfu42knjxxudve@kozik-lap>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-disposition: inline
In-reply-to: <20170106083729.4odfu42knjxxudve@kozik-lap>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Chanwoo Choi <cw00.choi@samsung.com>, Catalin Marinas <catalin.marinas@arm.com>, Jaechul Lee <jcsing.lee@samsung.com>, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, Javier Martinez Canillas <javier@osg.samsung.com>, Rob Herring <robh+dt@kernel.org>, Kukjin Kim <kgene@kernel.org>, linux-input@vger.kernel.org, galaxyra@gmail.com, beomho.seo@samsung.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-input@vger.kernel.org

Hi Krzysztof,

> > > >  .../boot/dts/exynos/exynos5433-tm2-common.dtsi     | 1118 +++++++++++++++++++
> > > >  arch/arm64/boot/dts/exynos/exynos5433-tm2.dts      | 1153 +-------------------
> > > 
> > > Like talking to a wall. Without any feedback. If my instructions were
> > > wrong (and it is not possible to detect rename) then please say it (you
> > > can add personal comments after separator ---).
> > 
> > no Krzysztof, I'm sorry, but this patch has been formatted with
> > the diff algorithm *you* asked, -B50% both version 2 (where you
> > didn't comment) and version 3. If you still don't like it, please
> > don't blame me, blame the algorithm.
> 
> If you wrote it in cover letter or after '---' I wouldn't complain
> because I would know that my feedback was ignored. But here it is like
> black hole - I do not know whether I was ignored or it was not working.

In the cover letter is written:

 "- patch 3 diff has been generated with -B50%"

in "Changes in v2:". In v3 patch 3 has become patch 2.

> > Now we can stay here at trying random diff algorithms (as they
> > give more or less the same result) or you tell me which exact
> > algorithm you want me to use. Besides, for me it's clear,
> > tm2-common is all new, while in tm2 you have on one side the '-'
> > (if it applies nothing has changed) on the bottom the '+'.
> 
> Maybe that depends on the git?
> $ git --version 
> git version 2.9.3
> $ git format-patch -2 -B50%
> ...
>   21  ...ynos5433-tm2.dts => exynos5433-tm2-common.dtsi} |   24 +-
>   22  arch/arm64/boot/dts/exynos/exynos5433-tm2.dts      | 1153 +-------------------
>   23  arch/arm64/boot/dts/exynos/exynos5433-tm2e.dts     |   22 +-
>   24  3 files changed, 56 insertions(+), 1143 deletions(-)
>   25  copy arch/arm64/boot/dts/exynos/{exynos5433-tm2.dts => exynos5433-tm2-common.dtsi} (98%)
>   26  rewrite arch/arm64/boot/dts/exynos/exynos5433-tm2.dts (98%)

I guess you're right, this has been generated from Jaechul's PC
who perhaps has a different version. I have version 2.11.0 and I
have same output as you.

I will send the patch generated from my PC as reply to your mail.

Andi
