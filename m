From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH 0/5] xen pvfb: Para-virtual framebuffer, keyboard and
 pointer driver updates
Date: Wed, 21 May 2008 10:09:14 +0100
Message-ID: <4833E6BA.3060408@goop.org>
References: <87d4ngm4s4.fsf@pike.pond.sub.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from gw.goop.org ([64.81.55.164]:56426 "EHLO mail.goop.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753765AbYEUJJp (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 21 May 2008 05:09:45 -0400
In-Reply-To: <87d4ngm4s4.fsf@pike.pond.sub.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Markus Armbruster <armbru@redhat.com>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, xen-devel@lists.xensource.com, linux-fbdev-devel@lists.sourceforge.net, adaplas@gmail.com, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, mingo@redhat.com, akpm@linux-foundation.org, Pat Campbell <plc@novell.com>

Markus Armbruster wrote:
> This is an update to the Linux part of the Xen PVFB.  Linux Xen PVFB
> is a pair of Xen para-virtual frontend device drivers:
> drivers/video/xen-fbfront.c provides a framebuffer, and
> drivers/input/xen-kbdfront provides keyboard and mouse.  Their
> backends run in dom0 user space.
>
> Parts in this patch series:
>
> 1. Enable Xen console by default in domU
> 2. Pointer z-axis (mouse wheel) support
> 3. Module aliases to support module autoloading
> 4. Zero unused bytes in events sent to backend
> 5. Dynamic mode support (screen resizing)
>
> To the best of my knowledge, these patches are independent.  The last
> one needs a bit of trivial merging to apply without the first one.  I
> tested only 1, 1+2, 1+2+3, 1+2+3+4, and the complete series.  I'm
> happy to split this into different parts if that helps.
>   

Thanks Markus,

This looks good.  I'll stick it into my queue and feed it via Ingo when 
I've given it a bit of a test.

Are we happy that the preferred console stuff is now the best solution?  
Does it solve your installer issues?

    J
