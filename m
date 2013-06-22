From: Gerhard Sittig <gsi@denx.de>
Subject: Re: [PATCH v1 12/12] input: matrix-keypad: add diagnostics in probe()
Date: Sat, 22 Jun 2013 10:30:44 +0200
Message-ID: <20130622083044.GD24305@book.gsilab.sittig.org>
References: <1371838198-7327-1-git-send-email-gsi@denx.de>
 <1371838198-7327-13-git-send-email-gsi@denx.de>
 <201306220428.44614.marex@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:38660 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932219Ab3FVIay (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 22 Jun 2013 04:30:54 -0400
Content-Disposition: inline
In-Reply-To: <201306220428.44614.marex@denx.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Marek Vasut <marex@denx.de>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, Chao Xie <xiechao.mail@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Sekhar Nori <nsekhar@ti.com>, Tony Lindgren <tony@atomide.com>, Eric Miao <eric.y.miao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Ralf Baechle <ralf@linux-mips.org>, Anatolij Gustschin <agust@denx.de>, Detlev Zundel <dzu@denx.de>

On Sat, Jun 22, 2013 at 04:28 +0200, Marek Vasut wrote:
> 
> Dear Gerhard Sittig,
> 
> > optionally dump relevant configuration of pins, matrix lines,
> > and delay/interval times at the very end of the probe routine
> > (development feature, silent by default)
> > 
> > Signed-off-by: Gerhard Sittig <gsi@denx.de>
> > ---
> >  drivers/input/keyboard/matrix_keypad.c |   18 ++++++++++++++++++
> >  1 file changed, 18 insertions(+)
> > 
> > diff --git a/drivers/input/keyboard/matrix_keypad.c
> > b/drivers/input/keyboard/matrix_keypad.c index 275b157..69b15720 100644
> > --- a/drivers/input/keyboard/matrix_keypad.c
> > +++ b/drivers/input/keyboard/matrix_keypad.c
> > @@ -800,6 +800,24 @@ static int matrix_keypad_probe(struct platform_device
> > *pdev) device_init_wakeup(&pdev->dev, pdata->wakeup);
> >  	platform_set_drvdata(pdev, keypad);
> > 
> > +	dev_dbg(&pdev->dev, "gpios col num[%u] lvl[%s] drv[%s] enc[%s]\n",
> > +		pdata->num_col_gpios,
> > +		pdata->col_gpios_active_low ? "low" : "high",
> > +		pdata->col_gpios_push_pull ? "pp" : "od",
> > +		pdata->col_gpios_binary_encoded ? "bin" : "1-1");
> > +	dev_dbg(&pdev->dev, "gpios row num[%u] lvl[%s]\n",
> > +		pdata->num_row_gpios,
> > +		pdata->row_gpios_active_low ? "low" : "high");
> > +	dev_dbg(&pdev->dev, "matrix cols[%u] rows[%u] code shift[%u]\n",
> > +		pdata->num_matrix_cols,
> > +		pdata->num_matrix_rows,
> > +		keypad->row_shift);
> > +	dev_dbg(&pdev->dev, "times scan[%u-%u] bounce[%u] switch[%u]\n",
> > +		pdata->col_scan_delay_us,
> > +		pdata->col_scan_delay_us_max,
> > +		pdata->debounce_ms,
> > +		pdata->col_switch_delay_ms);
> > +
> 
> It's a bit hard to understand this kind of debug output. Besides, we already 
> have all the DT props in /proc/device-tree where you can check them , do we 
> really need this patch then ?

This output shall reflect not only what was provided to the
driver as input, but as well what the driver made of it (that is,
some of the values get derived from others, some underwent
normalization).

The terse format mostly is a consequence of the 80 columns line
length limit, and the output being for debugging purposes
exclusively.  But I understand that one needs to know the
driver's internal working before one can read this output.  And I
felt that this is the only situation where one would enable
debugging for the driver.

That patch might as well get dropped, I have no strong feelings
about it.  Actually I put it at the end of the series such that
nothing else builds on top of it and that it doesn't change the
context of anything else, so that dropping it doesn't matter
anyway.


virtually yours
Gerhard Sittig
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr. 5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office@denx.de
