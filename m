From: Michael Poole <mdpoole@troilus.org>
Subject: Re: [PATCH 2/4] HID: magicmouse: properly account for scroll movement in state
Date: Wed, 09 Jun 2010 21:25:54 -0400
Message-ID: <8739wvel0d.fsf@troilus.org>
References: <1275488908-23624-1-git-send-email-chase.douglas@canonical.com>
	<1275488908-23624-3-git-send-email-chase.douglas@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:49401 "HELO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1756501Ab0FJBcK (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 9 Jun 2010 21:32:10 -0400
Received: by mail-vw0-f51.google.com with SMTP id 6so5265485vws.38
        for <linux-input@vger.kernel.org>; Wed, 09 Jun 2010 18:32:09 -0700 (PDT)
In-Reply-To: <1275488908-23624-3-git-send-email-chase.douglas@canonical.com>
	(Chase Douglas's message of "Wed, 2 Jun 2010 10:28:26 -0400")
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chase Douglas <chase.douglas@canonical.com>
Cc: linux-input@vger.kernel.org

Chase Douglas writes:

> Before this change, sequential scroll events would take a variable
> amount of movement due to incorrect accounting. This change ensures all
> scroll movements require a deterministic touch movement for an action to
> occur.
>
> Signed-off-by: Chase Douglas <chase.douglas@canonical.com>

My apologies for the delay in reviewing this one.  I understand now, and
agree it's the right thing to do here.

Acked-by: Michael Poole <mdpoole@troilus.org>

(For the rest of the list, I acked the other three patches in this
series via private email earlier.)

Michael Poole

> ---
>  drivers/hid/hid-magicmouse.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/hid/hid-magicmouse.c b/drivers/hid/hid-magicmouse.c
> index cd70635..171ed0c 100644
> --- a/drivers/hid/hid-magicmouse.c
> +++ b/drivers/hid/hid-magicmouse.c
> @@ -183,7 +183,8 @@ static void magicmouse_emit_touch(struct magicmouse_sc *msc, int raw_id, u8 *tda
>  		case TOUCH_STATE_DRAG:
>  			step = step / accel_profile[msc->scroll_accel];
>  			if (step != 0) {
> -				msc->touches[id].scroll_y = y;
> +				msc->touches[id].scroll_y -=
> +					step * accel_profile[msc->scroll_accel];
>  				msc->scroll_jiffies = now;
>  				input_report_rel(input, REL_WHEEL, step);
>  			}
