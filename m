From: Adrian Bunk <bunk@kernel.org>
Subject: Re: [BUILD_FAILURE] 2.6.24-git18 build fails section type conflict
	psmouse-base
Date: Mon, 3 Mar 2008 10:13:45 +0200
Message-ID: <20080303081345.GA4457@cs181133002.pp.htv.fi>
References: <47AC2FDB.7080104@linux.vnet.ibm.com> <20080208104851.GI7198@cs181133002.pp.htv.fi> <200803031535.17644.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp6.pp.htv.fi ([213.243.153.40]:40527 "EHLO smtp6.pp.htv.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751979AbYCCIPU (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 3 Mar 2008 03:15:20 -0500
Content-Disposition: inline
In-Reply-To: <200803031535.17644.rusty@rustcorp.com.au>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>, LKML <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org, Andy Whitcroft <apw@shadowen.org>, Balbir Singh <balbir@linux.vnet.ibm.com>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>

On Mon, Mar 03, 2008 at 03:35:16PM +1100, Rusty Russell wrote:
> On Friday 08 February 2008 21:48:51 Adrian Bunk wrote:
> > On Fri, Feb 08, 2008 at 04:02:59PM +0530, Kamalesh Babulal wrote:
> > > drivers/input/mouse/psmouse-base.c:44: error: __param_proto causes a
> > > section type conflict drivers/input/mouse/psmouse-base.c:44: error:
> > > __param_proto causes a section type conflict 
> > @Rusty:
> > Can you look at this issue? It's a modules problem on 3 architectures.
> >
> > cu
> > Adrian
> >
> > [1] http://lkml.org/lkml/2007/12/27/29
> 
> Erk... This is horrible, and arguably something gcc should try to deal with.  
> How about we just drop the const and add a comment, rather than breaking one 
> arch at a time?

We should have caught all architectures having problems, and a slightly 
improved patch is now in Linus' tree.

> Thanks,
> Rusty.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

