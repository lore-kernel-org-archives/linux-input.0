From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH 3/4] arm64: dts: exynos: make tm2 and tm2e independent
 from each other
Date: Tue, 3 Jan 2017 10:27:29 +0200
Message-ID: <CAJKOXPev9m07_dQWAvJ+=MKnbT0TFERKOtjWUDU+WXdGAiRyDA@mail.gmail.com>
References: <CGME20170103075734epcas5p43a9743131f63affd0a438d2ed342f22e@epcas5p4.samsung.com>
 <1483430237-26823-1-git-send-email-jcsing.lee@samsung.com> <1483430237-26823-4-git-send-email-jcsing.lee@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:59902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934604AbdACI1d (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 3 Jan 2017 03:27:33 -0500
In-Reply-To: <1483430237-26823-4-git-send-email-jcsing.lee@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jaechul Lee <jcsing.lee@samsung.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Kukjin Kim <kgene@kernel.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Andi Shyti <andi.shyti@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, beomho.seo@samsung.com, galaxyra@gmail.com, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org

On Tue, Jan 3, 2017 at 9:57 AM, Jaechul Lee <jcsing.lee@samsung.com> wrote:
> From: Andi Shyti <andi.shyti@samsung.com>
>
> Currently tm2e dts includes tm2 but there are some differences
> between the two boards and tm2 has some properties that tm2e
> doesn't have.
>
> That's why it's important to keep the two dts files independent
> and put all the commonalities in a tm2-common.dtsi file.
>
> Signed-off-by: Andi Shyti <andi.shyti@samsung.com>
> Signed-off-by: Jaechul Lee <jcsing.lee@samsung.com>
> ---
>  .../boot/dts/exynos/exynos5433-tm2-common.dtsi     | 1046 ++++++++++++++++++++
>  arch/arm64/boot/dts/exynos/exynos5433-tm2.dts      | 1033 +------------------
>  arch/arm64/boot/dts/exynos/exynos5433-tm2e.dts     |    2 +-
>  3 files changed, 1049 insertions(+), 1032 deletions(-)
>  create mode 100644 arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi

I would like to see here the rename and diff from it. Not entire delta
(deletions and addons). It is not possible to compare it... I think
git supports it by default with similarity of 50%.

Best regards,
Krzysztof
