From: Marek Vasut <marex@denx.de>
Subject: Re: [PATCH] HID: add quirk for Freescale i.MX23 ROM recovery
Date: Mon, 26 Nov 2012 18:12:05 +0100
Message-ID: <201211261812.05324.marex@denx.de>
References: <1353734157-9119-1-git-send-email-marex@denx.de> <alpine.LNX.2.00.1211261421050.12570@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:44894 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756530Ab2KZRMJ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 26 Nov 2012 12:12:09 -0500
In-Reply-To: <alpine.LNX.2.00.1211261421050.12570@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, Chen Peter <B29397@freescale.com>, Greg KH <greg@kroah.com>

Dear Jiri Kosina,

> On Sat, 24 Nov 2012, Marek Vasut wrote:
> > The USB recovery mode present in i.MX23 ROM emulates USB HID.
> > It needs this quirk to behave properly.
> > 
> > Even if the official branding of the chip is Freescale i.MX23,
> > I named it Sigmatel STMP3780 since that's what the chip really
> > is and it even reports itself as STMP3780.
> 
> Applied, thanks Marek.

Thank you. It'd be nice to queue this for -stable too.

Best regards,
Marek Vasut
