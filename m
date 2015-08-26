From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: only send a syn event when needed in input_dev_release_keys
Date: Wed, 26 Aug 2015 13:06:03 -0700
Message-ID: <CAKdAkRQ63UqR-FPAfho=MqGf-391wR=PJthOHkh+zb7U=tOO=w@mail.gmail.com>
References: <1440574712-25629-1-git-send-email-hans.holmberg@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ob0-f170.google.com ([209.85.214.170]:36480 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752714AbbHZUGE (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 26 Aug 2015 16:06:04 -0400
In-Reply-To: <1440574712-25629-1-git-send-email-hans.holmberg@intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hans Holmberg <hans.holmberg@intel.com>
Cc: ting.li@intel.com, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>

Hi Hans,

On Wed, Aug 26, 2015 at 12:38 AM, Hans Holmberg <hans.holmberg@intel.com> wrote:
> A SYN event is reported in input_release_keys even if no keys are
> released. Stop doing this as the superfluous event can prevent autosleep
> if a user has opened a device with EPOLLWAKEUP enabled.
>
> Based on a patch developed by Ting Li <ting.li@intel.com>.
>
> Signed-off-by: Hans Holmberg <hans.holmberg@intel.com>

We already have a similar commit
00159f19a5057cb779146afce1cceede692af346 in next.

Thanks!

> ---
>  drivers/input/input.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/input/input.c b/drivers/input/input.c
> index 78d2499..c748805 100644
> --- a/drivers/input/input.c
> +++ b/drivers/input/input.c
> @@ -675,12 +675,18 @@ EXPORT_SYMBOL(input_close_device);
>  static void input_dev_release_keys(struct input_dev *dev)
>  {
>         int code;
> +       bool key_released = false;
>
>         if (is_event_supported(EV_KEY, dev->evbit, EV_MAX)) {
> -               for_each_set_bit(code, dev->key, KEY_CNT)
> +               for_each_set_bit(code, dev->key, KEY_CNT) {
>                         input_pass_event(dev, EV_KEY, code, 0);
> -               memset(dev->key, 0, sizeof(dev->key));
> -               input_pass_event(dev, EV_SYN, SYN_REPORT, 1);
> +                       key_released = true;
> +               }
> +
> +               if (key_released) {
> +                       memset(dev->key, 0, sizeof(dev->key));
> +                       input_pass_event(dev, EV_SYN, SYN_REPORT, 1);
> +               }
>         }
>  }
>
> --
> 1.9.1
>



-- 
Dmitry
