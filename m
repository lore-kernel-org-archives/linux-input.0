From: "DISTEC Inan, Ahmet" <Inan@distec.de>
Subject: Re: [PATCH] Input: Add I2C attached EETI EXC3000 multi touch driver
Date: Mon, 25 Sep 2017 16:59:52 +0200
Message-ID: <20170925145952.zxj3m5qudfpqnil5@dev-ai1.datadisplay.de>
References: <20170920135129.10283-1-inan@distec.de>
 <20170921211551.GB15858@dtor-ws>
 <20170922124852.2bsx45jeqye6qcss@dev-ai1.datadisplay.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.datadisplay.de ([87.191.35.243]:55930 "EHLO
        mail.datadisplay.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964826AbdIYO7y (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 25 Sep 2017 10:59:54 -0400
Content-Disposition: inline
In-Reply-To: <20170922124852.2bsx45jeqye6qcss@dev-ai1.datadisplay.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Ahmet Inan <xdsopl@gmail.com>

Dear Dmitry,

> > > +	input_set_abs_params(input, ABS_X, 0, 4096, 0, 0);
> > > +	input_set_abs_params(input, ABS_Y, 0, 4096, 0, 0);
> > > +	input_set_abs_params(input, ABS_MT_POSITION_X, 0, 4096, 0, 0);
> > > +	input_set_abs_params(input, ABS_MT_POSITION_Y, 0, 4096, 0, 0);
> > 
> > 	touchscreen_parse_properties() ?
> 
> Need do wrap my head around this.

Thank you for suggesting the use of touchscreen_parse_properties():
Using touchscreen_report_pos() made it very easy to add inversion
and swapping support of axes to the driver.

I've also added the new properties from touchscreen.txt to exc3000.txt.

Best Regards,

Ahmet

