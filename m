From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/3 V2] gpio: add STMPE811 gpio controller support
Date: Mon, 14 Jun 2010 13:34:20 +0100
Message-ID: <20100614123420.GD14604@rakim.wolfsonmicro.main>
References: <1276251195-22981-1-git-send-email-l.fu@pengutronix.de>
 <1276511558-27121-3-git-send-email-l.fu@pengutronix.de>
 <20100614115123.GB14604@rakim.wolfsonmicro.main>
 <20100614120943.GB12027@pengutronix.de>
 <20100614121349.GC14604@rakim.wolfsonmicro.main>
 <20100614122853.GC12027@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:42958 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752021Ab0FNMe1 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 14 Jun 2010 08:34:27 -0400
Content-Disposition: inline
In-Reply-To: <20100614122853.GC12027@pengutronix.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Luotao Fu <l.fu@pengutronix.de>, Samuel Ortiz <sameo@linux.intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, linux-input@vger.kernel

On Mon, Jun 14, 2010 at 02:28:53PM +0200, Luotao Fu wrote:

> right, to_irq is simple. However, there're some more stuff necessary for
> gpio irq on this chip, since it has separate registers for GPIO
> interrupt control and status. A further gpio chip might be needed
> needed to get the stuff done. Hence I'd like to push out the most
> importatn core funcationalities out for the first turn before I take a
> deeper look into other stuffs.

Ah, right - that makes sense.  I'd have expected it to have just flopped
out of haiving working IRQ support in the core.
