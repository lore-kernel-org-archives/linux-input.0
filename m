From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] Input: TPS6507X - define MFD dependencies for touch
	and regulator unit
Date: Mon, 11 Jul 2011 13:20:04 +0100
Message-ID: <20110711122004.GA9478@sirena.org.uk>
References: <4E1AD56B.6080306@visionsystems.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:52464 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756080Ab1GKMUH (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 11 Jul 2011 08:20:07 -0400
Content-Disposition: inline
In-Reply-To: <4E1AD56B.6080306@visionsystems.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: yegor_sub1@visionsystems.de
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com

On Mon, Jul 11, 2011 at 12:50:19PM +0200, Yegor Yefremov wrote:
> both touchscreen and regulator units are only working if
> mfd device is activated. So if mfd support is enabled,
> select TPS6507X mfd support automatically.
> 
> Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>

This should be split into separate patches and sent to *all* the
relevant maintainers.

>  config TOUCHSCREEN_TPS6507X
>  	tristate "TPS6507x based touchscreens"
> -	depends on I2C
> +	depends on I2C && MFD_SUPPORT
> +	select TPS6507X

This isn't a good fix, the driver should depend on the MFD core not
select it.
