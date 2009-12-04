From: Wu Zhangjin <wuzhangjin@gmail.com>
Subject: Re: [PATCH 1/9] Input: add generic support for sparse keymaps
Date: Fri, 04 Dec 2009 17:18:40 +0800
Message-ID: <1259918320.3593.66.camel@falcon.domain.org>
References: <20091204060701.28288.91430.stgit@localhost.localdomain>
	 <20091204061158.28288.17664.stgit@localhost.localdomain>
	 <1259913744.3593.62.camel@falcon.domain.org>
	 <20091204083756.GA22570@core.coreip.homeip.net>
Reply-To: wuzhangjin@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20091204083756.GA22570@core.coreip.homeip.net>
Sender: linux-acpi-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, Herton Ronaldo Krzesinski <herton@mandriva.com.br>, Harald Welte <laforge@gnumonks.org>, Corentin Chary <corentincj@iksaif.net>, Carlos Corbacho <carlos@strangeworlds.co.uk>, Anisse Astier <anisse@astier.eu>
List-Id: linux-input@vger.kernel.org

On Fri, 2009-12-04 at 00:37 -0800, Dmitry Torokhov wrote:
> On Fri, Dec 04, 2009 at 04:02:24PM +0800, Wu Zhangjin wrote:
> > On Thu, 2009-12-03 at 22:11 -0800, Dmitry Torokhov wrote:
> > > More and more devices choose to reimplement support for sparse keymaps
> > > first introduced by wistron driver. Move it into a library module so it
> > > can be easily used by interested parties.
> > 
> > Hi, Dmitry
> > 
> > I have tried to apply this patch to the latest 2.6.32 and the linux-mips
> > tree, both rejected.
> > 
> > So, which git tree should I use?
> > 
> 
> Mine ;)
> 
> 	git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git next
> 

Thanks, I am rebasing the input driver for YeeLoong on your git tree ;)

Regards,
	Wu Zhangjin

