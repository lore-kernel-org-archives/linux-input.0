From: Marek Vasut <marex@denx.de>
Subject: Re: [PATCH] HID: add quirk for Freescale i.MX23 ROM recovery
Date: Sat, 12 Jan 2013 21:22:48 +0100
Message-ID: <201301122122.48856.marex@denx.de>
References: <1353734157-9119-1-git-send-email-marex@denx.de> <alpine.LNX.2.00.1211261421050.12570@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:56196 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754059Ab3ALUWy (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 12 Jan 2013 15:22:54 -0500
In-Reply-To: <alpine.LNX.2.00.1211261421050.12570@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, Chen Peter <B29397@freescale.com>, Greg KH <greg@kroah.com>

Hi Jirka,

> On Sat, 24 Nov 2012, Marek Vasut wrote:
> > The USB recovery mode present in i.MX23 ROM emulates USB HID.
> > It needs this quirk to behave properly.
> > 
> > Even if the official branding of the chip is Freescale i.MX23,
> > I named it Sigmatel STMP3780 since that's what the chip really
> > is and it even reports itself as STMP3780.
> 
> Applied, thanks Marek.

Can we possibly push this into -stable please?

Best regards,
Marek Vasut
