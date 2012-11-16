From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 11/14] HID: hiddev: Remove redundant check on unsigned
 variable
Date: Fri, 16 Nov 2012 10:27:43 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1211161027370.20577@pobox.suse.cz>
References: <1353048646-10935-1-git-send-email-tushar.behera@linaro.org> <1353048646-10935-12-git-send-email-tushar.behera@linaro.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:56187 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750826Ab2KPJ1r (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 16 Nov 2012 04:27:47 -0500
In-Reply-To: <1353048646-10935-12-git-send-email-tushar.behera@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Tushar Behera <tushar.behera@linaro.org>
Cc: linux-kernel@vger.kernel.org, patches@linaro.org, linux-usb@vger.kernel.org, linux-input@vger.kernel.org

On Fri, 16 Nov 2012, Tushar Behera wrote:

> No need to check whether unsigned variable is less than 0.
> 
> CC: Jiri Kosina <jkosina@suse.cz>
> CC: linux-usb@vger.kernel.org
> CC: linux-input@vger.kernel.org
> Signed-off-by: Tushar Behera <tushar.behera@linaro.org>
> ---
>  drivers/hid/usbhid/hiddev.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/hid/usbhid/hiddev.c b/drivers/hid/usbhid/hiddev.c
> index 14599e2..711c965 100644
> --- a/drivers/hid/usbhid/hiddev.c
> +++ b/drivers/hid/usbhid/hiddev.c
> @@ -625,7 +625,7 @@ static long hiddev_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
>  		break;
>  
>  	case HIDIOCAPPLICATION:
> -		if (arg < 0 || arg >= hid->maxapplication)
> +		if (arg >= hid->maxapplication)
>  			break;
>  
>  		for (i = 0; i < hid->maxcollection; i++)

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs
