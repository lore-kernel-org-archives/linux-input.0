From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [RFC/RFT] Reinject Alt+SysRq when no hotkeys have been pressed
Date: Wed, 10 Nov 2010 17:42:41 -0800
Message-ID: <20101111014240.GF2121@core.coreip.homeip.net>
References: <20101109073416.GA14110@core.coreip.homeip.net>
 <4CDAFCE0.60002@windriver.com>
 <201011101227.51837.dmitry.torokhov@gmail.com>
 <4CDB03F3.3000006@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:65224 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932078Ab0KKBmu (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 10 Nov 2010 20:42:50 -0500
Received: by gyh4 with SMTP id 4so903302gyh.19
        for <linux-input@vger.kernel.org>; Wed, 10 Nov 2010 17:42:49 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4CDB03F3.3000006@windriver.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jason Wessel <jason.wessel@windriver.com>
Cc: Linux Input <linux-input@vger.kernel.org>, Maxim Levitsky <maximlevitsky@gmail.com>

On Wed, Nov 10, 2010 at 02:43:31PM -0600, Jason Wessel wrote:
> On 11/10/2010 02:27 PM, Dmitry Torokhov wrote:
> > On Wednesday, November 10, 2010 12:13:20 pm Jason Wessel wrote:
> >> On 11/09/2010 01:34 AM, Dmitry Torokhov wrote:
> >>> Now that KGDB knows how to release keys that have been pressed when
> >>> entering the debugger the only issue left is that SysRq handler is too
> >>> greedy and always swallows Alt+SysRq, causing print screen hotkey to
> >>> stop working. The solution is to re-inject the key combo when user
> >>> releases SysRq without pressing any other keys. The patch below does
> >>> just that and also releases keys that have been pressed before we enter
> >>> SysRq mode.
> >>>
> >>> Note that it depends on a patch to input core that will stop events
> >>> injected by one input handler from reaching the very same input handler
> >>> (attached).
> >>>
> >>> Comments/testing/suggestion are sought after.
> >> I applied both patches and tested all the known failures cases I had on
> >> my list and it looks good, for the non kdb cases.
> >>
> >> Tested-by: Jason Wessel <jason.wessel@windriver.com>
> >>
> 
> >> However...  I also tested this with the kdb keyboard release
> >> patches plus your latest 2 patches and we appear to have an
> >> incompatibility.  The behavior is that when exiting kdb the print
> >> screen trigger fires.  I had not had a chance to debug it as of
> >> yet.
> >>
> >
> > Hmm, let me think...
> >
> 
> So I debugged it.  The key up events are peeled off in linear order
> with the kdb release key code.
> 
> The sequence looks like this
> 
> down - alt
> down - printScr
> down - g           <-- Enters kdb
> 
> The kdb release code simulates the events
> up - g
> up - alt
> up - printScr
> 
> That tells me we have something bad about the key events going on, or
> that we care about release ordering in the release handler.
> 

Ah, I see. I bet the shortcut for print screen is actually triggered on
_release_ and X drivers do not filter release events for which they have
not seen presses. Oh well...

Coudl you try sticking somethgin like this into sysrq code?

	case KEY_SYSRQ:

		if (value == 1 ... ) {
			....
		}

		if (sysrq->active)
			clear_bit(KEY_SYSRQ, handle->dev->key);


This is a bit dirty but sysrq is pretty special anyways...

Thanks.

-- 
Dmitry
