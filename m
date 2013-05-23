From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/7] input: ep93xx_keypad: Pass correct pointer to
 free_irq()
Date: Thu, 23 May 2013 09:31:45 -0700
Message-ID: <20130523163145.GC15494@core.coreip.homeip.net>
References: <1369061486-28226-1-git-send-email-lars@metafoo.de>
 <ADE657CA350FB648AAC2C43247A983F0021DA656F56D@AUSP01VMBX24.collaborationhost.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f171.google.com ([209.85.192.171]:37534 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752403Ab3EWQbs (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 23 May 2013 12:31:48 -0400
Content-Disposition: inline
In-Reply-To: <ADE657CA350FB648AAC2C43247A983F0021DA656F56D@AUSP01VMBX24.collaborationhost.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: H Hartley Sweeten <hartleys@visionengravers.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Mon, May 20, 2013 at 10:49:00AM -0500, H Hartley Sweeten wrote:
> On Monday, May 20, 2013 7:51 AM, Lars-Peter Clausen wrote:
> > free_irq() expects the same pointer that was passed to request_irq(), otherwise
> > the IRQ is not freed.
> 
> <snip>
> 
> > Cc: H Hartley Sweeten <hartleys@visionengravers.com>
> > Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> > ---
> >  drivers/input/keyboard/ep93xx_keypad.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> Thanks,
> 
> Acked-by: H Hartley Sweeten <hsweeten@visionengravers.com>
> 

Applied all, thank you.

-- 
Dmitry
