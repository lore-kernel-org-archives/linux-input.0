From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [v2] Input: elan_i2c - check if device is there before really
 probing
Date: Thu, 11 May 2017 13:51:32 -0700
Message-ID: <20170511205132.GA12010@roeck-us.net>
References: <20170509004553.GA21295@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:34786 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755197AbdEKUve (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 11 May 2017 16:51:34 -0400
Content-Disposition: inline
In-Reply-To: <20170509004553.GA21295@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, KT Liao <ktalex.liao@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-kernel@vger.kernel.org

On Mon, May 08, 2017 at 05:45:53PM -0700, Dmitry Torokhov wrote:
> Before trying to properly initialize the touchpad and generate bunch of
> errors, let's first see it there is anything at the given address. If we
> get error, fail silently with -ENXIO.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> 
> v2: switched over to i2c_smbus_read_byte() as Guenter suggested
> 
>  drivers/input/mouse/elan_i2c_core.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/input/mouse/elan_i2c_core.c b/drivers/input/mouse/elan_i2c_core.c
> index 5d3b53dd2fa2..3b616cb7c67f 100644
> --- a/drivers/input/mouse/elan_i2c_core.c
> +++ b/drivers/input/mouse/elan_i2c_core.c
> @@ -1091,6 +1091,13 @@ static int elan_probe(struct i2c_client *client,
>  		return error;
>  	}
>  
> +	/* Make sure there is something at this address */
> +	error = i2c_smbus_read_byte(client);
> +	if (error < 0) {
> +		dev_dbg(&client->dev, "nothing at this address: %d\n", error);
> +		return -ENXIO;
> +	}
> +
>  	/* Initialize the touchpad. */
>  	error = elan_initialize(data);
>  	if (error)
