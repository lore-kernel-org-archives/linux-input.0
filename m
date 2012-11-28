From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] HID: hidraw: fix signaling SIGIO when hidraw reports an
 event
Date: Wed, 28 Nov 2012 16:38:19 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1211281637320.25639@pobox.suse.cz>
References: <1354071747-14007-1-git-send-email-aduggan@synaptics.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:52142 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753270Ab2K1Pi1 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 28 Nov 2012 10:38:27 -0500
In-Reply-To: <1354071747-14007-1-git-send-email-aduggan@synaptics.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andrew Duggan <aduggan@synaptics.com>
Cc: linux-input@vger.kernel.org, cheiny@synaptics.com

On Tue, 27 Nov 2012, Andrew Duggan wrote:

> Hi Jiri and Linux-Input,
> 
> This patch fixes sending SIGIO from hidraw_report_event by creating a fasync
> handler which adds the fasync entry.
> 
> 
> Signed-off-by: Andrew Duggan <aduggan@synaptics.com>
> ---
>  drivers/hid/hidraw.c |    8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/hid/hidraw.c b/drivers/hid/hidraw.c
> index 7c47fc3..d4a5af4 100644
> --- a/drivers/hid/hidraw.c
> +++ b/drivers/hid/hidraw.c
> @@ -295,6 +295,13 @@ out:
>  
>  }
>  
> +static int hidraw_fasync(int fd, struct file *file, int on)
> +{
> +	struct hidraw_list *list = file->private_data;
> +
> +	return fasync_helper(fd, file, on, &list->fasync);
> +}
> +
>  static int hidraw_release(struct inode * inode, struct file * file)
>  {
>  	unsigned int minor = iminor(inode);
> @@ -438,6 +445,7 @@ static const struct file_operations hidraw_ops = {
>  	.open =         hidraw_open,
>  	.release =      hidraw_release,
>  	.unlocked_ioctl = hidraw_ioctl,
> +	.fasync =	hidraw_fasync,
>  #ifdef CONFIG_COMPAT
>  	.compat_ioctl   = hidraw_ioctl,
>  #endif

Right you are!

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs
