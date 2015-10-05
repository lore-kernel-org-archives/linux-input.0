From: Laxman Dewangan <ldewangan@nvidia.com>
Subject: Re: [PATCH 03/17] input: tegra-kbc: drop use of IRQF_NO_SUSPEND flag
Date: Mon, 5 Oct 2015 15:54:01 +0530
Message-ID: <56124FC1.8010202@nvidia.com>
References: <1442850433-5903-1-git-send-email-sudeep.holla@arm.com> <1442850433-5903-4-git-send-email-sudeep.holla@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1442850433-5903-4-git-send-email-sudeep.holla@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, linux-input@vger.kernel.org, linux-tegra@vger.kernel.org
List-Id: linux-input@vger.kernel.org


On Monday 21 September 2015 09:16 PM, Sudeep Holla wrote:
>
> diff --git a/drivers/input/keyboard/tegra-kbc.c b/drivers/input/keyboard/tegra-kbc.c
> index f97c73bd14f8..5f5dbbd51991 100644
> --- a/drivers/input/keyboard/tegra-kbc.c
> +++ b/drivers/input/keyboard/tegra-kbc.c
> @@ -705,7 +705,7 @@ static int tegra_kbc_probe(struct platform_device *pdev)
>   	input_set_drvdata(kbc->idev, kbc);
>   
>   	err = devm_request_irq(&pdev->dev, kbc->irq, tegra_kbc_isr,
> -			  IRQF_NO_SUSPEND | IRQF_TRIGGER_HIGH, pdev->name, kbc);
> +			       IRQF_TRIGGER_HIGH, pdev->name, kbc);
>

Acked-by: Laxman Dewangan <ldewangan@nvidia.com>
