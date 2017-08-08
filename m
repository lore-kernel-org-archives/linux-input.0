From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v2 1/5] mfd: mt6397: create irq mappings in mfd core
 driver
Date: Tue, 8 Aug 2017 12:14:13 +0100
Message-ID: <20170808111413.qt6qc2w6l6gdihpu@dell>
References: <1502071065-6745-1-git-send-email-chen.zhong@mediatek.com>
 <1502071065-6745-2-git-send-email-chen.zhong@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:35724 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752176AbdHHLOR (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Tue, 8 Aug 2017 07:14:17 -0400
Received: by mail-wm0-f46.google.com with SMTP id m85so4385044wma.0
        for <linux-input@vger.kernel.org>; Tue, 08 Aug 2017 04:14:16 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1502071065-6745-2-git-send-email-chen.zhong@mediatek.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chen Zhong <chen.zhong@mediatek.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>, Eddie Huang <eddie.huang@mediatek.com>, Alessandro Zummo <a.zummo@towertech.it>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Jaechul Lee <jcsing.lee@samsung.com>, Jonathan Cameron <jic23@kernel.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Linus Walleij <linus.walleij@linaro.org>, Beomho Seo <beomho.seo@samsung.com>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org

On Mon, 07 Aug 2017, Chen Zhong wrote:

> The core driver should create and manage irq mappings instead of
> leaf drivers. This patch change to pass irq domain to
> devm_mfd_add_devices() and it will create mapping for irq resources
> automatically. And remove irq mapping in rtc driver since this has
> been done in core driver.
> 
> Signed-off-by: Chen Zhong <chen.zhong@mediatek.com>
> ---
>  drivers/mfd/mt6397-core.c |    4 ++--
>  drivers/rtc/rtc-mt6397.c  |    2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)

Once you've fixed Dmitry's comment:

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
