From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/2] input:Regulator support in ROHM BU21013 touch panel
Date: Wed, 12 Jan 2011 01:15:54 -0800
Message-ID: <20110112091553.GA4183@core.coreip.homeip.net>
References: <1294814126-13632-1-git-send-email-naveen.gaddipati@stericsson.com>
 <20110112084050.GB4644@core.coreip.homeip.net>
 <81C3A93C17462B4BBD7E272753C1057919521AF539@EXDCVYMBSTM005.EQ1STM.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:37688 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751023Ab1ALJQA (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 12 Jan 2011 04:16:00 -0500
Received: by iyj18 with SMTP id 18so307824iyj.19
        for <linux-input@vger.kernel.org>; Wed, 12 Jan 2011 01:15:59 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <81C3A93C17462B4BBD7E272753C1057919521AF539@EXDCVYMBSTM005.EQ1STM.local>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Naveen Kumar GADDIPATI <naveen.gaddipati@stericsson.com>
Cc: STEricsson_nomadik_linux <STEricsson_nomadik_linux@list.st.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "tsoni@codeaurora.org" <tsoni@codeaurora.org>, "rydberg@euromail.se" <rydberg@euromail.se>, Mark Brown <broonie@opensource.wolfsonmicro.com>

On Wed, Jan 12, 2011 at 10:05:07AM +0100, Naveen Kumar GADDIPATI wrote:
> Hi Dmitry,
> 
> 
> >On Wed, Jan 12, 2011 at 12:05:26PM +0530, Naveen Kumar G wrote:
> >> @@ -456,6 +459,16 @@ static int __devinit bu21013_probe(struct
> >i2c_client *client,
> >>  	bu21013_data->in_dev = in_dev;
> >>  	bu21013_data->chip = pdata;
> >>  	bu21013_data->client = client;
> >> +	dev_set_name(&client->dev, pdata->name);
> >
> >Hmm, why is this needed?
> >
> Actual name of the client device is 3-005c, which is not clearly understand.
> So, in our project line we are setting the device name from platform data.
> 

So who/what cares about I2C device name? I do not see how this help
anything, but it does make device's name differ from its sysfs name.

I believe that driver should only alter names of objects they create and
leave other objects alone.

-- 
Dmitry
