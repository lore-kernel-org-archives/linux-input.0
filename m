From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: input: mt: Software finger tracking in the kernel?
Date: Sat, 20 Mar 2010 12:44:24 -0700
Message-ID: <20100320194424.GC28402@core.coreip.homeip.net>
References: <4BA358DB.20708@enmesh.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f172.google.com ([209.85.211.172]:42317 "EHLO
	mail-yw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752158Ab0CTToa (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 20 Mar 2010 15:44:30 -0400
Content-Disposition: inline
In-Reply-To: <4BA358DB.20708@enmesh.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@enmesh.se>
Cc: linux-input <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi Henrik,

On Fri, Mar 19, 2010 at 11:58:35AM +0100, Henrik Rydberg wrote:
> Hi Dmitry,
> 
> there is an ongoing discussion about adding multitouch to X
> (http://lists.x.org/archives/xorg-devel/2010-March/006206.html), which is
> beginning to take on more solid form.
> 
> One of the suggestions emerging from that discussion is to add the software
> finger tracking to the kernel. Back in summer 2009 when I thought about this, I
> disregarded it as being too experimental. I have since then reconsidered,
> starting to think it really is the right place.
> 
> The MT protocol allows applications to take advantage of multi-contact hardware,
> but leaves the problems of finger tracking and filtering to the user. Arguably,
> no application can make good use of MT without these, so the problem is pushed
> forward, in this case to evdev or equivalent.
> 
> The knowledge of signal-to-noise ratios and prior input states resides in the
> kernel. Because of this, the finger matching and filtering would naturally
> reside within the kernel.
> 
> So, if there were to appear patches to include matching in the input core, would
> you consider them? :-)
> 

I am not sure if input core itself is the proper place to do such
thing, I'd envisioned something more like a library providing common
code that drivers could opt in to use, like we hane ff-memless for
memory-less force-feedback devices.

Does it make any sense? I guess post the skeleton of the code and we can
discuss further.

-- 
Dmitry
