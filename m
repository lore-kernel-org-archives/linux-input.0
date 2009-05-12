From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] input: use PIT_TICK_RATE in vt beep ioctl
Date: Tue, 12 May 2009 10:31:38 +0100
Message-ID: <20090512103138.2675ca3f@lxorguk.ukuu.org.uk>
References: <20090511222702.352192505@arndb.de>
	<200905112258.27662.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:45011 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1759336AbZELJas (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 12 May 2009 05:30:48 -0400
In-Reply-To: <200905112258.27662.arnd@arndb.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

> This patch depends on "move PIT_TICK_RATE to linux/timex.h"
> in order to build on architectures that previously did not
> define PIT_TICK_RATE.
> 
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: linux-input@vger.kernel.org
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Alan Cox <alan@linux.intel.com>

I think this is probably the lesser of the evils here.
