From: Jason Wessel <jason.wessel@windriver.com>
Subject: Re: sysrq filter and stuck keys [ was Re: [Nouveau] [PATCH] drm/nouveau/kms:
 Implement KDB debug hooks for nouveau KMS.]
Date: Wed, 27 Oct 2010 07:51:11 -0500
Message-ID: <4CC8203F.6040407@windriver.com>
References: <1283335002.2741.5.camel@maxim-laptop> <4C7E3A73.5070503@windriver.com> <1283424363.2736.1.camel@maxim-laptop> <1285119735.5949.5.camel@maxim-laptop> <1285164198.3159.8.camel@maxim-laptop> <1285164387.3159.10.camel@maxim-laptop> <1285175225.2960.10.camel@maxim-laptop> <1285361406.4509.0.camel@maxim-laptop> <4C9D10F3.10105@windriver.com> <1285373672.26629.8.camel@maxim-laptop> <20100925040824.GB25773@core.coreip.homeip.net> <4CAB90F2.3090503@windriver.com> <1287023674.11191.2.camel@maxim-laptop> <4CBF123E.6020804@windriver.com> <1287800961.21313.4.camel@maxim-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:59948 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756248Ab0J0Mv1 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 27 Oct 2010 08:51:27 -0400
In-Reply-To: <1287800961.21313.4.camel@maxim-laptop>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Maxim Levitsky <maximlevitsky@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Chris Ball <cjb@laptop.org>, kgdb-bugreport@lists.sourceforge.net, linux-input <linux-input@vger.kernel.org>

On 10/22/2010 09:29 PM, Maxim Levitsky wrote:
> Jason, I already found the root cause of the problem.
> First of all, note that I use xorg's evdev driver.
> The in-kernel tty kbd driver is only used for virtual consoles.
>
>   

I would like to clarify where you observed the problem.  Was it only on
the tty console in X or both places?

> The root cause is that in-kernel kbd driver beeing a client of the input
> subsystem just doesn't see the sysrq keys because they are filtered,
> therefore it can't release them.
>
>   

With the 3 patches to the input layer in kgdb-next I cannot duplicate
the problem at all.  If I remove the last patch in the series, and use
the tty console, I can definitely see the behavior you mention.  I had
added a change to the sysrq input filter (which is consumes the key
strokes) that also resets the key mask in the tty keyboard driver

Specifically in

+                       /* Clear handled keys from being flagged as a
repeated stroke */
+                       __clear_bit(code, handle->dev->key);


Else drivers that use these bits for autorepeat (like the atkbd driver)
will end up with stuck keys.

> The right solution is to somehow hook at the atkbd driver , tell it that
> kbd tampered with its hardware, and make it release the keys.
>
>   

I don't think we need to do that because the input filter should be able
to actually "properly" filter state to all its clients.  As a last
resort of course the HW state could be tracked and updated, but ideally
I'd like to avoid it.

Jason.
