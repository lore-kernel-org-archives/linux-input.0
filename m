From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: add HP Compaq 2710p to 'noloop' table
Date: Wed, 14 Apr 2010 15:54:07 -0700
Message-ID: <20100414225407.GA12143@core.coreip.homeip.net>
References: <alpine.LNX.2.00.1004141409450.8345@pobox.suse.cz>
 <20100414160429.GC2450@core.coreip.homeip.net>
 <alpine.LNX.2.00.1004142354330.8345@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:42215 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756958Ab0DNWyQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 14 Apr 2010 18:54:16 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.1004142354330.8345@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On Wed, Apr 14, 2010 at 11:57:04PM +0200, Jiri Kosina wrote:
> On Wed, 14 Apr 2010, Dmitry Torokhov wrote:
> 
> > > Add HP Compaq 2710p to 'noloop' table. Otherwsie this machine is reported 
> > > to not report properly to AUX_LOOP command time-to-time, causing 
> > > non-working keyboard due to messed up i8042.
> > > 
> > 
> > What is the chassis type for the box in DMI? I am curious why it isn't
> > caought up by the generic "portable" test...
> 
> Hmm, you are right, I completely forgot that we are now completely 
> bypassing AUX IRQ delivery on Portable/Laptop/(Sub-)Notebook chasis types.
> 
> I was going through my older patchqueue and flushing it, and this one 
> slipped through, as it is apparently not necessary for current mainline 
> (the machine in question has chasis type "Notebook"), but only for older 
> kernels.
> 

OK, thanks.

-- 
Dmitry
