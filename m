From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v5 2/5] arm64: dts: exynos: make tm2 and tm2e independent
 from each other
Date: Fri, 6 Jan 2017 16:01:32 +0200
Message-ID: <CAJKOXPc9rPsqb1OVYKqMA2vs3J87=fxcr8cy+0mZjhOU7sa_Fw@mail.gmail.com>
References: <20170106134350.32428-1-andi.shyti@samsung.com>
 <CGME20170106134356epcas1p19be459900aec43b2b9ea343cdaf0a2bf@epcas1p1.samsung.com>
 <20170106134350.32428-3-andi.shyti@samsung.com>
 <20170106134929.mj7wqalp7lpkfm6b@kozik-lap>
 <20170106135357.n4ugkcdcog4hzbhe@gangnam.samsung>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170106135357.n4ugkcdcog4hzbhe@gangnam.samsung>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Andi Shyti <andi.shyti@samsung.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>, Catalin Marinas <catalin.marinas@arm.com>, Jaechul Lee <jcsing.lee@samsung.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Kukjin Kim <kgene@kernel.org>, linux-arm-kernel@lists.infradead.org, Andi Shyti <andi@etezian.org>, linux-input@vger.kernel.org, Jaechul Lee <galaxyra@gmail.com>, Beomho Seo <beomho.seo@samsung.com>
List-Id: linux-input@vger.kernel.org

On Fri, Jan 6, 2017 at 3:53 PM, Andi Shyti <andi.shyti@samsung.com> wrote:
> Hi Krzysztof,
>
>> > -#include "exynos5433-tm2.dts"
>> > +#include "exynos5433-tm2-common.dtsi"
>> >
>> >  / {
>> >     model = "Samsung TM2E board";
>>
>> Where are the regulators?
>
> No need, they were already overwriting the original property, so
> with your suggestion they didn't change in tm2e. That's why I like
> your suggestion.
>
> Originally I added the 'regulator' label to not have empty nodes.

Yes, I understand, I spotted it right now. Everything looks good, thanks.

Applied.

BR,
Krzysztof
