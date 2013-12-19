From: Benjamin Franzke <benjaminfranzke@googlemail.com>
Subject: Re: [PATCH 1/2] joydev: Map ABS_{THROTTLE,GAS,BREAK} to positive values.
Date: Thu, 19 Dec 2013 13:50:07 +0100
Message-ID: <CAFc8KeQkzk+TJV=8gJMyBbNPFC3HHZsjXMGdXYB8nHr49hFn2Q@mail.gmail.com>
References: <1386749731-6500-1-git-send-email-benjaminfranzke@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f178.google.com ([209.85.223.178]:57476 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756014Ab3LSMuH (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 19 Dec 2013 07:50:07 -0500
Received: by mail-ie0-f178.google.com with SMTP id lx4so1249607iec.9
        for <linux-input@vger.kernel.org>; Thu, 19 Dec 2013 04:50:07 -0800 (PST)
In-Reply-To: <1386749731-6500-1-git-send-email-benjaminfranzke@googlemail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Benjamin Franzke <benjaminfranzke@googlemail.com>

Hi List,

may I ask for some (other) comments that actually help fix this bug?
Some vague concerns dont really help.

Thanks, Ben



2013/12/11 Benjamin Franzke <benjaminfranzke@googlemail.com>:
> Gamepads like XInput devices have triggers with a range from
> e.g. 0 to 255.
> When the conventional joydev AXES correction/mapping method is used,
> the default state 0 (i.e. when the user does not press a button or trigger)
> is mapped to -32767 (and 255 to 32767).
> You'll get 0 only when pressing the trigger half-way down.
> This has several drawbacks:
>  - A trigger is not usable at all when configured to have 2 directions
>    when there is physically only one.
>  - Applications that let the user configure joystick input assignments
>    may register the mapped non-zero default state as a press,
>    preventing the user from configuring any sensible value.
>
> Traditonal calibration e.g. with jscal does not help to get a usable
> experience either, it'll map the default state to -32767 as well.
> Only manually editing the calibration data does work currently.
>
> This patch tries to fix this issue by calculating a positive-only range for
> the throttle break and gas ABS bits.
> Maybe other ABS types need to be added to this scheme as well(?)
>
> Note:
> Although joydev is considered obsolete and people are encouraged to just
> use evdev, joydev should still be fixed, because
>  1. many applications still use it.
>  2. userspace already copies the joydev correction code to evdev (e.g. libSDL).
>
> This bug should be fixed here in joydev first, and when we have a good
> sensible state, this should be propagated to the application/libraries
> that copied the joydev correction code.
>
> Gamepad drivers will need to advertise triggers as THROTTLE,GAS,BREAK instead
> of e.g. ABS_{RZ,Z} where phyisically appropriate, to make use of this.
>
> I've considered changing the current joydev correction calculation for all ABS
> types, to have only a scaling functionality by default, no translation
> (all positive values remain positive, negatives negative and zero remains zero),
> so that drivers would need to expose zero-centered ABS values.
> It turned out to many drivers would need to be adjusted, which i cant
> test.
>
> Signed-off-by: Benjamin Franzke <benjaminfranzke@googlemail.com>
> ---
>  drivers/input/joydev.c | 59 +++++++++++++++++++++++++++++++++++++-------------
>  1 file changed, 44 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/input/joydev.c b/drivers/input/joydev.c
> index f362883..8352bee 100644
> --- a/drivers/input/joydev.c
> +++ b/drivers/input/joydev.c
> @@ -761,11 +761,50 @@ static bool joydev_match(struct input_handler *handler, struct input_dev *dev)
>         return true;
>  }
>
> +static void joydev_calculate_correction(struct input_dev *dev, __u8 abs,
> +                                       struct js_corr *corr)
> +{
> +       int t;
> +
> +       corr->type = JS_CORR_BROKEN;
> +       corr->prec = input_abs_get_fuzz(dev, abs);
> +
> +       switch (abs) {
> +       /* Map [min - max] => [0 - 32767]. */
> +       case ABS_THROTTLE:
> +       case ABS_GAS:
> +       case ABS_BRAKE:
> +               corr->coef[0] = input_abs_get_min(dev, abs);
> +               corr->coef[1] = corr->coef[0] + input_abs_get_flat(dev, abs);
> +               corr->coef[2] = 0;
> +
> +               t = input_abs_get_max(dev, abs) - input_abs_get_min(dev, abs)
> +                       - input_abs_get_flat(dev, abs);
> +               if (t)
> +                       corr->coef[3] = (1 << 29) / t;
> +               break;
> +       /* Map [min - max] => [-32768 - 32767]. */
> +       default:
> +               t = (input_abs_get_max(dev, abs) +
> +                    input_abs_get_min(dev, abs)) / 2;
> +               corr->coef[0] = t - input_abs_get_flat(dev, abs);
> +               corr->coef[1] = t + input_abs_get_flat(dev, abs);
> +               t = (input_abs_get_max(dev, abs) -
> +                    input_abs_get_min(dev, abs)) / 2
> +                       - 2 * input_abs_get_flat(dev, abs);
> +               if (t) {
> +                       corr->coef[2] = (1 << 29) / t;
> +                       corr->coef[3] = (1 << 29) / t;
> +               }
> +               break;
> +       }
> +}
> +
>  static int joydev_connect(struct input_handler *handler, struct input_dev *dev,
>                           const struct input_device_id *id)
>  {
>         struct joydev *joydev;
> -       int i, j, t, minor, dev_no;
> +       int i, j, minor, dev_no;
>         int error;
>
>         minor = input_get_new_minor(JOYDEV_MINOR_BASE, JOYDEV_MINORS, true);
> @@ -826,23 +865,13 @@ static int joydev_connect(struct input_handler *handler, struct input_dev *dev,
>                         joydev->abs[i] = input_abs_get_val(dev, j);
>                         continue;
>                 }
> -               joydev->corr[i].type = JS_CORR_BROKEN;
> -               joydev->corr[i].prec = input_abs_get_fuzz(dev, j);
>
> -               t = (input_abs_get_max(dev, j) + input_abs_get_min(dev, j)) / 2;
> -               joydev->corr[i].coef[0] = t - input_abs_get_flat(dev, j);
> -               joydev->corr[i].coef[1] = t + input_abs_get_flat(dev, j);
> +               joydev_calculate_correction(dev, j, &joydev->corr[i]);
>
> -               t = (input_abs_get_max(dev, j) - input_abs_get_min(dev, j)) / 2
> -                       - 2 * input_abs_get_flat(dev, j);
> -               if (t) {
> -                       joydev->corr[i].coef[2] = (1 << 29) / t;
> -                       joydev->corr[i].coef[3] = (1 << 29) / t;
> +               joydev->abs[i] =
> +                       joydev_correct(input_abs_get_val(dev, j),
> +                                      joydev->corr + i);
>
> -                       joydev->abs[i] =
> -                               joydev_correct(input_abs_get_val(dev, j),
> -                                              joydev->corr + i);
> -               }
>         }
>
>         joydev->dev.devt = MKDEV(INPUT_MAJOR, minor);
> --
> 1.8.1.5
>
