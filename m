From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH] Input: elan: enable middle button of touchpads on
 ThinkPad P52
Date: Tue, 19 Jun 2018 14:21:39 +0200
Message-ID: <CAN+gG=EDc8WsC3MjbY1VnYyo7G1ZBUboM2_T-Zd8r322dOvwTA@mail.gmail.com>
References: <20180612070906.5305-1-aaron.ma@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180612070906.5305-1-aaron.ma@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: aaron.ma@canonical.com
Cc: linux-input <linux-input@vger.kernel.org>, linux-kernel@vger.kernel.org, KT Liao <kt.liao@emc.com.tw>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
List-Id: linux-input@vger.kernel.org

On Tue, Jun 12, 2018 at 9:10 AM Aaron Ma <aaron.ma@canonical.com> wrote:
>
> PNPID is better way to identify the type of touchpads.
> Enable middle button support on 2 types of touchpads on Lenovo P52.
>
> Cc: stable@vger.kernel.org
> Cc: KT Liao <kt.liao@emc.com.tw>
> Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
> ---
>  drivers/input/mouse/elantech.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)

Looks good to me:
Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Aaron, our internal tests show that the P52 shows a lot of lost
synchronization in pre-v4.18 kernels. Do you have a fix for that too?

In v4.18 we need to fix the elan_i2c module as right now the touchpad
is muted when booted with such a kernel.

Cheers,
Benjamin

>
> diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
> index fb4d902c4403..67b061dd4494 100644
> --- a/drivers/input/mouse/elantech.c
> +++ b/drivers/input/mouse/elantech.c
> @@ -1175,6 +1175,12 @@ static const struct dmi_system_id elantech_dmi_has_middle_button[] = {
>         { }
>  };
>
> +static const char * const middle_button_pnp_ids[] = {
> +       "LEN2131", /* ThinkPad P52 w/ NFC */
> +       "LEN2132", /* ThinkPad P52 */
> +       NULL
> +};
> +
>  /*
>   * Set the appropriate event bits for the input subsystem
>   */
> @@ -1194,7 +1200,8 @@ static int elantech_set_input_params(struct psmouse *psmouse)
>         __clear_bit(EV_REL, dev->evbit);
>
>         __set_bit(BTN_LEFT, dev->keybit);
> -       if (dmi_check_system(elantech_dmi_has_middle_button))
> +       if (dmi_check_system(elantech_dmi_has_middle_button) ||
> +               psmouse_matches_pnp_id(psmouse, middle_button_pnp_ids))
>                 __set_bit(BTN_MIDDLE, dev->keybit);
>         __set_bit(BTN_RIGHT, dev->keybit);
>
> --
> 2.17.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
