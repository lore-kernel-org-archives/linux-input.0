From: Wu Zhangjin <wuzhangjin@gmail.com>
Subject: Re: [PATCH v5 8/8] Loongson: YeeLoong: add hotkey driver
Date: Sun, 29 Nov 2009 13:50:02 +0800
Message-ID: <1259473802.2577.6.camel@falcon.domain.org>
References: <cover.1259414649.git.wuzhangjin@gmail.com>
	 <739db9c7b5bab429d0df5a7c68f301aa12f1402d.1259414649.git.wuzhangjin@gmail.com>
	 <20091129053527.GU6936@core.coreip.homeip.net>
Reply-To: wuzhangjin@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gx0-f212.google.com ([209.85.217.212]:58092 "EHLO
	mail-gx0-f212.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752510AbZK2Fu0 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 29 Nov 2009 00:50:26 -0500
Received: by gxk4 with SMTP id 4so968682gxk.8
        for <linux-input@vger.kernel.org>; Sat, 28 Nov 2009 21:50:32 -0800 (PST)
In-Reply-To: <20091129053527.GU6936@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org, zhangfx@lemote.com, yanh@lemote.com, huhb@lemote.com, linux-input@vger.kernel.org

On Sat, 2009-11-28 at 21:35 -0800, Dmitry Torokhov wrote:
> On Sat, Nov 28, 2009 at 09:44:41PM +0800, Wu Zhangjin wrote:
> >  
> > +config YEELOONG_HOTKEY
> > +	tristate "Hotkey Driver"
> > +	depends on YEELOONG_VO
> > +	select INPUT
> 
> I think this should be depend, not select. 

Hmm, okay, will replace it by depend later ;)

> 
> > +	select INPUT_EVDEV
> > +	select SUSPEND
> 
> Does it break without SUSPEND?

not break, but I just want to select something for users, so, they will
have no need to care about which extra option is needed.

anyway, I will use #ifdef ... #endif instead later.

>  I am pretty sure that it will work fine
> without EVDEV (however unlikely it is not present).

Yes, without EVDEV, it can be compiled, but without the EVDEV module, no
event will be sent to the user-space, as a result, we just get a broken
input support. so, let the users make their decision?

Regards,
	Wu Zhangjin

