From: Adrian Bunk <bunk@kernel.org>
Subject: Re: [BUILD_FAILURE] 2.6.24-git18 build fails section type conflict
	psmouse-base
Date: Fri, 8 Feb 2008 12:48:51 +0200
Message-ID: <20080208104851.GI7198@cs181133002.pp.htv.fi>
References: <47AC2FDB.7080104@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp6.pp.htv.fi ([213.243.153.40]:54636 "EHLO smtp6.pp.htv.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758924AbYBHLFt (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 8 Feb 2008 06:05:49 -0500
Content-Disposition: inline
In-Reply-To: <47AC2FDB.7080104@linux.vnet.ibm.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>, rusty@rustcorp.com.au
Cc: LKML <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org, Andy Whitcroft <apw@shadowen.org>, Balbir Singh <balbir@linux.vnet.ibm.com>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>

On Fri, Feb 08, 2008 at 04:02:59PM +0530, Kamalesh Babulal wrote:
> Hi,
> 
> The 2.6.24-git18 kernel build fails on the power machine with following message
> 
> drivers/input/mouse/psmouse-base.c:44: error: __param_proto causes a section type conflict
> drivers/input/mouse/psmouse-base.c:44: error: __param_proto causes a section type conflict
> make[3]: *** [drivers/input/mouse/psmouse-base.o] Error 1
> make[2]: *** [drivers/input/mouse] Error 2
> make[1]: *** [drivers/input] Error 2
> make: *** [drivers] Error 2
> 
> this failure was reported earlier http://lkml.org/lkml/2007/9/22/64

You need the patch from [1] manually applied (due to changed context) 
and with " || defined(__powerpc__)" added for getting it compiling.

@Rusty:
Can you look at this issue? It's a modules problem on 3 architectures.

cu
Adrian

[1] http://lkml.org/lkml/2007/12/27/29

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

