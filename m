From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH] platform/x86: silead_dmi: Add entry for the Teclast X98
 Plus II
Date: Tue, 2 Jan 2018 16:34:27 +0100
Message-ID: <997c8889-4e7f-89e3-b8a5-0cccd3cf5000@redhat.com>
References: <20180102134239.3579-1-paul@crapouillou.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <20180102134239.3579-1-paul@crapouillou.net>
Content-Language: en-US
Sender: platform-driver-x86-owner@vger.kernel.org
To: Paul Cercueil <paul@crapouillou.net>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>
Cc: linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi,

On 02-01-18 14:42, Paul Cercueil wrote:
> Add touchscreen platform data for the Teclast X98 Plus II tablet.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>

Looks good to me:

Acked-by: Hans de Goede <hdegoede@redhat.com>

You should probably send a v2 rebased on top of:

http://git.infradead.org/users/dvhart/linux-platform-drivers-x86.git/shortlog/refs/heads/review-andy

Which has several additional entries compared to the version you
used as base.

Regards,

Hans



> ---
>   drivers/platform/x86/silead_dmi.c | 24 ++++++++++++++++++++++++
>   1 file changed, 24 insertions(+)
> 
> diff --git a/drivers/platform/x86/silead_dmi.c b/drivers/platform/x86/silead_dmi.c
> index 266535c2a72f..ebe8692a2868 100644
> --- a/drivers/platform/x86/silead_dmi.c
> +++ b/drivers/platform/x86/silead_dmi.c
> @@ -171,6 +171,22 @@ static const struct silead_ts_dmi_data digma_citi_e200_data = {
>   	.properties	= digma_citi_e200_props,
>   };
>   
> +static const struct property_entry teclast_x98plus2_props[] = {
> +	PROPERTY_ENTRY_U32("touchscreen-size-x", 2048),
> +	PROPERTY_ENTRY_U32("touchscreen-size-y", 1280),
> +	PROPERTY_ENTRY_BOOL("touchscreen-inverted-x"),
> +	PROPERTY_ENTRY_BOOL("touchscreen-inverted-y"),
> +	PROPERTY_ENTRY_STRING("firmware-name",
> +			      "gsl1686-teclast_x98plus2.fw"),
> +	PROPERTY_ENTRY_U32("silead,max-fingers", 10),
> +	{ }
> +};
> +
> +static const struct silead_ts_dmi_data teclast_x98plus2_data = {
> +	.acpi_name	= "MSSL1680:00",
> +	.properties	= teclast_x98plus2_props,
> +};
> +
>   static const struct dmi_system_id silead_ts_dmi_table[] = {
>   	{
>   		/* CUBE iwork8 Air */
> @@ -271,6 +287,14 @@ static const struct dmi_system_id silead_ts_dmi_table[] = {
>   			DMI_MATCH(DMI_BOARD_NAME, "Cherry Trail CR"),
>   		},
>   	},
> +	{
> +		/* Teclast X98 Plus II */
> +		.driver_data = (void *)&teclast_x98plus2_data,
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "TECLAST"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "X98 Plus II"),
> +		},
> +	},
>   	{ },
>   };
>   
> 
