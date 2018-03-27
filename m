From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v6 0/6] Add MediaTek PMIC keys support
Date: Tue, 27 Mar 2018 09:05:07 +0100
Message-ID: <20180327080507.pgil6pw2mn4y2f4d@dell>
References: <1508937364-30054-1-git-send-email-chen.zhong@mediatek.com>
 <808b2029da224ab687fb0553cbc1c68e@mtkmbs08n1.mediatek.inc>
 <1521685073.28226.10.camel@mtkswgap22>
 <20180323185418.GD255819@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180323185418.GD255819@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Sean Wang <sean.wang@mediatek.com>, Rob Herring <robh+dt@kernel.org>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Mark Rutland <mark.rutland@arm.com>, a.zummo@towertech.it, devicetree@vger.kernel.org, linus.walleij@linaro.org, jcsing.lee@samsung.com, linux-kernel@vger.kernel.org, krzk@kernel.org, javier@osg.samsung.com, linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org, matthias.bgg@gmail.com, eddie.huang@mediatek.com, Chen.Zhong@mediatek.com, beomho.seo@samsung.com, linux-rtc@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Fri, 23 Mar 2018, Dmitry Torokhov wrote:
> On Thu, Mar 22, 2018 at 10:17:53AM +0800, Sean Wang wrote:
> > Hi, Dmitry and Lee
> > 
> > The series seems not being got merged. Are they good enough to be ready
> > into the your tree?
> > 
> > Recently I've tested the series with focusing on pwrkey event generated
> > through interrupt when push and release the key on bpi-r2 board and then
> > finally it's working fine. but for homekey it cannot be found on the
> > board and thus I cannot have more tests more about it.
> > 
> > Tested-by: Sean Wang <sean.wang@mediatek.com>
> 
> You have my Ack on the input patch; I expect it go through Lee's tree as
> there are some dependencies on mfd core piece.

Are you happy for me to merge the Input dt-bindings without your Ack?

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
