From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH v2] drivers/hid: Check result of debugfs_create_dir()
 and debugfs_create_file()
Date: Wed, 19 Aug 2015 22:41:56 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1508192240080.25821@pobox.suse.cz>
References: <1439922909-18452-1-git-send-email-kuleshovmail@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:56820 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751721AbbHSUl4 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 19 Aug 2015 16:41:56 -0400
In-Reply-To: <1439922909-18452-1-git-send-email-kuleshovmail@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alexander Kuleshov <kuleshovmail@gmail.com>
Cc: Henrik Rydberg <rydberg@bitmath.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, 19 Aug 2015, Alexander Kuleshov wrote:

> The debugfs_create_dir() and debugfs_create_file() functions may return -errno
> if an error occurs. This patch adds a couple of checks of the result of the
> debufs_create_dir() and debugfs_create_file() functions execution in the
> hid_debug_register() and othre places.
> 
> Changelog:
> 
> v2:
> 
>   * add check for the result of the debugfs_create_file() calls
>   * call hid_debug_init() and hid_debug_exit() only if hid_debug
>   * add check for the hid_debug_root in the hid_debug_register()
> 
> Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
> ---
>  drivers/hid/hid-core.c  | 15 ++++++++++-----
>  drivers/hid/hid-debug.c | 38 ++++++++++++++++++++++++++++++++++----
>  2 files changed, 44 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index e6fce23..8aa2c20 100644
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -2599,8 +2599,10 @@ int hid_add_device(struct hid_device *hdev)
>  	ret = device_add(&hdev->dev);
>  	if (!ret)
>  		hdev->status |= HID_STAT_ADDED;
> -	else
> -		hid_debug_unregister(hdev);
> +	else {
> +		if (hdev->debug)
> +			hid_debug_unregister(hdev);
> +	}
>  
>  	return ret;
>  }
> @@ -2644,7 +2646,8 @@ static void hid_remove_device(struct hid_device *hdev)
>  {
>  	if (hdev->status & HID_STAT_ADDED) {
>  		device_del(&hdev->dev);
> -		hid_debug_unregister(hdev);
> +		if (hdev->debug)
> +			hid_debug_unregister(hdev);
>  		hdev->status &= ~HID_STAT_ADDED;
>  	}
>  	kfree(hdev->dev_rdesc);
> @@ -2737,7 +2740,8 @@ static int __init hid_init(void)
>  	if (ret)
>  		goto err_bus;
>  
> -	hid_debug_init();
> +	if (hid_debug)
> +		hid_debug_init();

How is this change related to the rest of the patch?

It's wrong anyway, because hid_debug is independent of the debugfs HID 
debugging facility. Please see for example the printk() a few lines above 
in this very function, which is emited in case hid_debug is enabled.

-- 
Jiri Kosina
SUSE Labs

