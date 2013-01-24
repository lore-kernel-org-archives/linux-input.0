From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: wacom - fix wacom_set_report retry logic
Date: Wed, 23 Jan 2013 19:38:04 -0800
Message-ID: <20130124033804.GA4216@core.coreip.homeip.net>
References: <1358992356-7898-1-git-send-email-chris@cnpbagwell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f44.google.com ([209.85.160.44]:64999 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754273Ab3AXDiI (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 23 Jan 2013 22:38:08 -0500
Received: by mail-pb0-f44.google.com with SMTP id uo1so5124144pbc.31
        for <linux-input@vger.kernel.org>; Wed, 23 Jan 2013 19:38:07 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1358992356-7898-1-git-send-email-chris@cnpbagwell.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: chris@cnpbagwell.com
Cc: linux-input@vger.kernel.org, pinglinux@gmail.com, killertofu@gmail.com

On Wed, Jan 23, 2013 at 07:52:36PM -0600, chris@cnpbagwell.com wrote:
> From: Chris Bagwell <chris@cnpbagwell.com>
> 
> Logic sets a value and then reads it back to make sure it worked
> and retries write on failures.  Since read and write share a buffer,
> it needs to be set back up before writing though.
> 
> Issue is not seen a lot because 1) it doesn't need to retry for
> a lot of tablets and 2) a lot of failures that need a retry are
> from an -ETIMEDOUT and hopefully buffer is not touched in this case.
> 
> At least one user has shown logs with buffer being modified during
> -ETIMEDOUT case with linux 3.7 kernel.
> 
> Signed-off-by: Chris Bagwell <chris@cnpbagwell.com>

Applied, thank you Chris. 

> ---
>  drivers/input/tablet/wacom_sys.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/input/tablet/wacom_sys.c b/drivers/input/tablet/wacom_sys.c
> index f92d34f..aaf23ae 100644
> --- a/drivers/input/tablet/wacom_sys.c
> +++ b/drivers/input/tablet/wacom_sys.c
> @@ -553,10 +553,10 @@ static int wacom_set_device_mode(struct usb_interface *intf, int report_id, int
>  	if (!rep_data)
>  		return error;
>  
> -	rep_data[0] = report_id;
> -	rep_data[1] = mode;
> -
>  	do {
> +		rep_data[0] = report_id;
> +		rep_data[1] = mode;
> +
>  		error = wacom_set_report(intf, WAC_HID_FEATURE_REPORT,
>  		                         report_id, rep_data, length, 1);
>  		if (error >= 0)
> -- 
> 1.8.1
> 

-- 
Dmitry
