From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: wm97xx_read_aux_adc() for battery & pen down?
Date: Fri, 24 Jun 2011 17:52:04 +0100
Message-ID: <20110624165204.GB30047@opensource.wolfsonmicro.com>
References: <20110624130049.GA9374@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:40395 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751308Ab1FXQwI (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 24 Jun 2011 12:52:08 -0400
Content-Disposition: inline
In-Reply-To: <20110624130049.GA9374@pengutronix.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: linux-input@vger.kernel.org, dp@opensource.wolfsonmicro.com

On Fri, Jun 24, 2011 at 03:00:49PM +0200, Wolfram Sang wrote:

> battery-status, but I need the following dirty hack for 3.0-rc4 in
> wm97xx_read_aux_adc():

> ...
> -       if (!(*sample & WM97XX_PEN_DOWN)) {
> +       /* HACK! Disable check for battery channel on Jaytech PID7901 */
> +       if ((adcsel != 0x6000) && !(*sample & WM97XX_PEN_DOWN)) {
>                 wm->pen_probably_down = 0;
>                 return RC_PENUP;
>         }

I don't see this code in that function?
