From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: synaptics add manual min/max quirk for ThinkPad
 X240
Date: Fri, 28 Mar 2014 01:29:31 -0700
Message-ID: <20140328082931.GI22093@core.coreip.homeip.net>
References: <1394278521-6870-1-git-send-email-hdegoede@redhat.com>
 <1394278521-6870-2-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1394278521-6870-2-git-send-email-hdegoede@redhat.com>
Sender: stable-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Christopher Heiny <cheiny@synaptics.com>, Andrew Duggan <aduggan@synaptics.com>, linux-input@vger.kernel.org, Peter Hutterer <peter.hutterer@who-t.net>, Stephen Chandler Paul <thatslyude@gmail.com>, stable@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Sat, Mar 08, 2014 at 12:35:21PM +0100, Hans de Goede wrote:
> This extends Benjamin Tissoires manual min/max quirk table with support for
> the ThinkPad X240.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>


Applied, thank you.

> ---
>  drivers/input/mouse/synaptics.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
> index ff6a4cf..b522bdc 100644
> --- a/drivers/input/mouse/synaptics.c
> +++ b/drivers/input/mouse/synaptics.c
> @@ -1505,6 +1505,14 @@ static const struct dmi_system_id min_max_dmi_table[] __initconst = {
>  		.driver_data = (int []){1024, 5052, 2258, 4832},
>  	},
>  	{
> +		/* Lenovo ThinkPad X240 */
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> +			DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad X240"),
> +		},
> +		.driver_data = (int []){1232, 5710, 1156, 4696},
> +	},
> +	{
>  		/* Lenovo ThinkPad T440s */
>  		.matches = {
>  			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> -- 
> 1.8.4.2
> 

-- 
Dmitry
