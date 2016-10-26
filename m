From: Andrew Duggan <aduggan@synaptics.com>
Subject: Re: [PATCH v2] Input: synaptics-rmi4 - stop scanning PDT after two
 empty pages
Date: Wed, 26 Oct 2016 12:27:30 -0700
Message-ID: <48c87bf2-a2ae-9964-fe01-e4a511c1ea2c@synaptics.com>
References: <1477427791-1094-1-git-send-email-nick@shmanahar.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1477427791-1094-1-git-send-email-nick@shmanahar.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Nick Dyer <nick@shmanahar.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Christopher Heiny <cheiny@synaptics.com>, Guenter Roeck <linux@roeck-us.net>
Cc: Chris Healy <cphealy@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On 10/25/2016 01:36 PM, Nick Dyer wrote:
> We have encountered some RMI4 firmwares where there are blank pages in
> between PDT pages which contain functions. This change makes them
> correctly enumerate all functions on the device.
>
> Tested on S7817 (has empty page 2).
>
> Signed-off-by: Nick Dyer <nick@shmanahar.org>

Reviewed-by: Andrew Duggan <aduggan@synaptics.com>

> ---
>   drivers/input/rmi4/rmi_driver.c | 16 ++++++++++++++--
>   1 file changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_driver.c
> index 4a88312..425bd19 100644
> --- a/drivers/input/rmi4/rmi_driver.c
> +++ b/drivers/input/rmi4/rmi_driver.c
> @@ -422,6 +422,7 @@ static void rmi_driver_copy_pdt_to_fd(const struct pdt_entry *pdt,
>   
>   static int rmi_scan_pdt_page(struct rmi_device *rmi_dev,
>   			     int page,
> +			     int *empty_pages,
>   			     void *ctx,
>   			     int (*callback)(struct rmi_device *rmi_dev,
>   					     void *ctx,
> @@ -449,7 +450,16 @@ static int rmi_scan_pdt_page(struct rmi_device *rmi_dev,
>   			return retval;
>   	}
>   
> -	return (data->f01_bootloader_mode || addr == pdt_start) ?
> +	/*
> +	 * Count number of empty PDT pages. If a gap of two pages
> +	 * or more is found, stop scanning.
> +	 */
> +	if (addr == pdt_start)
> +		++*empty_pages;
> +	else
> +		*empty_pages = 0;
> +
> +	return (data->f01_bootloader_mode || *empty_pages >= 2) ?
>   					RMI_SCAN_DONE : RMI_SCAN_CONTINUE;
>   }
>   
> @@ -459,10 +469,12 @@ static int rmi_scan_pdt(struct rmi_device *rmi_dev, void *ctx,
>   					const struct pdt_entry *entry))
>   {
>   	int page;
> +	int empty_pages = 0;
>   	int retval = RMI_SCAN_DONE;
>   
>   	for (page = 0; page <= RMI4_MAX_PAGE; page++) {
> -		retval = rmi_scan_pdt_page(rmi_dev, page, ctx, callback);
> +		retval = rmi_scan_pdt_page(rmi_dev, page, &empty_pages,
> +					   ctx, callback);
>   		if (retval != RMI_SCAN_CONTINUE)
>   			break;
>   	}
