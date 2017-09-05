From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v3 5/5] mfd: mt6397: Add PMIC keys support to MT6397
 driver
Date: Tue, 5 Sep 2017 08:37:11 +0100
Message-ID: <20170905073711.vj75nniqg2ajkoeg@dell>
References: <1503642753-12385-1-git-send-email-chen.zhong@mediatek.com>
 <1503642753-12385-6-git-send-email-chen.zhong@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1503642753-12385-6-git-send-email-chen.zhong@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chen Zhong <chen.zhong@mediatek.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>, Eddie Huang <eddie.huang@mediatek.com>, Alessandro Zummo <a.zummo@towertech.it>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Andi Shyti <andi.shyti@samsung.com>, Javier Martinez Canillas <javier@osg.samsung.com>, Linus Walleij <linus.walleij@linaro.org>, Jaechul Lee <jcsing.lee@samsung.com>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Fri, 25 Aug 2017, Chen Zhong wrote:

> This patch adds compatible strings and interrupts for pmic keys
> which serves as child device of MFD.
> 
> Signed-off-by: Chen Zhong <chen.zhong@mediatek.com>
> ---
>  drivers/mfd/mt6397-core.c |   22 +++++++++++++++++++++-
>  1 file changed, 21 insertions(+), 1 deletion(-)

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
