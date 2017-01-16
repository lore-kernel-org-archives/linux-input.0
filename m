From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2 3/3] Input: pwm-beeper: add optional amplifier
 regulator
Date: Sun, 15 Jan 2017 16:34:56 -0800
Message-ID: <20170116003456.GH23285@dtor-ws>
References: <1484164921-30587-1-git-send-email-david@lechnology.com>
 <1484164921-30587-4-git-send-email-david@lechnology.com>
 <20170114191943.GC31309@dtor-ws>
 <a907970d-3ab9-69df-9636-54c2b660cff9@lechnology.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:35234 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751122AbdAPAfA (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sun, 15 Jan 2017 19:35:00 -0500
Content-Disposition: inline
In-Reply-To: <a907970d-3ab9-69df-9636-54c2b660cff9@lechnology.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Lechner <david@lechnology.com>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org

On Sun, Jan 15, 2017 at 06:12:29PM -0600, David Lechner wrote:
> On 01/14/2017 01:19 PM, Dmitry Torokhov wrote:
> >On Wed, Jan 11, 2017 at 02:02:01PM -0600, David Lechner wrote:
> >>This adds an optional regulator to the pwm-beeper device. This regulator
> >>acts as an amplifier. The amplifier is only enabled while beeping in order
> >>to reduce power consumption.
> >>
> >>Tested on LEGO MINDSTORMS EV3, which has a speaker connected to PWM through
> >>an amplifier.
> >>
> >>Signed-off-by: David Lechner <david@lechnology.com>
> >>---
> >> drivers/input/misc/pwm-beeper.c | 29 ++++++++++++++++++++++++++++-
> >> 1 file changed, 28 insertions(+), 1 deletion(-)
> >>
> >>diff --git a/drivers/input/misc/pwm-beeper.c b/drivers/input/misc/pwm-beeper.c
> >>index 30ac227..708e88e 100644
> >>--- a/drivers/input/misc/pwm-beeper.c
> >>+++ b/drivers/input/misc/pwm-beeper.c
> >>@@ -14,6 +14,7 @@
> >>  */
> >>
> >> #include <linux/input.h>
> >>+#include <linux/regulator/consumer.h>
> >> #include <linux/module.h>
> >> #include <linux/kernel.h>
> >> #include <linux/of.h>
> >>@@ -25,8 +26,10 @@
> >> struct pwm_beeper {
> >> 	struct input_dev *input;
> >> 	struct pwm_device *pwm;
> >>+	struct regulator *reg;
> >> 	struct work_struct work;
> >> 	unsigned long period;
> >>+	bool reg_enabled;
> >> };
> >>
> >> #define HZ_TO_NANOSECONDS(x) (1000000000UL/(x))
> >>@@ -38,8 +41,20 @@ static void __pwm_beeper_set(struct pwm_beeper *beeper)
> >> 	if (period) {
> >> 		pwm_config(beeper->pwm, period / 2, period);
> >> 		pwm_enable(beeper->pwm);
> >>-	} else
> >>+		if (beeper->reg) {
> >>+			int error;
> >>+
> >>+			error = regulator_enable(beeper->reg);
> >>+			if (!error)
> >>+				beeper->reg_enabled = true;
> >>+		}
> >>+	} else {
> >>+		if (beeper->reg_enabled) {
> >>+			regulator_disable(beeper->reg);
> >>+			beeper->reg_enabled = false;
> >>+		}
> >> 		pwm_disable(beeper->pwm);
> >>+	}
> >> }
> >>
> >> static void pwm_beeper_work(struct work_struct *work)
> >>@@ -82,6 +97,10 @@ static void pwm_beeper_stop(struct pwm_beeper *beeper)
> >> {
> >> 	cancel_work_sync(&beeper->work);
> >>
> >>+	if (beeper->reg_enabled) {
> >>+		regulator_disable(beeper->reg);
> >>+		beeper->reg_enabled = false;
> >>+	}
> >> 	if (beeper->period)
> >> 		pwm_disable(beeper->pwm);
> >> }
> >>@@ -111,6 +130,14 @@ static int pwm_beeper_probe(struct platform_device *pdev)
> >> 		return error;
> >> 	}
> >>
> >>+	beeper->reg = devm_regulator_get_optional(&pdev->dev, "amp");
> >
> >If you do not use optional regulator then you will not have to check if
> >you have it or not everywhere: regulator core will give you a dummy that
> >you can toggle to your heart's content.
> 
> Some months ago, I learned that if you are not using device tree and
> you do not call regulator_has_full_constraints(), then you do not
> get a dummy regulator. And here, we are only checking if the
> regulator exists in one place. We will still need the checks for
> beeper->reg_enabled to keep calls to regulator_enable() and
> regulator_disable() balanced.

Why? You do not have checks for calls to pwm_enable() and pwm_disable(),
(or rather beeper->period is used as such flag) why regulator would be
any different?

> 
> On the other hand, it is recommended that you always call
> regulator_has_full_constraints(), so I don't mind changing it if
> that is what you think we should do. But, I don't really see much of
> an advantage to changing it compared to the current implementation.

It greatly simplifies control flow in the driver (since I believe you
can get rid of the flags you introduced).

As far as arch not having full constraints - I am not sure if this makes
sense anymore. I am not quite sure what the original intent here was, we
should probably ask Mark Brown. But a lot of drivers do expect the dummy
substitution to imply work.

Thanks.

-- 
Dmitry
