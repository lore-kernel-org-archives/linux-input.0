From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v5 3/3] input: samsung-keypad - Add samsung keypad driver
Date: Mon, 28 Jun 2010 02:01:56 -0700
Message-ID: <20100628090156.GB13523@core.coreip.homeip.net>
References: <1277101605-2435-1-git-send-email-jy0922.shim@samsung.com>
 <1277101605-2435-3-git-send-email-jy0922.shim@samsung.com>
 <20100625083019.GD8546@core.coreip.homeip.net>
 <4C285FCB.3070100@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4C285FCB.3070100@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Joonyoung Shim <jy0922.shim@samsung.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-input@vger.kernel.org, ben-linux@fluff.org, kyungmin.park@samsung.com, kgene.kim@samsung.com
List-Id: linux-input@vger.kernel.org

On Mon, Jun 28, 2010 at 05:39:39PM +0900, Joonyoung Shim wrote:
> Hi, Dmitry.
> 
> On 6/25/2010 5:30 PM, Dmitry Torokhov wrote:
> > Hi Joonyoung,
> > 
> > On Mon, Jun 21, 2010 at 03:26:45PM +0900, Joonyoung Shim wrote:
> >> This patch adds support for keypad driver running on Samsung cpus. This
> >> driver is tested on GONI and Aquila board using S5PC110 cpu.
> >>
> >> Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>
> >> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> > 
> > Following my conversation with Thomas Gleixner reagrding "long playing"
> > threaded interrupt handlers I tried to convert your driver to use this
> > concept. The idea is to keep polling within IRQ thread context instead
> > of using additional work/timer structures to simplify code and ensure
> > race-free shutdown/unbind.
> > 
> > I think it was based on v4 of your driver and I'd appreciate if you could
> > give it a try.
> > 
> > Thank you.
> > 
> 
> I have tested your patch on my v5 patchset and it is working after some
> fixing. I will post v6 patchset appling your patch.

Cool, thanks.

-- 
Dmitry
