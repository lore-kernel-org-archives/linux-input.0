From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2] Input: elan_i2c - always output the device information
Date: Wed, 26 Oct 2016 16:27:45 -0700
Message-ID: <20161026232745.GE27930@dtor-ws>
References: <1476357810-11324-1-git-send-email-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1476357810-11324-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: KT Liao <kt.liao@emc.com.tw>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Thu, Oct 13, 2016 at 01:23:30PM +0200, Benjamin Tissoires wrote:
> it's always easier to retrieve these information in bug reports when
> it is always printed in the dmesg.
> 
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Applied, thank you.

> 
> ---
> 
> changes in v2:
> - split the version information message and the touchpad characteristics
> - keep sending the versions as info (on one line)
> - send the characteristics on debug only
> 
> Hi Dmitry,
> 
> This is a respin of one of the patches I sent for elan_i2c. Given that you
> applied the fixed one for SMBus and that I don't currently have a way to
> check from I2C if the trackstick is going to be used, this one is the only
> one left (also given SMBus Host Notify might meld into client->irq).
> 
> So, well, yes, there it comes, a single patch which IMO is useful
> when we receive bug reports.
> 
> Cheers,
> Benjamin
> 
> ---
>  drivers/input/mouse/elan_i2c_core.c | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/input/mouse/elan_i2c_core.c b/drivers/input/mouse/elan_i2c_core.c
> index d15b338..dc7c94d 100644
> --- a/drivers/input/mouse/elan_i2c_core.c
> +++ b/drivers/input/mouse/elan_i2c_core.c
> @@ -1093,19 +1093,18 @@ static int elan_probe(struct i2c_client *client,
>  	if (error)
>  		return error;
>  
> +	dev_info(&client->dev,
> +		"Elan Touchpad: Module ID: 0x%04x, Firmware: 0x%04x, Sample: 0x%04x, IAP: 0x%04x\n",
> +		data->product_id,
> +		data->fw_version,
> +		data->sm_version,
> +		data->iap_version);
> +
>  	dev_dbg(&client->dev,
> -		"Elan Touchpad Information:\n"
> -		"    Module product ID:  0x%04x\n"
> -		"    Firmware Version:  0x%04x\n"
> -		"    Sample Version:  0x%04x\n"
> -		"    IAP Version:  0x%04x\n"
> +		"Elan Touchpad Extra Information:\n"
>  		"    Max ABS X,Y:   %d,%d\n"
>  		"    Width X,Y:   %d,%d\n"
>  		"    Resolution X,Y:   %d,%d (dots/mm)\n",
> -		data->product_id,
> -		data->fw_version,
> -		data->sm_version,
> -		data->iap_version,
>  		data->max_x, data->max_y,
>  		data->width_x, data->width_y,
>  		data->x_res, data->y_res);
> -- 
> 2.7.4
> 

-- 
Dmitry
