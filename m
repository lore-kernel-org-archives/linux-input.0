From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: keypad: lm8323: convert to threaded IRQ
Date: Tue, 21 Jun 2011 04:25:56 -0700
Message-ID: <20110621112556.GA12114@core.coreip.homeip.net>
References: <1307999812-3802-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:50919 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752478Ab1FUL0F (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 21 Jun 2011 07:26:05 -0400
Content-Disposition: inline
In-Reply-To: <1307999812-3802-1-git-send-email-balbi@ti.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: linux-input@vger.kernel.org, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

On Tue, Jun 14, 2011 at 12:16:52AM +0300, Felipe Balbi wrote:
> there's no need for that workqueue anymore.
> Get rid of it and move to threaded IRQs
> instead.
> 
> Signed-off-by: Felipe Balbi <balbi@ti.com>

Applied, thanks Felipe.

-- 
Dmitry
