From: Jason Wessel <jason.wessel@windriver.com>
Subject: sysrq filter and stuck keys [ was Re: [Nouveau] [PATCH] drm/nouveau/kms:
 Implement KDB debug hooks for nouveau KMS.]
Date: Wed, 20 Oct 2010 11:01:02 -0500
Message-ID: <4CBF123E.6020804@windriver.com>
References: <1283335002.2741.5.camel@maxim-laptop> <4C7E3A73.5070503@windriver.com> <1283424363.2736.1.camel@maxim-laptop> <1285119735.5949.5.camel@maxim-laptop> <1285164198.3159.8.camel@maxim-laptop> <1285164387.3159.10.camel@maxim-laptop> <1285175225.2960.10.camel@maxim-laptop> <1285361406.4509.0.camel@maxim-laptop> <4C9D10F3.10105@windriver.com> <1285373672.26629.8.camel@maxim-laptop> <20100925040824.GB25773@core.coreip.homeip.net> <4CAB90F2.3090503@windriver.com> <1287023674.11191.2.camel@maxim-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:50486 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751129Ab0JTQBW (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 20 Oct 2010 12:01:22 -0400
In-Reply-To: <1287023674.11191.2.camel@maxim-laptop>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Maxim Levitsky <maximlevitsky@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Chris Ball <cjb@laptop.org>, kgdb-bugreport@lists.sourceforge.net, linux-input <linux-input@vger.kernel.org>

On 10/13/2010 09:34 PM, Maxim Levitsky wrote:
>
> Nope, still same problem.
> Maybe more keys were released, but still
> pressing Alt+SysRQ+g second time doesn't break to the debugger.
>
>   

Thanks for trying this out Maxim.

I have to wonder if part of the problem is the way that raw events can
propagate directly via the old keyboard interface vs the input layer.  
I had noticed something somewhat similar with an xorg.conf which
appeared to be using both the raw keyboard and the input layer for
input.  I was having all sorts of problems until I changed the xorg.conf
settings to use the input layer.  I noticed that even pressing the up
arrow in an xterm was invoking the screen shot mechanism for example.

Perhaps you can provide some more data to see if this is a similar
problem or not.

On the Fedora 13 test system I made sure the following were commented
out in the xorg.conf file.

#       InputDevice    "Keyboard0" "CoreKeyboard"

#       Option "AllowEmptyInput" "off"


This had resolved the issue at least for the system with the Intel
graphics chip and non-usb keyboard.

The next step might be to have you run with an instrumented kernel if
this is not the issue, and of course if you are willing to help further
debug this.

Thanks,
Jason.
