From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input synaptics-rmi4 trivial: Eliminate unused local
 variable.
Date: Wed, 18 Dec 2013 08:52:04 -0800
Message-ID: <20131218165204.GD30922@core.coreip.homeip.net>
References: <1387247151-21131-1-git-send-email-cheiny@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f53.google.com ([209.85.160.53]:33576 "EHLO
	mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751941Ab3LRQwK (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 18 Dec 2013 11:52:10 -0500
Received: by mail-pb0-f53.google.com with SMTP id ma3so8607337pbc.26
        for <linux-input@vger.kernel.org>; Wed, 18 Dec 2013 08:52:10 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1387247151-21131-1-git-send-email-cheiny@synaptics.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Christopher Heiny <cheiny@synaptics.com>
Cc: Linux Input <linux-input@vger.kernel.org>, Andrew Duggan <aduggan@synaptics.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Vivian Ly <vly@synaptics.com>, Daniel Rosenberg <daniel.rosenberg@synaptics.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>

On Mon, Dec 16, 2013 at 06:25:51PM -0800, Christopher Heiny wrote:
> One-line change to eliminate an unused local variable warning in rmi_f11.c.
> 
> Signed-off-by: Christopher Heiny <cheiny@synaptics.com>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Applied, thank you.

> 
> ---
> 
> This patch implements changes to the synaptics-rmi4 branch of
> Dmitry's input tree.  The base for the patch is commit
> e0c5aec5e6144ae8391d164e2dc659f8ef2b2ba7.
> 
> drivers/input/rmi4/rmi_f11.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/input/rmi4/rmi_f11.c b/drivers/input/rmi4/rmi_f11.c
> index d63ef31..c2be9de 100644
> --- a/drivers/input/rmi4/rmi_f11.c
> +++ b/drivers/input/rmi4/rmi_f11.c
> @@ -1289,7 +1289,6 @@ static int rmi_f11_register_devices(struct rmi_function *fn)
>  	struct f11_data *f11 = fn->data;
>  	struct input_dev *input_dev;
>  	struct input_dev *input_dev_mouse;
> -	struct rmi_driver_data *driver_data = dev_get_drvdata(&rmi_dev->dev);
>  	struct rmi_driver *driver = rmi_dev->driver;
>  	struct f11_2d_sensor *sensor = &f11->sensor;
>  	int rc;

-- 
Dmitry
