From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] UCB1400 IRQ Probe fix
Date: Mon, 21 Apr 2008 12:15:22 -0400
Message-ID: <20080421161522.GA7715@anvil.corenet.prv>
References: <47FD7D5F.40800@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rn-out-0910.google.com ([64.233.170.187]:32947 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760704AbYDUQPb (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 21 Apr 2008 12:15:31 -0400
Received: by rn-out-0910.google.com with SMTP id e11so402918rng.17
        for <linux-input@vger.kernel.org>; Mon, 21 Apr 2008 09:15:30 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <47FD7D5F.40800@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Vernon Sauder <vernoninhand@gmail.com>
Cc: linux-input@vger.kernel.org, Nicolas Pitre <nico@marvell.com>

On Wed, Apr 09, 2008 at 10:37:19PM -0400, Vernon Sauder wrote:
> The UCB1400 driver IRQ probe code fails to find an interrupt if all
> the interrupts in the range 0-31 are nonprobe-able. This patch
> removes the check of the return value so interrupts above 31 can be
> detected.
>
> This change may also be useful in drivers/mfd/ucb1x0-core.c but I
> cannot test that on my hardware.
>
> This patch is against 2.6.24.4. Tested on InHand Fingertip4 PXA270
> board.
>
> Signed-off-by: Vernon Sauder <vsauder@inhand.com>
> Acked-by: Nicolas Pitre <nico@marvell.com>
>

Applied, thank you Vernon.

-- 
Dmitry
