From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH] i2c: Split I2C_M_NOSTART support out of
 I2C_FUNC_PROTOCOL_MANGLING
Date: Fri, 4 May 2012 10:39:29 +0200
Message-ID: <20120504103929.644a05ce@endymion.delvare>
References: <1336042416-28330-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<20120503113546.GG9574@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from zoneX.GCU-Squad.org ([194.213.125.0]:37107 "EHLO
	services.gcu-squad.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752771Ab2EDIjn (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 4 May 2012 04:39:43 -0400
In-Reply-To: <20120503113546.GG9574@pengutronix.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-i2c@vger.kernel.org, linux-input@vger.kernel.org, linux-fbdev@vger.kernel.org

Hi Wolfram,

On Thu, 3 May 2012 13:35:46 +0200, Wolfram Sang wrote:
> On Thu, May 03, 2012 at 11:53:36AM +0100, Mark Brown wrote:
> > Since there are uses for I2C_M_NOSTART which are much more sensible and
> > standard than most of the protocol mangling functionality (the main one
> > being gather writes to devices where something like a register address
> > needs to be inserted before a block of data) create a new I2C_FUNC_NOSTART
> > for this feature and update all the users to use it.
> > 
> > In the case of regmap-i2c we remove the requirement for mangling as
> > I2C_M_NOSTART is the only mangling feature which is being used.
> > 
> > Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> 
> Applied to next, thanks! Jean, let me know if you prefer to take it.
> Acks from input and fbdev maintainers still appreciated.

I'd prefer to take it, yes, as it touches the core infrastructure.

Thanks,
-- 
Jean Delvare
