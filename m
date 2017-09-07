From: Chen Zhong <chen.zhong@mediatek.com>
Subject: Re: [PATCH v3 2/5] dt-bindings: input: Add document bindings for
 mtk-pmic-keys
Date: Thu, 7 Sep 2017 11:05:40 +0800
Message-ID: <1504753540.9882.15.camel@mhfsdcap03>
References: <1503642753-12385-1-git-send-email-chen.zhong@mediatek.com>
         <1503642753-12385-3-git-send-email-chen.zhong@mediatek.com>
         <20170831195239.b2litxbu7smhkkjl@rob-hp-laptop>
         <1504318583.15359.12.camel@mhfsdcap03>
         <CAL_JsqLe3o+iw0Wh=g5Ks93qM1BR1+S04Nv1R3FV17Z3dph1jg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailgw02.mediatek.com ([210.61.82.184]:63254 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752616AbdIGDFs (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Wed, 6 Sep 2017 23:05:48 -0400
In-Reply-To: <CAL_JsqLe3o+iw0Wh=g5Ks93qM1BR1+S04Nv1R3FV17Z3dph1jg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Mark Rutland <mark.rutland@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>, Lee Jones <lee.jones@linaro.org>, Eddie Huang <eddie.huang@mediatek.com>, Alessandro Zummo <a.zummo@towertech.it>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Andi Shyti <andi.shyti@samsung.com>, Javier Martinez Canillas <javier@osg.samsung.com>, Linus Walleij <linus.walleij@linaro.org>, Jaechul Lee <jcsing.lee@samsung.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-mediatek@lists.infradead.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Tue, 2017-09-05 at 11:05 -0500, Rob Herring wrote:
> On Fri, Sep 1, 2017 at 9:16 PM, Chen Zhong <chen.zhong@mediatek.com> wrote:
> > On Thu, 2017-08-31 at 14:52 -0500, Rob Herring wrote:
> >> On Fri, Aug 25, 2017 at 02:32:30PM +0800, Chen Zhong wrote:
> >> > This patch adds the device tree binding documentation for the MediaTek
> >> > pmic keys found on PMIC MT6397/MT6323.
> >> >
> >> > Signed-off-by: Chen Zhong <chen.zhong@mediatek.com>
> >> > ---
> >> >  .../devicetree/bindings/input/mtk-pmic-keys.txt    |   38 ++++++++++++++++++++
> >> >  1 file changed, 38 insertions(+)
> >> >  create mode 100644 Documentation/devicetree/bindings/input/mtk-pmic-keys.txt
> >> >
> >> > diff --git a/Documentation/devicetree/bindings/input/mtk-pmic-keys.txt b/Documentation/devicetree/bindings/input/mtk-pmic-keys.txt
> >> > new file mode 100644
> >> > index 0000000..100ec44
> >> > --- /dev/null
> >> > +++ b/Documentation/devicetree/bindings/input/mtk-pmic-keys.txt
> >> > @@ -0,0 +1,38 @@
> >> > +MediaTek MT6397/MT6323 PMIC Keys Device Driver
> >> > +
> >> > +There are two key functions provided by MT6397/MT6323 PMIC, pwrkey
> >> > +and homekey. The key functions are defined as the subnode of the function
> >> > +node provided by MT6397/MT6323 PMIC that is being defined as one kind
> >> > +of Muti-Function Device (MFD)
> >> > +
> >> > +For MT6397/MT6323 MFD bindings see:
> >> > +Documentation/devicetree/bindings/mfd/mt6397.txt
> >> > +
> >> > +Required properties:
> >> > +- compatible: "mediatek,mt6397-keys" or "mediatek,mt6323-keys"
> >> > +- linux,keycodes: Specifies the numeric keycode values to
> >> > +   be used for reporting keys presses. The array can
> >> > +   contain up to 2 entries.
> >> > +
> >> > +Optional Properties:
> >> > +- wakeup-source: each key can be used as a wakeup source.
> >>
> >> wakeup-source is defined as a boolean.
> >
> > Hi Rob,
> >
> > Could I modify it as this?
> >
> > mediatek,wakeup-keys = <1>, <0>;
> > wakeup-source;
> 
> What do the values and index signify? The power key is index 0 and the
> value 1 means enable wakeup? Or each value is the raw key (i.e.
> indexes in linux,keycode) that wakeup is enabled for?
> 
> I don't think this should be in DT really. It's really up to the user
> (i.e. userspace) to decide what keys cause wakeup (or maybe that's
> only suspend). If you default to the power key causes wakeup, do you
> really need to support different options?
> 
> If we do put this in DT, then it should be a common binding to specify
> keys that cause wake-up.
> 
> Rob

Hi Rob,

Yes, we want to describe that power key is index 0 and is a wakeup
source, homekey is index 1 and not a wakeup source.

Since power key and homekey are two real HW keys, customer can decide
which key to be the wakeup source or both due to their hw design, so we
put this in DT and can be different for different boards.

Thank you.

Chen


