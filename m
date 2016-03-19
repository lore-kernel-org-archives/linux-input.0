From: Michael Grzeschik <mgr@pengutronix.de>
Subject: Re: [PATCH] da9052: ensure da9052_ts_input_open will not lock up on
 irq flood
Date: Sat, 19 Mar 2016 10:12:38 +0100
Message-ID: <20160319091238.GJ5824@pengutronix.de>
References: <1457002322-21953-1-git-send-email-m.grzeschik@pengutronix.de>
 <20160311193311.GD13175@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:46777 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752200AbcCSJMm (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 19 Mar 2016 05:12:42 -0400
Content-Disposition: inline
In-Reply-To: <20160311193311.GD13175@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: support.opensource@diasemi.com, kernel@pengutronix.de, linux-input@vger.kernel.org

On Fri, Mar 11, 2016 at 11:33:11AM -0800, Dmitry Torokhov wrote:
> On Thu, Mar 03, 2016 at 11:52:02AM +0100, Michael Grzeschik wrote:
> > It is possible that da9052_ts_input_open is called and the touchscreen
> > is triggering continuous interrupts. In this case we will never leave
> > da9052_ts_input_open. The da9052_reg_update will never get the i2c bus
> > as the interrupt handler will continuously lock it.
> > 
> > This patch switch places of da9052_reg_update and the setting of
> > tsi->stopped. This way its ensured that da9052_ts_input_open will never
> > lockup on interrupt flood.
> 
> I understand what you are saying about updating register, however I do
> not understand why we would want to swap unmasking pendown event ans
> clearing the "stopped" flag.

The "stopped" flag has an locking purpose in the irq handler. My patch
ensures that the irq handler will not trigger any da9052_reg_update
before da9052_ts_input_open has finished.

On second thought, it would probably be enough to swap the call of
da9052_reg_update and da9052_enable_irq in da9052_ts_input_open.

This will have the same effect. I will send an corrected v2.

Thanks,
Michael

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
