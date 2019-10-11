From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] Revert "Input: elantech - enable SMBus on new (2018+) systems"
Date: Fri, 11 Oct 2019 17:26:05 +0200
Message-ID: <CAO-hwJJ_hjL8=D+BDTW6LQRhd86NawORuY-jnDF71mD88woiDw@mail.gmail.com>
References: <20191001070845.9720-1-kai.heng.feng@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191001070845.9720-1-kai.heng.feng@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Hi Kai-Heng,

On Tue, Oct 1, 2019 at 9:09 AM Kai-Heng Feng
<kai.heng.feng@canonical.com> wrote:
>
> This reverts commit 883a2a80f79ca5c0c105605fafabd1f3df99b34c.
>
> Apparently use dmi_get_bios_year() as manufacturing date isn't accurate
> and this breaks older laptops with new BIOS update.
>
> So let's revert this patch.
>
> There are still new HP laptops still need to use SMBus to support all
> features, but it'll be enabled via a whitelist.
>

You might want to add here:
Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D204771

> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

Oops, seems like you are missing my acked by:
Acked-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Also, don't we want to send this one to stable as well? I can't
remember if we reverted it in all the released kernels.

Cheers,
Benjamin

> ---
>  drivers/input/mouse/elantech.c | 55 ++++++++++++++++++----------------
>  1 file changed, 29 insertions(+), 26 deletions(-)
>
> diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantec=
h.c
> index 04fe43440a3c..2d8434b7b623 100644
> --- a/drivers/input/mouse/elantech.c
> +++ b/drivers/input/mouse/elantech.c
> @@ -1827,31 +1827,6 @@ static int elantech_create_smbus(struct psmouse *p=
smouse,
>                                   leave_breadcrumbs);
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
> -       case ETP_BUS_SMB_HST_NTFY_ONLY:
> -       case ETP_BUS_PS2_SMB_HST_NTFY:
> -               /* SMbus implementation is stable since 2018 */
> -               if (dmi_get_bios_year() >=3D 2018)
> -                       return true;
> -               /* fall through */
> -       default:
> -               psmouse_dbg(psmouse,
> -                           "Ignoring SMBus bus provider %d\n", info->bus=
);
> -               break;
> -       }
> -
> -       return false;
> -}
> -
>  /**
>   * elantech_setup_smbus - called once the PS/2 devices are enumerated
>   * and decides to instantiate a SMBus InterTouch device.
> @@ -1871,7 +1846,7 @@ static int elantech_setup_smbus(struct psmouse *psm=
ouse,
>                  * i2c_blacklist_pnp_ids.
>                  * Old ICs are up to the user to decide.
>                  */
> -               if (!elantech_use_host_notify(psmouse, info) ||
> +               if (!ETP_NEW_IC_SMBUS_HOST_NOTIFY(info->fw_version) ||
>                     psmouse_matches_pnp_id(psmouse, i2c_blacklist_pnp_ids=
))
>                         return -ENXIO;
>         }
> @@ -1891,6 +1866,34 @@ static int elantech_setup_smbus(struct psmouse *ps=
mouse,
>         return 0;
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
> +               psmouse_dbg(psmouse, "Ignoring SMBus provider through ale=
rt protocol.\n");
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
>  int elantech_init_smbus(struct psmouse *psmouse)
>  {
>         struct elantech_device_info info;
> --
> 2.17.1
>
