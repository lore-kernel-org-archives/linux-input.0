From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] HID: wacom: generic: Treat HID_DG_TOOLSERIALNUMBER as
 unsigned
Date: Fri, 14 Apr 2017 14:57:46 +0200
Message-ID: <20170414125746.GC301@mail.corp.redhat.com>
References: <20170413153949.23518-1-killertofu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170413153949.23518-1-killertofu@gmail.com>
Sender: stable-owner@vger.kernel.org
To: Jason Gerecke <killertofu@gmail.com>
Cc: linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, Ping Cheng <pinglinux@gmail.com>, Aaron Skomra <skomra@gmail.com>, stable@vger.kernel.org, Jason Gerecke <jason.gerecke@wacom.com>
List-Id: linux-input@vger.kernel.org

On Apr 13 2017 or thereabouts, Jason Gerecke wrote:
> Because HID_DG_TOOLSERIALNUMBER doesn't first cast the value recieved
> from HID to an unsigned type, sign-extension rules can cause the
> value of wacom_wac->serial[0] to inadvertently wind up with all 32 of
> its highest bits set if the highest bit of "value" was set.
> 
> This can cause problems for Tablet PC devices which use AES sensors
> and the xf86-input-wacom userspace driver. It is not uncommon for AES
> sensors to send a serial number of '0' while the pen is entering or
> leaving proximity. The xf86-input-wacom driver ignores events with a
> serial number of '0' since it cannot match them up to an in-use tool.
> To ensure the xf86-input-wacom driver does not ignore the final
> out-of-proximity event, the kernel does not send MSC_SERIAL events
> when the value of wacom_wac->serial[0] is '0'. If the highest bit of
> HID_DG_TOOLSERIALNUMBER is set by an in-prox pen which later leaves
> proximity and sends a '0' for HID_DG_TOOLSERIALNUMBER, then only the
> lowest 32 bits of wacom_wac->serial[0] are actually cleared, causing
> the kernel to send an MSC_SERIAL event. Since the 'input_event'
> function takes an 'int' as argument, only those lowest (now-cleared)
> 32 bits of wacom_wac->serial[0] are sent to userspace, causing
> xf86-input-wacom to ignore the event. If the event was the final
> out-of-prox event, then xf86-input-wacom may remain in a state where
> it believes the pen is in proximity and refuses to allow other
> devices under its control (e.g. the touchscreen) to move the cursor.
> 
> It should be noted that EMR devices and devices which use both the
> HID_DG_TOOLSERIALNUMBER and WACOM_HID_WD_SERIALHI usages (in that
> order) would be immune to this issue. It appears only AES devices are
> affected.
> 
> Fixes: f85c9dc678a ("HID: wacom: generic: Support tool ID and additional tool types")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
> ---

Acked-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

>  drivers/hid/wacom_wac.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
> index 1f3bdd16e159..51cf3d5eb478 100644
> --- a/drivers/hid/wacom_wac.c
> +++ b/drivers/hid/wacom_wac.c
> @@ -2002,7 +2002,7 @@ static void wacom_wac_pen_event(struct hid_device *hdev, struct hid_field *field
>  		return;
>  	case HID_DG_TOOLSERIALNUMBER:
>  		wacom_wac->serial[0] = (wacom_wac->serial[0] & ~0xFFFFFFFFULL);
> -		wacom_wac->serial[0] |= value;
> +		wacom_wac->serial[0] |= (__u32)value;
>  		return;
>  	case WACOM_HID_WD_SENSE:
>  		wacom_wac->hid_data.sense_state = value;
> -- 
> 2.12.0
> 
