From: Harald Welte <laforge@openmoko.org>
Subject: Re: [PATCH 8/12] neo1973: button input device driver
Date: Fri, 21 Dec 2007 09:33:57 +0100
Message-ID: <20071221083357.GN6625@prithivi.gnumonks.org>
References: <20071218110807.GO29882@prithivi.gnumonks.org> <4767AE27.1050201@dominion.kabel.utwente.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ganesha.gnumonks.org ([213.95.27.120]:37274 "EHLO
	ganesha.gnumonks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750968AbXLUIk7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 21 Dec 2007 03:40:59 -0500
Content-Disposition: inline
In-Reply-To: <4767AE27.1050201@dominion.kabel.utwente.nl>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Koen Kooi <koen@dominion.kabel.utwente.nl>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-input@vger.kernel.org

On Tue, Dec 18, 2007 at 12:25:27PM +0100, Koen Kooi wrote:

> > This driver provides support for the Neo1973 button/switch
> > 
> > Signed-off-by: Harald Welte <laforge@openmoko.org>
> >
> > +	  To compile this driver as a module, choose M here: the
> > +	  module will be called gta01kbd.
> 
> I think that needs a s/gta01kbd/neo1973kbd/ because:

Thanks a lot, I've fixed this in my patchset.  Will await further
comments before re-posting that patch.

-- 
- Harald Welte <laforge@openmoko.org>          	        http://openmoko.org/
============================================================================
Software for the world's first truly open Free Software mobile phone
