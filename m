From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v7 2/3] input: tm2-touchkey: Add touchkey driver support
 for TM2
Date: Wed, 18 Jan 2017 14:47:11 -0800
Message-ID: <20170118224711.GB11881@dtor-ws>
References: <1484632479-3111-1-git-send-email-jcsing.lee@samsung.com>
 <CGME20170117055444epcas1p47b0b0a0ae3260b22fa61d2b92362050b@epcas1p4.samsung.com>
 <1484632479-3111-3-git-send-email-jcsing.lee@samsung.com>
 <20170117172047.47535bj5xd6toayu@kozik-lap>
 <CAKdAkRQij9VuG1mguE0FwQMKuHrnyLAZJxOtkoR97uuX+ZBmLQ@mail.gmail.com>
 <20170117181056.mrwyudslfgh2wfms@kozik-lap>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20170117181056.mrwyudslfgh2wfms@kozik-lap>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Chanwoo Choi <cw00.choi@samsung.com>, Catalin Marinas <catalin.marinas@arm.com>, Jaechul Lee <jcsing.lee@samsung.com>, Will Deacon <will.deacon@arm.com>, lkml <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Kukjin Kim <kgene@kernel.org>, Andi Shyti <andi.shyti@samsung.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, =?utf-8?B?7J207J6s7LKg?= <galaxyra@gmail.com>, Beomho Seo <beomho.seo@samsung.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-input@vger.kernel.org

On Tue, Jan 17, 2017 at 08:10:56PM +0200, Krzysztof Kozlowski wrote:
> On Tue, Jan 17, 2017 at 10:06:27AM -0800, Dmitry Torokhov wrote:
> > On Tue, Jan 17, 2017 at 9:20 AM, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > > On Tue, Jan 17, 2017 at 02:54:38PM +0900, Jaechul Lee wrote:
> > >> This patch adds support for the TM2 touch key and led
> > >> functionality.
> > >>
> > >> The driver interfaces with userspace through an input device and
> > >> reports KEY_PHONE and KEY_BACK event types. LED brightness can be
> > >> controlled by "/sys/class/leds/tm2-touchkey/brightness".
> > >>
> > >> Signed-off-by: Beomho Seo <beomho.seo@samsung.com>
> > >> Signed-off-by: Jaechul Lee <jcsing.lee@samsung.com>
> > >> Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>
> > >> Reviewed-by: Andi Shyti <andi.shyti@samsung.com>
> > >> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
> > >> Tested-by: Chanwoo Choi <cw00.choi@samsung.com>
> > >> Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
> > >> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > >
> > > This looks unusual. How did Dmitry's Sob end here?
> > 
> > I sent Jaechul a version of the patch to try out.
> 
> Ah, makes sense then.

I picked up (and folded) the binding doc and driver patches, DTS should
go through some other tree I believe.

Thanks.

-- 
Dmitry
