From: Markus Pargmann <mpa@pengutronix.de>
Subject: Re: [PATCH 1/4] Input: wm97xx: Drop out of range inputs
Date: Fri, 8 Mar 2013 19:11:41 +0100
Message-ID: <20130308181141.GE11656@pengutronix.de>
References: <1362759309-18782-1-git-send-email-mpa@pengutronix.de>
 <1362759309-18782-2-git-send-email-mpa@pengutronix.de>
 <20130308171538.GA26088@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130308171538.GA26088@opensource.wolfsonmicro.com>
Sender: stable-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Liam Girdwood <lrg@slimlogic.co.uk>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, patches@opensource.wolfsonmicro.com, linux-input@vger.kernel.org, kernel@pengutronix.de, stable@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Sat, Mar 09, 2013 at 01:15:49AM +0800, Mark Brown wrote:
> On Fri, Mar 08, 2013 at 05:15:06PM +0100, Markus Pargmann wrote:
> 
> > +		if (
> > +				abs_x[0] > (data.x & 0xfff)
> > +				|| abs_x[1] < (data.x & 0xfff)
> > +				|| abs_y[0] > (data.y & 0xfff)
> > +				|| abs_y[1] < (data.y & 0xfff)) {
> > +			dev_dbg(wm->dev, "Measurement out of range, dropping it\n");
> > +			rc = RC_AGAIN;
> > +			goto out;
> 
> The change is good but not a fan of the coding style here.  Otherwise
> 
> Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Thanks. I would change the style to this:

		if (abs_x[0] > (data.x & 0xfff) ||
				abs_x[1] < (data.x & 0xfff) ||
				abs_y[0] > (data.y & 0xfff) ||
				abs_y[1] < (data.y & 0xfff)) {

Regards

Markus

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
