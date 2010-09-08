From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [Patch v1] input:rohm based bu21013 touch panel controller
 driver support
Date: Wed, 8 Sep 2010 08:44:21 -0700
Message-ID: <20100908154421.GE4190@core.coreip.homeip.net>
References: <81C3A93C17462B4BBD7E272753C1057916DE7CC963@EXDCVYMBSTM005.EQ1STM.local>
 <4C876936.8090708@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:52141 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754811Ab0IHPo3 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 8 Sep 2010 11:44:29 -0400
Received: by pxi10 with SMTP id 10so81654pxi.19
        for <linux-input@vger.kernel.org>; Wed, 08 Sep 2010 08:44:28 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4C876936.8090708@codeaurora.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Trilok Soni <tsoni@codeaurora.org>
Cc: Naveen Kumar GADDIPATI <naveen.gaddipati@stericsson.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, STEricsson_nomadik_linux <STEricsson_nomadik_linux@list.st.com>

On Wed, Sep 08, 2010 at 04:15:10PM +0530, Trilok Soni wrote:
> Hi Naveen,
> 
> On 9/8/2010 3:54 PM, Naveen Kumar GADDIPATI wrote:
> > Hi Dmitry,
> > 
> > From: Naveen Kumar Gaddipati <naveen.gaddipati@stericsson.com>
> > 
> > Added the ROHM based bu21013 capacitive touch panel controller
> > driver support with i2c interface.
> > 
> > Signed-off-by: Naveen Kumar Gaddipati <naveen.gaddipati@stericsson.com>
> > ---
> > Modifications in v1:
> >         --Updated with the Dmitry comments on Patch 0, but fuzz is not used to get the
> >                 delta between two co-ordinates in multi touch.
> >         --Updated with the Trilok comments on Patch 0
> 
> Thanks for the updates.
> 
> > 
> > +config TOUCHSCREEN_BU21013
> > +       tristate "BU21013 based touch panel controllers"
> > +       depends on I2C
> > +       help
> > +         Say Y here if you have a bu21013 touchscreen connected to
> > +         your system.
> > +
> > +         If unsure, say N.
> > +
> > +         To compile this driver as a module, choose M here: the
> > +         module will be called bu21013_ts.
> > +
> 
> Dmitry, we do follow the alphabetical order for Kconfig and Makefile for touchscreen folder, right?
> 

Yes. Mostly for my benefit though :) - if everyone adds their driver at
the end I need to fix up conflicts on every one of them and also when I
move the patches in my queue up and down. Having them listed
alphabetically reduces chances of conflicts.

> > +
> > +/**
> > + * bu21013_report_pen_down() - reports the pen down event
> > + * @data:bu21013_ts_data structure pointer
> > + * @count:touch count
> > + *
> > + * This function used to report the pen down interrupt to
> > + * input subsystem and returns none
> > + */
> > +static void bu21013_report_pen_down(struct bu21013_ts_data *data, int count)
> > +{
> > +       input_report_abs(data->in_dev, ABS_X, data->x_pos[0]);
> > +       input_report_abs(data->in_dev, ABS_Y, data->y_pos[0]);
> > +       input_report_key(data->in_dev, BTN_TOUCH, 1);
> > +
> > +       if (data->chip->multi_touch) {
> > +               if (count > 1)
> > +                       input_report_key(data->in_dev, BTN_2, 1);
> 
> Dmitry,
> 
> Do you prefer the method of supporting ST and MT like the code above? My preference
> would be to keep only MT, because the chip supports MT.

We still need to support the ST so that older clients can work with the
device; but yes, MT events should be sent unconditionally and BTN_2
should not be abused for multitouch indicator.

-- 
Dmitry
