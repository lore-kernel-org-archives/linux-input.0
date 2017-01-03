From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH 3/4] arm64: dts: exynos: make tm2 and tm2e independent
 from each other
Date: Tue, 3 Jan 2017 18:31:36 +0200
Message-ID: <20170103163136.rzoswklqevoeugn4@kozik-lap>
References: <1483430237-26823-4-git-send-email-jcsing.lee@samsung.com>
 <CAJKOXPev9m07_dQWAvJ+=MKnbT0TFERKOtjWUDU+WXdGAiRyDA@mail.gmail.com>
 <20170103095842.h3hl64amje4qv4ts@gangnam.samsung>
 <CAJKOXPeEE1VwAUSAOpfyX+t58zKeAT1fe3ybp0BoQiiDBb4Uqg@mail.gmail.com>
 <20170103102548.73jg6qddlcthe2mu@gangnam.samsung>
 <CAGTfZH3ez4DPTE7-bDeayjhSGxJ_8Mj1MQz1M7O1qhwOGOnmMQ@mail.gmail.com>
 <20170103115530.zhjwn7bzmqmumy23@gangnam.samsung>
 <ff876454-b49f-3d63-d76e-012dd303b0e7@osg.samsung.com>
 <20170103144056.4ft2ohmhgmezeney@jack.zhora.eu>
 <CAGTfZH0tnjkqF_7DChLSvzs3C369mkb_HZmyrf3cc0T-UcBZ4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <CAGTfZH0tnjkqF_7DChLSvzs3C369mkb_HZmyrf3cc0T-UcBZ4A@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Chanwoo Choi <cwchoi00@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree <devicetree@vger.kernel.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, Kukjin Kim <kgene@kernel.org>, Chanwoo Choi <cw00.choi@samsung.com>, Catalin Marinas <catalin.marinas@arm.com>, Jaechul Lee <jcsing.lee@samsung.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Will Deacon <will.deacon@arm.com>, linux-kernel <linux-kernel@vger.kernel.org>, Andi Shyti <andi.shyti@samsung.com>, Javier Martinez Canillas <javier@osg.samsung.com>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Andi Shyti <andi@etezian.org>, linux-input@vger.kernel.org, galaxyra@gmail.com, beomho.seo@samsung.com, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-input@vger.kernel.org

On Wed, Jan 04, 2017 at 12:29:23AM +0900, Chanwoo Choi wrote:
> Hi Andi,
> 
> 2017-01-03 23:40 GMT+09:00 Andi Shyti <andi@etezian.org>:
> > Hi,
> >
> >> FWIW, I also agree with Chanwoo that the difference is too small to
> >> need a common .dtsi file.
> >
> > in principle I don't like "switching on and off" properties by
> > overwriting them with "status = disable", unless it's really
> > necessary (and this case is not). Even for small differences. It
> > makes the DTS harder to read and duplicates nodes with different
> > values throughout the DTS include chain.

I agree.

> >
> > In my opinion this approach should be discouraged.
> >
> > Besides, there are other overwritten differences in tm2e.dts that
> > I think should be separated as well. The "common" file approach is
> > widely used in arm/boot/dts/exynos* files.

I agree. Mostly we use:
1. Common DTSI and final addons/customizations in DTS.
2. Several common DTSI for specific parts (like sound).

> > The "status = disable" looks to me more like a temporary hack
> > rather than a permanent solution.
> >
> > In any case, still up to you :)
> >
> > Andi
> 
> I think that "status=disabled" of hsi2c_9 is not hack. The overwrite
> is possible for Device-tree. But, there is just difference how to
> support them with some method.
> 
> Except for touchkey, all peripheral device are same on both tm2 and
> tm2e. There are only small difference for a few property value.
> 
> To understand the difference between tm2 and tm2e, I made the patch
> (it is not complete version). If we implement the following patch, we
> support both tm2 and tm2e. So, I think that it is not complex to
> understand the h/w difference between tm2 and tm2e.

The difference below (I removed it from the quote) is indeed very small,
thanks Chanwoo for pointing this. However having common DTSI should not
end with much bigger final diff between files. I mean that it should be
the same amount of lines in total...

Actually, after applying this patch, the final exynos5433-tm2e.dts is
exactly the same as before. To me, this is a indication that a common
file is a good approach.


>From a separate Javier's mail:
> On 01/03/2017 11:40 AM, Andi Shyti wrote:
> > Hi,
> > 
> >> FWIW, I also agree with Chanwoo that the difference is too small to
> >> need a common .dtsi file.
> > 
> > in principle I don't like "switching on and off" properties by
> > overwriting them with "status = disable", unless it's really
> 
> This is a very good point. It would had been different if it was the
> opposite and tm2e had to enable the device node, but disabling it is
> indeed more confusing.
> On 01/03/2017 11:40 AM, Andi Shyti wrote:
> > Hi,
> > 
> >> FWIW, I also agree with Chanwoo that the difference is too small to
> >> need a common .dtsi file.
> > 
> > in principle I don't like "switching on and off" properties by
> > overwriting them with "status = disable", unless it's really
> 
> This is a very good point. It would had been different if it was the
> opposite and tm2e had to enable the device node, but disabling it is
> indeed more confusing.

I agree, 'status = disable' in final DTS is not a common pattern and
to me when reading, it makes me wonder what was the author's intention.

Also including a DTS in DTS is not a common pattern, neither. It appears
(git grep include arch/arm/boot/dts | grep 'dts"') in few places but it
is not obvious. At least to me.

Overall, I prefer the common approach.

Best regards,
Krzysztof
