From: sboyd@codeaurora.org (spamassassin system account)
Subject: Re: [PATCH 6/7] Input: pmic8xxx-keypad - Migrate to devm_* APIs
Date: Mon, 16 Dec 2013 18:01:51 -0800
Message-ID: <20131217020151.GB31766@codeaurora.org>
References: <1386718996-3733-1-git-send-email-sboyd@codeaurora.org>
 <1386718996-3733-7-git-send-email-sboyd@codeaurora.org>
 <20131216153726.GB8884@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20131216153726.GB8884@core.coreip.homeip.net>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On 12/16, Dmitry Torokhov wrote:
> On Tue, Dec 10, 2013 at 03:43:15PM -0800, Stephen Boyd wrote:
> > -
> > -static int pmic8xxx_kp_remove(struct platform_device *pdev)
> > -{
> > -	struct pmic8xxx_kp *kp = platform_get_drvdata(pdev);
> > -
> > -	device_init_wakeup(&pdev->dev, 0);
> 
> Why are we removing restoring wakeup capable state?
> 

It's the only thing blocking removal of the remove callback and
as the driver is being unbound it didn't seem like we cared about
the state of the wakeup of the device. I greped the kernel tree
and I couldn't see a consistent pattern where driver probe was
setting the flag and driver remove was clearing it. Do we need to
keep it?

> > -	free_irq(kp->key_stuck_irq, kp);
> > -	free_irq(kp->key_sense_irq, kp);
> > -	input_unregister_device(kp->input);
> > -	kfree(kp);
> > -
> > -	return 0;
> >  }
> >  
> >  #ifdef CONFIG_PM_SLEEP

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
