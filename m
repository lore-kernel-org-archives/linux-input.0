From: Jaewon Kim <jaewon02.kim@samsung.com>
Subject: Re: [PATCH v6 4/5] Input: add haptic drvier on max77843
Date: Thu, 26 Feb 2015 11:49:36 +0900
Message-ID: <54EE89C0.7010507@samsung.com>
References: <1424741348-8728-1-git-send-email-jaewon02.kim@samsung.com>
 <1424741348-8728-5-git-send-email-jaewon02.kim@samsung.com>
 <20150226012353.GC25965@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:20578 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751479AbbBZCtk (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 25 Feb 2015 21:49:40 -0500
In-reply-to: <20150226012353.GC25965@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux-input@vger.kernel.org, Inki Dae <inki.dae@samsung.com>, SangBae Lee <sangbae90.lee@samsung.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Lee Jones <lee.jones@linaro.org>, Chanwoo Choi <cw00.choi@samsung.com>, Sebastian Reichel <sre@kernel.org>, Beomho Seo <beomho.seo@samsung.com>

Hi Dmitry,

On 26/02/2015 10:23, Dmitry Torokhov wrote:
> Hi Jaewon,
>
> On Tue, Feb 24, 2015 at 10:29:07AM +0900, Jaewon Kim wrote:
>> +static void max77843_haptic_play_work(struct work_struct *work)
>> +{
>> +	struct max77843_haptic *haptic =
>> +			container_of(work, struct max77843_haptic, work);
>> +	int error;
>> +
>> +	mutex_lock(&haptic->mutex);
>> +
>> +	if (haptic->suspended) {
>> +		goto err_play;
>> +	}
>> +
> You do not need braces around single statement. Also, this is not error
> that you are handling, I'd prefer if we called this label out_unlock.
You are right.
I will change label name and remove braces.
>> +	error = max77843_haptic_set_duty_cycle(haptic);
>> +	if (error) {
>> +		dev_err(haptic->dev, "failed to set duty cycle: %d\n", error);
>> +		goto err_play;
>> +	}
> Do you need to configure duty cycle if you stopping the playback? Or
> maybe disabling pwm is enough?

It do not need to set duty cycle requisitely when disabling haptic.

I will move this function to front of max77843_haptic_enable().

>
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
> What error? You did not assign it...
Detailed error message printed in enable/disable() function.

>
> Thanks.
>
Thanks to review my patch.

Thanks,
Jaewon Kim


