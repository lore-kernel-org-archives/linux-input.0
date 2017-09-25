From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v4 2/5] dt-bindings: input: Add document bindings for mtk-pmic-keys
Date: Sun, 24 Sep 2017 23:11:24 -0500
Message-ID: <CAL_JsqJZtn7YLn6o9mQMPD+kuseKLbfKe+JiY=1BosqnVqi5Kw@mail.gmail.com>
References: <1505635252-27716-1-git-send-email-chen.zhong@mediatek.com>
 <1505635252-27716-3-git-send-email-chen.zhong@mediatek.com>
 <20170920205301.v6gpmhll4pdpuyxv@rob-hp-laptop> <1506148695.19409.10.camel@mhfsdcap03>
 <1506149223.19409.11.camel@mhfsdcap03>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1506149223.19409.11.camel@mhfsdcap03>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Chen Zhong <chen.zhong-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Eddie Huang <eddie.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Alessandro Zummo <a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org>, Andi Shyti <andi.shyti-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Jaechul Lee <jcsing.lee-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Krzysztof Kozlowski <krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-r
List-Id: linux-input@vger.kernel.org

On Sat, Sep 23, 2017 at 1:47 AM, Chen Zhong <chen.zhong-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org> wrote:
> Sorry for the typo.
>
> On Sat, 2017-09-23 at 14:38 +0800, Chen Zhong wrote:
>> On Wed, 2017-09-20 at 15:53 -0500, Rob Herring wrote:
>> > On Sun, Sep 17, 2017 at 04:00:49PM +0800, Chen Zhong wrote:
>> > > This patch adds the device tree binding documentation for the MediaTek
>> > > pmic keys found on PMIC MT6397/MT6323.
>> > >
>> > > Signed-off-by: Chen Zhong <chen.zhong-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
>> > > ---
>> > >  .../devicetree/bindings/input/mtk-pmic-keys.txt    |   41 ++++++++++++++++++++
>> > >  1 file changed, 41 insertions(+)
>> > >  create mode 100644 Documentation/devicetree/bindings/input/mtk-pmic-keys.txt
>> > >
>> > > diff --git a/Documentation/devicetree/bindings/input/mtk-pmic-keys.txt b/Documentation/devicetree/bindings/input/mtk-pmic-keys.txt
>> > > new file mode 100644
>> > > index 0000000..fd48ff7
>> > > --- /dev/null
>> > > +++ b/Documentation/devicetree/bindings/input/mtk-pmic-keys.txt
>> > > @@ -0,0 +1,41 @@
>> > > +MediaTek MT6397/MT6323 PMIC Keys Device Driver
>> > > +
>> > > +There are two key functions provided by MT6397/MT6323 PMIC, pwrkey
>> > > +and homekey. The key functions are defined as the subnode of the function
>> > > +node provided by MT6397/MT6323 PMIC that is being defined as one kind
>> > > +of Muti-Function Device (MFD)
>> > > +
>> > > +For MT6397/MT6323 MFD bindings see:
>> > > +Documentation/devicetree/bindings/mfd/mt6397.txt
>> > > +
>> > > +Required properties:
>> > > +- compatible: "mediatek,mt6397-keys" or "mediatek,mt6323-keys"
>> > > +- linux,keycodes: Specifies the numeric keycode values to
>> > > + be used for reporting keys presses. The array can
>> > > + contain up to 2 entries.
>> > > +
>> > > +Optional Properties:
>> > > +- mediatek,wakeup-keys: Specifies each key can be used as a wakeup source
>> > > + or not. This can be customized depends on board design.
>> >
>> > I think this should be a common property if we're going to put into DT.
>> > Something like "wakeup-scancodes" to be clear the values are the raw
>> > scancodes. Alternatively, we could list Linux keycodes instead with
>> > something like "linux,wakeup-keycodes".
>> >
>> > > +- wakeup-source: PMIC keys can be used as wakeup sources.
>> >
>> > Just "See ../power/wakeup-source.txt" for the description.
>> >
>> > > +- mediatek,long-press-mode: Long press key shutdown setting, 1 for
>> > > + pwrkey only, 2 for pwrkey/homekey together, others for disabled.
>> > > +- debounce-interval: Long press key shutdown debouncing interval time
>> > > + in seconds. 0/1/2/3 for 8/11/14/5 seconds. If not specified defaults to 0.
>> >
>> > This property units should be in milliseconds. However, this doesn't
>> > sound like debounce filtering time if 5-14 seconds. That sounds like
>> > forced power off time (i.e. for a hung device). This also should be
>> > common. I imagine we already have some drivers with similar properties.
>>
>> Hi Rob,
>>
>> I searched in kernel documents and found a similar usage in
>> "ti,palmas-pwrbutton.txt"
>> "- ti,palmas-long-press-seconds: Duration in seconds which the power
>>   button should be kept pressed for Palmas to power off automatically."
>>
>> Could I just wrote it like this?
>> mediatek,long-press-seconds = <0>;

That doesn't really tell what the long press does. How about
"power-off-time-sec"? Surprisingly we don't have a common keyboard
binding doc, so please start one and document it there. Then just
refer to it.

>>
>> And for the wakeup source part, how about Dmitry's suggestion?

It's fine for me.

>> The whole device node would be:
>>
>> mt6397keys: mt6397keys {
>>       compatible = "mediatek,mt6397-keys";
>>       mediatek,long-press-mode = <1>;
>>       mediatek,long-press-seconds = <0>;
>>
>>       power@0 {
>>               linux,code = <116>;

linux,keycodes

Also, you either need a reg property with "0" or drop the unit address.

>>               wakeup-source;
>>       };
>>
>>       home@0 {
> should be home@1 {
>>               linux,code = <114>;
>>       };
>> };
>>
>> Thank you.
>>
>> >
>> > Rob
>>
>
>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
