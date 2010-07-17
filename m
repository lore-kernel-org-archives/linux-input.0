From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] trivial: rename config-token QT2160
Date: Sat, 17 Jul 2010 14:29:32 -0700
Message-ID: <20100717212932.GA20623@core.coreip.homeip.net>
References: <alpine.DEB.2.00.1007160434590.13824@lynx>
 <1279322143.4064.11.camel@lovely.krouter>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:63467 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753733Ab0GQV3m (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 17 Jul 2010 17:29:42 -0400
Received: by pzk26 with SMTP id 26so989500pzk.19
        for <linux-input@vger.kernel.org>; Sat, 17 Jul 2010 14:29:41 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1279322143.4064.11.camel@lovely.krouter>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Christoph Fritz <chf.fritz@googlemail.com>
Cc: "Robert P.J.Day" <rpjday@crashcourse.ca>, linux-input@vger.kernel.org

On Sat, Jul 17, 2010 at 01:15:43AM +0200, Christoph Fritz wrote:
> On Fri, 2010-07-16 at 04:39 -0400, Robert P. J. Day wrote:
> > not sure what you want to do with this, but there's a mismatch:
> > 
> > drivers/input/keyboard/Kconfig:
> > ...
> > config QT2160
> > ...
> > 
> >   while the corresponding Makefile contains:
> > 
> > obj-$(CONFIG_KEYBOARD_QT2160)           += qt2160.o
> >              ^^^^^^^^^
> > 
> >   normally, i'd just edit the Kconfig file to be consistent with all
> > other config entries in that file, but:
> > 
> > $ grep -rw CONFIG_QT2160 *
> > arch/powerpc/configs/pasemi_defconfig:# CONFIG_QT2160 is not set
> > arch/powerpc/configs/44x/sam440ep_defconfig:# CONFIG_QT2160 is not set
> > arch/powerpc/configs/44x/icon_defconfig:# CONFIG_QT2160 is not set
> > arch/powerpc/configs/wii_defconfig:# CONFIG_QT2160 is not set
> > arch/powerpc/configs/85xx/stx_gp3_defconfig:# CONFIG_QT2160 is not set
> > arch/powerpc/configs/ppc64e_defconfig:# CONFIG_QT2160 is not set
> > arch/powerpc/configs/mpc512x_defconfig:# CONFIG_QT2160 is not set
> > arch/mips/configs/fuloong2e_defconfig:# CONFIG_QT2160 is not set
> > arch/mips/configs/mtx1_defconfig:# CONFIG_QT2160 is not set
> > arch/sparc/configs/sparc64_defconfig:# CONFIG_QT2160 is not set
> > arch/avr32/configs/atstk1006_defconfig:# CONFIG_QT2160 is not set
> > arch/avr32/configs/atstk1002_defconfig:# CONFIG_QT2160 is not set
> > arch/blackfin/configs/BF548-EZKIT_defconfig:# CONFIG_QT2160 is not set
> > ... etc etc ...
> > 
> >   i'll let you decide how to resolve that.
> > 
> > rday
> > 
> 
> Hi,
> 
>  Robert thanks for this report. Dmitry do you think the
> applied patch is adoptable?
> 

I'll take the Kconfig change part however I am not going to touch
defconfig files (and probably others should stay away from them for a
while ;) ).

Thanks.

-- 
Dmitry
