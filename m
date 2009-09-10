From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 3/3] Hidraw: ioctl to expose 'uniq'
Date: Thu, 10 Sep 2009 19:51:18 +0200
Message-ID: <1252605078.8931.47.camel@violet>
References: <21b895620909101040vd71e774g71ee4a6a04b0f8ca@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from senator.holtmann.net ([87.106.208.187]:37285 "EHLO
	mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752155AbZIJRvS (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 10 Sep 2009 13:51:18 -0400
In-Reply-To: <21b895620909101040vd71e774g71ee4a6a04b0f8ca@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: SephirXV <sephirxv@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, linux-input@vger.kernel.org

Hi Christopher,

> Simple, deterministic way of getting uniq field bound to hidrawN
> files. Flame me on this one, so long as I get some feedback I can use.
> 
> Signed-off-by: Christopher Olson <sephirxv@gmail.com>
> 
> ---
> 
> --- drivers/hid/hidraw.c        2009-09-10 10:32:28.000000000 -0500
> +++ drivers/hid/hidraw.c.1      2009-09-10 10:32:13.000000000 -0500
> @@ -264,6 +264,12 @@ static long hidraw_ioctl(struct file *fi
>                                         ret = -EFAULT;
>                                 break;
>                         }
> +               case HIDIOCGRAWINFO + 1:        //HIDIOCG_UNIQ
> +                       {
> +                               if (copy_to_user(user_arg, dev->hid->uniq, 64))
> +                                       ret = -EFAULT;
> +                               break;
> +                       }
>                 default:
>                         ret = -ENOTTY;
>         }

wrong mailing list to begin with.

Regards

Marcel


