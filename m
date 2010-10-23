From: Maxim Levitsky <maximlevitsky@gmail.com>
Subject: Re: sysrq filter and stuck keys [ was Re: [Nouveau] [PATCH]
 drm/nouveau/kms: Implement KDB debug hooks for nouveau KMS.]
Date: Sat, 23 Oct 2010 04:29:21 +0200
Message-ID: <1287800961.21313.4.camel@maxim-laptop>
References: <1283335002.2741.5.camel@maxim-laptop>
	 <4C7E3A73.5070503@windriver.com> <1283424363.2736.1.camel@maxim-laptop>
	 <1285119735.5949.5.camel@maxim-laptop>
	 <1285164198.3159.8.camel@maxim-laptop>
	 <1285164387.3159.10.camel@maxim-laptop>
	 <1285175225.2960.10.camel@maxim-laptop>
	 <1285361406.4509.0.camel@maxim-laptop> <4C9D10F3.10105@windriver.com>
	 <1285373672.26629.8.camel@maxim-laptop>
	 <20100925040824.GB25773@core.coreip.homeip.net>
	 <4CAB90F2.3090503@windriver.com> <1287023674.11191.2.camel@maxim-laptop>
	 <4CBF123E.6020804@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:49345 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754961Ab0JWC31 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 22 Oct 2010 22:29:27 -0400
Received: by fxm16 with SMTP id 16so1253018fxm.19
        for <linux-input@vger.kernel.org>; Fri, 22 Oct 2010 19:29:26 -0700 (PDT)
In-Reply-To: <4CBF123E.6020804@windriver.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jason Wessel <jason.wessel@windriver.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Chris Ball <cjb@laptop.org>, kgdb-bugreport@lists.sourceforge.net, linux-input <linux-input@vger.kernel.org>

On Wed, 2010-10-20 at 11:01 -0500, Jason Wessel wrote:
> On 10/13/2010 09:34 PM, Maxim Levitsky wrote:
> >
> > Nope, still same problem.
> > Maybe more keys were released, but still
> > pressing Alt+SysRQ+g second time doesn't break to the debugger.
> >
> >   
> 
> Thanks for trying this out Maxim.
> 
> I have to wonder if part of the problem is the way that raw events can
> propagate directly via the old keyboard interface vs the input layer.  
> I had noticed something somewhat similar with an xorg.conf which
> appeared to be using both the raw keyboard and the input layer for
> input.  I was having all sorts of problems until I changed the xorg.conf
> settings to use the input layer.  I noticed that even pressing the up
> arrow in an xterm was invoking the screen shot mechanism for example.
> 
> Perhaps you can provide some more data to see if this is a similar
> problem or not.

Jardon, I already found the root cause of the problem.
First of all, note that I use xorg's evdev driver.
The in-kernel tty kbd driver is only used for virtual consoles.

The root cause is that in-kernel kbd driver beeing a client of the input
subsystem just doesn't see the sysrq keys because they are filtered,
therefore it can't release them.

The right solution is to somehow hook at the atkbd driver , tell it that
kbd tampered with its hardware, and make it release the keys.

But that is easy to say, not that easy to do...

the in-kernel kbd driver just isn't the right place for the job.

Best regards,
	Maxim Levitsky

