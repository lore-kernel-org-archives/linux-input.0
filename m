From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 1/3] HID: magicmouse: properly account for scroll movement
 in state
Date: Thu, 24 Jun 2010 10:48:29 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1006241048110.13809@pobox.suse.cz>
References: <1277083951-29137-1-git-send-email-chase.douglas@canonical.com> <1277083951-29137-2-git-send-email-chase.douglas@canonical.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:56632 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753375Ab0FXIsb (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 24 Jun 2010 04:48:31 -0400
In-Reply-To: <1277083951-29137-2-git-send-email-chase.douglas@canonical.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chase Douglas <chase.douglas@canonical.com>
Cc: Michael Poole <mdpoole@troilus.org>, linux-input@vger.kernel.org

On Sun, 20 Jun 2010, Chase Douglas wrote:

> Before this change, sequential scroll events would take a variable
> amount of movement due to incorrect accounting. This change ensures all
> scroll movements require a deterministic touch movement for an action to
> occur.
> 
> Signed-off-by: Chase Douglas <chase.douglas@canonical.com>
> Acked-by: Michael Poole <mdpoole@troilus.org>
> ---
>  drivers/hid/hid-magicmouse.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/hid/hid-magicmouse.c b/drivers/hid/hid-magicmouse.c
> index 4c4a79c..f44aaf2 100644
> --- a/drivers/hid/hid-magicmouse.c
> +++ b/drivers/hid/hid-magicmouse.c
> @@ -189,7 +189,8 @@ static void magicmouse_emit_touch(struct magicmouse_sc *msc, int raw_id, u8 *tda
>  		case TOUCH_STATE_DRAG:
>  			step = step / accel_profile[msc->scroll_accel];
>  			if (step != 0) {
> -				msc->touches[id].scroll_y = y;
> +				msc->touches[id].scroll_y -=
> +					step * accel_profile[msc->scroll_accel];
>  				msc->scroll_jiffies = now;
>  				input_report_rel(input, REL_WHEEL, step);
>  			}

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
