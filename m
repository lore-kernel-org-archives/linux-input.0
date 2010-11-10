From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [RFC/RFT] Reinject Alt+SysRq when no hotkeys have been pressed
Date: Wed, 10 Nov 2010 12:27:51 -0800
Message-ID: <201011101227.51837.dmitry.torokhov@gmail.com>
References: <20101109073416.GA14110@core.coreip.homeip.net> <4CDAFCE0.60002@windriver.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:50273 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756327Ab0KJU2A (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 10 Nov 2010 15:28:00 -0500
Received: by qyk12 with SMTP id 12so3448790qyk.19
        for <linux-input@vger.kernel.org>; Wed, 10 Nov 2010 12:28:00 -0800 (PST)
In-Reply-To: <4CDAFCE0.60002@windriver.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jason Wessel <jason.wessel@windriver.com>
Cc: Linux Input <linux-input@vger.kernel.org>, Maxim Levitsky <maximlevitsky@gmail.com>

On Wednesday, November 10, 2010 12:13:20 pm Jason Wessel wrote:
> On 11/09/2010 01:34 AM, Dmitry Torokhov wrote:
> > Now that KGDB knows how to release keys that have been pressed when
> > entering the debugger the only issue left is that SysRq handler is too
> > greedy and always swallows Alt+SysRq, causing print screen hotkey to
> > stop working. The solution is to re-inject the key combo when user
> > releases SysRq without pressing any other keys. The patch below does
> > just that and also releases keys that have been pressed before we enter
> > SysRq mode.
> > 
> > Note that it depends on a patch to input core that will stop events
> > injected by one input handler from reaching the very same input handler
> > (attached).
> > 
> > Comments/testing/suggestion are sought after.
> 
> I applied both patches and tested all the known failures cases I had on
> my list and it looks good, for the non kdb cases.
> 
> Tested-by: Jason Wessel <jason.wessel@windriver.com>
> 
> However...  I also tested this with the kdb keyboard release patchs plus
> your latest 2 patches we appear to have and incompatibility.  The
> behavior is that when exiting kdb, the print screen trigger fires.  I
> had not had a chance to debug it as of yet.
> 

Hmm, let me think...

-- 
Dmitry
