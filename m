From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [linux-pm] [PATCH v2 1/2] Input: gpio-keys - allow platform to
	specify exact irq flags
Date: Mon, 30 Nov 2009 01:14:20 -0800
Message-ID: <20091130091420.GE10295@core.coreip.homeip.net>
References: <Pine.LNX.4.44L0.0911291103070.3165-100000@netrider.rowland.org> <87hbsd2b17.fsf@tac.ki.iif.hu> <20091130082737.GA27979@gw.healthdatacare.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f171.google.com ([209.85.222.171]:53020 "EHLO
	mail-pz0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753416AbZK3JOS (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 30 Nov 2009 04:14:18 -0500
Received: by pzk1 with SMTP id 1so2375895pzk.33
        for <linux-input@vger.kernel.org>; Mon, 30 Nov 2009 01:14:24 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20091130082737.GA27979@gw.healthdatacare.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mika Westerberg <mika.westerberg@iki.fi>
Cc: Ferenc Wagner <wferi@niif.hu>, Alan Stern <stern@rowland.harvard.edu>, linux-pm@lists.linux-foundation.org, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Mon, Nov 30, 2009 at 10:27:37AM +0200, Mika Westerberg wrote:
> 
> BTW: maybe this sharing the IRQ line between multiple buttons could be
> implemented with threaded irq handler? Then it can go to sleep if, for
> some reason, gpio_get_value() sleeps. Unfortunately I don't have such
> hardware so I can't test it.
> 

We still need debounce support there so you still need a timer and a
workqueue. In the current form theraded IRQ will not buy us anything.

-- 
Dmitry
