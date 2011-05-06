From: Anirudh Ghayal <aghayal@codeaurora.org>
Subject: Re: [PATCH V2 3/3] input: pmic8xxx_pwrkey: Add support for power
 key
Date: Fri, 06 May 2011 19:02:38 +0530
Message-ID: <4DC3F876.6010008@codeaurora.org>
References: <1304573604-21843-1-git-send-email-aghayal@codeaurora.org> <1304573604-21843-3-git-send-email-aghayal@codeaurora.org> <20110505160819.GD27251@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20110505160819.GD27251@core.coreip.homeip.net>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-arm-msm@vger.kernel.org, Samuel Ortiz <sameo@linux.intel.com>, Trilok Soni <tsoni@codeaurora.org>
List-Id: linux-input@vger.kernel.org

Hi Dmitry,

On 5/5/2011 9:38 PM, Dmitry Torokhov wrote:
> Hi Anirudh,
>
> On Thu, May 05, 2011 at 11:03:24AM +0530, Anirudh Ghayal wrote:
>> From: Trilok Soni<tsoni@codeaurora.org>
>>
>> Add support for PMIC8XXX power key driven over dedicated
>> KYPD_PWR_N pin. It allows the user to specify the amount
>> of time by which the power key reporting can be delayed.
>>
>> +
>> +static irqreturn_t pwrkey_press_irq(int irq, void *_pwrkey)
>> +{
>> +	struct pmic8xxx_pwrkey *pwrkey = _pwrkey;
>> +	const struct pm8xxx_pwrkey_platform_data *pdata = pwrkey->pdata;
>> +	unsigned long flags;
>> +
>> +	/* no pwrkey time duration, means no screen lock key simulation */
>> +	if (!pwrkey->pdata->pwrkey_time_ms) {
>> +		input_report_key(pwrkey->pwr, KEY_POWER, 1);
>> +		input_sync(pwrkey->pwr);
>> +		return IRQ_HANDLED;
>> +	}
>> +
>> +	spin_lock_irqsave(&pwrkey->lock, flags);
>> +
>> +	input_report_key(pwrkey->pwr, KEY_SCREENLOCK, 1);
>> +	input_sync(pwrkey->pwr);
>> +
>
> I am very sorry for misleading Trilok and you earlier but I think this
> kind of transformation should be done in your userspace framework. Have
> the driver emit KEY_SCREENLOCK and have userspace initiate device
> shutdown if it detects that KEY_SCREENLOCK is pressed for longer than X
> seconds.

After giving this a further thought, I agree that this handling should 
be in the userspace. I will submit a new patch with the changes.

>
> Thanks.
>

Thank you,
~Anirudh
