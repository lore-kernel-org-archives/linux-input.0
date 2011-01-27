From: Baruch Siach <baruch@tkos.co.il>
Subject: Re: [PATCH] evdev: fix evdev_write return value on partial writes
Date: Thu, 27 Jan 2011 11:46:13 +0200
Message-ID: <20110127094613.GE12588@jasper.tkos.co.il>
References: <1296121320-8946-1-git-send-email-jacmet@sunsite.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from tango.tkos.co.il ([62.219.50.35]:59264 "EHLO tango.tkos.co.il"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753889Ab1A0Jqe (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 27 Jan 2011 04:46:34 -0500
Content-Disposition: inline
In-Reply-To: <1296121320-8946-1-git-send-email-jacmet@sunsite.dk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Peter Korsgaard <jacmet@sunsite.dk>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org

Hi Peter,

On Thu, Jan 27, 2011 at 10:42:00AM +0100, Peter Korsgaard wrote:
> As was recently brought up on the busybox list
> (http://lists.busybox.net/pipermail/busybox/2011-January/074565.html),
> evdev_write doesn't properly check the count argument, which will
> lead to a return value > count on partial writes if the remaining bytes
> are accessible - Causing userspace confusion.
> 
> Fix it by only handling each full input_event structure, similar to how
> it is done in evdev_read.
> 

A Reporte-by here would be nice.

> Signed-off-by: Peter Korsgaard <jacmet@sunsite.dk>

As I said on the Busybox list, applying this results in an endless

write(1, "test\n", 5)                   = 0
write(1, "test\n", 5)                   = 0
write(1, "test\n", 5)                   = 0
write(1, "test\n", 5)                   = 0
write(1, "test\n", 5)                   = 0
write(1, "test\n", 5)                   = 0
write(1, "test\n", 5)                   = 0

from the command

echo test > /dev/input/event0

write() should probably return -EINVAL here.

baruch

> ---
>  drivers/input/evdev.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
> index c8471a2..61fa24e 100644
> --- a/drivers/input/evdev.c
> +++ b/drivers/input/evdev.c
> @@ -330,7 +330,7 @@ static ssize_t evdev_write(struct file *file, const char __user *buffer,
>  		goto out;
>  	}
>  
> -	while (retval < count) {
> +	while ((retval + input_event_size()) <= count) {
>  
>  		if (input_event_from_user(buffer + retval, &event)) {
>  			retval = -EFAULT;
> -- 
> 1.7.2.3
> 

-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch@tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
