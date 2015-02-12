From: Sylvain Rochet <sylvain.rochet@finsecur.com>
Subject: Re: [PATCHv2] input: rotary encoder: Add wake up support
Date: Thu, 12 Feb 2015 16:42:55 +0100
Message-ID: <20150212154255.GA9701@gradator.net>
References: <1422529818-6140-1-git-send-email-sylvain.rochet@finsecur.com>
 <1422529818-6140-2-git-send-email-sylvain.rochet@finsecur.com>
 <20150208040716.GA544@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx-guillaumet.finsecur.com ([91.217.234.131]:55258 "EHLO
	guillaumet.finsecur.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755793AbbBLPm6 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 12 Feb 2015 10:42:58 -0500
Content-Disposition: inline
In-Reply-To: <20150208040716.GA544@localhost>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Johan Hovold <johan@kernel.org>
Cc: linux-input@vger.kernel.org, Daniel Mack <daniel@caiaq.de>, Johan Hovold <jhovold@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

Hello Johan,

On Sun, Feb 08, 2015 at 12:07:16PM +0800, Johan Hovold wrote:
> On Thu, Jan 29, 2015 at 12:10:18PM +0100, Sylvain Rochet wrote:
> > This patch add wake up support for rotary encoders.
> > 
> > Signed-off-by: Sylvain Rochet <sylvain.rochet@finsecur.com>
> 
> > @@ -306,6 +311,8 @@ static int rotary_encoder_remove(struct platform_device *pdev)
> >  	struct rotary_encoder *encoder = platform_get_drvdata(pdev);
> >  	const struct rotary_encoder_platform_data *pdata = encoder->pdata;
> >  
> > +	device_init_wakeup(&pdev->dev, 0);
> > +
> 
> Perhaps you should use false rather than 0 here for consistency. 

I agree, done.


> Looks good otherwise, so feel free to add my
> 
> Reviewed-by: Johan Hovold <johan@kernel.org>

Thank you Johan :)


> If you resend, you could split the device-tree binding documentation in
> a separate patch that you CC the devicetree list in order to get an ack
> for the property name.

I agree, done.


Sylvain
