From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: Re: [PATCH] Revert "Input: elantech - enable SMBus on new (2018+)
 systems"
Date: Tue, 1 Oct 2019 19:20:01 +0800
Message-ID: <9EF87E3C-6CE0-4AD2-B2F9-C7FF9D978AFD@canonical.com>
References: <20191001070845.9720-1-kai.heng.feng@canonical.com>
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3594.4.18\))
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191001070845.9720-1-kai.heng.feng@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Hi Benjamin,

> On Oct 1, 2019, at 15:08, Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:
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

Before I make a manifest of devices, do you have any idea of the uniqueness of PNP IDs?
Or should I use DMI strings in this case?

Kai-Heng

> 
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
> drivers/input/mouse/elantech.c | 55 ++++++++++++++++++----------------
> 1 file changed, 29 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
> index 04fe43440a3c..2d8434b7b623 100644
> --- a/drivers/input/mouse/elantech.c
> +++ b/drivers/input/mouse/elantech.c
> @@ -1827,31 +1827,6 @@ static int elantech_create_smbus(struct psmouse *psmouse,
> 				  leave_breadcrumbs);
> }
> 
> -static bool elantech_use_host_notify(struct psmouse *psmouse,
> -				     struct elantech_device_info *info)
> -{
> -	if (ETP_NEW_IC_SMBUS_HOST_NOTIFY(info->fw_version))
> -		return true;
> -
> -	switch (info->bus) {
> -	case ETP_BUS_PS2_ONLY:
> -		/* expected case */
> -		break;
> -	case ETP_BUS_SMB_HST_NTFY_ONLY:
> -	case ETP_BUS_PS2_SMB_HST_NTFY:
> -		/* SMbus implementation is stable since 2018 */
> -		if (dmi_get_bios_year() >= 2018)
> -			return true;
> -		/* fall through */
> -	default:
> -		psmouse_dbg(psmouse,
> -			    "Ignoring SMBus bus provider %d\n", info->bus);
> -		break;
> -	}
> -
> -	return false;
> -}
> -
> /**
>  * elantech_setup_smbus - called once the PS/2 devices are enumerated
>  * and decides to instantiate a SMBus InterTouch device.
> @@ -1871,7 +1846,7 @@ static int elantech_setup_smbus(struct psmouse *psmouse,
> 		 * i2c_blacklist_pnp_ids.
> 		 * Old ICs are up to the user to decide.
> 		 */
> -		if (!elantech_use_host_notify(psmouse, info) ||
> +		if (!ETP_NEW_IC_SMBUS_HOST_NOTIFY(info->fw_version) ||
> 		    psmouse_matches_pnp_id(psmouse, i2c_blacklist_pnp_ids))
> 			return -ENXIO;
> 	}
> @@ -1891,6 +1866,34 @@ static int elantech_setup_smbus(struct psmouse *psmouse,
> 	return 0;
> }
> 
> +static bool elantech_use_host_notify(struct psmouse *psmouse,
> +				     struct elantech_device_info *info)
> +{
> +	if (ETP_NEW_IC_SMBUS_HOST_NOTIFY(info->fw_version))
> +		return true;
> +
> +	switch (info->bus) {
> +	case ETP_BUS_PS2_ONLY:
> +		/* expected case */
> +		break;
> +	case ETP_BUS_SMB_ALERT_ONLY:
> +		/* fall-through  */
> +	case ETP_BUS_PS2_SMB_ALERT:
> +		psmouse_dbg(psmouse, "Ignoring SMBus provider through alert protocol.\n");
> +		break;
> +	case ETP_BUS_SMB_HST_NTFY_ONLY:
> +		/* fall-through  */
> +	case ETP_BUS_PS2_SMB_HST_NTFY:
> +		return true;
> +	default:
> +		psmouse_dbg(psmouse,
> +			    "Ignoring SMBus bus provider %d.\n",
> +			    info->bus);
> +	}
> +
> +	return false;
> +}
> +
> int elantech_init_smbus(struct psmouse *psmouse)
> {
> 	struct elantech_device_info info;
> -- 
> 2.17.1
> 
