From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: wm831x-ts - Fix races with IRQ management
Date: Sat, 12 Mar 2011 22:14:10 -0800
Message-ID: <20110313061410.GA31566@core.coreip.homeip.net>
References: <1298998459-12526-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:64525 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751105Ab1CMGOQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 13 Mar 2011 01:14:16 -0500
Received: by iyb26 with SMTP id 26so3952582iyb.19
        for <linux-input@vger.kernel.org>; Sat, 12 Mar 2011 22:14:15 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1298998459-12526-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: linux-input@vger.kernel.org, patches@opensource.wolfsonmicro.com

On Tue, Mar 01, 2011 at 04:54:19PM +0000, Mark Brown wrote:
> If the WM831x pen down and data IRQs run in parallel it is possible for the
> data and pen down IRQs to deadlock themselves as one is part way through
> disabling its operation while the other is part way through enabling. Fix
> this by always disabling the pen down interrupt while data is active and
> vice versa.
> 
> This also fixes an issue when using the built in IRQs due to enable_irq()
> not being valid from interrupt context on an interrupt controller with bus
> operations like the built in IRQ controller - this issue may also have
> affected other interrupt controllers.
> 

Hmm, this is quite ugly. The race that you mentioned should be dealt
with by rearranging the order in which you disable IRQ and enable the
conversions. I.e. in wm831x_ts_pen_down_irq() you should do:

	disable_irq_nosync(wm831x_ts->pd_irq);
	wm831x_ts->pendown = true;

	...
	enable_irq(wm831x_ts->data_irq);

The issue is that wm831x_ts_input_close() is racy; it simply writes into
WM831X_TOUCH_CONTROL_1 and hopes that it will stick...

What is needed I guess is wm831x_ts->open flag that
wm831x_ts_input_open() would set and wm831x_ts_input_close() would reset
and the interrupt handlers would check before touching the registers
or enabling their counterparts. wm831x_ts_input_close() would reset the
flag first and then disable first pd_irq and then data_irq, before
writing to the control register. The only issue is to keep track of irq
disble counters.

The issue with enable_irq() not working in the irq handler thread should
be dealt at the controller level (i.e. fix it so that it works).

Thanks.

-- 
Dmitry
