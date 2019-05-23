From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: silead: Add MSSL0017 to acpi_device_id.
Date: Thu, 23 May 2019 12:55:18 -0700
Message-ID: <20190523195518.GA176265@dtor-ws>
References: <20190523190659.3117-1-danct12@disroot.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190523190659.3117-1-danct12@disroot.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Smith <danct12@disroot.org>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Fri, May 24, 2019 at 02:06:59AM +0700, Daniel Smith wrote:
> On Chuwi Hi10 Plus, the Silead device id is MSSL0017.
> 
> Signed-off-by: Daniel Smith <danct12@disroot.org>

Applied keeping Hans' reviewed-by from the previous version; thank you.

> ---
>  drivers/input/touchscreen/silead.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/input/touchscreen/silead.c b/drivers/input/touchscreen/silead.c
> index 09241d4cdebc..06f0eb04a8fd 100644
> --- a/drivers/input/touchscreen/silead.c
> +++ b/drivers/input/touchscreen/silead.c
> @@ -617,6 +617,7 @@ static const struct acpi_device_id silead_ts_acpi_match[] = {
>  	{ "MSSL1680", 0 },
>  	{ "MSSL0001", 0 },
>  	{ "MSSL0002", 0 },
> +	{ "MSSL0017", 0 },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(acpi, silead_ts_acpi_match);
> -- 
> 2.21.0
> 

-- 
Dmitry
