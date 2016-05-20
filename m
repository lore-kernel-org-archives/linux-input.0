From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2] Input: uinput - handle compat ioctl for UI_SET_PHYS
Date: Fri, 20 May 2016 10:59:35 -0700
Message-ID: <20160520175935.GF14951@dtor-ws>
References: <1463499587-21346-1-git-send-email-jcliang@chromium.org>
 <1463766648-2392-1-git-send-email-jcliang@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:36106 "EHLO
	mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750800AbcETR7j (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 20 May 2016 13:59:39 -0400
Content-Disposition: inline
In-Reply-To: <1463766648-2392-1-git-send-email-jcliang@chromium.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ricky Liang <jcliang@chromium.org>
Cc: David Herrmann <dh.herrmann@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Anshul Garg <aksgarg1989@gmail.com>, Elias Vanderstuyft <elias.vds@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, "open list:INPUT (KEYBOARD, MOUSE, JOYSTICK, TOUCHSCREEN)..." <linux-input@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>

On Sat, May 21, 2016 at 01:50:46AM +0800, Ricky Liang wrote:
> When running a 32-bit userspace on a 64-bit kernel, the UI_SET_PHYS
> ioctl needs to be treated with special care, as it has the pointer
> size encoded in the command.
> 
> Signed-off-by: Ricky Liang <jcliang@chromium.org>

Applied, thank you.

> ---
>  drivers/input/misc/uinput.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/input/misc/uinput.c b/drivers/input/misc/uinput.c
> index abe1a92..65ebbd1 100644
> --- a/drivers/input/misc/uinput.c
> +++ b/drivers/input/misc/uinput.c
> @@ -981,9 +981,15 @@ static long uinput_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
>  }
>  
>  #ifdef CONFIG_COMPAT
> +
> +#define UI_SET_PHYS_COMPAT	_IOW(UINPUT_IOCTL_BASE, 108, compat_uptr_t)
> +
>  static long uinput_compat_ioctl(struct file *file,
>  				unsigned int cmd, unsigned long arg)
>  {
> +	if (cmd == UI_SET_PHYS_COMPAT)
> +		cmd = UI_SET_PHYS;
> +
>  	return uinput_ioctl_handler(file, cmd, arg, compat_ptr(arg));
>  }
>  #endif
> -- 
> 2.1.2
> 

-- 
Dmitry
