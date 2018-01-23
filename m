From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH] Add touchscreen platform data for the Teclast X3 Plus
 tablet.
Date: Tue, 23 Jan 2018 15:50:29 +0100
Message-ID: <4e89391a-12ab-1d58-7ccb-03b403fd858d@redhat.com>
References: <1516706288-177-1-git-send-email-ponces26@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <1516706288-177-1-git-send-email-ponces26@gmail.com>
Content-Language: en-US
Sender: platform-driver-x86-owner@vger.kernel.org
To: Alberto Ponces <ponces26@gmail.com>, linux-input@vger.kernel.org
Cc: Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi,

Nitpick, please change the patch subject to:

platform/x86: silead_dmi: Add touchscreen platform data for the Teclast X3 Plus tablet

On 23-01-18 12:18, Alberto Ponces wrote:
> Add touchscreen platform data for the Teclast X3 Plus tablet. > > Signed-off-by: Alberto Ponces <ponces26@gmail.com>
Otherwise looks good to me, so with the subject fixed this is:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

But you should rebase this on top of:

http://git.infradead.org/users/dvhart/linux-platform-drivers-x86.git/shortlog/refs/heads/testing

So that it can be applied cleanly by the platform/x86 maintainers.

Please send a rebased v2 with the fixed subject, you can add
me Reviewed-by to the v2 before sending it.

Regards,

Hans



> ---
>   drivers/platform/x86/silead_dmi.c | 23 +++++++++++++++++++++++
>   1 file changed, 23 insertions(+)
> 
> diff --git a/drivers/platform/x86/silead_dmi.c b/drivers/platform/x86/silead_dmi.c
> index 266535c..d4c1190 100644
> --- a/drivers/platform/x86/silead_dmi.c
> +++ b/drivers/platform/x86/silead_dmi.c
> @@ -171,6 +171,20 @@ static const struct silead_ts_dmi_data digma_citi_e200_data = {
>   	.properties	= digma_citi_e200_props,
>   };
>   
> +static const struct property_entry teclast_x3_plus_props[] = {
> +	PROPERTY_ENTRY_U32("touchscreen-size-x", 1980),
> +	PROPERTY_ENTRY_U32("touchscreen-size-y", 1500),
> +	PROPERTY_ENTRY_STRING("firmware-name", "gsl1680-teclast-x3-plus.fw"),
> +	PROPERTY_ENTRY_U32("silead,max-fingers", 10),
> +	PROPERTY_ENTRY_BOOL("silead,home-button"),
> +	{ }
> +};
> +
> +static const struct silead_ts_dmi_data teclast_x3_plus_data = {
> +	.acpi_name	= "MSSL1680:00",
> +	.properties	= teclast_x3_plus_props,
> +};
> +
>   static const struct dmi_system_id silead_ts_dmi_table[] = {
>   	{
>   		/* CUBE iwork8 Air */
> @@ -271,6 +285,15 @@ static const struct dmi_system_id silead_ts_dmi_table[] = {
>   			DMI_MATCH(DMI_BOARD_NAME, "Cherry Trail CR"),
>   		},
>   	},
> +	{
> +		/* Teclast X3 Plus */
> +		.driver_data = (void *)&teclast_x3_plus_data,
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "TECLAST"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "X3 Plus"),
> +			DMI_MATCH(DMI_BOARD_NAME, "X3 Plus"),
> +		},
> +	},
>   	{ },
>   };
>   
> 
