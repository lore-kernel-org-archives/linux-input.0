From: Wu Zhangjin <wuzhangjin@gmail.com>
Subject: Re: [PATCH v5 8/8] Loongson: YeeLoong: add hotkey driver
Date: Sun, 29 Nov 2009 15:40:41 +0800
Message-ID: <1259480441.2577.18.camel@falcon.domain.org>
References: <cover.1259414649.git.wuzhangjin@gmail.com>
	 <739db9c7b5bab429d0df5a7c68f301aa12f1402d.1259414649.git.wuzhangjin@gmail.com>
	 <20091129053527.GU6936@core.coreip.homeip.net>
	 <1259473802.2577.6.camel@falcon.domain.org>
	 <20091129072948.GA15146@linux-mips.org>
Reply-To: wuzhangjin@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f182.google.com ([209.85.211.182]:63252 "EHLO
	mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751017AbZK2HlE (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 29 Nov 2009 02:41:04 -0500
Received: by ywh12 with SMTP id 12so2936380ywh.21
        for <linux-input@vger.kernel.org>; Sat, 28 Nov 2009 23:41:10 -0800 (PST)
In-Reply-To: <20091129072948.GA15146@linux-mips.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-mips@linux-mips.org, zhangfx@lemote.com, yanh@lemote.com, huhb@lemote.com, linux-input@vger.kernel.org

On Sun, 2009-11-29 at 07:29 +0000, Ralf Baechle wrote:
> On Sun, Nov 29, 2009 at 01:50:02PM +0800, Wu Zhangjin wrote:
> 
> > On Sat, 2009-11-28 at 21:35 -0800, Dmitry Torokhov wrote:
> > > On Sat, Nov 28, 2009 at 09:44:41PM +0800, Wu Zhangjin wrote:
> > > >  
> > > > +config YEELOONG_HOTKEY
> > > > +	tristate "Hotkey Driver"
> > > > +	depends on YEELOONG_VO
> > > > +	select INPUT
> > > 
> > > I think this should be depend, not select. 
> > 
> > Hmm, okay, will replace it by depend later ;)
> > 
> > > 
> > > > +	select INPUT_EVDEV
> > > > +	select SUSPEND
> > > 
> > > Does it break without SUSPEND?
> > 
> > not break, but I just want to select something for users, so, they will
> > have no need to care about which extra option is needed.
> 
> We use  select extensively on MIPS but select is dangerous and you stepped
> into its trap.  When SUSPEND is enabled by a user in
> kernel/power/Kconfig it can only be choosen if PM is enabled.  By
> "select SUSPEND" this dependency so now it is possible to have a kernel
> where SUSPEND is enabled without PM which won't work.
> 

Get it, thanks for your clarification ;)

Regards,
	Wu Zhangjin

