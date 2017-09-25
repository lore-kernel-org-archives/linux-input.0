From: Chen Zhong <chen.zhong@mediatek.com>
Subject: Re: [PATCH v4 2/5] dt-bindings: input: Add document bindings for
 mtk-pmic-keys
Date: Mon, 25 Sep 2017 16:14:16 +0800
Message-ID: <1506327256.19409.16.camel@mhfsdcap03>
References: <1505635252-27716-1-git-send-email-chen.zhong@mediatek.com>
         <1505635252-27716-3-git-send-email-chen.zhong@mediatek.com>
         <20170920205301.v6gpmhll4pdpuyxv@rob-hp-laptop>
         <1506148695.19409.10.camel@mhfsdcap03>
         <1506149223.19409.11.camel@mhfsdcap03>
         <CAL_JsqJZtn7YLn6o9mQMPD+kuseKLbfKe+JiY=1BosqnVqi5Kw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailgw02.mediatek.com ([210.61.82.184]:49463 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751408AbdIYIOY (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 25 Sep 2017 04:14:24 -0400
In-Reply-To: <CAL_JsqJZtn7YLn6o9mQMPD+kuseKLbfKe+JiY=1BosqnVqi5Kw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lee Jones <lee.jones@linaro.org>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Mark Rutland <mark.rutland@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>, Eddie Huang <eddie.huang@mediatek.com>, Alessandro Zummo <a.zummo@towertech.it>, Andi Shyti <andi.shyti@samsung.com>, Jaechul Lee <jcsing.lee@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-mediatek@lists.infradead.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>li

On Sun, 2017-09-24 at 23:11 -0500, Rob Herring wrote:
> On Sat, Sep 23, 2017 at 1:47 AM, Chen Zhong <chen.zhong@mediatek.com> wrote:
> > Sorry for the typo.
> >
> > On Sat, 2017-09-23 at 14:38 +0800, Chen Zhong wrote:
> >> On Wed, 2017-09-20 at 15:53 -0500, Rob Herring wrote:
> >> > On Sun, Sep 17, 2017 at 04:00:49PM +0800, Chen Zhong wrote:
> >> > > This patch adds the device tree binding documentation for the MediaTek
> >> > > pmic keys found on PMIC MT6397/MT6323.
> >> > >
> >> > > Signed-off-by: Chen Zhong <chen.zhong@mediatek.com>
> >> > > ---
> >> > >  .../devicetree/bindings/input/mtk-pmic-keys.txt    |   41 ++++++++++++++++++++
> >> > >  1 file changed, 41 insertions(+)
> >> > >  create mode 100644 Documentation/devicetree/bindings/input/mtk-pmic-keys.txt
> >> > >
> >> > > diff --git a/Documentation/devicetree/bindings/input/mtk-pmic-keys.txt b/Documentation/devicetree/bindings/input/mtk-pmic-keys.txt
> >> > > new file mode 100644
> >> > > index 0000000..fd48ff7
> >> > > --- /dev/null
> >> > > +++ b/Documentation/devicetree/bindings/input/mtk-pmic-keys.txt
> >> > > @@ -0,0 +1,41 @@
> >> > > +MediaTek MT6397/MT6323 PMIC Keys Device Driver
> >> > > +
> >> > > +There are two key functions provided by MT6397/MT6323 PMIC, pwrkey
> >> > > +and homekey. The key functions are defined as the subnode of the function
> >> > > +node provided by MT6397/MT6323 PMIC that is being defined as one kind
> >> > > +of Muti-Function Device (MFD)
> >> > > +
> >> > > +For MT6397/MT6323 MFD bindings see:
> >> > > +Documentation/devicetree/bindings/mfd/mt6397.txt
> >> > > +
> >> > > +Required properties:
> >> > > +- compatible: "mediatek,mt6397-keys" or "mediatek,mt6323-keys"
> >> > > +- linux,keycodes: Specifies the numeric keycode values to
> >> > > + be used for reporting keys presses. The array can
> >> > > + contain up to 2 entries.
> >> > > +
> >> > > +Optional Properties:
> >> > > +- mediatek,wakeup-keys: Specifies each key can be used as a wakeup source
> >> > > + or not. This can be customized depends on board design.
> >> >
> >> > I think this should be a common property if we're going to put into DT.
> >> > Something like "wakeup-scancodes" to be clear the values are the raw
> >> > scancodes. Alternatively, we could list Linux keycodes instead with
> >> > something like "linux,wakeup-keycodes".
> >> >
> >> > > +- wakeup-source: PMIC keys can be used as wakeup sources.
> >> >
> >> > Just "See ../power/wakeup-source.txt" for the description.
> >> >
> >> > > +- mediatek,long-press-mode: Long press key shutdown setting, 1 for
> >> > > + pwrkey only, 2 for pwrkey/homekey together, others for disabled.
> >> > > +- debounce-interval: Long press key shutdown debouncing interval time
> >> > > + in seconds. 0/1/2/3 for 8/11/14/5 seconds. If not specified defaults to 0.
> >> >
> >> > This property units should be in milliseconds. However, this doesn't
> >> > sound like debounce filtering time if 5-14 seconds. That sounds like
> >> > forced power off time (i.e. for a hung device). This also should be
> >> > common. I imagine we already have some drivers with similar properties.
> >>
> >> Hi Rob,
> >>
> >> I searched in kernel documents and found a similar usage in
> >> "ti,palmas-pwrbutton.txt"
> >> "- ti,palmas-long-press-seconds: Duration in seconds which the power
> >>   button should be kept pressed for Palmas to power off automatically."
> >>
> >> Could I just wrote it like this?
> >> mediatek,long-press-seconds = <0>;
> 
> That doesn't really tell what the long press does. How about
> "power-off-time-sec"? Surprisingly we don't have a common keyboard
> binding doc, so please start one and document it there. Then just
> refer to it.
> 

OK, I will add a common document named "keys.txt" and put the long press
property "power-off-time-sec" there as a common property.

> >>
> >> And for the wakeup source part, how about Dmitry's suggestion?
> 
> It's fine for me.
> 
> >> The whole device node would be:
> >>
> >> mt6397keys: mt6397keys {
> >>       compatible = "mediatek,mt6397-keys";
> >>       mediatek,long-press-mode = <1>;
> >>       mediatek,long-press-seconds = <0>;
> >>
> >>       power@0 {
> >>               linux,code = <116>;
> 
> linux,keycodes
> 
> Also, you either need a reg property with "0" or drop the unit address.

There is no need to add reg property here, I'll drop the unit address.

Thank you.
> 
> >>               wakeup-source;
> >>       };
> >>
> >>       home@0 {
> > should be home@1 {
> >>               linux,code = <114>;
> >>       };
> >> };
> >>
> >> Thank you.
> >>
> >> >
> >> > Rob
> >>
> >
> >


