From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH v4 5/9] Input: pmic8xxx-pwrkey - Migrate to DT
Date: Fri, 28 Feb 2014 10:32:37 -0800
Message-ID: <20140228183237.GE2487@codeaurora.org>
References: <1393552520-9068-1-git-send-email-sboyd@codeaurora.org>
 <1393552520-9068-6-git-send-email-sboyd@codeaurora.org>
 <20140228034547.GE7308@joshc.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140228034547.GE7308@joshc.qualcomm.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Josh Cartwright <joshc@codeaurora.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On 02/27, Josh Cartwright wrote:
> On Thu, Feb 27, 2014 at 05:55:16PM -0800, Stephen Boyd wrote:
> > The driver is only supported on DT enabled platforms. Convert the
> > driver to DT so that it can probe properly.
> > 
> > Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> > ---
> > --- a/drivers/input/misc/pmic8xxx-pwrkey.c
> > +++ b/drivers/input/misc/pmic8xxx-pwrkey.c
> > @@ -172,7 +178,7 @@ static int pmic8xxx_pwrkey_probe(struct platform_device *pdev)
> >  	}
> >  
> >  	platform_set_drvdata(pdev, pwrkey);
> > -	device_init_wakeup(&pdev->dev, pdata->wakeup);
> > +	device_init_wakeup(&pdev->dev, 1);
> 
> Is there a particular reason you aren't providing a 'linux,wakeup'
> property for pwrkey?
> 

In all the users of this device I've never seen wakeup set to 0.
Given that this is a power key it makes sense because this is
used to wake up a phone from suspend (also see the comment above
device_init_wakeup() where power buttons are explicitly called
out).

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
