From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH] Set buttonpad property on those bcm5974 devices that
 have a physical button.
Date: Tue, 10 Jan 2012 10:45:20 +0100
Message-ID: <20120110094520.GA7582@polaris.bitmath.org>
References: <1326188164-6106-1-git-send-email-jussi.pakkanen@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-b11.telenor.se ([62.127.194.20]:34305 "EHLO
	smtprelay-b11.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755630Ab2AJJpS (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 10 Jan 2012 04:45:18 -0500
Received: from ipb5.telenor.se (ipb5.telenor.se [195.54.127.168])
	by smtprelay-b11.telenor.se (Postfix) with ESMTP id 64988D123
	for <linux-input@vger.kernel.org>; Tue, 10 Jan 2012 10:45:17 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1326188164-6106-1-git-send-email-jussi.pakkanen@canonical.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jussi Pakkanen <jussi.pakkanen@canonical.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org

Jussi,

On Tue, Jan 10, 2012 at 11:36:04AM +0200, Jussi Pakkanen wrote:
> ---
>  drivers/input/mouse/bcm5974.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/input/mouse/bcm5974.c b/drivers/input/mouse/bcm5974.c
> index 5ec617e..df3fd85 100644
> --- a/drivers/input/mouse/bcm5974.c
> +++ b/drivers/input/mouse/bcm5974.c
> @@ -876,6 +876,9 @@ static int bcm5974_probe(struct usb_interface *iface,
>  
>  	input_dev->name = "bcm5974";
>  	input_dev->phys = dev->phys;
> +	if (bcm5974_get_config(dev->udev)->caps & HAS_INTEGRATED_BUTTON) {
> +		__set_bit(INPUT_PROP_BUTTONPAD, input_dev->propbit);
> +	}
>  	usb_to_input_id(dev->udev, &input_dev->id);
>  	/* report driver capabilities via the version field */
>  	input_dev->id.version = cfg->caps;
> -- 
> 1.7.5.4
> 

Besides being put in the wrong place, the already-defined local
variable is not used. Any particular reason for it? Otherwise, please
bundle the change with the rest in setup_events_to_report().

Thanks,
Henrik
