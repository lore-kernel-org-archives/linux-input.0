From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: edt-ft5x06 - fix access to non-existing register
Date: Thu, 7 Sep 2017 14:34:17 -0700
Message-ID: <20170907213417.GD19320@dtor-ws>
References: <1504615523-9663-1-git-send-email-luca@lucaceresoli.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1504615523-9663-1-git-send-email-luca@lucaceresoli.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Luca Ceresoli <luca@lucaceresoli.net>
Cc: linux-input@vger.kernel.org, Lothar =?iso-8859-1?Q?Wa=DFmann?= <LW@KARO-electronics.de>, Manfred Schlaegl <manfred.schlaegl@ginzinger.com>, Rob Herring <robh@kernel.org>, Aniroop Mathur <a.mathur@samsung.com>, Guenter Roeck <linux@roeck-us.net>, Martin Kepplinger <martink@posteo.de>, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tue, Sep 05, 2017 at 02:45:23PM +0200, Luca Ceresoli wrote:
> reg_addr->reg_report_rate is supposed to exist in M06, not M09.
> 
> The driver is written to skip avoids access to non-existing registers
> when the register address is NO_REGISTER (0xff). But
> reg_addr->reg_report_rate is initialized to 0x00 by devm_kzalloc() (in
> edt_ft5x06_ts_probe()) and not changed thereafter. So the checks do
> not work and an access to register 0x00 is done.
> 
> Fix by setting reg_addr->reg_report_rate to NO_REGISTER.
> 
> Also fix the only place where reg_report_rate is checked against zero
> instead of NO_REGISTER.
> 
> Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>

Applied, thank you.

> ---
>  drivers/input/touchscreen/edt-ft5x06.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touchscreen/edt-ft5x06.c
> index f872817e81e4..5bf63f76ddda 100644
> --- a/drivers/input/touchscreen/edt-ft5x06.c
> +++ b/drivers/input/touchscreen/edt-ft5x06.c
> @@ -593,7 +593,7 @@ static int edt_ft5x06_work_mode(struct edt_ft5x06_ts_data *tsdata)
>  				  tsdata->gain);
>  	edt_ft5x06_register_write(tsdata, reg_addr->reg_offset,
>  				  tsdata->offset);
> -	if (reg_addr->reg_report_rate)
> +	if (reg_addr->reg_report_rate != NO_REGISTER)
>  		edt_ft5x06_register_write(tsdata, reg_addr->reg_report_rate,
>  				  tsdata->report_rate);
>  
> @@ -874,6 +874,7 @@ edt_ft5x06_ts_set_regs(struct edt_ft5x06_ts_data *tsdata)
>  
>  	case M09:
>  		reg_addr->reg_threshold = M09_REGISTER_THRESHOLD;
> +		reg_addr->reg_report_rate = NO_REGISTER;
>  		reg_addr->reg_gain = M09_REGISTER_GAIN;
>  		reg_addr->reg_offset = M09_REGISTER_OFFSET;
>  		reg_addr->reg_num_x = M09_REGISTER_NUM_X;
> -- 
> 2.7.4
> 

-- 
Dmitry
