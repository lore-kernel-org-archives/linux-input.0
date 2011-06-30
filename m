From: Marek Vasut <marek.vasut@gmail.com>
Subject: Re: kernel panic in spi_complete() on spitz (PXA270)
Date: Thu, 30 Jun 2011 17:09:48 +0200
Message-ID: <201106301709.48818.marek.vasut@gmail.com>
References: <1308845380.4533.54.camel@oct.suse.cz> <201106301352.21684.marek.vasut@gmail.com> <1309445118.4406.47.camel@oct.suse.cz>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f52.google.com ([209.85.161.52]:33162 "EHLO
	mail-fx0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750714Ab1F3PJy (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 30 Jun 2011 11:09:54 -0400
In-Reply-To: <1309445118.4406.47.camel@oct.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Stanislav Brabec <utx@penguin.cz>
Cc: linux-arm-kernel@lists.infradead.org, zaurus-devel@lists.linuxtogo.org, spi-devel-general@lists.sourceforge.net, Igor Grinberg <grinberg@compulab.co.il>, vapier@gentoo.org, khilman@deeprootsystems.com, dmitry.torokhov@gmail.com, linux-kernel@vger.kernel.org, pavel@ucw.cz, linux-input@vger.kernel.org, eric.y.miao@gmail.com, akpm@linux-foundation.org, broonie@opensource.wolfsonmicro.com, Pavel Herrmann <morpheus.ibis@gmail.com>

On Thursday, June 30, 2011 04:45:18 PM Stanislav Brabec wrote:
> Marek Vasut wrote:
> > On Thursday, June 23, 2011 06:09:40 PM Stanislav Brabec wrote:
> > > Hallo.
> > > 
> > > These Oops and kernel panic were observed on a Zaurus (spitz) machine
> > > (ARMv5, PXA270).
> > 
> > Looks similar to "Re: [PATCH v2] Input: Make ADS7846 independent on
> > regulator"
> 
> I don't see any trace in that thread. But yes, I was testing your patch
> from this thread. Without it, ADS7846 does not work on spitz (ADS7846
> does not have any dedicated regulator there). I want to
> add .needs_regulator bool to ads7846.c and send the patch again to the
> list.
> 
> After sending the trace I was able to reproduced it several times by
> attaching of external charger.
> 
> Then I tried to apply "[PATCH] MAX1111: Fix race condition causing NULL
> pointer exception", connected charger that periodically disconnects and
> not seen the crash again. No OOPS was seen after ~100 reconnects.
> 
> So I guess that MAX1111 AC voltage reading (via SPI) was involved in an
> incorrect moment and race happened there and your MAX1111 race condition
> fix fixes it.

It's not mine, it's from Pavel Herrmann actually ;-)

But yes, it's likely either this or the regulator stuff again (which I believed 
was fixed).
