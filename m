From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH 1/1] Input: elantech: Use SMBus based on bus info
Date: Thu, 17 Jan 2019 15:42:44 +0100
Message-ID: <CAO-hwJKyBHM1Yy8=pQrbDoArTOX4=8G6f0jECv4x1mth+LZZDw@mail.gmail.com>
References: <20190117092948.32079-1-kai.heng.feng@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190117092948.32079-1-kai.heng.feng@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, =?UTF-8?B?5buW5bSH5qau?= <kt.liao@emc.com.tw>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Hi Kai-Heng,

On Thu, Jan 17, 2019 at 10:30 AM Kai-Heng Feng
<kai.heng.feng@canonical.com> wrote:
>
> There are some new HP laptops with Elantech touchpad don't support
> multitouch.
>
> Both ETP_BUS_SMB_HST_NTFY_ONLY and ETP_BUS_PS2_SMB_HST_NTFY devices can
> use SMBus to support 5 fingers touch, so we need to chech them too.
>
> So use elantech_use_host_notify() to do a more thouroughly check.
>
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
>  drivers/input/mouse/elantech.c | 58 +++++++++++++++++-----------------
>  1 file changed, 29 insertions(+), 29 deletions(-)
>
> diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
> index 9fe075c137dc..5bcf1c147eb1 100644
> --- a/drivers/input/mouse/elantech.c
> +++ b/drivers/input/mouse/elantech.c
> @@ -1799,6 +1799,34 @@ static int elantech_create_smbus(struct psmouse *psmouse,
>                                   leave_breadcrumbs);
>  }
>
> +static bool elantech_use_host_notify(struct psmouse *psmouse,
> +                                    struct elantech_device_info *info)
> +{
> +       if (ETP_NEW_IC_SMBUS_HOST_NOTIFY(info->fw_version))
> +               return true;
> +
> +       switch (info->bus) {
> +       case ETP_BUS_PS2_ONLY:
> +               /* expected case */
> +               break;
> +       case ETP_BUS_SMB_ALERT_ONLY:
> +               /* fall-through  */
> +       case ETP_BUS_PS2_SMB_ALERT:
> +               psmouse_dbg(psmouse, "Ignoring SMBus provider through alert protocol.\n");
> +               break;
> +       case ETP_BUS_SMB_HST_NTFY_ONLY:
> +               /* fall-through  */
> +       case ETP_BUS_PS2_SMB_HST_NTFY:
> +               return true;
> +       default:
> +               psmouse_dbg(psmouse,
> +                           "Ignoring SMBus bus provider %d.\n",
> +                           info->bus);
> +       }
> +
> +       return false;
> +}
> +
>  /**
>   * elantech_setup_smbus - called once the PS/2 devices are enumerated
>   * and decides to instantiate a SMBus InterTouch device.
> @@ -1818,7 +1846,7 @@ static int elantech_setup_smbus(struct psmouse *psmouse,
>                  * i2c_blacklist_pnp_ids.
>                  * Old ICs are up to the user to decide.
>                  */
> -               if (!ETP_NEW_IC_SMBUS_HOST_NOTIFY(info->fw_version) ||
> +               if (!elantech_use_host_notify(psmouse, info) ||

That was my initial approach of the series, but I ended up being more
conservative as this would flip all of the existing elantech SMBUS
capable touchpads to use elan_i2c.
And I didn't want to deal with 4/5 year old laptops that suddenly broke.

So I wonder if you can restrict this default change to the recent
laptops (let's say 2018+). Maybe by looking at their FW version or
something else in the DMI?

Cheers,
Benjamin

>                     psmouse_matches_pnp_id(psmouse, i2c_blacklist_pnp_ids))
>                         return -ENXIO;
>         }
> @@ -1838,34 +1866,6 @@ static int elantech_setup_smbus(struct psmouse *psmouse,
>         return 0;
>  }
>
> -static bool elantech_use_host_notify(struct psmouse *psmouse,
> -                                    struct elantech_device_info *info)
> -{
> -       if (ETP_NEW_IC_SMBUS_HOST_NOTIFY(info->fw_version))
> -               return true;
> -
> -       switch (info->bus) {
> -       case ETP_BUS_PS2_ONLY:
> -               /* expected case */
> -               break;
> -       case ETP_BUS_SMB_ALERT_ONLY:
> -               /* fall-through  */
> -       case ETP_BUS_PS2_SMB_ALERT:
> -               psmouse_dbg(psmouse, "Ignoring SMBus provider through alert protocol.\n");
> -               break;
> -       case ETP_BUS_SMB_HST_NTFY_ONLY:
> -               /* fall-through  */
> -       case ETP_BUS_PS2_SMB_HST_NTFY:
> -               return true;
> -       default:
> -               psmouse_dbg(psmouse,
> -                           "Ignoring SMBus bus provider %d.\n",
> -                           info->bus);
> -       }
> -
> -       return false;
> -}
> -
>  int elantech_init_smbus(struct psmouse *psmouse)
>  {
>         struct elantech_device_info info;
> --
> 2.17.1
>
