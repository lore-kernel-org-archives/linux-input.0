From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 2/4] HID: lg4ff: Remove unnecessary casts of void
 pointers
Date: Mon, 17 Sep 2012 13:08:13 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1209171308070.31149@pobox.suse.cz>
References: <1347516512.3319.2.camel@phoenix> <1347516573.3319.3.camel@phoenix>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:43640 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755687Ab2IQLIV (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 17 Sep 2012 07:08:21 -0400
In-Reply-To: <1347516573.3319.3.camel@phoenix>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Axel Lin <axel.lin@gmail.com>
Cc: Simon Wood <simon@mungewell.org>, =?ISO-8859-15?Q?Michal_Mal=FD?= <madcatxster@gmail.com>, linux-input@vger.kernel.org

On Thu, 13 Sep 2012, Axel Lin wrote:

> Signed-off-by: Axel Lin <axel.lin@gmail.com>
> ---
>  drivers/hid/hid-lg4ff.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied, thanks.

> 
> diff --git a/drivers/hid/hid-lg4ff.c b/drivers/hid/hid-lg4ff.c
> index f3390ee..da23c6b 100644
> --- a/drivers/hid/hid-lg4ff.c
> +++ b/drivers/hid/hid-lg4ff.c
> @@ -360,7 +360,7 @@ static void lg4ff_led_set_brightness(struct led_classdev *led_cdev,
>  {
>  	struct device *dev = led_cdev->dev->parent;
>  	struct hid_device *hid = container_of(dev, struct hid_device, dev);
> -	struct lg_drv_data *drv_data = (struct lg_drv_data *)hid_get_drvdata(hid);
> +	struct lg_drv_data *drv_data = hid_get_drvdata(hid);
>  	struct lg4ff_device_entry *entry;
>  	int i, state = 0;
>  
> @@ -395,7 +395,7 @@ static enum led_brightness lg4ff_led_get_brightness(struct led_classdev *led_cde
>  {
>  	struct device *dev = led_cdev->dev->parent;
>  	struct hid_device *hid = container_of(dev, struct hid_device, dev);
> -	struct lg_drv_data *drv_data = (struct lg_drv_data *)hid_get_drvdata(hid);
> +	struct lg_drv_data *drv_data = hid_get_drvdata(hid);
>  	struct lg4ff_device_entry *entry;
>  	int i, value = 0;
>  
> -- 
> 1.7.9.5
> 
> 
> 

-- 
Jiri Kosina
SUSE Labs
