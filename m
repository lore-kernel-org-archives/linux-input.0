From: Andi Shyti <andi.shyti@samsung.com>
Subject: Re: [PATCH 3/4] arm64: dts: exynos: make tm2 and tm2e independent from
 each other
Date: Tue, 03 Jan 2017 17:16:24 +0900
Message-ID: <20170103081624.wo3molbmpxtvafcz@gangnam.samsung>
References: <1483430237-26823-1-git-send-email-jcsing.lee@samsung.com>
 <CGME20170103075734epcas5p43a9743131f63affd0a438d2ed342f22e@epcas5p4.samsung.com>
 <1483430237-26823-4-git-send-email-jcsing.lee@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:60895 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933594AbdACIQ2 (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Tue, 3 Jan 2017 03:16:28 -0500
Content-disposition: inline
In-reply-to: <1483430237-26823-4-git-send-email-jcsing.lee@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jaechul Lee <jcsing.lee@samsung.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, beomho.seo@samsung.com, galaxyra@gmail.com, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org

Hi,

> +	compatible = "samsung,tm2e", "samsung,exynos5433";

this is supposed to be "samsung,tm2".
Will wait for other comments and fix it in v2.

Andi
