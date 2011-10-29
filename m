From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH 3/5] drivers/hid/hid-roccat.c: eliminate a null pointer
 dereference
Date: Sat, 29 Oct 2011 09:24:13 +0300
Message-ID: <20111029062412.GG14881@longonot.mountain>
References: <1319846297-2985-3-git-send-email-julia@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from acsinet15.oracle.com ([141.146.126.227]:40580 "EHLO
	acsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752558Ab1J2G1k (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 29 Oct 2011 02:27:40 -0400
Content-Disposition: inline
In-Reply-To: <1319846297-2985-3-git-send-email-julia@diku.dk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Julia Lawall <julia@diku.dk>
Cc: Jiri Kosina <jkosina@suse.cz>, kernel-janitors@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Sat, Oct 29, 2011 at 01:58:15AM +0200, Julia Lawall wrote:
> diff --git a/drivers/hid/hid-roccat.c b/drivers/hid/hid-roccat.c
> index 2596321..36a28b8 100644
> --- a/drivers/hid/hid-roccat.c
> +++ b/drivers/hid/hid-roccat.c
> @@ -163,14 +163,15 @@ static int roccat_open(struct inode *inode, struct file *file)
>  
>  	device = devices[minor];
>  
> -	mutex_lock(&device->readers_lock);
> -
>  	if (!device) {
>  		pr_emerg("roccat device with minor %d doesn't exist\n", minor);
> -		error = -ENODEV;
> -		goto exit_err;
> +		kfree(reader);
> +		mutex_lock(&devices_lock);

Typo.  mutex_unlock() instead of mutex_lock().

> +		return -ENODEV;
>  	}
>  
> +	mutex_lock(&device->readers_lock);
> +
>  	if (!device->open++) {
>  		/* power on device on adding first reader */
>  		error = hid_hw_power(device->hid, PM_HINT_FULLON);
> 

regards,
dan carpenter
