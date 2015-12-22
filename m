From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input:touchscreen:Properly check touchscreen information
 is read in ads7846_probe
Date: Tue, 22 Dec 2015 10:53:00 -0800
Message-ID: <CAKdAkRSjJJrnEb6-e9DHG14w6trLeRKn6AZ8_gXq9-YbawncdQ@mail.gmail.com>
References: <1450807105-14209-1-git-send-email-xerofoify@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1450807105-14209-1-git-send-email-xerofoify@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicholas Krause <xerofoify@gmail.com>
Cc: Javier Martinez Canillas <javier@osg.samsung.com>, Mark Brown <broonie@kernel.org>, Andrey Gelman <andrey.gelman@compulab.co.il>, afd@ti.com, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Tue, Dec 22, 2015 at 9:58 AM, Nicholas Krause <xerofoify@gmail.com> wrote:
> This properly checks if touchscreen information is read before
> allocating a sysfs_group of files for this device's device
> structure's kobject(s) and if we fail to read the information
> successfully then we must continue with the error path for
> the error occurred by freeing up resources allocating by
> ads7846_probe before returning the error code returned
> by this function call to the caller of ads7846_probe.
>
> Signed-off-by: Nicholas Krause <xerofoify@gmail.com>
> ---
>  drivers/input/touchscreen/ads7846.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
> index a61b215..d8150a9 100644
> --- a/drivers/input/touchscreen/ads7846.c
> +++ b/drivers/input/touchscreen/ads7846.c
> @@ -1412,9 +1412,12 @@ static int ads7846_probe(struct spi_device *spi)
>          * the touchscreen, in case it's not connected.
>          */
>         if (ts->model == 7845)
> -               ads7845_read12_ser(&spi->dev, PWRDOWN);
> +               err = ads7845_read12_ser(&spi->dev, PWRDOWN);
>         else
> -               (void) ads7846_read12_ser(&spi->dev, READ_12BIT_SER(vaux));
> +               err = ads7846_read12_ser(&spi->dev, READ_12BIT_SER(vaux));
> +
> +       if (err)
> +               goto err_remove_hwmon;

Positive return value from ads784*_read12_ser() does not indicate
error. Also note that when someone takes care annotating an
expressions as "(void)" they explicitly indicate that return value
should be ignored. For details about why it has been done here you'd
have to ask Anatolij Gustschin.

>
>         err = sysfs_create_group(&spi->dev.kobj, &ads784x_attr_group);
>         if (err)
> --
> 2.5.0
>

Nick, it has been proven time and again that your submissions are not
useful, please refrain from sending me patches.

Thanks.

-- 
Dmitry
