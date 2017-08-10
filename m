From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 3/5] dt-bindings: mfd: Add bindings for the keys as
 subnode of PMIC
Date: Thu, 10 Aug 2017 15:42:05 -0500
Message-ID: <20170810204205.i4k56dophgvfyjrv@rob-hp-laptop>
References: <1502071065-6745-1-git-send-email-chen.zhong@mediatek.com>
 <1502071065-6745-4-git-send-email-chen.zhong@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:36999 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753126AbdHJUmH (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 10 Aug 2017 16:42:07 -0400
Content-Disposition: inline
In-Reply-To: <1502071065-6745-4-git-send-email-chen.zhong@mediatek.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chen Zhong <chen.zhong@mediatek.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Mark Rutland <mark.rutland@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>, Lee Jones <lee.jones@linaro.org>, Eddie Huang <eddie.huang@mediatek.com>, Alessandro Zummo <a.zummo@towertech.it>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Jaechul Lee <jcsing.lee@samsung.com>, Jonathan Cameron <jic23@kernel.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Linus Walleij <linus.walleij@linaro.org>, Beomho Seo <beomho.seo@samsung.com>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org

On Mon, Aug 07, 2017 at 09:57:43AM +0800, Chen Zhong wrote:
> This patch adds documentation for device tree bindings for keys support
> as the subnode of MT6397/MT6323 PMIC.
> 
> Signed-off-by: Chen Zhong <chen.zhong@mediatek.com>
> ---
>  Documentation/devicetree/bindings/mfd/mt6397.txt |    6 ++++++
>  1 file changed, 6 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
