From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: Add Nintendo extension controller driver
Date: Mon, 16 May 2011 15:43:53 -0700
Message-ID: <20110516224353.GA19481@core.coreip.homeip.net>
References: <20110516214608.17011.3075.stgit@ponder>
 <20110516215110.GE16731@trinity.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:60819 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752691Ab1EPWoA (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 16 May 2011 18:44:00 -0400
Content-Disposition: inline
In-Reply-To: <20110516215110.GE16731@trinity.fluff.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ben Dooks <ben@trinity.fluff.org>
Cc: Grant Likely <grant.likely@secretlab.ca>, simon@mungewell.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, OliverNeukumoliver@neukum.org

On Mon, May 16, 2011 at 10:51:10PM +0100, Ben Dooks wrote:
> On Mon, May 16, 2011 at 03:46:08PM -0600, Grant Likely wrote:
> > +
> > +	/*
> > +	 * DMA buffer, with padding to give it its own cache line so that
> > +	 * the DMA streaming works on non-coherent architectures.
> > +	 * Question: Is this the proper pattern, and is this really necessary?
> > +	 */
> > +	uint8_t pad1[L1_CACHE_BYTES];
> > +	uint8_t buf[6];
> > +	uint8_t pad2[L1_CACHE_BYTES];
> > +};
> 
> I think there's an attribute to do this, starting with an __ defined
> in the kernel.
> 

Yes, it is called "____cacheline_aligned".

-- 
Dmitry
