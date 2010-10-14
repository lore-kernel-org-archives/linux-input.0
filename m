From: Maxim Levitsky <maximlevitsky@gmail.com>
Subject: Re: [Nouveau] [PATCH] drm/nouveau/kms: Implement
 KDB debug hooks for nouveau KMS.
Date: Thu, 14 Oct 2010 04:34:34 +0200
Message-ID: <1287023674.11191.2.camel@maxim-laptop>
References: <1283335002.2741.5.camel@maxim-laptop>
	<4C7E3A73.5070503@windriver.com> <1283424363.2736.1.camel@maxim-laptop>
	<1285119735.5949.5.camel@maxim-laptop>
	<1285164198.3159.8.camel@maxim-laptop>
	<1285164387.3159.10.camel@maxim-laptop>
	<1285175225.2960.10.camel@maxim-laptop>
	<1285361406.4509.0.camel@maxim-laptop> <4C9D10F3.10105@windriver.com>
	<1285373672.26629.8.camel@maxim-laptop>
	<20100925040824.GB25773@core.coreip.homeip.net>
	<4CAB90F2.3090503@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <kgdb-bugreport-bounces@lists.sourceforge.net>
In-Reply-To: <4CAB90F2.3090503@windriver.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/kgdb-bugreport>,
	<mailto:kgdb-bugreport-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=kgdb-bugreport>
List-Post: <mailto:kgdb-bugreport@lists.sourceforge.net>
List-Help: <mailto:kgdb-bugreport-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/kgdb-bugreport>,
	<mailto:kgdb-bugreport-request@lists.sourceforge.net?subject=subscribe>
Errors-To: kgdb-bugreport-bounces@lists.sourceforge.net
To: Jason Wessel <jason.wessel@windriver.com>
Cc: kgdb-bugreport@lists.sourceforge.net, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input <linux-input@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Tue, 2010-10-05 at 15:56 -0500, Jason Wessel wrote:
> On 09/24/2010 11:08 PM, Dmitry Torokhov wrote:
> > On Sat, Sep 25, 2010 at 02:14:32AM +0200, Maxim Levitsky wrote:
> >   
> >> On Fri, 2010-09-24 at 15:58 -0500, Jason Wessel wrote:
> >>     
> >>> On 09/24/2010 03:50 PM, Maxim Levitsky wrote:
> >>>       
> >>>>   
> >>>>         
> >>>>> [Dropped nouveau list, because this is offtopic there]
> >>>>>
> >>>>> I pretty much got to the bottom of this.
> >>>>> There are 2 separate issues:
> >>>>>
> >>>>>
> >>>>> 1. SysRq handler is now a input 'filter', which means that it can 'eat'
> >>>>> input events, so they don't show up on input bus.
> >>>>> It does so while sysrq key is down.
> >>>>> So sysrq and 'g' events never reach the kernel kbd driver and therefore
> >>>>> the hack to release them doesn't work.
> >>>>>
> >>>>> 2. The kbd_clear_keys_helper injects the keyup events alright, but it
> >>>>> doesn't inject SYN events, and therefore X evdev driver doesn't pick
> >>>>> these injected events untill next SYN event. 
> >>>>>
> >>>>> This patch makes key release work in expense of showing sysrq key to userspace, which isn't that good,
> >>>>> because now Alt+SysRQ causes a screen capture by default.
> >>>>> In my opinion the sysrq filter should stay.
> >>>>> We should just make kdb hook into atkbd and do the key release there.
> >>>>> This should both result in cleaner/more robust code, and make this issue disappear.
> >>>>> I'll look at doing that.
> >>>>>
Nope, still same problem.
Maybe more keys were released, but still
pressing Alt+SysRQ+g second time doesn't break to the debugger.

I pulled your kgdb-next branch which does contain these patches.

Best regards,
	Maxim Levitsky


------------------------------------------------------------------------------
Beautiful is writing same markup. Internet Explorer 9 supports
standards for HTML5, CSS3, SVG 1.1,  ECMAScript5, and DOM L2 & L3.
Spend less time writing and  rewriting code and more time creating great
experiences on the web. Be a part of the beta today.
http://p.sf.net/sfu/beautyoftheweb
