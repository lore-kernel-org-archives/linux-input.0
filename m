From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v7 2/3] input: tm2-touchkey: Add touchkey driver support
 for TM2
Date: Thu, 19 Jan 2017 09:17:21 +0200
Message-ID: <CAJKOXPd1jd2LkdTPB4oUK071v0X92YWCsc=japDUv3tuFbNXHQ@mail.gmail.com>
References: <1484632479-3111-1-git-send-email-jcsing.lee@samsung.com>
 <CGME20170117055444epcas1p47b0b0a0ae3260b22fa61d2b92362050b@epcas1p4.samsung.com>
 <1484632479-3111-3-git-send-email-jcsing.lee@samsung.com> <20170117172047.47535bj5xd6toayu@kozik-lap>
 <CAKdAkRQij9VuG1mguE0FwQMKuHrnyLAZJxOtkoR97uuX+ZBmLQ@mail.gmail.com>
 <20170117181056.mrwyudslfgh2wfms@kozik-lap> <20170118224711.GB11881@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:52884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750955AbdASHTn (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 19 Jan 2017 02:19:43 -0500
In-Reply-To: <20170118224711.GB11881@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jaechul Lee <jcsing.lee@samsung.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Kukjin Kim <kgene@kernel.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Andi Shyti <andi.shyti@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Beomho Seo <beomho.seo@samsung.com>, =?UTF-8?B?7J207J6s7LKg?= <galaxyra@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>

On Thu, Jan 19, 2017 at 12:47 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Tue, Jan 17, 2017 at 08:10:56PM +0200, Krzysztof Kozlowski wrote:
>> On Tue, Jan 17, 2017 at 10:06:27AM -0800, Dmitry Torokhov wrote:
>> > On Tue, Jan 17, 2017 at 9:20 AM, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>> > > On Tue, Jan 17, 2017 at 02:54:38PM +0900, Jaechul Lee wrote:
>> > >> This patch adds support for the TM2 touch key and led
>> > >> functionality.
>> > >>
>> > >> The driver interfaces with userspace through an input device and
>> > >> reports KEY_PHONE and KEY_BACK event types. LED brightness can be
>> > >> controlled by "/sys/class/leds/tm2-touchkey/brightness".
>> > >>
>> > >> Signed-off-by: Beomho Seo <beomho.seo@samsung.com>
>> > >> Signed-off-by: Jaechul Lee <jcsing.lee@samsung.com>
>> > >> Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>
>> > >> Reviewed-by: Andi Shyti <andi.shyti@samsung.com>
>> > >> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
>> > >> Tested-by: Chanwoo Choi <cw00.choi@samsung.com>
>> > >> Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
>> > >> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>> > >
>> > > This looks unusual. How did Dmitry's Sob end here?
>> >
>> > I sent Jaechul a version of the patch to try out.
>>
>> Ah, makes sense then.
>
> I picked up (and folded) the binding doc and driver patches, DTS should
> go through some other tree I believe.

Yes, I will take it. I waited for driver and bindings to be accepted.

Thanks,
Krzysztof
