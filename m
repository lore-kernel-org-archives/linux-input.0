From: Marcos Paulo de Souza <marcos.souza.org@gmail.com>
Subject: Re: [PATCH] Input: i8042 - add noloop quirk for Dell Embedded Box PC
 3000
Date: Mon, 6 Mar 2017 07:48:18 -0300
Message-ID: <20170306104816.GA28703@xfiles>
References: <20170306100306.8900-1-kai.heng.feng@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170306100306.8900-1-kai.heng.feng@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, Mar 06, 2017 at 06:03:06PM +0800, Kai-Heng Feng wrote:
> The aux port does not get detected without noloop quirk, so external PS/2
> mouse cannot work as result.
> 
> The PS/2 mouse can work with this quirk.
> 
> BugLink: https://bugs.launchpad.net/bugs/1591053
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
>  drivers/input/serio/i8042-x86ia64io.h | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/input/serio/i8042-x86ia64io.h b/drivers/input/serio/i8042-x86ia64io.h
> index 05afd16ea9c9..e856b073d533 100644
> --- a/drivers/input/serio/i8042-x86ia64io.h
> +++ b/drivers/input/serio/i8042-x86ia64io.h
> @@ -120,6 +120,13 @@ static const struct dmi_system_id __initconst i8042_dmi_noloop_table[] = {
>  		},
>  	},
>  	{
> +		/* Dell Embedded Box PC 3000 */
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "Embedded Box PC 3000"),
> +		},
> +	},
> +	{
>  		/* OQO Model 01 */
>  		.matches = {
>  			DMI_MATCH(DMI_SYS_VENDOR, "OQO"),

Reviewed-by: Marcos Paulo de Souza <marcos.souza.org@gmail.com>

> -- 
> 2.12.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Thanks,
	Marcos
