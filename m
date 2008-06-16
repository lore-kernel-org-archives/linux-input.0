From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] input: make mainstone-wm97xx.c depend on
	MACH_MAINSTONE instead of ARCH_PXA
Date: Mon, 16 Jun 2008 13:07:56 +0100
Message-ID: <20080616120756.GA7302@rakim.wolfsonmicro.main>
References: <48564133.3070609@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:42476 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753051AbYFPMH7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 16 Jun 2008 08:07:59 -0400
Content-Disposition: inline
In-Reply-To: <48564133.3070609@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Eric Miao <eric.y.miao@gmail.com>
Cc: linux-input <linux-input@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>

On Mon, Jun 16, 2008 at 06:32:19PM +0800, Eric Miao wrote:
> If this is totally mainstone specific.

> Signed-off-by: Eric Miao <eric.miao@marvell.com>

It is and it isn't.  It's very thin and stands a reasonable chance of
working with generic PXA systems - ideally at some point we will have 
the ability to pass platform data to AC97 devices which would let it run
elsewhere.  The driver was until very recently called pxa-wm97xx but
renamed recently due to the fact that we can't assume it'll work on
other things due to having the GPIO hookup hardcoded.

I'd rather let it be visible but I'm not *too* bothered either way.
