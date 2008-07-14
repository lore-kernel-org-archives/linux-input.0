From: tsbogend@alpha.franken.de (Thomas Bogendoerfer)
Subject: Re: [PATCH] new driver for SGI Indy volume buttons
Date: Mon, 14 Jul 2008 17:47:06 +0200
Message-ID: <20080714154706.GA9817@alpha.franken.de>
References: <20080711183435.4C53AC2EBF@solo.franken.de> <20080714143210.GB13938@anvil.corenet.prv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from elvis.franken.de ([193.175.24.41]:54270 "EHLO elvis.franken.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753834AbYGNPrL (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 14 Jul 2008 11:47:11 -0400
Content-Disposition: inline
In-Reply-To: <20080714143210.GB13938@anvil.corenet.prv>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

On Mon, Jul 14, 2008 at 10:32:10AM -0400, Dmitry Torokhov wrote:
> On Fri, Jul 11, 2008 at 08:34:35PM +0200, Thomas Bogendoerfer wrote:
> > This driver adds support for the volume buttons on the front of every
> > SGI Indy workstation.
> > 
> 
> This driver looks like a twin brother to sgio2_btns. Is is possible to
> merge these 2?

It'd need some #ifdefs to select the hardware register and decide
whether the events need to be acked. If you prefer just one driver,
I'll put both together.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessary a
good idea.                                                [ RFC1925, 2.3 ]
