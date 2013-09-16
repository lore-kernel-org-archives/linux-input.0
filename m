From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 20/51] Input: atmel_mxt_ts - Set default irqflags when
 there is no pdata
Date: Sun, 15 Sep 2013 19:25:33 -0700
Message-ID: <20130916022533.GA6468@core.coreip.homeip.net>
References: <1372337366-9286-1-git-send-email-nick.dyer@itdev.co.uk>
 <1372337366-9286-21-git-send-email-nick.dyer@itdev.co.uk>
 <20130718171744.GC32381@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f52.google.com ([209.85.160.52]:34088 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753098Ab3IPGdI (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 16 Sep 2013 02:33:08 -0400
Content-Disposition: inline
In-Reply-To: <20130718171744.GC32381@polaris.bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: rydberg@euromail.se
Cc: Nick Dyer <nick.dyer@itdev.co.uk>, Daniel Kurtz <djkurtz@chromium.org>, Joonyoung Shim <jy0922.shim@samsung.com>, Alan Bowens <Alan.Bowens@atmel.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Meerwald <pmeerw@pmeerw.net>, Benson Leung <bleung@chromium.org>, Olof Johansson <olofj@chromium.org>, Yufeng Shen <miletus@chromium.org>

On Thu, Jul 18, 2013 at 07:17:44PM +0200, rydberg@euromail.se wrote:
> Hi Nick,
> 
> > From: Yufeng Shen <miletus@chromium.org>
> > 
> > This is the preparation for supporting the code path when there is
> > platform data provided and still boot the device into a sane state
> > with backup NVRAM config.
> > 
> > Make the irqflags default to be IRQF_TRIGGER_FALLING if no platform data is
> > provided.

I think if there is no platform data we should use 0 as IRQ falgs and
assume that IRQ line is properly configured by the board code or via
device tree.

Thanks.

-- 
Dmitry
