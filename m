From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH] Set buttonpad property bit on bcm5974 devices.
Date: Mon, 9 Jan 2012 18:08:34 +0100
Message-ID: <20120109170834.GA5510@polaris.bitmath.org>
References: <1326126826-11608-1-git-send-email-jussi.pakkanen@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-b21.telenor.se ([195.54.99.212]:56984 "EHLO
	smtprelay-b21.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932429Ab2AIRIi (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 9 Jan 2012 12:08:38 -0500
Received: from ipb2.telenor.se (ipb2.telenor.se [195.54.127.165])
	by smtprelay-b21.telenor.se (Postfix) with ESMTP id E403CC522
	for <linux-input@vger.kernel.org>; Mon,  9 Jan 2012 18:08:35 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1326126826-11608-1-git-send-email-jussi.pakkanen@canonical.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jussi Pakkanen <jussi.pakkanen@canonical.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org

Hi Jussi,

> diff --git a/drivers/input/mouse/bcm5974.c b/drivers/input/mouse/bcm5974.c
> index 5ec617e..7c69d9e 100644
> --- a/drivers/input/mouse/bcm5974.c
> +++ b/drivers/input/mouse/bcm5974.c
> @@ -876,6 +876,7 @@ static int bcm5974_probe(struct usb_interface *iface,
>  
>  	input_dev->name = "bcm5974";
>  	input_dev->phys = dev->phys;
> +	__set_bit(INPUT_PROP_BUTTONPAD, input_dev->propbit); 
>  	usb_to_input_id(dev->udev, &input_dev->id);
>  	/* report driver capabilities via the version field */
>  	input_dev->id.version = cfg->caps;

Only macbooks from 2010 and later have the integrated touchpad, so
this has clearly not been broadly tested. Please use the
HAS_INTEGRATED_BUTTON property to steer the logic right.

Thanks,
Henrik
