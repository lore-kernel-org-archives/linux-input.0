From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: linux-next: Tree for July 30
Date: Thu, 7 Aug 2008 14:11:09 -0400
Message-ID: <20080807140357.ZZRA012@mailhub.coreip.homeip.net>
References: <20080730170635.f737ffe9.sfr@canb.auug.org.au> <20080731104437.5e5669bc.akpm@linux-foundation.org> <20080731141302.ZZRA012@mailhub.coreip.homeip.net> <200807312048.57575.rjw@sisk.pl> <20080731145023.ZZRA012@mailhub.coreip.homeip.net> <alpine.LFD.1.10.0807311207000.3277@nehalem.linux-foundation.org> <20080731151625.ZZRA012@mailhub.coreip.homeip.net> <20080731194207.GA12233@anvil.corenet.prv> <20080731131056.eecc4826.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.242]:31569 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751429AbYHGSLP (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 7 Aug 2008 14:11:15 -0400
Received: by an-out-0708.google.com with SMTP id d40so98853and.103
        for <linux-input@vger.kernel.org>; Thu, 07 Aug 2008 11:11:14 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20080731131056.eecc4826.akpm@linux-foundation.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: torvalds@linux-foundation.org, rjw@sisk.pl, bzolnier@gmail.com, sfr@canb.auug.org.au, linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On Thu, Jul 31, 2008 at 01:10:56PM -0700, Andrew Morton wrote:
> 
> If that works then great.  But I think the printk could be improved. 
> Please provide sufficient information so that users (not programmers)
> can go off and fix things up without needing to email kernel developers.
> 
> One suitable approach would be
> 
> 	printk("see http://userweb.kernel.org/~dtor/read-this.txt")
> 

Ok, I made a small page here:

	http://userweb.kernel.org/~dtor/eviocgbit-bug.html

If you think this is sufficient I'd like to put the patch with the
warning in 2.6.27 so people and distributions could start updarting
affected programs.

-- 
Dmitry
