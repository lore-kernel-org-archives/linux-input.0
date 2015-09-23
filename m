From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH v4] drivers/hid: Check result of debugfs_create_dir()
 and debugfs_create_file()
Date: Wed, 23 Sep 2015 11:30:30 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1509231129180.30132@pobox.suse.cz>
References: <1441374016-12804-1-git-send-email-kuleshovmail@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:35963 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753211AbbIWJab (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 23 Sep 2015 05:30:31 -0400
In-Reply-To: <1441374016-12804-1-git-send-email-kuleshovmail@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alexander Kuleshov <kuleshovmail@gmail.com>
Cc: Henrik Rydberg <rydberg@bitmath.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, 4 Sep 2015, Alexander Kuleshov wrote:

> The debugfs_create_dir() and debugfs_create_file() functions may return -errno
> if an error occurs. This patch adds a couple of checks of the result of the
> debufs_create_dir() and debugfs_create_file() functions execution in the
> hid_debug_register() and othre places.
> 
> Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
> ---
> Changelog:
> 
> v4:
> 
>   * Syntax error fixed.
> 
> v3:
> 
>   * do not check hid_debug before the call of the hid_debug_init()
> and hid_debug_exit() from v2.
> 
> v2:
> 
>   * add check for the result of the debugfs_create_file() calls
>   * call hid_debug_init() and hid_debug_exit() only if hid_debug
>   * add check for the hid_debug_root in the hid_debug_register()
> 
>  drivers/hid/hid-core.c  |  9 ++++++---
>  drivers/hid/hid-debug.c | 34 +++++++++++++++++++++++++++++++++-
>  2 files changed, 39 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index e6fce23..fea2a88 100644
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

As we are sprinkling these checks around, and hid_debug_unregister() is a 
slow path anyway, I think I'll just rearrange the code that 
hid_debug_unregister() actually accepts NULL pointer.

Applied, thanks for the cleanup.

-- 
Jiri Kosina
SUSE Labs

