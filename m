From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v8 2/5] HID: quirks: Refactor ELAN 400 and 401 handling
Date: Sun, 30 Jun 2019 00:18:59 -0700
Message-ID: <20190630071859.GD91171@dtor-ws>
References: <20190621144854.38568-1-jeffrey.l.hugo@gmail.com>
 <20190621145312.38688-1-jeffrey.l.hugo@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190621145312.38688-1-jeffrey.l.hugo@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
Cc: benjamin.tissoires@redhat.com, jikos@kernel.org, hdegoede@redhat.com, bjorn.andersson@linaro.org, agross@kernel.org, lee.jones@linaro.org, xnox@ubuntu.com, robh+dt@kernel.org, mark.rutland@arm.com, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Fri, Jun 21, 2019 at 07:53:12AM -0700, Jeffrey Hugo wrote:
> There needs to be coordination between hid-quirks and the elan_i2c driver
> about which devices are handled by what drivers.  Currently, both use
> whitelists, which results in valid devices being unhandled by default,
> when they should not be rejected by hid-quirks.  This is quickly becoming
> an issue.
> 
> Since elan_i2c has a maintained whitelist of what devices it will handle,
> which is now in a header file that hid-quirks can access, use that to
> implement a blacklist in hid-quirks so that only the devices that need to
> be handled by elan_i2c get rejected by hid-quirks, and everything else is
> handled by default.
> 
> Suggested-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> Signed-off-by: Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
> Acked-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Applied, thank you.

> ---
>  drivers/hid/hid-quirks.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
> index e5ca6fe2ca57..48ed4caf0ebc 100644
> --- a/drivers/hid/hid-quirks.c
> +++ b/drivers/hid/hid-quirks.c
> @@ -16,6 +16,7 @@
>  #include <linux/export.h>
>  #include <linux/slab.h>
>  #include <linux/mutex.h>
> +#include <linux/input/elan-i2c-ids.h>
>  
>  #include "hid-ids.h"
>  
> @@ -914,6 +915,8 @@ static const struct hid_device_id hid_mouse_ignore_list[] = {
>  
>  bool hid_ignore(struct hid_device *hdev)
>  {
> +	int i;
> +
>  	if (hdev->quirks & HID_QUIRK_NO_IGNORE)
>  		return false;
>  	if (hdev->quirks & HID_QUIRK_IGNORE)
> @@ -978,18 +981,15 @@ bool hid_ignore(struct hid_device *hdev)
>  		break;
>  	case USB_VENDOR_ID_ELAN:
>  		/*
> -		 * Many Elan devices have a product id of 0x0401 and are handled
> -		 * by the elan_i2c input driver. But the ACPI HID ELAN0800 dev
> -		 * is not (and cannot be) handled by that driver ->
> -		 * Ignore all 0x0401 devs except for the ELAN0800 dev.
> +		 * Blacklist of everything that gets handled by the elan_i2c
> +		 * input driver.  This avoids disabling valid touchpads and
> +		 * other ELAN devices.
>  		 */
> -		if (hdev->product == 0x0401 &&
> -		    strncmp(hdev->name, "ELAN0800", 8) != 0)
> -			return true;
> -		/* Same with product id 0x0400 */
> -		if (hdev->product == 0x0400 &&
> -		    strncmp(hdev->name, "QTEC0001", 8) != 0)
> -			return true;
> +		if ((hdev->product == 0x0401 || hdev->product == 0x0400))
> +			for (i = 0; strlen(elan_acpi_id[i].id); ++i)
> +				if (!strncmp(hdev->name, elan_acpi_id[i].id,
> +					     strlen(elan_acpi_id[i].id)))
> +					return true;
>  		break;
>  	}
>  
> -- 
> 2.17.1
> 

-- 
Dmitry
