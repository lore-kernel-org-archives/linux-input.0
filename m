From: "Datta, Shubhrajyoti" <shubhrajyoti@ti.com>
Subject: RE: [PATCH v3 1/1] input: add support for Nomadik SKE keypad
 controller
Date: Mon, 6 Sep 2010 21:11:09 +0530
Message-ID: <0680EC522D0CC943BC586913CF3768C003C2018609@dbde02.ent.ti.com>
References: <1283777284-24811-1-git-send-email-sundar.iyer@stericsson.com>
 <0680EC522D0CC943BC586913CF3768C003C20185F8@dbde02.ent.ti.com>
 <33A307AF30D7BF4F811B1568FE7A9B181C7DC680@EXDCVYMBSTM006.EQ1STM.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:40736 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751042Ab0IFPlV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 6 Sep 2010 11:41:21 -0400
In-Reply-To: <33A307AF30D7BF4F811B1568FE7A9B181C7DC680@EXDCVYMBSTM006.EQ1STM.local>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sundar R IYER <sundar.iyer@stericsson.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, STEricsson_nomadik_linux <STEricsson_nomadik_linux@list.st.com>



> -----Original Message-----
> From: Sundar R IYER [mailto:sundar.iyer@stericsson.com]
> Sent: Monday, September 06, 2010 8:46 PM
> To: Datta, Shubhrajyoti
> Cc: linux-input@vger.kernel.org; STEricsson_nomadik_linux
> Subject: RE: [PATCH v3 1/1] input: add support for Nomadik SKE keypad
> controller
> 
> Hi,
> 
> >-----Original Message-----
> >From: Datta, Shubhrajyoti [mailto:shubhrajyoti@ti.com]
> >> +     /* go through board initialiazation helpers */
> >> +     if (keypad->board->init) {
> >Did not understand this
> 
> >-----Original Message-----
> >From: Dmitry Torokhov [mailto:dmitry.torokhov@gmail.com]
> >> > > +
> >> > > +     if (!keypad->board->init) {
> >> > > +             dev_err(&pdev->dev, "NULL board initialization
> helper\n");
> >> >
> >> > Could be checked earlier. Also, does it have to be an error?
> >> >
> >>
> >> The platform code takes care to request the GPIOs and the GPIO
> configurations.
> >> Hence I return error in case the board configurations dont get
> completed.
> >>
> >
> >PLanform author migth opt to do the initialization earlier, together
> >with teh rest of GPIO configuration so it is all ready by the time the
> >driver is loaded. I think we should give such an option.
> 
> I interpreted Dmitry's above suggestion as allowing the driver to proceed
> in case platform
> Initialization is not done.
> 
> The [PATCH 2/2] ux500: add platform data for Nomadik SKE keypad controller
> adds this platform
> data which is configuration of the GPIO pins like this.
> 
> +/*
> + * ske_set_gpio_row: request and set gpio rows  */ static int
> +ske_set_gpio_row(int gpio) {
> +	int ret;
> +
> +	ret = gpio_request(gpio, "ske-kp");
> +	if (ret < 0) {
> +		pr_err("ske_set_gpio_row: gpio request failed\n");
> +		return ret;
> +	}
> +
> +	ret = gpio_direction_output(gpio, 1);
> +	if (ret < 0) {
> +		pr_err("ske_set_gpio_row: gpio direction failed\n");
> +		gpio_free(gpio);
> +	}
> +
> +	return ret;
> +}
> +
> +/*
> + * ske_kp_init - enable the gpio configuration  */ static int
> +ske_kp_init(void) {
> +	int ret, i;
> +
> +	for (i = 0; i < SKE_KPD_MAX_ROWS; i++) {
> +		ret = ske_set_gpio_row(ske_kp_rows[i]);
> +		if (ret < 0) {
> +			pr_err("ske_kp_init: failed init\n");
> +			return ret;
> +		}
> +	}
> +
> +	return 0;
> +}
> 
> And hence I need to call this board init to make sure that I get the GPIO
> lines
> for my device.
> 
> >> +
> >> +     if (keypad->board->exit())
> >> +             keypad->board->exit();
> >What does this exit function do?
> >Are you sure the exit function does not need the keypad clock?

     if (keypad->board->exit)
             keypad->board->exit();
Is this you intended?
> >
> 
> Although I haven't added a exit function to the platform data, but from
> the platform
> code posted from above, it is clear that there are no controller
> dependencies for the
> board exit function.
> 
> Regards,
> Sundar
