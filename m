From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH 1/2 v2] device-tree: nexus7-flo: Remove power gpio key
 entry and use pmic8xxx-pwrkey
Date: Fri, 15 Apr 2016 11:59:27 -0700
Message-ID: <20160415185927.GN14441@codeaurora.org>
References: <1460668031-12384-1-git-send-email-john.stultz@linaro.org>
 <20160415172212.GW391@tuxbot>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:60813 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750951AbcDOS7a (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 15 Apr 2016 14:59:30 -0400
Content-Disposition: inline
In-Reply-To: <20160415172212.GW391@tuxbot>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bjorn Andersson <bjorn.andersson@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: John Stultz <john.stultz@linaro.org>, Stephen Boyd <stephen.boyd@linaro.org>, lkml <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Arnd Bergmann <arnd.bergmann@linaro.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Andy Gross <agross@codeaurora.org>, Vinay Simha BN <simhavcs@gmail.com>, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-input@vger.kernel.org

On 04/15, Bjorn Andersson wrote:
> On Thu 14 Apr 14:07 PDT 2016, John Stultz wrote:
> 
> > Signed-off-by: John Stultz <john.stultz@linaro.org>
> > ---
> > v2:
> >  - Add wakeup-source entry as suggested by
> >    Sudeep Holla <sudeep.holla@arm.com>
> > 
> >  arch/arm/boot/dts/qcom-apq8064-asus-nexus7-flo.dts | 16 ++++++++++------
> >  1 file changed, 10 insertions(+), 6 deletions(-)
> > 
> > diff --git a/arch/arm/boot/dts/qcom-apq8064-asus-nexus7-flo.dts b/arch/arm/boot/dts/qcom-apq8064-asus-nexus7-flo.dts
> [..]
> > @@ -190,6 +184,16 @@
> >  			};
> >  		};
> >  
> > +		/* override default debounce for power-key */
> > +		qcom,ssbi@500000 {
> > +			pmic@0 {
> > +				pwrkey@1c {
> > +					debounce = <1>;
> 
> The debounce is specified in microseconds, so if the 15625us that's
> specified in the dtsi is too much for you we have a bug in the driver.
> 
> Further, comparing the math with downstream indicates that we're quite
> off.
> 
> Could you please try the downstream calculation of "delay", by changing
> pmic8xxx_pwrkey_probe() to include:
> 
> 	delay = (kpb_delay << 6) / USEC_PER_SEC;
> 	delay = ilog2(delay);
> 
> Unfortunately I don't have the register documentation for this pmic.
> 
> Stephen, can you shed some light on the trig-delay (what I presume is
> the bark timer in later versions) bits in PON_CNTRL_1 (0x1c) on PM8921.

It looks like this driver needs some love! qcom has layered these
patches on top of the upstream submission (hashes from msm-3.10
branch):

0fba556b7b95 input: pmic8xxx-pwrkey: Support sysfs interface for
debounce
f042aa6efec6 input: pm8xxx-pwrkey: Update key press status during
probe
0b58468eb5ca input: pwrkey: Handle out-of-order press and release
interrupts
2099d2368cb5 input: pmic8xxx-pwrkey: Keep pdata after probe
4ecfcdf235de input: pm8xxx-pwrkey: Move from threaded irq to
any-context irq
dfed28404288 input: pmic8xxx-pwrkey: Change algorithm on
converting trigger delay

That last one is the one you want here, although f042aa6efec6
looks interesting too.

Anyway, the equation for the lower 3 bits for the trigger delay
is:
	
	delay (Seconds) = (1 / 1024) * 2 ^ (x + 4)

where x is the 3 bits. With so few bits we only have 8 delays,
ranging from 2 seconds to 1/64 seconds (16/1024 == 1/64).

Funny thing, I looked back on some older PMICs and the
documentation usually has the same equation. Except for this one
document that seems to have messed up the formatting for the
power of 2 part so the equation looks like:

	delay (Seconds) = (1 / 1024) * 2 x + 4

Maybe the driver was written to this equation, but I'm willing to
bet that the documentation is wrong here. I seriously doubt the
power key would change like this!

Alright, here's the patch which should make the debounce actually
work.

----8<-----
From: Stephen Boyd <sboyd@codeaurora.org>
Subject: [PATCH] Input: pmic8xxx-pwrkey: Fix algorithm for converting trigger
 delay

The trigger delay algorithm that converts from microseconds to
the register value looks incorrect. According to most of the PMIC
documentation, the equation is

	delay (Seconds) = (1 / 1024) * 2 ^ (x + 4)

except for one case where the documentation looks to have a
formatting issue and the equation looks like

	delay (Seconds) = (1 / 1024) * 2 x + 4

Most likely this driver was written with the improper
documentation to begin with. According to the downstream sources
the valid delays are from 2 seconds to 1/64 second, and the
latter equation just doesn't make sense for that. Let's fix the
algorithm and the range check to match the documentation and the
downstream sources.

Reported-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: John Stultz <john.stultz@linaro.org>
Fixes: 92d57a73e410 ("input: Add support for Qualcomm PMIC8XXX power key")
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/input/misc/pmic8xxx-pwrkey.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/input/misc/pmic8xxx-pwrkey.c b/drivers/input/misc/pmic8xxx-pwrkey.c
index 3f02e0e03d12..67aab86048ad 100644
--- a/drivers/input/misc/pmic8xxx-pwrkey.c
+++ b/drivers/input/misc/pmic8xxx-pwrkey.c
@@ -353,7 +353,8 @@ static int pmic8xxx_pwrkey_probe(struct platform_device *pdev)
 	if (of_property_read_u32(pdev->dev.of_node, "debounce", &kpd_delay))
 		kpd_delay = 15625;
 
-	if (kpd_delay > 62500 || kpd_delay == 0) {
+	/* Valid range of pwr key trigger delay is 1/64 sec to 2 seconds. */
+	if (kpd_delay > USEC_PER_SEC * 2 || kpd_delay < USEC_PER_SEC / 64) {
 		dev_err(&pdev->dev, "invalid power key trigger delay\n");
 		return -EINVAL;
 	}
@@ -385,8 +386,8 @@ static int pmic8xxx_pwrkey_probe(struct platform_device *pdev)
 	pwr->name = "pmic8xxx_pwrkey";
 	pwr->phys = "pmic8xxx_pwrkey/input0";
 
-	delay = (kpd_delay << 10) / USEC_PER_SEC;
-	delay = 1 + ilog2(delay);
+	delay = (kpd_delay << 6) / USEC_PER_SEC;
+	delay = ilog2(delay);
 
 	err = regmap_read(regmap, PON_CNTL_1, &pon_cntl);
 	if (err < 0) {
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
