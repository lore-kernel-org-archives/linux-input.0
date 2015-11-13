From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: wacom: Add outbounding area for DTU1141
Date: Fri, 13 Nov 2015 11:18:28 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1511131114050.20111@pobox.suse.cz>
References: <1447377674-16818-1-git-send-email-pingc@wacom.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:53862 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933258AbbKMKS3 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 13 Nov 2015 05:18:29 -0500
In-Reply-To: <1447377674-16818-1-git-send-email-pingc@wacom.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: linux-input@vger.kernel.org, Ping Cheng <pingc@wacom.com>

On Thu, 12 Nov 2015, Ping Cheng wrote:

> DTU1141 has an extra 1 mm tablet active outbounding area on each
> side of the display, same as those recently released DTUs.
> 
> Signed-off-by: Ping Cheng <pingc@wacom.com>
> ---
>  drivers/hid/wacom_wac.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
> index 9db6a8b..5d946bb 100644
> --- a/drivers/hid/wacom_wac.c
> +++ b/drivers/hid/wacom_wac.c
> @@ -3187,7 +3187,8 @@ static const struct wacom_features wacom_features_0x32F =
>  	  WACOM_DTU_OFFSET, WACOM_DTU_OFFSET };
>  static const struct wacom_features wacom_features_0x336 =
>  	{ "Wacom DTU1141", 23472, 13203, 1023, 0,
> -	  DTUS, WACOM_INTUOS_RES, WACOM_INTUOS_RES, 4 };
> +	  DTUS, WACOM_INTUOS_RES, WACOM_INTUOS_RES, 4,
> +	  WACOM_DTU_OFFSET, WACOM_DTU_OFFSET };
>  static const struct wacom_features wacom_features_0x57 =
>  	{ "Wacom DTK2241", 95640, 54060, 2047, 63,
>  	  DTK, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES, 6,

Applied to for-4.4/upstream-fixes.

-- 
Jiri Kosina
SUSE Labs

