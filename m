From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] HID: add quirk for Freescale i.MX23 ROM recovery
Date: Mon, 26 Nov 2012 14:21:18 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1211261421050.12570@pobox.suse.cz>
References: <1353734157-9119-1-git-send-email-marex@denx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:44144 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754662Ab2KZNVW (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 26 Nov 2012 08:21:22 -0500
In-Reply-To: <1353734157-9119-1-git-send-email-marex@denx.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Marek Vasut <marex@denx.de>
Cc: linux-input@vger.kernel.org, Chen Peter <B29397@freescale.com>, Greg KH <greg@kroah.com>

On Sat, 24 Nov 2012, Marek Vasut wrote:

> The USB recovery mode present in i.MX23 ROM emulates USB HID.
> It needs this quirk to behave properly.
> 
> Even if the official branding of the chip is Freescale i.MX23,
> I named it Sigmatel STMP3780 since that's what the chip really
> is and it even reports itself as STMP3780.

Applied, thanks Marek.

-- 
Jiri Kosina
SUSE Labs
