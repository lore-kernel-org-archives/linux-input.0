From: Nick Dyer <nick.dyer@itdev.co.uk>
Subject: Re: [PATCH 26/51] Input: atmel_mxt_ts - Move input device init into
 separate function
Date: Mon, 08 Jul 2013 10:41:33 +0100
Message-ID: <51DA894D.3050208@itdev.co.uk>
References: <1372337366-9286-1-git-send-email-nick.dyer@itdev.co.uk> <1372337366-9286-27-git-send-email-nick.dyer@itdev.co.uk> <20130707053407.GC15453@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from kdh-gw.itdev.co.uk ([89.21.227.133]:16032 "EHLO
	hermes.kdh.itdev.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751045Ab3GHJlg (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 8 Jul 2013 05:41:36 -0400
In-Reply-To: <20130707053407.GC15453@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Daniel Kurtz <djkurtz@chromium.org>, Henrik Rydberg <rydberg@euromail.se>, Joonyoung Shim <jy0922.shim@samsung.com>, Alan Bowens <Alan.Bowens@atmel.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Meerwald <pmeerw@pmeerw.net>, Benson Leung <bleung@chromium.org>, Olof Johansson <olofj@chromium.org>

Dmitry Torokhov wrote:
> On Thu, Jun 27, 2013 at 01:49:01PM +0100, Nick Dyer wrote:
>> Signed-off-by: Nick Dyer <nick.dyer@itdev.co.uk>
> 
> So before we allocated input device before requesting IRQ, now we fo it
> afterwards so there is moment where the interrupt is requested and not
> disabled and input device is not allocated yet. Is it possible for
> interrupt to happen at that moment?

Yes, and it will be handled correctly, there are guards in the correct
places to ensure the input device will not be used before being registered.

It is registered at this point since there are several paths that might
need the interrupt handler (for example, to handle flash if device is in
failed state, or to upload configuration if necessary).
