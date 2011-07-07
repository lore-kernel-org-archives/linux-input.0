From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 04/12] Input: synaptics - set resolution for
 MT_POSITION_X/Y axes
Date: Wed, 6 Jul 2011 23:23:08 -0700
Message-ID: <20110707062308.GC7658@core.coreip.homeip.net>
References: <1309324042-22943-1-git-send-email-djkurtz@chromium.org>
 <1309324042-22943-5-git-send-email-djkurtz@chromium.org>
 <4E134D94.60604@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:52357 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753105Ab1GGGXP (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 7 Jul 2011 02:23:15 -0400
Content-Disposition: inline
In-Reply-To: <4E134D94.60604@canonical.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chase Douglas <chase.douglas@canonical.com>
Cc: djkurtz@chromium.org, rydberg@euromail.se, rubini@cvml.unipv.it, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, derek.foreman@collabora.co.uk, daniel.stone@collabora.co.uk, olofj@chromium.org

On Tue, Jul 05, 2011 at 10:44:52AM -0700, Chase Douglas wrote:
> On 06/28/2011 10:07 PM, djkurtz@chromium.org wrote:
> > From: Daniel Kurtz <djkurtz@chromium.org>
> > 
> > Set resolution for MT_POSITION_X and MT_POSITION_Y to match ABS_X and
> > ABS_Y, respectively.
> > 
> > Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
> 
> Acked-by: Chase Douglas <chase.douglas@canonical.com>

Applied.

> 
> > ---
> >  drivers/input/mouse/synaptics.c |    3 +++
> >  1 files changed, 3 insertions(+), 0 deletions(-)
> > 
> > diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
> > index a4b7801..1ce47b7 100644
> > --- a/drivers/input/mouse/synaptics.c
> > +++ b/drivers/input/mouse/synaptics.c
> > @@ -703,6 +703,9 @@ static void set_input_params(struct input_dev *dev, struct synaptics_data *priv)
> >  				     priv->x_max ?: XMAX_NOMINAL, 0, 0);
> >  		input_set_abs_params(dev, ABS_MT_POSITION_Y, YMIN_NOMINAL,
> >  				     priv->y_max ?: YMAX_NOMINAL, 0, 0);
> > +
> > +		input_abs_set_res(dev, ABS_MT_POSITION_X, priv->x_res);
> > +		input_abs_set_res(dev, ABS_MT_POSITION_Y, priv->y_res);
> >  	}
> >  
> >  	if (SYN_CAP_PALMDETECT(priv->capabilities))
> 

-- 
Dmitry
