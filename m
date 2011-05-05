From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH V2 3/3] input: pmic8xxx_pwrkey: Add support for power key
Date: Thu, 5 May 2011 09:08:20 -0700
Message-ID: <20110505160819.GD27251@core.coreip.homeip.net>
References: <1304573604-21843-1-git-send-email-aghayal@codeaurora.org>
 <1304573604-21843-3-git-send-email-aghayal@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1304573604-21843-3-git-send-email-aghayal@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Anirudh Ghayal <aghayal@codeaurora.org>
Cc: linux-input@vger.kernel.org, linux-arm-msm@vger.kernel.org, Samuel Ortiz <sameo@linux.intel.com>, Trilok Soni <tsoni@codeaurora.org>
List-Id: linux-input@vger.kernel.org

Hi Anirudh,

On Thu, May 05, 2011 at 11:03:24AM +0530, Anirudh Ghayal wrote:
> From: Trilok Soni <tsoni@codeaurora.org>
> 
> Add support for PMIC8XXX power key driven over dedicated
> KYPD_PWR_N pin. It allows the user to specify the amount
> of time by which the power key reporting can be delayed.
> 
> +
> +static irqreturn_t pwrkey_press_irq(int irq, void *_pwrkey)
> +{
> +	struct pmic8xxx_pwrkey *pwrkey = _pwrkey;
> +	const struct pm8xxx_pwrkey_platform_data *pdata = pwrkey->pdata;
> +	unsigned long flags;
> +
> +	/* no pwrkey time duration, means no screen lock key simulation */
> +	if (!pwrkey->pdata->pwrkey_time_ms) {
> +		input_report_key(pwrkey->pwr, KEY_POWER, 1);
> +		input_sync(pwrkey->pwr);
> +		return IRQ_HANDLED;
> +	}
> +
> +	spin_lock_irqsave(&pwrkey->lock, flags);
> +
> +	input_report_key(pwrkey->pwr, KEY_SCREENLOCK, 1);
> +	input_sync(pwrkey->pwr);
> +

I am very sorry for misleading Trilok and you earlier but I think this
kind of transformation should be done in your userspace framework. Have
the driver emit KEY_SCREENLOCK and have userspace initiate device
shutdown if it detects that KEY_SCREENLOCK is pressed for longer than X
seconds.

Thanks.

-- 
Dmitry
