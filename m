From: Andi Shyti <andi.shyti@samsung.com>
Subject: Re: [PATCH v3 2/5] arm64: dts: exynos: make tm2 and tm2e independent
 from each other
Date: Fri, 06 Jan 2017 16:59:14 +0900
Message-ID: <20170106075914.y5nuak3bz3zrvvex@gangnam.samsung>
References: <1483675149-32598-1-git-send-email-jcsing.lee@samsung.com>
 <CGME20170106035914epcas5p209490dfca8e8ae83c6a9b5aa1408a1ed@epcas5p2.samsung.com>
 <1483675149-32598-3-git-send-email-jcsing.lee@samsung.com>
 <20170106070911.sj6qjd5akyxnazsl@kozik-lap>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:43830 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753834AbdAFH7U (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Fri, 6 Jan 2017 02:59:20 -0500
Content-disposition: inline
In-reply-to: <20170106070911.sj6qjd5akyxnazsl@kozik-lap>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Jaechul Lee <jcsing.lee@samsung.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Kukjin Kim <kgene@kernel.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, beomho.seo@samsung.com, galaxyra@gmail.com, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org

Hi, 

On Fri, Jan 06, 2017 at 09:09:11AM +0200, Krzysztof Kozlowski wrote:
> On Fri, Jan 06, 2017 at 12:59:06PM +0900, Jaechul Lee wrote:
> > From: Andi Shyti <andi.shyti@samsung.com>
> > 
> > Currently tm2e dts includes tm2 but there are some differences
> > between the two boards and tm2 has some properties that tm2e
> > doesn't have.
> > 
> > That's why it's important to keep the two dts files independent
> > and put all the commonalities in a tm2-common.dtsi file.
> > 
> > At the current status the only two differences between the two
> > dts files (besides the board name) are ldo31 and ldo38.
> > 
> > Signed-off-by: Andi Shyti <andi.shyti@samsung.com>
> > Signed-off-by: Jaechul Lee <jcsing.lee@samsung.com>
> > ---
> >  .../boot/dts/exynos/exynos5433-tm2-common.dtsi     | 1118 +++++++++++++++++++
> >  arch/arm64/boot/dts/exynos/exynos5433-tm2.dts      | 1153 +-------------------
> 
> Like talking to a wall. Without any feedback. If my instructions were
> wrong (and it is not possible to detect rename) then please say it (you
> can add personal comments after separator ---).

no Krzysztof, I'm sorry, but this patch has been formatted with
the diff algorithm *you* asked, -B50% both version 2 (where you
didn't comment) and version 3. If you still don't like it, please
don't blame me, blame the algorithm.

Now we can stay here at trying random diff algorithms (as they
give more or less the same result) or you tell me which exact
algorithm you want me to use. Besides, for me it's clear,
tm2-common is all new, while in tm2 you have on one side the '-'
(if it applies nothing has changed) on the bottom the '+'.

Andi
