From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 03/17] input: tegra-kbc: drop use of IRQF_NO_SUSPEND flag
Date: Mon, 26 Oct 2015 01:37:08 -0700
Message-ID: <20151026083708.GB13056@localhost>
References: <1442850433-5903-1-git-send-email-sudeep.holla@arm.com>
 <1442850433-5903-4-git-send-email-sudeep.holla@arm.com>
 <56124FC1.8010202@nvidia.com>
 <5625298A.9010801@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:35573 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753049AbbJZIhR (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 26 Oct 2015 04:37:17 -0400
Content-Disposition: inline
In-Reply-To: <5625298A.9010801@arm.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Laxman Dewangan <ldewangan@nvidia.com>, Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, linux-input@vger.kernel.org, linux-tegra@vger.kernel.org

On Mon, Oct 19, 2015 at 06:34:02PM +0100, Sudeep Holla wrote:
> Hi Dmitry,
> 
> On 05/10/15 11:24, Laxman Dewangan wrote:
> >
> >On Monday 21 September 2015 09:16 PM, Sudeep Holla wrote:
> >>
> >>diff --git a/drivers/input/keyboard/tegra-kbc.c
> >>b/drivers/input/keyboard/tegra-kbc.c
> >>index f97c73bd14f8..5f5dbbd51991 100644
> >>--- a/drivers/input/keyboard/tegra-kbc.c
> >>+++ b/drivers/input/keyboard/tegra-kbc.c
> >>@@ -705,7 +705,7 @@ static int tegra_kbc_probe(struct platform_device
> >>*pdev)
> >>      input_set_drvdata(kbc->idev, kbc);
> >>      err = devm_request_irq(&pdev->dev, kbc->irq, tegra_kbc_isr,
> >>-              IRQF_NO_SUSPEND | IRQF_TRIGGER_HIGH, pdev->name, kbc);
> >>+                   IRQF_TRIGGER_HIGH, pdev->name, kbc);
> >>
> >
> >Acked-by: Laxman Dewangan <ldewangan@nvidia.com>
> >
> 
> Can you pick this up with all the Acks ?

Applied, thank you.

-- 
Dmitry
