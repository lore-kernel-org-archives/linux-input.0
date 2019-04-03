From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v7 4/4] Input: goodix - Add GT5663 CTP support
Date: Wed, 3 Apr 2019 16:09:39 -0700
Message-ID: <20190403230939.GH53104@dtor-ws>
References: <20190321082104.2874-1-jagan@amarulasolutions.com>
 <20190321082104.2874-5-jagan@amarulasolutions.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190321082104.2874-5-jagan@amarulasolutions.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jagan Teki <jagan@amarulasolutions.com>
Cc: Bastien Nocera <hadess@hadess.net>, Rob Herring <robh+dt@kernel.org>, Henrik Rydberg <rydberg@bitmath.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, linux-amarula@amarulasolutions.com, Michael Trimarchi <michael@amarulasolutions.com>
List-Id: linux-input@vger.kernel.org

On Thu, Mar 21, 2019 at 01:51:04PM +0530, Jagan Teki wrote:
> GT5663 is capacitive touch controller with customized smart
> wakeup gestures.
> 
> Add support for it by adding compatible and supported chip data.
> 
> The chip data on GT5663 is similar to GT1151, like
> - config data register has 0x8050 address
> - config data register max len is 240
> - config data checksum has 16-bit
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>

Applied, thank you.

> ---
>  drivers/input/touchscreen/goodix.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/input/touchscreen/goodix.c b/drivers/input/touchscreen/goodix.c
> index de5b80a08f41..c558b091749c 100644
> --- a/drivers/input/touchscreen/goodix.c
> +++ b/drivers/input/touchscreen/goodix.c
> @@ -219,6 +219,7 @@ static const struct goodix_chip_data *goodix_get_chip_data(u16 id)
>  {
>  	switch (id) {
>  	case 1151:
> +	case 5663:
>  	case 5688:
>  		return &gt1x_chip_data;
>  
> @@ -1003,6 +1004,7 @@ MODULE_DEVICE_TABLE(acpi, goodix_acpi_match);
>  #ifdef CONFIG_OF
>  static const struct of_device_id goodix_of_match[] = {
>  	{ .compatible = "goodix,gt1151" },
> +	{ .compatible = "goodix,gt5663" },
>  	{ .compatible = "goodix,gt5688" },
>  	{ .compatible = "goodix,gt911" },
>  	{ .compatible = "goodix,gt9110" },
> -- 
> 2.18.0.321.gffc6fa0e3
> 

-- 
Dmitry
