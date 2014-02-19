From: David Herrmann <dh.herrmann@gmail.com>
Subject: Re: [PATCH 2/3] HID: sony: Force-feedback cleanup
Date: Wed, 19 Feb 2014 11:23:18 +0100
Message-ID: <CANq1E4TL-s70q+gQ6_y5Ds-zWgAqtyrn3MgWbFOVkyH3y2RRZA@mail.gmail.com>
References: <1392762123-17725-1-git-send-email-frank.praznik@oh.rr.com>
	<1392762123-17725-3-git-send-email-frank.praznik@oh.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f176.google.com ([209.85.223.176]:46443 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753149AbaBSKXT (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 19 Feb 2014 05:23:19 -0500
Received: by mail-ie0-f176.google.com with SMTP id rd18so99382iec.21
        for <linux-input@vger.kernel.org>; Wed, 19 Feb 2014 02:23:18 -0800 (PST)
In-Reply-To: <1392762123-17725-3-git-send-email-frank.praznik@oh.rr.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Frank Praznik <frank.praznik@oh.rr.com>
Cc: "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>

Hi

On Tue, Feb 18, 2014 at 11:22 PM, Frank Praznik <frank.praznik@oh.rr.com> wrote:
> Only initialize force feedback for devices that actually support it (Sixaxis and
> Dualshock 4).
>
> Move the cancel_work_sync() call out of sony_destroy_ff() since the state worker
> is used for the LEDs even when force-feedback is disabled.
>
> Remove the sony_destroy_ff() function since it is no longer used.
>
> Signed-off-by: Frank Praznik <frank.praznik@oh.rr.com>
> ---
>  drivers/hid/hid-sony.c | 21 +++++++--------------
>  1 file changed, 7 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
> index 81917eb..ad1cebd 100644
> --- a/drivers/hid/hid-sony.c
> +++ b/drivers/hid/hid-sony.c
> @@ -50,6 +50,7 @@
>  #define SONY_LED_SUPPORT (SIXAXIS_CONTROLLER | BUZZ_CONTROLLER |\
>                                 DUALSHOCK4_CONTROLLER)
>  #define SONY_BATTERY_SUPPORT (SIXAXIS_CONTROLLER | DUALSHOCK4_CONTROLLER)
> +#define SONY_FF_SUPPORT (SIXAXIS_CONTROLLER | DUALSHOCK4_CONTROLLER)
>
>  #define MAX_LEDS 4
>
> @@ -1354,22 +1355,12 @@ static int sony_init_ff(struct hid_device *hdev)
>         return input_ff_create_memless(input_dev, NULL, sony_play_effect);
>  }
>
> -static void sony_destroy_ff(struct hid_device *hdev)
> -{
> -       struct sony_sc *sc = hid_get_drvdata(hdev);
> -
> -       cancel_work_sync(&sc->state_worker);
> -}
> -
>  #else
>  static int sony_init_ff(struct hid_device *hdev)
>  {
>         return 0;
>  }
>
> -static void sony_destroy_ff(struct hid_device *hdev)
> -{
> -}
>  #endif
>
>  static int sony_battery_get_property(struct power_supply *psy,
> @@ -1567,9 +1558,11 @@ static int sony_probe(struct hid_device *hdev, const struct hid_device_id *id)
>                 }
>         }
>
> -       ret = sony_init_ff(hdev);
> -       if (ret < 0)
> -               goto err_close;
> +       if (sc->quirks & SONY_FF_SUPPORT) {
> +               ret = sony_init_ff(hdev);
> +               if (ret < 0)
> +                       goto err_close;
> +       }
>
>         return 0;
>  err_close:
> @@ -1595,7 +1588,7 @@ static void sony_remove(struct hid_device *hdev)
>                 sony_battery_remove(sc);
>         }
>
> -       sony_destroy_ff(hdev);
> +       cancel_work_sync(&sc->state_worker);

Ugh, that's a bugfix! This can trigger if the led-worker runs during
unplug. You should mark it for stable next time you send it (adding:
Cc: <stable@vger.kernel.org>)

Reviewed-by: David Herrmann <dh.herrmann@gmail.com>

Thanks
David

>
>         hid_hw_stop(hdev);
>  }
> --
> 1.8.5.3
>
