From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/3] input: mpu3050: Configure the sampling method
Date: Sat, 24 Dec 2011 00:07:52 -0800
Message-ID: <20111224080752.GA13020@core.coreip.homeip.net>
References: <20111215221732.8657.63987.stgit@bob.linux.org.uk>
 <20111215221845.8657.17958.stgit@bob.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:36084 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753238Ab1LXIIC (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 24 Dec 2011 03:08:02 -0500
Received: by iaeh11 with SMTP id h11so16252198iae.19
        for <linux-input@vger.kernel.org>; Sat, 24 Dec 2011 00:08:00 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20111215221845.8657.17958.stgit@bob.linux.org.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-input@vger.kernel.org

Hi Alan,

On Thu, Dec 15, 2011 at 10:18:47PM +0000, Alan Cox wrote:
> From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> 
> This will improve the output of the sensor.
> 

...

>  
> +/* Configures the sampling method */
> +static int mpu3050_hw_init(struct mpu3050_sensor *sensor)

This should be __devinit.

...
> @@ -336,6 +423,10 @@ static int __devinit mpu3050_probe(struct i2c_client *client,
>  
>  	pm_runtime_set_active(&client->dev);
>  
> +	error = mpu3050_hw_init(sensor);
> +	if (error)
> +		goto err_free_mem;

We should go to err_pm_set_suspended, not err_free_mem.

I fixed it up locally.

Thanks.

-- 
Dmitry
