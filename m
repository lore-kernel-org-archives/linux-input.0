From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH V1] da9052: ONKEY: use correct register bit for key status
Date: Tue, 11 Feb 2014 08:28:57 -0800
Message-ID: <20140211162857.GA12106@core.coreip.homeip.net>
References: <201402111610.s1BGAXJo056493@swsrvapps-02.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201402111610.s1BGAXJo056493@swsrvapps-02.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Anthony Olech <anthony.olech.opensource@diasemi.com>" <Anthony.Olech.OpenSource@diasemi.com>
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, David Dajun Chen <david.chen@diasemi.com>
List-Id: linux-input@vger.kernel.org

Hi Anthony,

On Thu, Feb 06, 2014 at 03:19:49PM +0000, Anthony Olech <anthony.olech.opensource@diasemi.com> wrote:
> The wrong register bit of the DA9052/3 PMIC registers was
> used to determine the status on the ONKEY.
> 
> Signed-off-by: Anthony Olech <anthony.olech.opensource@diasemi.com>
> Signed-off-by: David Dajun Chen <david.chen@diasemi.com>
> ---
> 
> This patch is relative to linux-next repository tag next-20140206
> 
> The bug that this patch fixes affects only the DA9052 ONKEY driver.
> 
> The problem was detected whilst running a scripted set of functional
> regression tests whilst investigating a different problem.
> 
> This patch has been test compiled on an amd64 server for both x86
> and arm targets.
> 
> This patch has been spot verified using an SMDK6410 platform
> fly-wired to a Dialog da9053 EVB.
> 
>  drivers/input/misc/da9052_onkey.c |   14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/input/misc/da9052_onkey.c b/drivers/input/misc/da9052_onkey.c
> index 1f695f2..7e78334 100644
> --- a/drivers/input/misc/da9052_onkey.c
> +++ b/drivers/input/misc/da9052_onkey.c
> @@ -27,19 +27,23 @@ struct da9052_onkey {
>  
>  static void da9052_onkey_query(struct da9052_onkey *onkey)
>  {
> -	int key_stat;
> +	int ret, key_stat;
>  
> -	key_stat = da9052_reg_read(onkey->da9052, DA9052_EVENT_B_REG);
> -	if (key_stat < 0) {
> +	ret = da9052_reg_read(onkey->da9052, DA9052_STATUS_A_REG);
> +	if (ret < 0) {
>  		dev_err(onkey->da9052->dev,
> -			"Failed to read onkey event %d\n", key_stat);
> +			"Failed to read onkey event err=%d\n", ret);
> +		key_stat = false;

Why do you need this assignment? Also, key_stat is integer, why are we
using boolean values for it?

>  	} else {
>  		/*
>  		 * Since interrupt for deassertion of ONKEY pin is not
>  		 * generated, onkey event state determines the onkey
>  		 * button state.
>  		 */
> -		key_stat &= DA9052_EVENTB_ENONKEY;
> +		if (ret & DA9052_STATUSA_NONKEY)
> +			key_stat = false;
> +		else
> +			key_stat = true;

It seems to me that the relevant changes are replacement of
DA9052_EVENT_B_REG -> DA9052_STATUS_A_REG in da9052_reg_read() and doing:

		key_stat &= DA9052_STATUSA_NONKEY;
		input_report_key(onkey->input, KEY_POWER, !key_stat);

Right?

Thanks.

-- 
Dmitry 
