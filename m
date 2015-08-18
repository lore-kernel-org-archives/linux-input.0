From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] drivers/hid: Fix debugfs_create_dir's error checking
 method for hid-core
Date: Tue, 18 Aug 2015 15:12:37 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1508181510220.25821@pobox.suse.cz>
References: <1439577817-9948-1-git-send-email-kuleshovmail@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:59739 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752707AbbHRNMh (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 18 Aug 2015 09:12:37 -0400
In-Reply-To: <1439577817-9948-1-git-send-email-kuleshovmail@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alexander Kuleshov <kuleshovmail@gmail.com>
Cc: Henrik Rydberg <rydberg@bitmath.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Sat, 15 Aug 2015, Alexander Kuleshov wrote:

> The debugfs_create_dir() function returns NULL if an error occurs. This patch
> adds check of the result of the debufs_create_dir() execution in the
> hid_debug_register().
> 
> Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
> ---
>  drivers/hid/hid-core.c  | 6 ++++--
>  drivers/hid/hid-debug.c | 3 +++
>  2 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index e6fce23..315a980 100644
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -2599,8 +2599,10 @@ int hid_add_device(struct hid_device *hdev)
>  	ret = device_add(&hdev->dev);
>  	if (!ret)
>  		hdev->status |= HID_STAT_ADDED;
> -	else
> -		hid_debug_unregister(hdev);
> +	else {
> +		if (hdev->debug_dir)
> +			hid_debug_unregister(hdev);
> +	}
>  
>  	return ret;
>  }
> diff --git a/drivers/hid/hid-debug.c b/drivers/hid/hid-debug.c
> index 2886b64..80fa03d 100644
> --- a/drivers/hid/hid-debug.c
> +++ b/drivers/hid/hid-debug.c
> @@ -1223,6 +1223,9 @@ static const struct file_operations hid_debug_events_fops = {
>  void hid_debug_register(struct hid_device *hdev, const char *name)
>  {
>  	hdev->debug_dir = debugfs_create_dir(name, hid_debug_root);
> +	if (!hdev->debug_dir)
> +		return -ENOMEM;
> +

What sense does it make to return -ENOMEM from void function?

>  	hdev->debug_rdesc = debugfs_create_file("rdesc", 0400,
>  			hdev->debug_dir, hdev, &hid_debug_rdesc_fops);
>  	hdev->debug_events = debugfs_create_file("events", 0400,

Fixing this is ultimately a good thing, but why did you just pick 
debugfs_create_dir() and left the other, with the same issue 
(debugfs_create_file()) intact?

-- 
Jiri Kosina
SUSE Labs

