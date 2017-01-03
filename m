From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH 3/4] arm64: dts: exynos: make tm2 and tm2e independent
 from each other
Date: Tue, 3 Jan 2017 18:41:16 +0200
Message-ID: <20170103164116.qkvpwvm27gdefvhy@kozik-lap>
References: <CGME20170103075734epcas5p43a9743131f63affd0a438d2ed342f22e@epcas5p4.samsung.com>
 <1483430237-26823-1-git-send-email-jcsing.lee@samsung.com>
 <1483430237-26823-4-git-send-email-jcsing.lee@samsung.com>
 <CAJKOXPev9m07_dQWAvJ+=MKnbT0TFERKOtjWUDU+WXdGAiRyDA@mail.gmail.com>
 <20170103095842.h3hl64amje4qv4ts@gangnam.samsung>
 <CAJKOXPeEE1VwAUSAOpfyX+t58zKeAT1fe3ybp0BoQiiDBb4Uqg@mail.gmail.com>
 <20170103102548.73jg6qddlcthe2mu@gangnam.samsung>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20170103102548.73jg6qddlcthe2mu@gangnam.samsung>
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Chanwoo Choi <cw00.choi@samsung.com>, Catalin Marinas <catalin.marinas@arm.com>, Jaechul Lee <jcsing.lee@samsung.com>, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Rob Herring <robh+dt@kernel.org>, Kukjin Kim <kgene@kernel.org>, linux-input@vger.kernel.org, galaxyra@gmail.com, beomho.seo@samsung.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-input@vger.kernel.org

On Tue, Jan 03, 2017 at 07:25:48PM +0900, Andi Shyti wrote:
> > >> > Currently tm2e dts includes tm2 but there are some differences
> > >> > between the two boards and tm2 has some properties that tm2e
> > >> > doesn't have.
> > >> >
> > >> > That's why it's important to keep the two dts files independent
> > >> > and put all the commonalities in a tm2-common.dtsi file.
> > >> >
> > >> > Signed-off-by: Andi Shyti <andi.shyti@samsung.com>
> > >> > Signed-off-by: Jaechul Lee <jcsing.lee@samsung.com>
> > >> > ---
> > >> >  .../boot/dts/exynos/exynos5433-tm2-common.dtsi     | 1046 ++++++++++++++++++++
> > >> >  arch/arm64/boot/dts/exynos/exynos5433-tm2.dts      | 1033 +------------------
> > >> >  arch/arm64/boot/dts/exynos/exynos5433-tm2e.dts     |    2 +-
> > >> >  3 files changed, 1049 insertions(+), 1032 deletions(-)
> > >> >  create mode 100644 arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
> > >>
> > >> I would like to see here the rename and diff from it. Not entire delta
> > >> (deletions and addons). It is not possible to compare it... I think
> > >> git supports it by default with similarity of 50%.
> > >
> > > I understand, it's indeed quite cryptic to understand. But all
> > > the diff algorithms (patience, minimal, histogram, myers) give
> > > the same result. I don't know how to make it better.
> > >
> > > I could split this patch, but this also means breaking tm2's
> > > functionality, which looks worse.
> > >
> > > Please tell me if you know a better way for generating the patch.
> > 
> > git format-patch -M95%?
> 
> Same thing with all M values.
> 
> Because exynos5433-tm2.dts results modified, while
> exynos5433-tm2-common.dtsi is new. Even though I did:
> 
> 1. mv exynos5433-tm2.dts exynos5433-tm2-common.dtsi
> 2. copied pieces from exynos5433-tm2-common.dtsi to a new
>    exynos5433-tm2.dts

mv/etc won't help. You need to convince git format-patch that it is
rename. For that, you need -B so copy will be considered a rename
(otherwise rename will be detected only if a file is removed), so:
	git format-patch -B50% -1

Please resend with this approach.

Best regards,
Krzysztof
