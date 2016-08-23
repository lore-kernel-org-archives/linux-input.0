From: ulrik.debie-os@e2big.org
Subject: Re: [PATCHv3 2/2] input/serio/i8042.c: Skipt selftest on ASUS laptops
Date: Tue, 23 Aug 2016 22:20:08 +0200
Message-ID: <20160823202007.GA3598@lantern>
References: <1470799545-1102-1-git-send-email-marcos.souza.org@gmail.com>
 <1470799545-1102-3-git-send-email-marcos.souza.org@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from e2big.org ([198.61.226.133]:53510 "EHLO e2big.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752449AbcHWUVb (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 23 Aug 2016 16:21:31 -0400
Content-Disposition: inline
In-Reply-To: <1470799545-1102-3-git-send-email-marcos.souza.org@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Marcos Paulo de Souza <marcos.souza.org@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org

Hi Marcos,

Given the fact that there are already Asus laptops that do not have a problem
with self test, is there no chance of regression on those that they would stop functioning with this patch ?

Anyone with a Asus K53SV, G46VW, G750JX, TP500LN, X750JN, UX31 or UX32VD wants to give this patch a try ?

Thanks,
Kind regards

On Wed, Aug 10, 2016 at 12:25:45AM -0300, Marcos Paulo de Souza wrote:
> Date:	Wed, 10 Aug 2016 00:25:45 -0300
> From: Marcos Paulo de Souza <marcos.souza.org@gmail.com>
> To: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
> Cc: Marcos Paulo de Souza <marcos.souza.org@gmail.com>
> Subject: [PATCHv3 2/2] input/serio/i8042.c: Skipt selftest on ASUS laptops
> X-Mailer: git-send-email 2.7.4
> X-Mailing-List:	linux-input@vger.kernel.org
> 
> On suspend/resume cycle, selftest is executed to reset i8042 controller. But
> when this is done in Asus devices, posterior calls to detect/init functions
> to elantech driver fails. Skipping selftest fixes this problem.
> 
> An easier step to reproduce this problem is adding i8042.reset=1 as a kernel
> parameter. On Asus laptops, it'll make the system to start with the
> touchpad already stuck, since psmouse_probe forcibly calls the
> selftest function.
> 
> This patch was inspired by John Hiesey's change[1], but, since this problem
> affects a lot of models of Asus (A455LD, K401LB, K501LX, V502LX, X302LA, X450LCP,
> X455LAB, X455LDB, X455LF, V502LX), let's just disable self tests for any Asus laptop.
> 
> [1]: https://marc.info/?l=linux-input&m=144312209020616&w=2
> 
> Fixes: "ETPS/2 Elantech Touchpad dies after resume from suspend" (https://bugzilla.kernel.org/show_bug.cgi?id=107971)
> 
> Signed-off-by: Marcos Paulo de Souza <marcos.souza.org@gmail.com>
> ---
>  drivers/input/serio/i8042-x86ia64io.h | 21 +++++++++++++++++--
>  drivers/input/serio/i8042.c           | 38 +++++++++++++++++++++++++++++------
>  2 files changed, 51 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/input/serio/i8042-x86ia64io.h b/drivers/input/serio/i8042-x86ia64io.h
> index 68f5f4a..43008b6 100644
> --- a/drivers/input/serio/i8042-x86ia64io.h
> +++ b/drivers/input/serio/i8042-x86ia64io.h
> @@ -510,6 +510,17 @@ static const struct dmi_system_id __initconst i8042_dmi_nomux_table[] = {
>  	{ }
>  };
>  
> +/*
> + * On Asus laptops, just running self tests cause problems.
> + */
> +static const struct dmi_system_id __initconst i8042_dmi_noselftest_table[] = {
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
> +		},
> +	},
> +	{ }
> +};
>  static const struct dmi_system_id __initconst i8042_dmi_reset_table[] = {
>  	{
>  		/* MSI Wind U-100 */
> @@ -1076,8 +1087,14 @@ static int __init i8042_platform_init(void)
>  #endif
>  
>  #ifdef CONFIG_X86
> -	if (dmi_check_system(i8042_dmi_reset_table))
> -		i8042_reset = true;
> +	/* Honor module parameter when value is not default */
> +	if (i8042_reset == I8042_RESET_ON_RESUME) {
> +		if (dmi_check_system(i8042_dmi_reset_table))
> +			i8042_reset = I8042_RESET_ALWAYS;
> +
> +		if (dmi_check_system(i8042_dmi_noselftest_table))
> +			i8042_reset = I8042_RESET_NEVER;
> +	}
>  
>  	if (dmi_check_system(i8042_dmi_noloop_table))
>  		i8042_noloop = true;
> diff --git a/drivers/input/serio/i8042.c b/drivers/input/serio/i8042.c
> index b4d3408..0dfe754 100644
> --- a/drivers/input/serio/i8042.c
> +++ b/drivers/input/serio/i8042.c
> @@ -48,9 +48,32 @@ static bool i8042_unlock;
>  module_param_named(unlock, i8042_unlock, bool, 0);
>  MODULE_PARM_DESC(unlock, "Ignore keyboard lock.");
>  
> -static bool i8042_reset;
> -module_param_named(reset, i8042_reset, bool, 0);
> -MODULE_PARM_DESC(reset, "Reset controller during init and cleanup.");
> +enum i8042_controller_reset_mode {
> +	I8042_RESET_NEVER,
> +	I8042_RESET_ALWAYS,
> +	I8042_RESET_ON_RESUME
> +};
> +static unsigned int i8042_reset = I8042_RESET_ON_RESUME;
> +static int i8042_set_reset(const char *val, const struct kernel_param *kp)
> +{
> +	unsigned int ret = I8042_RESET_ON_RESUME;
> +        if (!val || !strncmp(val, "1", 1) || !strncasecmp(val, "y", 1))
> +		ret = I8042_RESET_ALWAYS;
> +	else if (!strncmp(val, "0", 1) || !strncasecmp(val, "n", 1))
> +		ret = I8042_RESET_NEVER;
> +
> +        *((unsigned int *)kp->arg) = ret;
> +
> +        return 0;
> +}
> +
> +static const struct kernel_param_ops param_ops_reset_param = {
> +	.flags = KERNEL_PARAM_OPS_FL_NOARG,
> +	.set = i8042_set_reset,
> +};
> +#define param_check_reset_param(name, p) __param_check(name, p, unsigned int)
> +module_param_named(reset, i8042_reset, reset_param, 0);
> +MODULE_PARM_DESC(reset, "Reset controller on resume, cleanup or both");
>  
>  static bool i8042_direct;
>  module_param_named(direct, i8042_direct, bool, 0);
> @@ -890,6 +913,9 @@ static int i8042_controller_selftest(void)
>  	unsigned char param;
>  	int i = 0;
>  
> +	if (i8042_reset == I8042_RESET_NEVER)
> +		return 0;
> +
>  	/*
>  	 * We try this 5 times; on some really fragile systems this does not
>  	 * take the first time...
> @@ -1044,7 +1070,7 @@ static void i8042_controller_reset(bool force_reset)
>   * Reset the controller if requested.
>   */
>  
> -	if (i8042_reset || force_reset)
> +	if (i8042_reset != I8042_RESET_NEVER || force_reset)
>  		i8042_controller_selftest();
>  
>  /*
> @@ -1118,7 +1144,7 @@ static int i8042_controller_resume(bool force_reset)
>  	if (error)
>  		return error;
>  
> -	if (i8042_reset || force_reset) {
> +	if (i8042_reset != I8042_RESET_NEVER || force_reset) {
>  		error = i8042_controller_selftest();
>  		if (error)
>  			return error;
> @@ -1481,7 +1507,7 @@ static int __init i8042_probe(struct platform_device *dev)
>  
>  	i8042_platform_device = dev;
>  
> -	if (i8042_reset) {
> +	if (i8042_reset == I8042_RESET_ALWAYS) {
>  		error = i8042_controller_selftest();
>  		if (error)
>  			return error;
> -- 
> 2.7.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
