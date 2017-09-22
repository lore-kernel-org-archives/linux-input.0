From: "DISTEC Inan, Ahmet" <Inan@distec.de>
Subject: Re: [PATCH] Input: Add I2C attached EETI EXC3000 multi touch driver
Date: Fri, 22 Sep 2017 14:48:53 +0200
Message-ID: <20170922124852.2bsx45jeqye6qcss@dev-ai1.datadisplay.de>
References: <20170920135129.10283-1-inan@distec.de>
 <20170921211551.GB15858@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.datadisplay.de ([87.191.35.243]:20951 "EHLO
        mail.datadisplay.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752253AbdIVMsy (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 22 Sep 2017 08:48:54 -0400
Content-Disposition: inline
In-Reply-To: <20170921211551.GB15858@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Ahmet Inan <xdsopl@gmail.com>

Dear Dmitry,

> > It is important not to rely on the i2c_master_recv return value:
> > Ignoring failed transfers sometimes causes hanging touch events, as the
> > controller thinks that the transfer succeeded and won't resend the event.
> 
> This statement worries me, because you are basically end up reporting
> garbage. Does the controller sends all active contacts in each frame, or
> only changed ones? You can use INPUT_MT_DROP_UNUSED to let input core
> automatically drop contacts that were not reported within the last
> frame. And fire up a timer to release everything if last transfer errors
> out.
Thank you for the suggestions. I indeed felt uncomfortable about
ignoring the return value of i2c_master_recv() but INPUT_MT_DROP_UNUSED
helped and now it works awesome!

> > +	input_set_abs_params(input, ABS_X, 0, 4096, 0, 0);
> > +	input_set_abs_params(input, ABS_Y, 0, 4096, 0, 0);
> > +	input_set_abs_params(input, ABS_MT_POSITION_X, 0, 4096, 0, 0);
> > +	input_set_abs_params(input, ABS_MT_POSITION_Y, 0, 4096, 0, 0);
> 
> 	touchscreen_parse_properties() ?

Need do wrap my head around this. I've send you a new patch with all
(but this one) suggested improvements. I will send send you a follow-up
patch with touchscreen_parse_properties() if you're OK with the current
patch and want to merge it.

Best Regards,

Ahmet

