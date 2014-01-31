From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH 4/6] HID: Add the HIDIOCGRAWCLIENTADDR ioctl to hidraw
Date: Fri, 31 Jan 2014 14:19:19 -0500
Message-ID: <CAN+gG=EzJL98VFqShv3VSzM_k8ubPmi27RmVrRz5n87z9YTiCQ@mail.gmail.com>
References: <1391189573-2591-1-git-send-email-frank.praznik@oh.rr.com>
	<1391189573-2591-5-git-send-email-frank.praznik@oh.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:44694 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932271AbaAaTTV (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 31 Jan 2014 14:19:21 -0500
Received: by mail-lb0-f174.google.com with SMTP id l4so3738034lbv.19
        for <linux-input@vger.kernel.org>; Fri, 31 Jan 2014 11:19:19 -0800 (PST)
In-Reply-To: <1391189573-2591-5-git-send-email-frank.praznik@oh.rr.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Frank Praznik <frank.praznik@oh.rr.com>
Cc: linux-input <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>, David Herrmann <dh.herrmann@gmail.com>

On Fri, Jan 31, 2014 at 12:32 PM, Frank Praznik <frank.praznik@oh.rr.com> wrote:
> Add a new HIDIOCGRAWCLIENTADDR ioctl to hidraw for retrieving the client
> address.
>
> Signed-off-by: Frank Praznik <frank.praznik@oh.rr.com>
> ---
>  drivers/hid/hidraw.c        | 19 +++++++++++++++++++
>  include/uapi/linux/hidraw.h |  1 +
>  2 files changed, 20 insertions(+)
>
> diff --git a/drivers/hid/hidraw.c b/drivers/hid/hidraw.c
> index cb0137b..07c328b 100644
> --- a/drivers/hid/hidraw.c
> +++ b/drivers/hid/hidraw.c
> @@ -447,6 +447,25 @@ static long hidraw_ioctl(struct file *file, unsigned int cmd,
>                                                 -EFAULT : len;
>                                         break;
>                                 }
> +
> +                               if (_IOC_NR(cmd) == _IOC_NR(HIDIOCGRAWCLIENTADDR(0))) {

Maybe we are just lacking an ioctl to retrieve hid->uniq...

Cheers,
Benjamin

> +                                       char addr_str[32];
> +                                       int len;
> +                                       ret = snprintf(addr_str, sizeof(addr_str),
> +                                                       "%pMR", hid->client_addr);
> +                                       if (ret < 0)
> +                                               break;
> +                                       else if (ret > sizeof(addr_str)-1)
> +                                               len = sizeof(addr_str);
> +                                       else
> +                                               len = ret + 1;
> +
> +                                       if (len > _IOC_SIZE(cmd))
> +                                               len = _IOC_SIZE(cmd);
> +                                       ret = copy_to_user(user_arg, addr_str, len) ?
> +                                               -EFAULT : len;
> +                                       break;
> +                               }
>                         }
>
>                 ret = -ENOTTY;
> diff --git a/include/uapi/linux/hidraw.h b/include/uapi/linux/hidraw.h
> index f5b7329..5b6f4fa 100644
> --- a/include/uapi/linux/hidraw.h
> +++ b/include/uapi/linux/hidraw.h
> @@ -38,6 +38,7 @@ struct hidraw_devinfo {
>  /* The first byte of SFEATURE and GFEATURE is the report number */
>  #define HIDIOCSFEATURE(len)    _IOC(_IOC_WRITE|_IOC_READ, 'H', 0x06, len)
>  #define HIDIOCGFEATURE(len)    _IOC(_IOC_WRITE|_IOC_READ, 'H', 0x07, len)
> +#define HIDIOCGRAWCLIENTADDR(len) _IOC(_IOC_READ, 'H', 0x08, len)
>
>  #define HIDRAW_FIRST_MINOR 0
>  #define HIDRAW_MAX_DEVICES 64
> --
> 1.8.5.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
