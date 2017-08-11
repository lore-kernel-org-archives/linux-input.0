From: Chen Zhong <chen.zhong@mediatek.com>
Subject: Re: [PATCH v2 2/5] dt-bindings: input: Add document bindings for
 mtk-pmic-keys
Date: Fri, 11 Aug 2017 15:01:32 +0800
Message-ID: <1502434892.28466.18.camel@mhfsdcap03>
References: <1502071065-6745-1-git-send-email-chen.zhong@mediatek.com>
         <1502071065-6745-3-git-send-email-chen.zhong@mediatek.com>
         <20170810204136.eghsslqq6d5fqg5d@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailgw01.mediatek.com ([210.61.82.183]:28879 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751521AbdHKHBl (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 11 Aug 2017 03:01:41 -0400
In-Reply-To: <20170810204136.eghsslqq6d5fqg5d@rob-hp-laptop>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Mark Rutland <mark.rutland@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>, Lee Jones <lee.jones@linaro.org>, Eddie Huang <eddie.huang@mediatek.com>, Alessandro Zummo <a.zummo@towertech.it>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Jaechul Lee <jcsing.lee@samsung.com>, Jonathan Cameron <jic23@kernel.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Linus Walleij <linus.walleij@linaro.org>, Beomho Seo <beomho.seo@samsung.com>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org

Hi Rob,

On Thu, 2017-08-10 at 15:41 -0500, Rob Herring wrote:
> On Mon, Aug 07, 2017 at 09:57:42AM +0800, Chen Zhong wrote:
> > This patch adds the device tree binding documentation for the MediaTek
> > pmic keys found on PMIC MT6397/MT6323.
> > 
> > Signed-off-by: Chen Zhong <chen.zhong@mediatek.com>
> > ---
> >  .../devicetree/bindings/input/mtk-pmic-keys.txt    |   36 ++++++++++++++++++++
> >  1 file changed, 36 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/input/mtk-pmic-keys.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/input/mtk-pmic-keys.txt b/Documentation/devicetree/bindings/input/mtk-pmic-keys.txt
> > new file mode 100644
> > index 0000000..c5b230f
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/input/mtk-pmic-keys.txt
> > @@ -0,0 +1,36 @@
> > +MediaTek MT6397/MT6323 PMIC Keys Device Driver
> > +
> > +There are two key functions provided by MT6397/MT6323 PMIC, pwrkey
> > +and homekey. The key functions are defined as the subnode of the function
> > +node provided by MT6397/MT6323 PMIC that is being defined as one kind
> > +of Muti-Function Device (MFD)
> > +
> > +For MT6397/MT6323 MFD bindings see:
> > +Documentation/devicetree/bindings/mfd/mt6397.txt
> > +
> > +Required properties:
> > +- compatible: "mediatek,mt6397-keys" or "mediatek,mt6323-keys"
> > +- mediatek,pwrkey-code: Keycode of pwrkey
> > +
> > +Optional Properties:
> > +- mediatek,homekey-code: Keycode of homekey
> > +- mediatek,long-press-mode: Long press key shutdown setting, 1 for
> > +	pwrkey only, 2 for pwrkey/homekey together, others for disabled.
> > +- mediatek,long-press-duration: Long press key shutdown duration setting,
> > +	0/1/2/3 for 8/11/14/5 seconds.
> 
> Surely this could be a common property.

Sorry I'm not very clear about this. Could i move this to required
properties or remove the "mediatek" string here?

> 
> > +
> > +Example:
> > +
> > +	pmic: mt6397 {
> > +		compatible = "mediatek,mt6397";
> > +
> > +		...
> > +
> > +		mt6397keys: mt6397keys {
> > +			compatible = "mediatek,mt6397-keys";
> > +			mediatek,pwrkey-code = <116>;
> > +			mediatek,homekey-code = <114>;
> 
> We have a standard properties for keycodes.

Could i write them like this way?

linux,keycodes = <KEY_POWER>, <KEY_VOLUMEDOWN>

> 
> > +			mediatek,long-press-mode = <1>;
> > +			mediatek,long-press-duration = <0>;
> > +		};
> > +	};
> > \ No newline at end of file
> > -- 
> > 1.7.9.5
> > 

Thanks.

