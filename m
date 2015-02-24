From: Jaewon Kim <jaewon02.kim@samsung.com>
Subject: Re: [PATCH v4 4/5] Input: add haptic drvier on max77843
Date: Tue, 24 Feb 2015 09:59:15 +0900
Message-ID: <54EBCCE3.8070404@samsung.com>
References: <1424678991-13978-1-git-send-email-jaewon02.kim@samsung.com>
 <1424678991-13978-5-git-send-email-jaewon02.kim@samsung.com>
 <20150223172658.GA604@dtor-glaptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:11057 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751848AbbBXA7S (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 23 Feb 2015 19:59:18 -0500
In-reply-to: <20150223172658.GA604@dtor-glaptop>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux-input@vger.kernel.org, Inki Dae <inki.dae@samsung.com>, SangBae Lee <sangbae90.lee@samsung.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Lee Jones <lee.jones@linaro.org>, Chanwoo Choi <cw00.choi@samsung.com>, Sebastian Reichel <sre@kernel.org>, Beomho Seo <beomho.seo@samsung.com>

Hi Dmitry Torokhov,

On 02/24/2015 02:26 AM, Dmitry Torokhov wrote:
> Hi Jaew9on,
>
> On Mon, Feb 23, 2015 at 05:09:50PM +0900, Jaewon Kim wrote:
>> This patch adds support for haptic driver on max77843
>> MFD(Multi Function Device) with PMIC, MUIC, LED, CHARGER.
>>
>> This driver supports external pwm and LRA(Linear Resonant Actuator) motor.
>> And it supports ff-memless interface from inpu framework.
>>
>> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>> Signed-off-by: Jaewon Kim <jaewon02.kim@samsung.com>
> ...
>
>> +static void max77843_haptic_play_work(struct work_struct *work)
>> +{
>> +	struct max77843_haptic *haptic =
>> +			container_of(work, struct max77843_haptic, work);
>> +	int error;
>> +
>> +	mutex_lock(&haptic->mutex);
>> +
>> +	if (haptic->suspended)
>> +		mutex_unlock(&haptic->mutex);
> Huh?
This code prevent to play haptic when entering suspend state.
But I forgot return.
I will add return 0 in version 6.

>
>> +
>> +	error = max77843_haptic_set_duty_cycle(haptic);
>> +	if (error) {
>> +		dev_err(haptic->dev, "failed to set duty cycle: %d\n", error);
>> +		return;
> Here you are leaving with the mutex held.
Okay, I will add mutex_unlock().
>
>> +	}
>> +
>> +	if (haptic->magnitude) {
>> +		error = max77843_haptic_enable(haptic);
>> +		if (error)
>> +			dev_err(haptic->dev,
>> +					"cannot enable haptic: %d\n", error);
>> +	} else {
>> +		max77843_haptic_disable(haptic);
>> +		if (error)
>> +			dev_err(haptic->dev,
>> +					"cannot disable haptic: %d\n", error);
>> +	}
>> +
>> +	mutex_unlock(&haptic->mutex);
>> +}
>> +
> The rest seems quite reasonable.
>
> Thanks.
>
Thanks to review my patch.


Thanks,
Jaewon Kim
