From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: wacom: Work around HID descriptor bug in DTK-2451
 and DTH-2452
Date: Thu, 11 Oct 2018 14:33:43 +0200 (CEST)
Message-ID: <nycvar.YFH.7.76.1810111432530.14430@cbobk.fhfr.pm>
References: <20181010204026.4555-1-killertofu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20181010204026.4555-1-killertofu@gmail.com>
Sender: stable-owner@vger.kernel.org
To: Jason Gerecke <killertofu@gmail.com>
Cc: linux-input@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Ping Cheng <pinglinux@gmail.com>, Jason Gerecke <jason.gerecke@wacom.com>, stable@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wed, 10 Oct 2018, Jason Gerecke wrote:

> The DTK-2451 and DTH-2452 have a buggy HID descriptor which incorrectly
> contains a Cintiq-like report, complete with pen tilt, rotation, twist,
> serial number, etc. The hardware doesn't actually support this data but
> our driver duitifully sets up the device as though it does. To ensure
> userspace has a correct view of devices without updated firmware, we clean
> up this incorrect data in wacom_setup_device_quirks.
> 
> We're also careful to clear the WACOM_QUIRK_TOOLSERIAL flag since its
> presence causes the driver to wait for serial number information (via
> wacom_wac_pen_serial_enforce) that never comes, resulting in the pen
> being non-responsive.
> 
> Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
> Fixes: 8341720642 ("HID: wacom: Queue events with missing type/serial data for later processing")
> Cc: stable@vger.kernel.org # v4.16+
> ---
>  drivers/hid/wacom_wac.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
> index e0a06be5ef5c..b4b4a30e3982 100644
> --- a/drivers/hid/wacom_wac.c
> +++ b/drivers/hid/wacom_wac.c
> @@ -3335,6 +3335,7 @@ static void wacom_setup_intuos(struct wacom_wac *wacom_wac)
>  
>  void wacom_setup_device_quirks(struct wacom *wacom)
>  {
> +	struct wacom_wac *wacom_wac = &wacom->wacom_wac;
>  	struct wacom_features *features = &wacom->wacom_wac.features;
>  
>  	/* The pen and pad share the same interface on most devices */
> @@ -3464,6 +3465,25 @@ void wacom_setup_device_quirks(struct wacom *wacom)
>  
>  	if (features->type == REMOTE)
>  		features->device_type |= WACOM_DEVICETYPE_WL_MONITOR;
> +
> +	/* HID descriptor for DTK-2451 / DTH-2452 claims to report lots
> +	 * of things it shouldn't. Lets fix up the damage...
> +	 */
> +	if (wacom->hdev->product == 0x382 || wacom->hdev->product == 0x37d) {
> +		features->quirks &= ~WACOM_QUIRK_TOOLSERIAL;
> +		__clear_bit(BTN_TOOL_BRUSH, wacom_wac->pen_input->keybit);
> +		__clear_bit(BTN_TOOL_PENCIL, wacom_wac->pen_input->keybit);
> +		__clear_bit(BTN_TOOL_AIRBRUSH, wacom_wac->pen_input->keybit);
> +		__clear_bit(ABS_Z, wacom_wac->pen_input->absbit);
> +		__clear_bit(ABS_DISTANCE, wacom_wac->pen_input->absbit);
> +		__clear_bit(ABS_TILT_X, wacom_wac->pen_input->absbit);
> +		__clear_bit(ABS_TILT_Y, wacom_wac->pen_input->absbit);
> +		__clear_bit(ABS_WHEEL, wacom_wac->pen_input->absbit);
> +		__clear_bit(ABS_MISC, wacom_wac->pen_input->absbit);
> +		__clear_bit(MSC_SERIAL, wacom_wac->pen_input->mscbit);
> +		__clear_bit(EV_MSC, wacom_wac->pen_input->evbit);
> +	}
>  }
>  
>  int wacom_setup_pen_input_capabilities(struct input_dev *input_dev,

I don't know how you did it (I can't spot anything wrong there), but both 
git and patch complain about this line when trying to apply the patch :)

Anyway, I've applied it "manually" to for-4.19/fixes branch. Thanks,

-- 
Jiri Kosina
SUSE Labs
