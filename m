From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: i8042 - add Gigabyte P57 to the keyboard reset
 table
Date: Fri, 15 Sep 2017 09:55:51 -0700
Message-ID: <20170915165551.GA16550@dtor-ws>
References: <20170712033953.16318-1-kai.heng.feng@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170712033953.16318-1-kai.heng.feng@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wed, Jul 12, 2017 at 11:39:53AM +0800, Kai-Heng Feng wrote:
> Similar to other Gigabyte laptops, the touchpad on P57 requires a
> keyboard reset to detect Elantech touchpad correctly.
> 
> BugLink: https://bugs.launchpad.net/bugs/1594214
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

Applied, thank you.

> ---
>  drivers/input/serio/i8042-x86ia64io.h | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/input/serio/i8042-x86ia64io.h b/drivers/input/serio/i8042-x86ia64io.h
> index 09720d950686..1c6a49b5b93d 100644
> --- a/drivers/input/serio/i8042-x86ia64io.h
> +++ b/drivers/input/serio/i8042-x86ia64io.h
> @@ -833,6 +833,13 @@ static const struct dmi_system_id __initconst i8042_dmi_kbdreset_table[] = {
>  		},
>  	},
>  	{
> +		/* Gigabyte P57 - Elantech touchpad */
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "GIGABYTE"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "P57"),
> +		},
> +	},
> +	{
>  		/* Schenker XMG C504 - Elantech touchpad */
>  		.matches = {
>  			DMI_MATCH(DMI_SYS_VENDOR, "XMG"),
> -- 
> 2.13.2
> 

-- 
Dmitry
