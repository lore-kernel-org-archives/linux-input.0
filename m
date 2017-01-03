From: Andi Shyti <andi.shyti-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 3/4] arm64: dts: exynos: make tm2 and tm2e independent from
 each other
Date: Tue, 03 Jan 2017 20:55:30 +0900
Message-ID: <20170103115530.zhjwn7bzmqmumy23@gangnam.samsung>
References: <CGME20170103075734epcas5p43a9743131f63affd0a438d2ed342f22e@epcas5p4.samsung.com>
 <1483430237-26823-1-git-send-email-jcsing.lee@samsung.com>
 <1483430237-26823-4-git-send-email-jcsing.lee@samsung.com>
 <CAJKOXPev9m07_dQWAvJ+=MKnbT0TFERKOtjWUDU+WXdGAiRyDA@mail.gmail.com>
 <20170103095842.h3hl64amje4qv4ts@gangnam.samsung>
 <CAJKOXPeEE1VwAUSAOpfyX+t58zKeAT1fe3ybp0BoQiiDBb4Uqg@mail.gmail.com>
 <20170103102548.73jg6qddlcthe2mu@gangnam.samsung>
 <CAGTfZH3ez4DPTE7-bDeayjhSGxJ_8Mj1MQz1M7O1qhwOGOnmMQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-disposition: inline
In-reply-to: <CAGTfZH3ez4DPTE7-bDeayjhSGxJ_8Mj1MQz1M7O1qhwOGOnmMQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Chanwoo Choi <cwchoi00-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Krzysztof Kozlowski <krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jaechul Lee <jcsing.lee-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>, Chanwoo Choi <cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, beomho.seo-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, galaxyra-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-samsung-soc <linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Hi Chanwoo,

> >> >> > Currently tm2e dts includes tm2 but there are some differences
> >> >> > between the two boards and tm2 has some properties that tm2e
> >> >> > doesn't have.
> >> >> >
> >> >> > That's why it's important to keep the two dts files independent
> >> >> > and put all the commonalities in a tm2-common.dtsi file.
> >> >> >
> >> >> > Signed-off-by: Andi Shyti <andi.shyti-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> >> >> > Signed-off-by: Jaechul Lee <jcsing.lee-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> >> >> > ---
> >> >> >  .../boot/dts/exynos/exynos5433-tm2-common.dtsi     | 1046 ++++++++++++++++++++
> >> >> >  arch/arm64/boot/dts/exynos/exynos5433-tm2.dts      | 1033 +------------------
> >> >> >  arch/arm64/boot/dts/exynos/exynos5433-tm2e.dts     |    2 +-
> >> >> >  3 files changed, 1049 insertions(+), 1032 deletions(-)
> >> >> >  create mode 100644 arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
> >> >>

[...]

> > Because exynos5433-tm2.dts results modified, while
> > exynos5433-tm2-common.dtsi is new. Even though I did:
> >
> > 1. mv exynos5433-tm2.dts exynos5433-tm2-common.dtsi
> > 2. copied pieces from exynos5433-tm2-common.dtsi to a new
> >    exynos5433-tm2.dts
> 
> I think that exynos5433-tm2-common.dtsi is not necessary because there
> is small difference between TM2 and TM2E.
> 
> I explain the detailed difference between TM2 and TM2E and then reply
> how to support the TM2E board with existing exynos5433-tm2.dts file
> without exynos5433-tm2-common.dtsi.
> 
> Difference and the way to support TM2E with existing
> exynos5433-tm2.dts file as following:
> - hsi2c_9 is either used or not. TM2 uses the hsi2c_9 node for
> touchkey. but TM2E do not use the hsi2c_9.
>    : We can just disable the hsi2c_9 node on tm2e.dts as following:
> 
>    &hsi2c_9 {
>          status = "disable";
>    };

I thought about this alternative too, it just looked cleaner to
me to have a tm2-common.dtsi file.

Anyway, as you guys wish. If for you and Krzysztof is better this
way, we can drop this patch and add the above lines in the current
Jaechul's patch 4/4.

Thanks,
Andi
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
