From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input:Misc changes against kxtj9 v5 patch
Date: Tue, 5 Jul 2011 13:05:48 -0700
Message-ID: <20110705200548.GB15876@core.coreip.homeip.net>
References: <1309895754-5441-1-git-send-email-chris.hudson.comp.eng@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:44660 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752487Ab1GEUFy (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 5 Jul 2011 16:05:54 -0400
Received: by pvg12 with SMTP id 12so5442710pvg.19
        for <linux-input@vger.kernel.org>; Tue, 05 Jul 2011 13:05:53 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1309895754-5441-1-git-send-email-chris.hudson.comp.eng@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: chris.hudson.comp.eng@gmail.com
Cc: linux-input@vger.kernel.org, jic23@cam.ac.uk, Chris Hudson <chudson@kionix.com>

On Tue, Jul 05, 2011 at 03:55:54PM -0400, chris.hudson.comp.eng@gmail.com wrote:
> From: Chris Hudson <chudson@kionix.com>
> 
> As requested, miscellaneous changes originally suggested by Jonathan Cameron,
> patched against the original kxtj9 v5 patch.
> 
> Signed-off-by: Chris Hudson <chudson@kionix.com>
> ---
>  drivers/input/misc/kxtj9.c  |   38 +++++++++++++-------------------------
>  include/linux/input/kxtj9.h |   10 +---------
>  2 files changed, 14 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/input/misc/kxtj9.c b/drivers/input/misc/kxtj9.c
> index 7faf155..b2da841 100644
> --- a/drivers/input/misc/kxtj9.c
> +++ b/drivers/input/misc/kxtj9.c
> @@ -71,6 +71,15 @@ static const struct {
>  	{ 0,	ODR12_5F},
>  };
>  
> +static const struct {
> +	u8 g_range;
> +	u8 shift;
> +} kxtj9_range[] = {
> +	{ 0,		4 },	/* +/-2g */
> +	{ (1 << 3),	3 },	/* +/-4g */
> +	{ (1 << 4),	2 },	/* +/-8g */
> +};
> +
>  struct kxtj9_data {
>  	struct i2c_client *client;
>  	struct kxtj9_platform_data pdata;
> @@ -129,25 +138,9 @@ static void kxtj9_report_acceleration_data(struct kxtj9_data *tj9)
>  
>  static int kxtj9_update_g_range(struct kxtj9_data *tj9, u8 new_g_range)
>  {
> -	switch (new_g_range) {
> -	case KXTJ9_G_2G:
> -		tj9->shift = SHIFT_ADJ_2G;
> -		break;
> -
> -	case KXTJ9_G_4G:
> -		tj9->shift = SHIFT_ADJ_4G;
> -		break;
> -
> -	case KXTJ9_G_8G:
> -		tj9->shift = SHIFT_ADJ_8G;
> -		break;
> -
> -	default:
> -		return -EINVAL;
> -	}
> -
> +	tj9->shift = kxtj9_range[new_g_range].shift;

This is not safe, you still need to sanitize input to make sure you do
not go beyond array boundaries.

-- 
Dmitry
