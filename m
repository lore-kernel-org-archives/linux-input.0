From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH 03/17] input: tegra-kbc: drop use of IRQF_NO_SUSPEND flag
Date: Mon, 19 Oct 2015 18:34:02 +0100
Message-ID: <5625298A.9010801@arm.com>
References: <1442850433-5903-1-git-send-email-sudeep.holla@arm.com>
 <1442850433-5903-4-git-send-email-sudeep.holla@arm.com>
 <56124FC1.8010202@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:51323 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753324AbbJSReF (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 19 Oct 2015 13:34:05 -0400
In-Reply-To: <56124FC1.8010202@nvidia.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Laxman Dewangan <ldewangan@nvidia.com>, Sudeep Holla <sudeep.holla@arm.com>, Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, linux-input@vger.kernel.org, linux-tegra@vger.kernel.org

Hi Dmitry,

On 05/10/15 11:24, Laxman Dewangan wrote:
>
> On Monday 21 September 2015 09:16 PM, Sudeep Holla wrote:
>>
>> diff --git a/drivers/input/keyboard/tegra-kbc.c
>> b/drivers/input/keyboard/tegra-kbc.c
>> index f97c73bd14f8..5f5dbbd51991 100644
>> --- a/drivers/input/keyboard/tegra-kbc.c
>> +++ b/drivers/input/keyboard/tegra-kbc.c
>> @@ -705,7 +705,7 @@ static int tegra_kbc_probe(struct platform_device
>> *pdev)
>>       input_set_drvdata(kbc->idev, kbc);
>>       err = devm_request_irq(&pdev->dev, kbc->irq, tegra_kbc_isr,
>> -              IRQF_NO_SUSPEND | IRQF_TRIGGER_HIGH, pdev->name, kbc);
>> +                   IRQF_TRIGGER_HIGH, pdev->name, kbc);
>>
>
> Acked-by: Laxman Dewangan <ldewangan@nvidia.com>
>

Can you pick this up with all the Acks ?

-- 
Regards,
Sudeep
