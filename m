From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] input: Force Sentelic reconnect when mode setting has
 failed
Date: Mon, 21 May 2012 16:28:51 +0100
Message-ID: <20120521152851.GA3552@srcf.ucam.org>
References: <1337468192-16337-1-git-send-email-mjg@redhat.com>
 <12052123215711.9614@cnaqrzbavhz.fragryvp.pbz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:56689 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750896Ab2EUP27 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 21 May 2012 11:28:59 -0400
Content-Disposition: inline
In-Reply-To: <12052123215711.9614@cnaqrzbavhz.fragryvp.pbz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Tai-hwa Liang <avatar@sentelic.com>
Cc: os@ohmu.fi, dtor@mail.ru, linux-input@vger.kernel.org

On Mon, May 21, 2012 at 11:22:07PM +0800, Tai-hwa Liang wrote:
> On Sat, 19 May 2012, Matthew Garrett wrote:
> >The Sentelic touchpad in an Asus UX-21 failed to work since the native
> >driver was merged. Examination showed that the FSP_REG_SWC1 register had
> >reverted back to 0x80 and so the pad was sending normal packets despite
> >the driver expecting absolute ones.
> 
>    Sounds to me that the hardware was reset, which usually happens if
> there's intermittent power failure events.  Is there any particular step
> to reproduce this unexpected resetting?

None that I've identified. It only seems to do it once, and afterwards 
it's fine. I agree that this seems to be covering up some more insidious 
bug, but I spent most of Friday and Saturday failing to find one.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
