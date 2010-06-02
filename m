From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Ads7846 breaks suspend-to-ram on 3430SDP
Date: Wed, 2 Jun 2010 00:24:00 -0700
Message-ID: <20100602072400.GD3713@core.coreip.homeip.net>
References: <5A47E75E594F054BAF48C5E4FC4B92AB0322D7D778@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:49967 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752684Ab0FBHYF (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 2 Jun 2010 03:24:05 -0400
Content-Disposition: inline
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB0322D7D778@dbde02.ent.ti.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Gadiyar, Anand" <gadiyar@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Hi Anand,

On Fri, May 14, 2010 at 02:26:40PM +0530, Gadiyar, Anand wrote:
> Looks like the ads7846 driver breaks suspend-to-ram at least on
> the OMAP 3430SDP. On a kernel built with the omap3_defconfig, with
> no_console_suspend, I see the log below.
> 
> Will investigate some time next week, unless someone already has a fix.
> 

Could you please try 2.6.35-rc1 - I expect Kevin's fix to handle
regulatore registering failure will take care of this oops.

Thanks.

-- 
Dmitry
