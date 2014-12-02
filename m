From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] i8042: prevent the loading of the i8042 driver on Intel
 NUC D54250WYK
Date: Tue, 2 Dec 2014 15:22:18 -0800
Message-ID: <20141202232218.GB6207@localhost>
References: <1417508822-8243-1-git-send-email-todor.minchev@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f169.google.com ([209.85.192.169]:60229 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750931AbaLCF0U (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 3 Dec 2014 00:26:20 -0500
Content-Disposition: inline
In-Reply-To: <1417508822-8243-1-git-send-email-todor.minchev@intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Todor Minchev <todor.minchev@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On Tue, Dec 02, 2014 at 08:27:02AM +0000, Todor Minchev wrote:
> The Intel NUC D54250WYK has no PS/2 controller, however the DSDT declares
> PS/2 devices which trigger the loading of the i8042 driver.
> 
> Signed-off-by: Todor Minchev <todor.minchev@intel.com>

Applied, thank you.

> ---
>  drivers/input/serio/i8042-x86ia64io.h | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/input/serio/i8042-x86ia64io.h b/drivers/input/serio/i8042-x86ia64io.h
> index faeeb13..5182008 100644
> --- a/drivers/input/serio/i8042-x86ia64io.h
> +++ b/drivers/input/serio/i8042-x86ia64io.h
> @@ -579,6 +579,13 @@ static const struct dmi_system_id __initconst i8042_dmi_nopnp_table[] = {
>  		},
>  	},
>  	{
> +		/* Intel NUC D54250WYK */
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_NAME, "D54250WYK"),
> +			DMI_MATCH(DMI_BOARD_VENDOR, "Intel Corporation"),
> +		},
> +	},
> +	{
>  		/* MSI Wind U-100 */
>  		.matches = {
>  			DMI_MATCH(DMI_BOARD_NAME, "U-100"),
> -- 
> 2.1.3
> 

-- 
Dmitry
