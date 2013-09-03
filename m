From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: input: i8042 possible bug
Date: Tue, 3 Sep 2013 11:11:35 -0700
Message-ID: <20130903181134.GD25985@core.coreip.homeip.net>
References: <52261EBE.5010007@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:63417 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756445Ab3ICSLi (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 3 Sep 2013 14:11:38 -0400
Content-Disposition: inline
In-Reply-To: <52261EBE.5010007@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andrey Moiseev <o2g.org.ru@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Sep 03, 2013 at 09:39:10PM +0400, Andrey Moiseev wrote:
> Here is an extract from drivers/input/serio/i8042.c:
> > 
> > static int i8042_flush(void)
> > {
> > 	unsigned long flags;
> > 	unsigned char data, str;
> > 	int i = 0;
> > 
> > 	spin_lock_irqsave(&i8042_lock, flags);
> > 
> > 	while (((str = i8042_read_status()) & I8042_STR_OBF) && (i < I8042_BUFFER_SIZE)) {
> > 		udelay(50);
> > 		data = i8042_read_data();
> > 		i++;
> > 		dbg("%02x <- i8042 (flush, %s)\n",
> > 		    data, str & I8042_STR_AUXDATA ? "aux" : "kbd");
> > 	}
> > 
> > 	spin_unlock_irqrestore(&i8042_lock, flags);
> > 
> > 	return i;
> > }
> > 
> > static int i8042_controller_check(void)
> > {
> > 	if (i8042_flush() == I8042_BUFFER_SIZE) {
> Doesn't it panic needlessly, while the buffer was initially full?

It appears so. We probably want to change it to return -1 if we still
see OBF after fetching I8042_BUFFER_SIZE characters.

Thanks.

-- 
Dmitry
