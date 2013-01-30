From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: matrix-keypad - support binary column select gpios
Date: Tue, 29 Jan 2013 17:16:29 -0800
Message-ID: <20130130011628.GD5446@core.coreip.homeip.net>
References: <1359462324-7233-1-git-send-email-agust@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f50.google.com ([209.85.160.50]:35210 "EHLO
	mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751586Ab3A3BQc (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 29 Jan 2013 20:16:32 -0500
Received: by mail-pb0-f50.google.com with SMTP id ro8so626546pbb.23
        for <linux-input@vger.kernel.org>; Tue, 29 Jan 2013 17:16:31 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1359462324-7233-1-git-send-email-agust@denx.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Anatolij Gustschin <agust@denx.de>
Cc: linux-input@vger.kernel.org

HI Anatolij,

On Tue, Jan 29, 2013 at 01:25:24PM +0100, Anatolij Gustschin wrote:
> On hardware with limited gpios one column select gpio can select
> two different rows when using some additional hardware logic:
> high value selects one row, low value selects another row. Add
> support for such matrix keyboards and document device tree
> bindings used to describe them.
> 
> Since half of the columns is always not selected, interrupts won't be
> generated for press events on these columns. To generate interrupts
> for not selected columns we need to periodicaly switch to these columns
> in order to catch the potential press events. This is done by additional
> work function.

So this effectively switches the driver from interrupt driven to polled
model, right? The device does not really need an interrupt anymore...

Thanks.

-- 
Dmitry
