From: Chen Zhong <chen.zhong@mediatek.com>
Subject: Re: [PATCH v3 2/5] dt-bindings: input: Add document bindings for
 mtk-pmic-keys
Date: Fri, 1 Sep 2017 10:00:05 +0800
Message-ID: <1504231205.15359.9.camel@mhfsdcap03>
References: <1503642753-12385-1-git-send-email-chen.zhong@mediatek.com>
         <1503642753-12385-3-git-send-email-chen.zhong@mediatek.com>
         <20170831195239.b2litxbu7smhkkjl@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170831195239.b2litxbu7smhkkjl@rob-hp-laptop>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Mark Rutland <mark.rutland@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>, Lee Jones <lee.jones@linaro.org>, Eddie Huang <eddie.huang@mediatek.com>, Alessandro Zummo <a.zummo@towertech.it>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Andi Shyti <andi.shyti@samsung.com>, Javier Martinez Canillas <javier@osg.samsung.com>, Linus Walleij <linus.walleij@linaro.org>, Jaechul Lee <jcsing.lee@samsung.com>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Thu, 2017-08-31 at 14:52 -0500, Rob Herring wrote:
> On Fri, Aug 25, 2017 at 02:32:30PM +0800, Chen Zhong wrote:
> > This patch adds the device tree binding documentation for the MediaTek
> > pmic keys found on PMIC MT6397/MT6323.
> > 
> > Signed-off-by: Chen Zhong <chen.zhong@mediatek.com>
> > ---
> >  .../devicetree/bindings/input/mtk-pmic-keys.txt    |   38 ++++++++++++++++++++
> >  1 file changed, 38 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/input/mtk-pmic-keys.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/input/mtk-pmic-keys.txt b/Documentation/devicetree/bindings/input/mtk-pmic-keys.txt
> > new file mode 100644
> > index 0000000..100ec44
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/input/mtk-pmic-keys.txt
> > @@ -0,0 +1,38 @@
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
> > +- linux,keycodes: Specifies the numeric keycode values to
> > +	be used for reporting keys presses. The array can
> > +	contain up to 2 entries.
> > +
> > +Optional Properties:
> > +- wakeup-source: each key can be used as a wakeup source.
> 
> wakeup-source is defined as a boolean.

Hi Rob,

We have two keys, maybe one key can be used as a wakeup source, another
not.Since wakeup-source is defined as a boolean, we cannot distinguish
the behavior of the two keys. May i know the better way to do this?

Thank you.
> 
> > +- mediatek,long-press-mode: Long press key shutdown setting, 1 for
> > +	pwrkey only, 2 for pwrkey/homekey together, others for disabled.
> > +- debounce-interval: Long press key shutdown debouncing interval time
> > +	in seconds. 0/1/2/3 for 8/11/14/5 seconds. If not specified defaults to 0.
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
> > +			linux,keycodes = <KEY_POWER>, <KEY_VOLUMEDOWN>;
> > +			wakeup-source = <1>, <0>;
> > +			mediatek,long-press-mode = <1>;
> > +			debounce-interval = <0>;
> > +		};
> > +	};
> > -- 
> > 1.7.9.5
> > 
