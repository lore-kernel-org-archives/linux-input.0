From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [BUILD_FAILURE] 2.6.24-git18 build fails section type conflict psmouse-base
Date: Tue, 4 Mar 2008 13:35:04 +1100
Message-ID: <200803041335.05144.rusty@rustcorp.com.au>
References: <47AC2FDB.7080104@linux.vnet.ibm.com> <200803031535.17644.rusty@rustcorp.com.au> <20080303081345.GA4457@cs181133002.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ozlabs.org ([203.10.76.45]:34060 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753021AbYCDCf6 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 3 Mar 2008 21:35:58 -0500
In-Reply-To: <20080303081345.GA4457@cs181133002.pp.htv.fi>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Adrian Bunk <bunk@kernel.org>
Cc: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>, LKML <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org, Andy Whitcroft <apw@shadowen.org>, Balbir Singh <balbir@linux.vnet.ibm.com>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>

On Monday 03 March 2008 19:13:45 Adrian Bunk wrote:
> On Mon, Mar 03, 2008 at 03:35:16PM +1100, Rusty Russell wrote:
> > Erk... This is horrible, and arguably something gcc should try to deal
> > with. How about we just drop the const and add a comment, rather than
> > breaking one arch at a time?
>
> We should have caught all architectures having problems, and a slightly
> improved patch is now in Linus' tree.

Yes, thanks, I saw it later on in the thread.  'Tis still horrible tho :)

Rusty.
