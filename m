From: Chen Zhong <chen.zhong@mediatek.com>
Subject: Re: [PATCH v3 4/5] input: Add MediaTek PMIC keys support
Date: Tue, 29 Aug 2017 10:11:35 +0800
Message-ID: <1503972695.3340.16.camel@mhfsdcap03>
References: <1503642753-12385-1-git-send-email-chen.zhong@mediatek.com>
         <1503642753-12385-5-git-send-email-chen.zhong@mediatek.com>
         <20170828165757.GE12195@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170828165757.GE12195@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>, Lee Jones <lee.jones@linaro.org>, Eddie Huang <eddie.huang@mediatek.com>, Alessandro Zummo <a.zummo@towertech.it>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Andi Shyti <andi.shyti@samsung.com>, Javier Martinez Canillas <javier@osg.samsung.com>, Linus Walleij <linus.walleij@linaro.org>, Jaechul Lee <jcsing.lee@samsung.com>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, 2017-08-28 at 09:57 -0700, Dmitry Torokhov wrote:
> Hi Chen,
> 
> On Fri, Aug 25, 2017 at 02:32:32PM +0800, Chen Zhong wrote:
> > +static int mtk_pmic_key_setup(struct mtk_pmic_keys *keys,
> > +		struct pmic_keys_info *info)
> > +{
> > +	int ret;
> > +
> > +	info->keys = keys;
> > +
> > +	ret = regmap_update_bits(keys->regmap, info->regs->intsel_reg,
> > +				 info->regs->intsel_mask,
> > +				 info->regs->intsel_mask);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	ret = devm_request_threaded_irq(keys->dev, info->irq, NULL,
> > +					mtk_pmic_keys_irq_handler_thread,
> > +					IRQF_ONESHOT | IRQF_TRIGGER_HIGH,
> > +					"mtk-pmic-keys", info);
> > +	if (ret) {
> > +		dev_err(keys->dev, "Failed to request IRQ: %d: %d\n",
> > +			info->irq, ret);
> > +		return ret;
> > +	}
> > +
> > +	if (info->wakeup)
> > +		irq_set_irq_wake(info->irq, 1);
> 
> Normally we do this in suspend() (and undo in resume()), and I believe
> the drover API is enable_irq_wake() and disable_irq_wake().
> 

Hi Dmitry,

I'll add suspend/resume callback functions and do this with
enable_irq_wake() and disable_irq_wake().

Thank you.


> Thanks.
> 
