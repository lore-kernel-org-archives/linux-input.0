From: Christopher Hudson <chris.hudson.comp.eng@gmail.com>
Subject: Re: [PATCH v3] input: Add support for Kionix KXTJ9 accelerometer
Date: Wed, 25 May 2011 14:55:56 -0400
Message-ID: <BANLkTi=PwXb7PJTd8B_Y8x9G0WwDYgmk8w@mail.gmail.com>
References: <1306273877-28503-1-git-send-email-chudson@kionix.com>
	<4DDCC9E5.7050205@cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:46458 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751180Ab1EYSz5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 25 May 2011 14:55:57 -0400
Received: by vxi39 with SMTP id 39so6014059vxi.19
        for <linux-input@vger.kernel.org>; Wed, 25 May 2011 11:55:56 -0700 (PDT)
In-Reply-To: <4DDCC9E5.7050205@cam.ac.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: Chris Hudson <chudson@kionix.com>, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com

On Wed, May 25, 2011 at 5:20 AM, Jonathan Cameron <jic23@cam.ac.uk> wro=
te:
Hi Jonathan,

> So after all this, I'd leave it as it currently is! =A0Sorry for the =
wild
> goose chase.

I think I lost you somewhere in there, but I'm glad it turned out that
I was doing it right!

> Subject to responses to RFC on delay control, I'm happy with this dri=
ver.
> Good work and I look forward to lots more drivers in the future.

Thanks!  Don't worry, we have plenty more accelerometers to merge
drivers for eventually!
I saw the git pull request from yesterday; does this mean there's no
chance to make it in this merge window?  I know Dmitry will be
traveling next week, but we are really hoping to be able to give our
customer a 'final' version within a few business days if at all
possible.

>> + =A0 =A0 if (!tj9->hw_initialized) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 mdelay(40);
> nitpick - is it alright to sleep for longer? =A0If slow msleep is
> a better bet as lets the processor get on with something useful
> in the meantime.

Good point.  The 40ms is based on the power-up time in the product
specification, which itself is just a minimum value.  In reality, the
time between power on and communication could be significantly longer
with no impact to the hardware.  So yes, this can be changed to msleep
with no issues.

>> + =A0 =A0 unsigned long val;
>> + =A0 =A0 int ret =3D kstrtoul(buf, 10, &val);
>> + =A0 =A0 if (ret < 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return ret;
> You could use the just merged strtobool

I implemented this change and it compiled with no issues.
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
