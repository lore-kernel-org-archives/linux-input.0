From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] HID:hid-logitech: Prevent possibility of infinite loop
 when using /sys interface
Date: Tue, 12 Aug 2014 16:30:20 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1408121630000.15220@pobox.suse.cz>
References: <1407379951-7038-1-git-send-email-simon@mungewell.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:38521 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752393AbaHLOaW (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 12 Aug 2014 10:30:22 -0400
In-Reply-To: <1407379951-7038-1-git-send-email-simon@mungewell.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Simon Wood <simon@mungewell.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, 6 Aug 2014, Simon Wood wrote:

> If the device data is not accessible for some reason, returning 0 will cause the call to be
> continuously called again as none of the string has been 'consumed'.

Hi Simon,

this patch is missing signoff.

> ---
>  drivers/hid/hid-lg4ff.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hid/hid-lg4ff.c b/drivers/hid/hid-lg4ff.c
> index cc2bd20..7835717 100644
> --- a/drivers/hid/hid-lg4ff.c
> +++ b/drivers/hid/hid-lg4ff.c
> @@ -451,13 +451,13 @@ static ssize_t lg4ff_range_store(struct device *dev, struct device_attribute *at
>  	drv_data = hid_get_drvdata(hid);
>  	if (!drv_data) {
>  		hid_err(hid, "Private driver data not found!\n");
> -		return 0;
> +		return -EINVAL;
>  	}
>  
>  	entry = drv_data->device_props;
>  	if (!entry) {
>  		hid_err(hid, "Device properties not found!\n");
> -		return 0;
> +		return -EINVAL;
>  	}
>  
>  	if (range == 0)

-- 
Jiri Kosina
SUSE Labs
