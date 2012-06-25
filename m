From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 3/4] input/nomadik-ske: get rid of multiple interrupts
Date: Mon, 25 Jun 2012 00:35:15 -0700
Message-ID: <20120625073515.GG13876@core.coreip.homeip.net>
References: <1339942678-20156-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:37946 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753988Ab2FYHfV (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 25 Jun 2012 03:35:21 -0400
Received: by dady13 with SMTP id y13so4958175dad.19
        for <linux-input@vger.kernel.org>; Mon, 25 Jun 2012 00:35:20 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1339942678-20156-1-git-send-email-linus.walleij@stericsson.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linus Walleij <linus.walleij@stericsson.com>
Cc: linux-input@vger.kernel.org, Naveen Kumar Gaddipati <naveen.gaddipati@stericsson.com>, Linus Walleij <linus.walleij@linaro.org>

On Sun, Jun 17, 2012 at 04:17:58PM +0200, Linus Walleij wrote:
> From: Naveen Kumar Gaddipati <naveen.gaddipati@stericsson.com>
> 
> The keypad could cause multiple interrupts to be fired in succession
> since we weren't waiting for the IRQs to clear properly in the
> interrupt handler. We ait for a number of bus iterations (the
> readl():s from the peripheral bus will stall, so these are quite
> long) before giving up on getting keys ready to read, then we
> sleep until the IRQ is deasserted (this is OK since the interrupt
> is threaded). Also use the debounce platform data for another
> hardcoded wait loop.
> 
> Signed-off-by: Naveen Kumar Gaddipati <naveen.gaddipati@stericsson.com>
> Reviewed-by: Rikard Olsson <rikard.p.olsson@stericsson.com>
> Reviewed-by: Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Applied, thank you.

-- 
Dmitry
