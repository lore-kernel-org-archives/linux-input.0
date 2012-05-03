From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] i2c: Split I2C_M_NOSTART support out of
 I2C_FUNC_PROTOCOL_MANGLING
Date: Thu, 3 May 2012 12:58:52 +0200
Message-ID: <20120503125852.46faa6e2@endymion.delvare>
References: <1335443839-22872-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<20120503095211.GC9574@pengutronix.de>
	<20120503095814.GA3955@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120503095814.GA3955-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Florian Tobias Schandinat <FlorianSchandinat-Mmb7MZpHnFY@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Thu, 3 May 2012 10:58:15 +0100, Mark Brown wrote:
> On Thu, May 03, 2012 at 11:52:11AM +0200, Wolfram Sang wrote:
> 
> > Also, I'd think the FUNC_NOSTART bit should be 0x08 and SMBUS_PEC 0x4000. This
> > will be more intuitive, probably?
> 
> What is the value in renumbering everything?  It just seems like it
> makes the diff less clear and has no practical value.

You actually just can't renumber them, as they are part of the ABI to
user-space (through i2c-dev's ioctl I2C_FUNCS.)

-- 
Jean Delvare
