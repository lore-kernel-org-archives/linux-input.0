From: Anatolij Gustschin <agust@denx.de>
Subject: Re: [PATCH] Input: matrix-keypad - support binary column select
 gpios
Date: Wed, 30 Jan 2013 09:44:32 +0100
Message-ID: <20130130094432.17cf30fd@crub>
References: <1359462324-7233-1-git-send-email-agust@denx.de>
	<20130130011628.GD5446@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:38781 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752681Ab3A3Ipy (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 30 Jan 2013 03:45:54 -0500
In-Reply-To: <20130130011628.GD5446@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

Hi Dmitry,

On Tue, 29 Jan 2013 17:16:29 -0800
Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
...
> On Tue, Jan 29, 2013 at 01:25:24PM +0100, Anatolij Gustschin wrote:
> > On hardware with limited gpios one column select gpio can select
> > two different rows when using some additional hardware logic:
> > high value selects one row, low value selects another row. Add
> > support for such matrix keyboards and document device tree
> > bindings used to describe them.
> > 
> > Since half of the columns is always not selected, interrupts won't be
> > generated for press events on these columns. To generate interrupts
> > for not selected columns we need to periodicaly switch to these columns
> > in order to catch the potential press events. This is done by additional
> > work function.
> 
> So this effectively switches the driver from interrupt driven to polled
> model, right? The device does not really need an interrupt anymore...

Yes, partially. I do not need to scan the state of the rows right
after column switching. The interrupts for press events will only be
generated if a key in the affected row was actually pressed. So the
device is still interrupt driven and the row state read-out happens
in the work scheduled from the interrupt handler.

Thanks,

Anatolij
