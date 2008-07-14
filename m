From: tsbogend@alpha.franken.de (Thomas Bogendoerfer)
Subject: Re: [PATCH] new driver for SGI Indy volume buttons
Date: Mon, 14 Jul 2008 18:33:00 +0200
Message-ID: <20080714163300.GA15481@alpha.franken.de>
References: <20080711183435.4C53AC2EBF@solo.franken.de> <20080714143210.GB13938@anvil.corenet.prv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from elvis.franken.de ([193.175.24.41]:54817 "EHLO elvis.franken.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753763AbYGNQdI (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 14 Jul 2008 12:33:08 -0400
Content-Disposition: inline
In-Reply-To: <20080714143210.GB13938@anvil.corenet.prv>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

On Mon, Jul 14, 2008 at 10:32:10AM -0400, Dmitry Torokhov wrote:
> This driver looks like a twin brother to sgio2_btns. Is is possible to
> merge these 2?
> [...]

small update, I've merged both drivers and it looks pretty good. I'm
going to test it and submit it. I'd like to rename the driver to
sgi_btns.c. Should I provide a patch to remove the already included
sgi o2 button driver ?

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessary a
good idea.                                                [ RFC1925, 2.3 ]
