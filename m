From: Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH 1/2 v6] HID: gt683r: fix race condition
Date: Thu, 3 Jul 2014 19:34:21 +0200
Message-ID: <20140703173421.GO16590@localhost>
References: <20140703082830.GB16590@localhost>
 <1404407829-1815-1-git-send-email-janne.kanniainen@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-leds-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1404407829-1815-1-git-send-email-janne.kanniainen@gmail.com>
Sender: linux-leds-owner@vger.kernel.org
To: Janne Kanniainen <janne.kanniainen@gmail.com>
Cc: johan@kernel.org, cooloney@gmail.com, jkosina@suse.cz, greg@kroah.com, bjorn@mork.no, linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org, linux-usb@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Thu, Jul 03, 2014 at 08:17:08PM +0300, Janne Kanniainen wrote:
> This will fix race condition noticed by Oliver Neukum. Sysfs files are
> created before mutex and work are initialized.
> 
> Signed-off-by: Janne Kanniainen <janne.kanniainen@gmail.com>

Reviewed-by: Johan Hovold <johan@kernel.org>

> ---
>  drivers/hid/hid-gt683r.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/hid/hid-gt683r.c b/drivers/hid/hid-gt683r.c
> index 077f7a1..073bd80 100644
> --- a/drivers/hid/hid-gt683r.c
> +++ b/drivers/hid/hid-gt683r.c
> @@ -227,6 +227,9 @@ static int gt683r_led_probe(struct hid_device *hdev,
>  	if (!led)
>  		return -ENOMEM;
>  
> +	mutex_init(&led->lock);
> +	INIT_WORK(&led->work, gt683r_led_work);
> +
>  	led->mode = GT683R_LED_NORMAL;
>  	led->hdev = hdev;
>  	hid_set_drvdata(hdev, led);
> @@ -271,9 +274,6 @@ static int gt683r_led_probe(struct hid_device *hdev,
>  		goto fail;
>  	}
>  
> -	mutex_init(&led->lock);
> -	INIT_WORK(&led->work, gt683r_led_work);
> -
>  	return 0;
>  
>  fail:
