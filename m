From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH] i2c: Split I2C_M_NOSTART support out of
 I2C_FUNC_PROTOCOL_MANGLING
Date: Tue, 8 May 2012 13:31:01 +0200
Message-ID: <20120508133101.5019b934@endymion.delvare>
References: <1336127208-17951-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from zoneX.GCU-Squad.org ([194.213.125.0]:25048 "EHLO
	services.gcu-squad.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753639Ab2EHLbL (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 8 May 2012 07:31:11 -0400
In-Reply-To: <1336127208-17951-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Wolfram Sang <w.sang@pengutronix.de>, linux-i2c@vger.kernel.org, linux-input@vger.kernel.org, linux-fbdev@vger.kernel.org

On Fri,  4 May 2012 11:26:48 +0100, Mark Brown wrote:
> Since there are uses for I2C_M_NOSTART which are much more sensible and
> standard than most of the protocol mangling functionality (the main one
> being gather writes to devices where something like a register address
> needs to be inserted before a block of data) create a new I2C_FUNC_NOSTART
> for this feature and update all the users to use it.
> 
> Also strengthen the disrecommendation of the protocol mangling while we're
> at it.
> 
> In the case of regmap-i2c we remove the requirement for mangling as
> I2C_M_NOSTART is the only mangling feature which is being used.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  Documentation/i2c/functionality       |    8 +++++---
>  Documentation/i2c/i2c-protocol        |    9 ++++++++-
>  drivers/base/regmap/regmap-i2c.c      |    2 +-
>  drivers/i2c/algos/i2c-algo-bit.c      |    2 +-
>  drivers/i2c/busses/i2c-nuc900.c       |    3 ++-
>  drivers/i2c/busses/i2c-s3c2410.c      |    3 ++-
>  drivers/input/joystick/as5011.c       |    1 +
>  drivers/video/matrox/matroxfb_maven.c |    1 +
>  include/linux/i2c.h                   |    5 +++--
>  9 files changed, 24 insertions(+), 10 deletions(-)
> (...)

Applied with minor cleanups, thanks.

-- 
Jean Delvare
