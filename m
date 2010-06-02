From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v3] powerpc: Add i8042 keyboard and mouse irq parsing
Date: Tue, 1 Jun 2010 23:26:34 -0700
Message-ID: <20100602062634.GA3713@core.coreip.homeip.net>
References: <20100525080834.29149.70967.stgit@ES-J7S4D2J.amer.consind.ge.com>
 <1275104126.1931.521.camel@pasglop>
 <4C050017.10905@ge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:37466 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751989Ab0FBG0l (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 2 Jun 2010 02:26:41 -0400
Received: by pwj2 with SMTP id 2so1546798pwj.19
        for <linux-input@vger.kernel.org>; Tue, 01 Jun 2010 23:26:41 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4C050017.10905@ge.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Martyn Welch <martyn.welch@ge.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Grant Likely <grant.likely@secretlab.ca>, linuxppc-dev@ozlabs.org, linux-input@vger.kernel.org

On Tue, Jun 01, 2010 at 01:41:59PM +0100, Martyn Welch wrote:
> Benjamin Herrenschmidt wrote:
> > O
> >   
> >> diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
> >> index 48f0a00..3d169bb 100644
> >> --- a/arch/powerpc/kernel/setup-common.c
> >> +++ b/arch/powerpc/kernel/setup-common.c
> >> @@ -94,6 +94,10 @@ struct screen_info screen_info = {
> >>  	.orig_video_points = 16
> >>  };
> >>  
> >> +/* Variables required to store legacy IO irq routing */
> >> +int of_i8042_kbd_irq;
> >> +int of_i8042_aux_irq;
> >>     
> >
> > Is there a reasonable ifdef to use for the above or we don't care ?
> >
> >   
> >>  #ifdef __DO_IRQ_CANON
> >>  /* XXX should go elsewhere eventually */
> >>  int ppc_do_canonicalize_irqs;
> >> @@ -567,6 +571,15 @@ int check_legacy_ioport(unsigned long base_port)
> >>  			np = of_find_compatible_node(NULL, NULL, "pnpPNP,f03");
> >>  		if (np) {
> >>  			parent = of_get_parent(np);
> >> +
> >> +			of_i8042_kbd_irq = irq_of_parse_and_map(parent, 0);
> >> +			if (!of_i8042_kbd_irq)
> >> +				of_i8042_kbd_irq = 1;
> >> +
> >> +			of_i8042_aux_irq = irq_of_parse_and_map(parent, 1);
> >> +			if (!of_i8042_aux_irq)
> >> +				of_i8042_aux_irq = 12;
> >> +
> >>  			of_node_put(np);
> >>  			np = parent;
> >>  			break;
> >> diff --git a/drivers/input/serio/i8042-io.h b/drivers/input/serio/i8042-io.h
> >> index 847f4aa..5d48bb6 100644
> >> --- a/drivers/input/serio/i8042-io.h
> >> +++ b/drivers/input/serio/i8042-io.h
> >> @@ -27,6 +27,11 @@
> >>  #include <asm/irq.h>
> >>  #elif defined(CONFIG_SH_CAYMAN)
> >>  #include <asm/irq.h>
> >> +#elif defined(CONFIG_PPC)
> >> +extern int of_i8042_kbd_irq;
> >> +extern int of_i8042_aux_irq;
> >> +# define I8042_KBD_IRQ  of_i8042_kbd_irq
> >> +# define I8042_AUX_IRQ  of_i8042_aux_irq
> >>  #else
> >>  # define I8042_KBD_IRQ	1
> >>  # define I8042_AUX_IRQ	12
> >>     
> >
> > Now while that works, I do tend to dislike global variables like that.
> >
> > _Maybe_ a better approach would be to have those #define resolve to
> > functions:
> >
> > #define I8042_KBD_IRQ	of_find_i8042_kbd_irq()
> >
> > Or something like that ?
> >
> > That means ending up having 2 functions which more/less reproduce the
> > loop to find the driver in the device-tree but that's a minor
> > inconvenience.
> >
> > Now, maybe the variables are less bloat here. What do you think ? Which
> > way do you prefer ?
> >
> >   
> 
> Personally, I'm happy either way. If you'd prefer I implement these as
> functions, I can't quickly see why that wouldn't work. I thought using
> variables would be the least disruptive.

FYI: i8042 core expects I8042_{KBD|AUX}_IRQ to be integers, however it
is certainly fixable...

-- 
Dmitry
