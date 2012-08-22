From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: imx_keypad - reset the hardware before enabling
Date: Tue, 21 Aug 2012 22:06:16 -0700
Message-ID: <20120822050616.GA20624@core.coreip.homeip.net>
References: <1345476893-4737-1-git-send-email-m.grzeschik@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:34438 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753091Ab2HVFGV (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 22 Aug 2012 01:06:21 -0400
Received: by dady13 with SMTP id y13so443319dad.19
        for <linux-input@vger.kernel.org>; Tue, 21 Aug 2012 22:06:21 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1345476893-4737-1-git-send-email-m.grzeschik@pengutronix.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Michael Grzeschik <m.grzeschik@pengutronix.de>
Cc: linux-input@vger.kernel.org

On Mon, Aug 20, 2012 at 05:34:53PM +0200, Michael Grzeschik wrote:
> assert the hardware is correctly initialized before requesting the
> interrupt. Otherwise if a key was already touched since power-on the
> kernel enters an interrupt loop. To fix this issue we clear pending
> interrupt sources. We have to ensure to enable clks while changing the
> keypad registers.
> 
> Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>

Applied, thank you Michael.

-- 
Dmitry
