From: Mika Westerberg <mika.westerberg@iki.fi>
Subject: Re: [linux-pm] [PATCH v2 1/2] Input: gpio-keys - allow platform to
	specify exact irq flags
Date: Mon, 30 Nov 2009 11:37:57 +0200
Message-ID: <20091130093757.GB27979@gw.healthdatacare.com>
References: <Pine.LNX.4.44L0.0911291103070.3165-100000@netrider.rowland.org> <87hbsd2b17.fsf@tac.ki.iif.hu> <20091130082737.GA27979@gw.healthdatacare.com> <20091130091420.GE10295@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bw0-f227.google.com ([209.85.218.227]:43611 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752469AbZK3Jhy (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 30 Nov 2009 04:37:54 -0500
Received: by bwz27 with SMTP id 27so2327403bwz.21
        for <linux-input@vger.kernel.org>; Mon, 30 Nov 2009 01:38:00 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20091130091420.GE10295@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Ferenc Wagner <wferi@niif.hu>, Alan Stern <stern@rowland.harvard.edu>, linux-pm@lists.linux-foundation.org, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Mon, Nov 30, 2009 at 01:14:20AM -0800, Dmitry Torokhov wrote:
> On Mon, Nov 30, 2009 at 10:27:37AM +0200, Mika Westerberg wrote:
> > 
> > BTW: maybe this sharing the IRQ line between multiple buttons could be
> > implemented with threaded irq handler? Then it can go to sleep if, for
> > some reason, gpio_get_value() sleeps. Unfortunately I don't have such
> > hardware so I can't test it.
> > 
> 
> We still need debounce support there so you still need a timer and a
> workqueue. In the current form theraded IRQ will not buy us anything.

Yes, but with threaded irq handler it should be possible to find
out which gpio line caused the irq (via gpio_get_value()) so we can
schedule the correct workqueue handler, right?

MW
