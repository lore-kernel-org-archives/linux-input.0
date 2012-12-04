From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Caps lock XOR on multiple keyboards?
Date: Mon, 03 Dec 2012 21:33:34 -0800
Message-ID: <2188671.oC9zW7H8e5@dtor-d630.eng.vmware.com>
References: <20121204000101.31658.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-da0-f46.google.com ([209.85.210.46]:63725 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750753Ab2LDFdj (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 4 Dec 2012 00:33:39 -0500
Received: by mail-da0-f46.google.com with SMTP id p5so1640676dak.19
        for <linux-input@vger.kernel.org>; Mon, 03 Dec 2012 21:33:38 -0800 (PST)
In-Reply-To: <20121204000101.31658.qmail@science.horizon.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: George Spelvin <linux@horizon.com>
Cc: linux-input@vger.kernel.org, alan@linux.intel.com, chris@the-brannons.com, gregkh@linuxfoundation.org, jslaby@suse.cz

Hi George,

On Monday, December 03, 2012 07:01:01 PM George Spelvin wrote:
> (Moving to linux-input.)
> 
> I happen to have both a PS/2 and USB keyboard plugged, in, but was
> noticing that the caps lock key seemed inverted.  When the LED was off,
> I got all caps (unless I used shift), while when it was on I got normal
> lower-case letters.
> 
> This quite confused me, until I looked over and saw that someone had
> hit caps lock on the PS/2.
> 
> Experimenting, it seems that each keyboard has its own caps lock LED
> state, and the XOR of the two controls the case of the letters.
> 
> The corresponding shift keys have a shared logical state which depends
> on who last had a transition.  Holding down left-shift on one can be
> cancelled by pressing and releasing left-shift on the other.  (But
> left & right shift are tracked separately.)
> 
> It would make more sense if each keyboard's caps lock LED controlled
> the effect on its keys.

LEDs do not control state, state should control LEDs.

> Either give each keyboard a completely separate
> caps lock state, or toggle both LEDs when either caps lock is pressed.

When in console (i.e. not X) then all keyboard's LEDs and state should be 
synced together. I.e. when pressing CapsLock on one keyboard both keyboards 
CapsLock LEDs should come on or off and the register should be the same.

This is known to be broken in X (and should be reported [again] there) but
if you can provide scenario to break it in VT I'd love to know it.

> 
> Perhaps the answer is "It's too much work to fix; stop doing something
> so stupid", but I thought I'd at least mention it.

No, it is not stupid at all.

Thanks.

-- 
Dmitrys
