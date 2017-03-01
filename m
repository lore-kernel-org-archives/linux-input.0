From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH v2] HID: sony: Fix input device leak when connecting a
 DS4 twice using USB/BT
Date: Wed, 1 Mar 2017 18:18:57 +0100
Message-ID: <20170301171857.GK7064@mail.corp.redhat.com>
References: <20170225001415.21361-1-roderick@gaikai.com>
 <20170225001415.21361-2-roderick@gaikai.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:33754 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750725AbdCARTE (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 1 Mar 2017 12:19:04 -0500
Content-Disposition: inline
In-Reply-To: <20170225001415.21361-2-roderick@gaikai.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Roderick Colenbrander <roderick@gaikai.com>
Cc: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jikos@kernel.org>, Simon Wood <simon@mungewell.org>, Frank Praznik <frank.praznik@gmail.com>, Tim Bird <tim.bird@am.sony.com>, Roderick Colenbrander <roderick.colenbrander@sony.com>

On Feb 24 2017 or thereabouts, Roderick Colenbrander wrote:
> From: Roderick Colenbrander <roderick.colenbrander@sony.com>
> 
> When a user connects a DS4 twice using USB and BT, we reject the
> second device connection after the setup work. We then perform
> a cleanup, but during cleanup we are not removing the touchpad
> device. This leads to leakage of an input device, which we would
> never remove. It can likely result into a kernel oops as well
> when the touchpad evdev node is accessed and the underlaying HID
> device has been removed from the system.
> 
> Fixes: ac797b95f532 ("HID: sony: Make the DS4 touchpad a separate device")
> Signed-off-by: Roderick Colenbrander <roderick.colenbrander@sony.com>
> ---

Looks good to me:
Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

>  drivers/hid/hid-sony.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
> index f405b07..740996f 100644
> --- a/drivers/hid/hid-sony.c
> +++ b/drivers/hid/hid-sony.c
> @@ -2632,6 +2632,8 @@ static int sony_input_configured(struct hid_device *hdev,
>  		sony_leds_remove(sc);
>  	if (sc->quirks & SONY_BATTERY_SUPPORT)
>  		sony_battery_remove(sc);
> +	if (sc->touchpad)
> +		sony_unregister_touchpad(sc);
>  	sony_cancel_work_sync(sc);
>  	kfree(sc->output_report_dmabuf);
>  	sony_remove_dev_list(sc);
> -- 
> 2.9.3
> 
