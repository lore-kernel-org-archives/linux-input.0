From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] rotary_encoder: Use proper irqflags
Date: Wed, 2 Feb 2011 22:05:54 -0800
Message-ID: <20110203060554.GB25739@core.coreip.homeip.net>
References: <1296682169-12653-1-git-send-email-alexander.stein@informatik.tu-chemnitz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:56420 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751424Ab1BCGGB (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 3 Feb 2011 01:06:01 -0500
Received: by gyb11 with SMTP id 11so335510gyb.19
        for <linux-input@vger.kernel.org>; Wed, 02 Feb 2011 22:06:00 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1296682169-12653-1-git-send-email-alexander.stein@informatik.tu-chemnitz.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alexander Stein <alexander.stein@informatik.tu-chemnitz.de>
Cc: linux-input@vger.kernel.org

On Wed, Feb 02, 2011 at 10:29:29PM +0100, Alexander Stein wrote:
> IORESOURCE_IRQ_* is wrong for irq_request, use the correct IRQF_* instead.
> 
> Signed-off-by: Alexander Stein <alexander.stein@informatik.tu-chemnitz.de>

Applied, thank you Alexander.

-- 
Dmitry
