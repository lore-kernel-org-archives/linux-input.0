From: David Herrmann <dh.herrmann@gmail.com>
Subject: Re: [PATCH] Input: gamepad - use independent axes for analog D-Pad buttons
Date: Wed, 25 Dec 2013 18:40:10 +0100
Message-ID: <CANq1E4Rw59A6byvmKXrhXqS_MW0oxYu9Fa4YnE9Vkhi8MLC_-g@mail.gmail.com>
References: <1387815463-29345-1-git-send-email-ospite@studenti.unina.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f177.google.com ([209.85.223.177]:64761 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751624Ab3LYRrN (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 25 Dec 2013 12:47:13 -0500
Received: by mail-ie0-f177.google.com with SMTP id tp5so7645218ieb.8
        for <linux-input@vger.kernel.org>; Wed, 25 Dec 2013 09:47:12 -0800 (PST)
In-Reply-To: <1387815463-29345-1-git-send-email-ospite@studenti.unina.it>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Antonio Ospite <ospite@studenti.unina.it>
Cc: "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>

Hi

On Mon, Dec 23, 2013 at 5:17 PM, Antonio Ospite
<ospite@studenti.unina.it> wrote:
> Model this part of the API after the Sony PlayStation 3 Controller which
> exposes independent analog values for each one of the D-Pad buttons.
>
> The PS3 programming API psl1ght also maps the analog D-Pad buttons
> individually.
>
> Cc: David Herrmann <dh.herrmann@gmail.com>
> Signed-off-by: Antonio Ospite <ospite@studenti.unina.it>
> ---
>
> Hi,
>
> as David mentioned no gamepad defines analog D-Pad buttons as mentioned in the
> gamepad API, so the API change should be OK.
>
> And is it OK too to fill the holes in the ABS space or should I just use
> higher codes?

You might wanna try searching git-history, but apart from ABS_MISC to
ABS_MT_* I think all other spaces can be filled.
Patch is fine with me, but I'd also be ok with the ABS_DPAD_HORIZ/VERT pair.

Reviewed-by: David Herrmann <dh.herrmann@gmail.com>

Thanks
David

> Thanks,
>    Antonio
>
>  Documentation/input/gamepad.txt       | 4 ++--
>  drivers/staging/et131x/Module.symvers | 0
>  include/uapi/linux/input.h            | 5 +++++
>  3 files changed, 7 insertions(+), 2 deletions(-)
>  delete mode 100644 drivers/staging/et131x/Module.symvers
>
> diff --git a/Documentation/input/gamepad.txt b/Documentation/input/gamepad.txt
> index ed13782..aab000d 100644
> --- a/Documentation/input/gamepad.txt
> +++ b/Documentation/input/gamepad.txt
> @@ -124,8 +124,8 @@ D-Pad:
>      Digital buttons are reported as:
>        BTN_DPAD_*
>      Analog buttons are reported as:
> -      ABS_HAT0X and ABS_HAT0Y
> -      (for ABS values negative is left/up, positive is right/down)
> +      ABS_DPAD_*
> +      (ABS values start at 0, pressure is reported as positive values)
>
>  Analog-Sticks:
>    The left analog-stick is reported as ABS_X, ABS_Y. The right analog stick is
> diff --git a/drivers/staging/et131x/Module.symvers b/drivers/staging/et131x/Module.symvers
> deleted file mode 100644
> index e69de29..0000000
> diff --git a/include/uapi/linux/input.h b/include/uapi/linux/input.h
> index d3fcbff..dcc73c0 100644
> --- a/include/uapi/linux/input.h
> +++ b/include/uapi/linux/input.h
> @@ -842,6 +842,11 @@ struct input_keymap_entry {
>
>  #define ABS_VOLUME             0x20
>
> +#define ABS_DPAD_UP            0x21    /* Analog D-Pad Up for gamepads */
> +#define ABS_DPAD_DOWN          0x22    /* Analog D-Pad Down for gamepads */
> +#define ABS_DPAD_LEFT          0x23    /* Analog D-Pad Left for gamepads */
> +#define ABS_DPAD_RIGHT         0x24    /* Analog D-Pad Right for gamepads */
> +
>  #define ABS_MISC               0x28
>
>  #define ABS_MT_SLOT            0x2f    /* MT slot being modified */
> --
> 1.8.5.2
>
