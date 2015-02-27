From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v6 4/5] Input: add haptic drvier on max77843
Date: Fri, 27 Feb 2015 09:49:41 -0800
Message-ID: <20150227174941.GD6679@dtor-ws>
References: <1424741348-8728-1-git-send-email-jaewon02.kim@samsung.com>
 <1424741348-8728-5-git-send-email-jaewon02.kim@samsung.com>
 <20150226012353.GC25965@dtor-ws>
 <54EE89C0.7010507@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f177.google.com ([209.85.223.177]:40029 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753437AbbB0Rtr (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 27 Feb 2015 12:49:47 -0500
Content-Disposition: inline
In-Reply-To: <54EE89C0.7010507@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jaewon Kim <jaewon02.kim@samsung.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux-input@vger.kernel.org, Inki Dae <inki.dae@samsung.com>, SangBae Lee <sangbae90.lee@samsung.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Lee Jones <lee.jones@linaro.org>, Chanwoo Choi <cw00.choi@samsung.com>, Sebastian Reichel <sre@kernel.org>, Beomho Seo <beomho.seo@samsung.com>

On Thu, Feb 26, 2015 at 11:49:36AM +0900, Jaewon Kim wrote:
> Hi Dmitry,
> 
> On 26/02/2015 10:23, Dmitry Torokhov wrote:
> >Hi Jaewon,
> >
> >On Tue, Feb 24, 2015 at 10:29:07AM +0900, Jaewon Kim wrote:
> >>+static void max77843_haptic_play_work(struct work_struct *work)
> >>+{
> >>+	struct max77843_haptic *haptic =
> >>+			container_of(work, struct max77843_haptic, work);
> >>+	int error;
> >>+
> >>+	mutex_lock(&haptic->mutex);
> >>+
> >>+	if (haptic->suspended) {
> >>+		goto err_play;
> >>+	}
> >>+
> >You do not need braces around single statement. Also, this is not error
> >that you are handling, I'd prefer if we called this label out_unlock.
> You are right.
> I will change label name and remove braces.
> >>+	error = max77843_haptic_set_duty_cycle(haptic);
> >>+	if (error) {
> >>+		dev_err(haptic->dev, "failed to set duty cycle: %d\n", error);
> >>+		goto err_play;
> >>+	}
> >Do you need to configure duty cycle if you stopping the playback? Or
> >maybe disabling pwm is enough?
> 
> It do not need to set duty cycle requisitely when disabling haptic.
> 
> I will move this function to front of max77843_haptic_enable().
> 
> >
> >>+
> >>+	if (haptic->magnitude) {
> >>+		error = max77843_haptic_enable(haptic);
> >>+		if (error)
> >>+			dev_err(haptic->dev,
> >>+					"cannot enable haptic: %d\n", error);
> >>+	} else {
> >>+		max77843_haptic_disable(haptic);
> >>+		if (error)
> >>+			dev_err(haptic->dev,
> >>+					"cannot disable haptic: %d\n", error);
> >What error? You did not assign it...
> Detailed error message printed in enable/disable() function.

What I was trying to say is that you do not assign new value to 'error'
variable in this path; it still carries the value from
max77843_haptic_set_duty_cycle() above and so this "if" statement will
never work and the message will never show up.

Thanks.

-- 
Dmitry
