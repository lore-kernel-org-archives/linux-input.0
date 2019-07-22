From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v3] Input: elantech: Enable SMBus on new (2018+) systems
Date: Mon, 22 Jul 2019 11:17:39 +0300
Message-ID: <20190722081739.GA804@penguin>
References: <20190121070258.1844-1-kai.heng.feng@canonical.com>
 <20190722074055.22427-1-kai.heng.feng@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190722074055.22427-1-kai.heng.feng@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: benjamin.tissoires@redhat.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Your Name <you@example.com>
List-Id: linux-input@vger.kernel.org

Hi Kai-Heng,

On Mon, Jul 22, 2019 at 03:40:55PM +0800, Kai-Heng Feng wrote:
> There are some new HP laptops with Elantech touchpad don't support
> multitouch.
> 
> Currently we use ETP_NEW_IC_SMBUS_HOST_NOTIFY() to check if SMBus is
> supported, but in addition to firmware version, the bus type also
> informs us if the IC can support SMBus, so also check that.
> 
> In case of breaking old ICs, only enables SMBus on systems manufactured
> after 2018, alongsides aforementioned checks.
> 
> Lastly, consolidats all check into elantech_use_host_notify() and use it
> to determine whether to use PS/2 or SMBus.
> 
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> Signed-off-by: Your Name <you@example.com>

I do not think "Your Name" should be signing DCO here :)

> +static bool elantech_use_host_notify(struct psmouse *psmouse,
> +				     struct elantech_device_info *info)
> +{
> +	bool host_notify = false;
> +
> +	if (ETP_NEW_IC_SMBUS_HOST_NOTIFY(info->fw_version))
> +		host_notify = true;
> +	else {
> +		switch (info->bus) {
> +		case ETP_BUS_PS2_ONLY:
> +			/* expected case */
> +			break;
> +		case ETP_BUS_SMB_ALERT_ONLY:
> +			/* fall-through  */
> +		case ETP_BUS_PS2_SMB_ALERT:
> +			psmouse_dbg(psmouse, "Ignoring SMBus provider through alert protocol.\n");
> +			break;
> +		case ETP_BUS_SMB_HST_NTFY_ONLY:
> +			/* fall-through  */
> +		case ETP_BUS_PS2_SMB_HST_NTFY:
> +			/* SMbus implementation is stable since 2018 */
> +			if (dmi_get_bios_year() >= 2018)
> +				host_notify = true;
> +			break;
> +		default:
> +			psmouse_dbg(psmouse,
> +				    "Ignoring SMBus bus provider %d.\n",
> +				    info->bus);
> +		}
> +	}

I think this is way too verbose. How about a bit more condensed form:


Input: elantech - enable SMBus on new (2018+) systems

From: Kai-Heng Feng <kai.heng.feng@canonical.com>

There are some new HP laptops with Elantech touchpad that don't support
multitouch.

Currently we use ETP_NEW_IC_SMBUS_HOST_NOTIFY() to check if SMBus is supported,
but in addition to firmware version, the bus type also informs us whether the IC
can support SMBus. To avoid breaking old ICs, we will only enable SMbus support
based the bus type on systems manufactured after 2018.

Lastly, let's consolidate all checks into elantech_use_host_notify() and use it
to determine whether to use PS/2 or SMBus.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Acked-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/mouse/elantech.c |   54 +++++++++++++++++++---------------------
 1 file changed, 25 insertions(+), 29 deletions(-)

diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
index 2d8434b7b623..73544776a9ed 100644
--- a/drivers/input/mouse/elantech.c
+++ b/drivers/input/mouse/elantech.c
@@ -1827,6 +1827,30 @@ static int elantech_create_smbus(struct psmouse *psmouse,
 				  leave_breadcrumbs);
 }
 
+static bool elantech_use_host_notify(struct psmouse *psmouse,
+				     struct elantech_device_info *info)
+{
+	if (ETP_NEW_IC_SMBUS_HOST_NOTIFY(info->fw_version))
+		return true;
+
+	switch (info->bus) {
+	case ETP_BUS_PS2_ONLY:
+		/* expected case */
+		break;
+	case ETP_BUS_SMB_HST_NTFY_ONLY:
+	case ETP_BUS_PS2_SMB_HST_NTFY:
+		/* SMbus implementation is stable since 2018 */
+		if (dmi_get_bios_year() >= 2018)
+			return true;
+	default:
+		psmouse_dbg(psmouse,
+			    "Ignoring SMBus bus provider %d\n", info->bus);
+		break;
+	}
+
+	return false;
+}
+
 /**
  * elantech_setup_smbus - called once the PS/2 devices are enumerated
  * and decides to instantiate a SMBus InterTouch device.
@@ -1846,7 +1870,7 @@ static int elantech_setup_smbus(struct psmouse *psmouse,
 		 * i2c_blacklist_pnp_ids.
 		 * Old ICs are up to the user to decide.
 		 */
-		if (!ETP_NEW_IC_SMBUS_HOST_NOTIFY(info->fw_version) ||
+		if (!elantech_use_host_notify(psmouse, info) ||
 		    psmouse_matches_pnp_id(psmouse, i2c_blacklist_pnp_ids))
 			return -ENXIO;
 	}
@@ -1866,34 +1890,6 @@ static int elantech_setup_smbus(struct psmouse *psmouse,
 	return 0;
 }
 
-static bool elantech_use_host_notify(struct psmouse *psmouse,
-				     struct elantech_device_info *info)
-{
-	if (ETP_NEW_IC_SMBUS_HOST_NOTIFY(info->fw_version))
-		return true;
-
-	switch (info->bus) {
-	case ETP_BUS_PS2_ONLY:
-		/* expected case */
-		break;
-	case ETP_BUS_SMB_ALERT_ONLY:
-		/* fall-through  */
-	case ETP_BUS_PS2_SMB_ALERT:
-		psmouse_dbg(psmouse, "Ignoring SMBus provider through alert protocol.\n");
-		break;
-	case ETP_BUS_SMB_HST_NTFY_ONLY:
-		/* fall-through  */
-	case ETP_BUS_PS2_SMB_HST_NTFY:
-		return true;
-	default:
-		psmouse_dbg(psmouse,
-			    "Ignoring SMBus bus provider %d.\n",
-			    info->bus);
-	}
-
-	return false;
-}
-
 int elantech_init_smbus(struct psmouse *psmouse)
 {
 	struct elantech_device_info info;

Thanks.

-- 
Dmitry
