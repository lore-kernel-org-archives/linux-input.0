From: Jason Wessel <jason.wessel@windriver.com>
Subject: Re: [RFC/RFT] Reinject Alt+SysRq when no hotkeys have been pressed
Date: Wed, 10 Nov 2010 14:13:20 -0600
Message-ID: <4CDAFCE0.60002@windriver.com>
References: <20101109073416.GA14110@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:37429 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756469Ab0KJUNX (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 10 Nov 2010 15:13:23 -0500
In-Reply-To: <20101109073416.GA14110@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linux Input <linux-input@vger.kernel.org>, Maxim Levitsky <maximlevitsky@gmail.com>

On 11/09/2010 01:34 AM, Dmitry Torokhov wrote:
> Now that KGDB knows how to release keys that have been pressed when
> entering the debugger the only issue left is that SysRq handler is too
> greedy and always swallows Alt+SysRq, causing print screen hotkey to
> stop working. The solution is to re-inject the key combo when user
> releases SysRq without pressing any other keys. The patch below does
> just that and also releases keys that have been pressed before we enter
> SysRq mode.
>
> Note that it depends on a patch to input core that will stop events
> injected by one input handler from reaching the very same input handler
> (attached).
>
> Comments/testing/suggestion are sought after.
>   

I applied both patches and tested all the known failures cases I had on
my list and it looks good, for the non kdb cases.

Tested-by: Jason Wessel <jason.wessel@windriver.com>

However...  I also tested this with the kdb keyboard release patchs plus
your latest 2 patches we appear to have and incompatibility.  The
behavior is that when exiting kdb, the print screen trigger fires.  I
had not had a chance to debug it as of yet.

Jason.
