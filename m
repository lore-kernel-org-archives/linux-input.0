From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v4] platform/x86: touchscreen_dmi: Add info for the ONDA
 V891W Dual OS tablet
Date: Mon, 18 Jun 2018 10:43:48 +0200
Message-ID: <342c314e-6e9f-aefc-3ec0-300b53071089@redhat.com>
References: <20180617235812.18596-1-youling257@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180617235812.18596-1-youling257@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: youling257 <youling257@gmail.com>, linux-kernel@vger.kernel.org
Cc: platform-driver-x86@vger.kernel.org, linux-input@vger.kernel.org, andy@infradead.org, dvhart@infradead.org
List-Id: linux-input@vger.kernel.org

Hi,

On 18-06-18 01:58, youling257 wrote:
> Add touchscreen info for the ONDA V891W Dual OS tablet

Nitpick: still missing a period '.' at the end, this should be:

Add touchscreen info for the ONDA V891W Dual OS tablet.

> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> Signed-off-by: youling257 <youling257@gmail.com>

As Andy indicated you need to use your real name when submitting
kernel patches, not an internet alias (or a nick).

So you need to re-submit this with something like this:

Signed-off-by: FirstName LastName <youling257@gmail.com>

Regards,

Hans




> ---
>   drivers/platform/x86/touchscreen_dmi.c | 27 ++++++++++++++++++++++++++
>   1 file changed, 27 insertions(+)
> 
> diff --git a/drivers/platform/x86/touchscreen_dmi.c b/drivers/platform/x86/touchscreen_dmi.c
> index 6284946cb0d1..2ad9327c8c0f 100644
> --- a/drivers/platform/x86/touchscreen_dmi.c
> +++ b/drivers/platform/x86/touchscreen_dmi.c
> @@ -221,6 +221,24 @@ static const struct ts_dmi_data onda_v891w_v1_data = {
>   	.properties	= onda_v891w_v1_props,
>   };
>   
> +static const struct property_entry onda_v891w_v3_props[] = {
> +	PROPERTY_ENTRY_U32("touchscreen-min-x", 35),
> +	PROPERTY_ENTRY_U32("touchscreen-min-y", 15),
> +	PROPERTY_ENTRY_U32("touchscreen-size-x", 1625),
> +	PROPERTY_ENTRY_U32("touchscreen-size-y", 1135),
> +	PROPERTY_ENTRY_BOOL("touchscreen-inverted-y"),
> +	PROPERTY_ENTRY_STRING("firmware-name",
> +			      "gsl3676-onda-v891w-v3.fw"),
> +	PROPERTY_ENTRY_U32("silead,max-fingers", 10),
> +	PROPERTY_ENTRY_BOOL("silead,home-button"),
> +	{ }
> +};
> +
> +static const struct ts_dmi_data onda_v891w_v3_data = {
> +	.acpi_name	= "MSSL1680:00",
> +	.properties	= onda_v891w_v3_props,
> +};
> +
>   static const struct property_entry pipo_w2s_props[] = {
>   	PROPERTY_ENTRY_U32("touchscreen-size-x", 1660),
>   	PROPERTY_ENTRY_U32("touchscreen-size-y", 880),
> @@ -481,6 +499,15 @@ static const struct dmi_system_id touchscreen_dmi_table[] = {
>   			DMI_EXACT_MATCH(DMI_BIOS_VERSION, "ONDA.W89EBBN08"),
>   		},
>   	},
> +	{
> +		/* ONDA V891w Dual OS P891DCF2V1A01274 64GB */
> +		.driver_data = (void *)&onda_v891w_v3_data,
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Insyde"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "ONDA Tablet"),
> +			DMI_MATCH(DMI_BIOS_VERSION, "ONDA.D890HBBNR0A"),
> +		},
> +	},
>   	{
>   		/* Pipo W2S */
>   		.driver_data = (void *)&pipo_w2s_data,
> 
