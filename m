From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: soc_button_array - Silence -ENOENT error on Dell
 XPS13 9365
Date: Sun, 20 Aug 2017 09:29:19 -0700
Message-ID: <20170820162919.GB1176@dtor-ws>
References: <20170820094221.7629-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:38380 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753101AbdHTQ3W (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sun, 20 Aug 2017 12:29:22 -0400
Received: by mail-pf0-f196.google.com with SMTP id h75so4542293pfh.5
        for <linux-input@vger.kernel.org>; Sun, 20 Aug 2017 09:29:22 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170820094221.7629-1-hdegoede@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: linux-input@vger.kernel.org

On Sun, Aug 20, 2017 at 11:42:21AM +0200, Hans de Goede wrote:
> The Dell XPS13 9365 has an INT33D2 ACPI node with no GPIOs, causing
> the following error in dmesg:
> 
> [    7.172275] soc_button_array: probe of INT33D2:00 failed with error -2
> 
> This commit silences this, by returning -ENODEV when there are no GPIOs.
> 
> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=196679
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Applied, thank you.

> ---
>  drivers/input/misc/soc_button_array.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/misc/soc_button_array.c b/drivers/input/misc/soc_button_array.c
> index 27b99831cb97..0f7cce70f748 100644
> --- a/drivers/input/misc/soc_button_array.c
> +++ b/drivers/input/misc/soc_button_array.c
> @@ -334,7 +334,7 @@ static int soc_button_probe(struct platform_device *pdev)
>  	error = gpiod_count(dev, NULL);
>  	if (error < 0) {
>  		dev_dbg(dev, "no GPIO attached, ignoring...\n");
> -		return error;
> +		return -ENODEV;
>  	}
>  
>  	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> -- 
> 2.13.4
> 

-- 
Dmitry
