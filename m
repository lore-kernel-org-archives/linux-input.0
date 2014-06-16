From: David Herrmann <dh.herrmann@gmail.com>
Subject: Re: [PATCH v3 2/2] elantech: Call psmouse_reset when elantech probe fails
Date: Mon, 16 Jun 2014 10:44:06 +0200
Message-ID: <CANq1E4S6E23h6Yzdh+tH_teX3UacJeLd68nn5Tare-GF=+pM_Q@mail.gmail.com>
References: <20140613205547.GA5244@lantern>
	<1402694473-11518-1-git-send-email-ulrik.debie-os@e2big.org>
	<1402694473-11518-3-git-send-email-ulrik.debie-os@e2big.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1402694473-11518-3-git-send-email-ulrik.debie-os@e2big.org>
Sender: stable-owner@vger.kernel.org
To: Ulrik De Bie <ulrik.debie-os@e2big.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, stable <stable@vger.kernel.org>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>
List-Id: linux-input@vger.kernel.org

Hi

On Fri, Jun 13, 2014 at 11:21 PM, Ulrik De Bie <ulrik.debie-os@e2big.org> wrote:
> Signed-off-by: Ulrik De Bie <ulrik.debie-os@e2big.org>

This patch lacks _any_ explanation why this is done. Please always
write commit-messages! It is totally unclear from the patch
description why the device is reset.

Thanks
David

> ---
>  drivers/input/mouse/elantech.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
> index 0eb185b..fa150d9 100644
> --- a/drivers/input/mouse/elantech.c
> +++ b/drivers/input/mouse/elantech.c
> @@ -1617,6 +1617,7 @@ int elantech_init(struct psmouse *psmouse)
>         sysfs_remove_group(&psmouse->ps2dev.serio->dev.kobj,
>                            &elantech_attr_group);
>   init_fail:
> +       psmouse_reset(psmouse);
>         kfree(etd);
>         return error;
>  }
> --
> 2.0.0
>
