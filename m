From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2] touchscreen: elants: fix a missing check of return
 values
Date: Wed, 26 Dec 2018 12:00:56 -0800
Message-ID: <20181226200056.GB5999@dtor-ws>
References: <20181225043616.66032-1-kjlu@umn.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181225043616.66032-1-kjlu@umn.edu>
Sender: linux-kernel-owner@vger.kernel.org
To: Kangjie Lu <kjlu@umn.edu>
Cc: pakki001@umn.edu, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Stephen Boyd <swboyd@chromium.org>, Joe Perches <joe@perches.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi,

On Mon, Dec 24, 2018 at 10:36:13PM -0600, Kangjie Lu wrote:
> elants_i2c_send() may fail, let's check its return values. The fix does
> the check and reports an error message upon the failure.
> 
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>
> ---
>  drivers/input/touchscreen/elants_i2c.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/elants_i2c.c b/drivers/input/touchscreen/elants_i2c.c
> index f2cb23121833..8ccba4ccee37 100644
> --- a/drivers/input/touchscreen/elants_i2c.c
> +++ b/drivers/input/touchscreen/elants_i2c.c
> @@ -245,8 +245,22 @@ static int elants_i2c_calibrate(struct elants_data *ts)
>  	ts->state = ELAN_WAIT_RECALIBRATION;
>  	reinit_completion(&ts->cmd_done);
>  
> -	elants_i2c_send(client, w_flashkey, sizeof(w_flashkey));
> -	elants_i2c_send(client, rek, sizeof(rek));
> +	error = elants_i2c_send(client, w_flashkey, sizeof(w_flashkey));
> +	if (error) {
> +		dev_err(&client->dev,
> +				"error in sending the w_flashkey command for calibration: %d\n",
> +				error);
> +		enable_irq(client->irq);
> +		return error;
> +	}
> +  error = elants_i2c_send(client, rek, sizeof(rek));

Messed up formatting.

> +	if (error) {
> +		dev_err(&client->dev,
> +				"error in sending the rek command for calibration: %d\n",
> +				error);
> +		enable_irq(client->irq);
> +		return error;

This also leaves the touchscreen in ELAN_WAIT_RECALIBRATION state. I
think all in all I'd rather leave the code as it was.

> +	}
>  
>  	enable_irq(client->irq);
>  
> -- 
> 2.17.2 (Apple Git-113)
> 

Thanks.

-- 
Dmitry
