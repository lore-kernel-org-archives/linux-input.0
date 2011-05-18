From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] input: members 'name' and 'phys' of 'struct hid_device'
 can never be NULL
Date: Wed, 18 May 2011 13:24:07 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1105181323360.28291@pobox.suse.cz>
References: <1305475662-4478-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:46888 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932168Ab1ERLYJ (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 18 May 2011 07:24:09 -0400
In-Reply-To: <1305475662-4478-1-git-send-email-zonque@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Mack <zonque@gmail.com>
Cc: linux-input@vger.kernel.org, Dmitry Torokhov <dtor@mail.ru>

On Sun, 15 May 2011, Daniel Mack wrote:

> As they are static members of fix size, there is no need to them.
> 
> Signed-off-by: Daniel Mack <zonque@gmail.com>
> Cc: Dmitry Torokhov <dtor@mail.ru>
> Cc: Jiri Kosina <jkosina@suse.cz>
> ---
>  drivers/hid/hidraw.c        |   14 ++------------
>  drivers/hid/usbhid/hiddev.c |   18 ++----------------
>  2 files changed, 4 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/hid/hidraw.c b/drivers/hid/hidraw.c
> index 54409cb..3dd1877 100644
> --- a/drivers/hid/hidraw.c
> +++ b/drivers/hid/hidraw.c
> @@ -395,12 +395,7 @@ static long hidraw_ioctl(struct file *file, unsigned int cmd,
>  				}
>  
>  				if (_IOC_NR(cmd) == _IOC_NR(HIDIOCGRAWNAME(0))) {
> -					int len;
> -					if (!hid->name) {
> -						ret = 0;
> -						break;
> -					}
> -					len = strlen(hid->name) + 1;
> +					int len = strlen(hid->name) + 1;
>  					if (len > _IOC_SIZE(cmd))
>  						len = _IOC_SIZE(cmd);
>  					ret = copy_to_user(user_arg, hid->name, len) ?
> @@ -409,12 +404,7 @@ static long hidraw_ioctl(struct file *file, unsigned int cmd,
>  				}
>  
>  				if (_IOC_NR(cmd) == _IOC_NR(HIDIOCGRAWPHYS(0))) {
> -					int len;
> -					if (!hid->phys) {
> -						ret = 0;
> -						break;
> -					}
> -					len = strlen(hid->phys) + 1;
> +					int len = strlen(hid->phys) + 1;
>  					if (len > _IOC_SIZE(cmd))
>  						len = _IOC_SIZE(cmd);
>  					ret = copy_to_user(user_arg, hid->phys, len) ?
> diff --git a/drivers/hid/usbhid/hiddev.c b/drivers/hid/usbhid/hiddev.c
> index af0a7c1..5ca9c35 100644
> --- a/drivers/hid/usbhid/hiddev.c
> +++ b/drivers/hid/usbhid/hiddev.c
> @@ -801,14 +801,7 @@ static long hiddev_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
>  			break;
>  
>  		if (_IOC_NR(cmd) == _IOC_NR(HIDIOCGNAME(0))) {
> -			int len;
> -
> -			if (!hid->name) {
> -				r = 0;
> -				break;
> -			}
> -
> -			len = strlen(hid->name) + 1;
> +			int len = strlen(hid->name) + 1;
>  			if (len > _IOC_SIZE(cmd))
>  				 len = _IOC_SIZE(cmd);
>  			r = copy_to_user(user_arg, hid->name, len) ?
> @@ -817,14 +810,7 @@ static long hiddev_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
>  		}
>  
>  		if (_IOC_NR(cmd) == _IOC_NR(HIDIOCGPHYS(0))) {
> -			int len;
> -
> -			if (!hid->phys) {
> -				r = 0;
> -				break;
> -			}
> -
> -			len = strlen(hid->phys) + 1;
> +			int len = strlen(hid->phys) + 1;
>  			if (len > _IOC_SIZE(cmd))
>  				len = _IOC_SIZE(cmd);
>  			r = copy_to_user(user_arg, hid->phys, len) ?

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs
