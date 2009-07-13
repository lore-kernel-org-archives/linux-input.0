From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: fix EVIOCGNAME regression
Date: Mon, 13 Jul 2009 09:52:05 -0700
Message-ID: <20090713165205.GA28063@dtor-d630.eng.vmware.com>
References: <1247503151-15615-1-git-send-email-daniel@caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-px0-f185.google.com ([209.85.216.185]:54152 "EHLO
	mail-px0-f185.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752905AbZGMQwN (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 13 Jul 2009 12:52:13 -0400
Received: by pxi15 with SMTP id 15so640708pxi.33
        for <linux-input@vger.kernel.org>; Mon, 13 Jul 2009 09:52:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1247503151-15615-1-git-send-email-daniel@caiaq.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Mack <daniel@caiaq.de>
Cc: linux-input@vger.kernel.org, s.neumann@raumfeld.com, Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>

Hi Daniel,

On Mon, Jul 13, 2009 at 06:39:11PM +0200, Daniel Mack wrote:
> Commit 3d5cb60e ("Input: simplify name handling for certain input
> handles") introduced a regression for the EVIOCGNAME ioctl.
> 
> Before this, patch, the platform device's name was given back to
> userspace which was good to identify devices. After this patch, the
> device was ("event%d", minor) which is not descriptive at all.
> 
> This fixes the behaviour by taking input_dev->name.
> 
> Signed-off-by: Daniel Mack <daniel@caiaq.de>
> Reported-by: Sven Neumann <s.neumann@raumfeld.com>
> Cc: Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>
> Cc: Dmitry Torokhov <dtor@mail.ru>
> ---
>  drivers/input/evdev.c |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
> index 114efd8..c81e042 100644
> --- a/drivers/input/evdev.c
> +++ b/drivers/input/evdev.c
> @@ -608,8 +608,8 @@ static long evdev_do_ioctl(struct file *file, unsigned int cmd,
>  						    p, compat_mode);
>  
>  			if (_IOC_NR(cmd) == _IOC_NR(EVIOCGNAME(0)))
> -				return str_to_user(dev_name(&evdev->dev),
> -						   _IOC_SIZE(cmd), p);
> +				return str_to_user(evdev->handle.name,
> +						    _IOC_SIZE(cmd), p);

No, this actually should be just dev->name, handle names were always in
the form of eventX or jsX. The change below is not needed either.

Btw, there is the similar issue in joydev.c as well.

-- 
Dmitry
