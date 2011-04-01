From: Anirudh Ghayal <aghayal@codeaurora.org>
Subject: Re: [rtc-linux] Re: [PATCH 2/3] input: pmic8xxx_pwrkey: Add support
 for power key
Date: Fri, 01 Apr 2011 14:53:18 +0530
Message-ID: <4D959986.2040108@codeaurora.org>
References: <1301158345-22206-1-git-send-email-aghayal@codeaurora.org> <1301158345-22206-3-git-send-email-aghayal@codeaurora.org> <4D90F631.908@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4D90F631.908@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>, linux-input@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, Trilok Soni <tsoni@codeaurora.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
List-Id: linux-input@vger.kernel.org

Hi Stephen,

Thanks for reviewing. I will submit a V2 patch with the changes.

On 3/29/2011 2:27 AM, Stephen Boyd wrote:
> On 3/26/2011 9:52 AM, Anirudh Ghayal wrote:
>> +static void pmic8xxx_pwrkey_timer(unsigned long handle)
>> +{
>> +	unsigned long flags;
>> +	struct pmic8xxx_pwrkey *pwrkey = (struct pmic8xxx_pwrkey *)handle;
>> +
>> +	spin_lock_irqsave(&pwrkey->lock, flags);
>> +	pwrkey->key_pressed = true;
>> +
>> +	input_report_key(pwrkey->pwr, KEY_POWER, 1);
>> +	input_sync(pwrkey->pwr);
>> +	spin_unlock_irqrestore(&pwrkey->lock, flags);
>> +}
>> +
>>
> [snip]
>> +
>> +static irqreturn_t pwrkey_release_irq(int irq, void *_pwrkey)
>> +{
>> +	struct pmic8xxx_pwrkey *pwrkey = _pwrkey;
>> +	unsigned long flags;
>> +
>> +	/* no pwrkey time, means no delay in pwr key reporting */
>> +	if (!pwrkey->pdata->pwrkey_time_ms) {
>> +		input_report_key(pwrkey->pwr, KEY_POWER, 0);
>> +		input_sync(pwrkey->pwr);
>> +		return IRQ_HANDLED;
>> +	}
>> +
>> +	spin_lock_irqsave(&pwrkey->lock, flags);
>> +	del_timer_sync(&pwrkey->timer);
>
> Can you call del_timer_sync() while holding the lock that your timer
> function also acquires? I thought lockdep would have complained loudly
> about that but I'm not sure. It looks like a deadlock scenario.
Right. I will move del_timer_sync outside the spinlock.

>
>> +static int __devinit pmic8xxx_pwrkey_probe(struct platform_device *pdev)
>> +{
>>
> [snip]
>> +
>> +	if (pdata->kpd_trigger_delay_us>  62500) {
>> +		dev_err(&pdev->dev, "invalid pwr key trigger delay\n");
>
> Nitpick: Can you spell out "power" here instead of pwr? Or use
> "kpd_trigger_delay_us" instead.
Ok.

>
>> +		return -EINVAL;
>> +	}
>> +
>> +	if (pdata->pwrkey_time_ms&&
>> +	     (pdata->pwrkey_time_ms<  500 || pdata->pwrkey_time_ms>  1000)) {
>> +		dev_err(&pdev->dev, "invalid pwr key time supplied\n");
>
Ok.
> Ditto
>
>> +
>> +	pon_cntl&= ~PON_CNTL_TRIG_DELAY_MASK;
>> +	pon_cntl |= (delay&  PON_CNTL_TRIG_DELAY_MASK);
>> +	pon_cntl |= (pdata->pull_up ? PON_CNTL_PULL_UP : ~PON_CNTL_PULL_UP);
>
> Did you just set a bunch of bits you didn't want to when pdata->pull_up
> == false?
Oops right. I will fix this.
>

Thank you,
~Anirudh

-- 
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
