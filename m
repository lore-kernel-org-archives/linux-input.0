From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 26/51] Input: atmel_mxt_ts - Move input device init into
 separate function
Date: Wed, 10 Jul 2013 09:53:41 -0700
Message-ID: <20130710165341.GB22992@core.coreip.homeip.net>
References: <1372337366-9286-1-git-send-email-nick.dyer@itdev.co.uk>
 <1372337366-9286-27-git-send-email-nick.dyer@itdev.co.uk>
 <20130707053407.GC15453@core.coreip.homeip.net>
 <51DA894D.3050208@itdev.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:60749 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754110Ab3GJQxq (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 10 Jul 2013 12:53:46 -0400
Content-Disposition: inline
In-Reply-To: <51DA894D.3050208@itdev.co.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Nick Dyer <nick.dyer@itdev.co.uk>
Cc: Daniel Kurtz <djkurtz@chromium.org>, Henrik Rydberg <rydberg@euromail.se>, Joonyoung Shim <jy0922.shim@samsung.com>, Alan Bowens <Alan.Bowens@atmel.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Meerwald <pmeerw@pmeerw.net>, Benson Leung <bleung@chromium.org>, Olof Johansson <olofj@chromium.org>

On Mon, Jul 08, 2013 at 10:41:33AM +0100, Nick Dyer wrote:
> Dmitry Torokhov wrote:
> > On Thu, Jun 27, 2013 at 01:49:01PM +0100, Nick Dyer wrote:
> >> Signed-off-by: Nick Dyer <nick.dyer@itdev.co.uk>
> > 
> > So before we allocated input device before requesting IRQ, now we fo it
> > afterwards so there is moment where the interrupt is requested and not
> > disabled and input device is not allocated yet. Is it possible for
> > interrupt to happen at that moment?
> 
> Yes, and it will be handled correctly, there are guards in the correct
> places to ensure the input device will not be used before being registered.
> 
> It is registered at this point since there are several paths that might
> need the interrupt handler (for example, to handle flash if device is in
> failed state, or to upload configuration if necessary).

OK, thanks.

-- 
Dmitry
