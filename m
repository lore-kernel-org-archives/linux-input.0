From: Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH RFT 2/5] iio: mxs-lradc: move TS config into suitable
 function
Date: Sun, 17 Apr 2016 05:19:12 -0700
Message-ID: <20160417121912.GA33215@dtor-ws>
References: <1460648909-2657-1-git-send-email-stefan.wahren@i2se.com>
 <1460648909-2657-3-git-send-email-stefan.wahren@i2se.com>
 <570FF737.4050606@denx.de>
 <571361DD.1090001@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f169.google.com ([209.85.192.169]:34224 "EHLO
	mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751474AbcDQMTP (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 17 Apr 2016 08:19:15 -0400
Content-Disposition: inline
In-Reply-To: <571361DD.1090001@kernel.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jonathan Cameron <jic23@kernel.org>
Cc: Marek Vasut <marex@denx.de>, Stefan Wahren <stefan.wahren@i2se.com>, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Ksenija Stanojevic <ksenija.stanojevic@gmail.com>, Fabio Estevam <fabio.estevam@nxp.com>, Juergen Borleis <jbe@pengutronix.de>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Sun, Apr 17, 2016 at 11:13:49AM +0100, Jonathan Cameron wrote:
> On 14/04/16 21:01, Marek Vasut wrote:
> > On 04/14/2016 05:48 PM, Stefan Wahren wrote:
> >> This patch moves the touchscreen type configuration into
> >> a more suitable function. Btw this simplifies PM ops later.
> >>
> >> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> > 
> > Looks OK
> > 
> > Reviewed-by: Marek Vasut <marex@denx.de>
> Please do CC Dmitry and linux-input on any patches 'touching' the
> touchscreen parts of the driver.  I'm happy this one is simple
> enough to apply anyway, but best to make sure everyone is in the
> loop.

FWIW:

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

> 
> Something a little odd happened when applying the patch.  Automerging
> failed so I did it by hand. Not sure what had changed!
> 
> Anyhow, please sanity check I haven't messed it up.
> 
> Applied to the togreg branch of iio.git - initially pushed out as
> testing for the autobuilders to play with it.
> 
> Thanks,
> 
> 
> Jonathan
> > 
> >> ---
> >>  drivers/iio/adc/mxs-lradc.c |   21 +++++++++++----------
> >>  1 file changed, 11 insertions(+), 10 deletions(-)
> >>
> >> diff --git a/drivers/iio/adc/mxs-lradc.c b/drivers/iio/adc/mxs-lradc.c
> >> index 0576953..7118fca 100644
> >> --- a/drivers/iio/adc/mxs-lradc.c
> >> +++ b/drivers/iio/adc/mxs-lradc.c
> >> @@ -686,6 +686,17 @@ static void mxs_lradc_prepare_pressure(struct mxs_lradc *lradc)
> >>  
> >>  static void mxs_lradc_enable_touch_detection(struct mxs_lradc *lradc)
> >>  {
> >> +	/* Configure the touchscreen type */
> >> +	if (lradc->soc == IMX28_LRADC) {
> >> +		mxs_lradc_reg_clear(lradc, LRADC_CTRL0_MX28_TOUCH_SCREEN_TYPE,
> >> +				    LRADC_CTRL0);
> >> +
> >> +		if (lradc->use_touchscreen == MXS_LRADC_TOUCHSCREEN_5WIRE)
> >> +			mxs_lradc_reg_set(lradc,
> >> +					  LRADC_CTRL0_MX28_TOUCH_SCREEN_TYPE,
> >> +					  LRADC_CTRL0);
> >> +	}
> >> +
> >>  	mxs_lradc_setup_touch_detection(lradc);
> >>  
> >>  	lradc->cur_plate = LRADC_TOUCH;
> >> @@ -1491,16 +1502,6 @@ static int mxs_lradc_hw_init(struct mxs_lradc *lradc)
> >>  	mxs_lradc_reg_wrt(lradc, 0, LRADC_DELAY(2));
> >>  	mxs_lradc_reg_wrt(lradc, 0, LRADC_DELAY(3));
> >>  
> >> -	/* Configure the touchscreen type */
> >> -	if (lradc->soc == IMX28_LRADC) {
> >> -		mxs_lradc_reg_clear(lradc, LRADC_CTRL0_MX28_TOUCH_SCREEN_TYPE,
> >> -				    LRADC_CTRL0);
> >> -
> >> -	if (lradc->use_touchscreen == MXS_LRADC_TOUCHSCREEN_5WIRE)
> >> -		mxs_lradc_reg_set(lradc, LRADC_CTRL0_MX28_TOUCH_SCREEN_TYPE,
> >> -				  LRADC_CTRL0);
> >> -	}
> >> -
> >>  	/* Start internal temperature sensing. */
> >>  	mxs_lradc_reg_wrt(lradc, 0, LRADC_CTRL2);
> >>  
> >>
> > 
> > 
> 

-- 
Dmitry
