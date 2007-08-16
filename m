From: Len Brown <lenb@kernel.org>
Subject: Re: [RFC] [PATCH V2 2/3] ACPI video hotkey: remove invalid events handled by video output devices
Date: Wed, 15 Aug 2007 23:16:33 -0400
Message-ID: <200708152316.34097.lenb@kernel.org>
References: <1186780044.6830.58.camel@rzhang-asus.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <1186780044.6830.58.camel@rzhang-asus.sh.intel.com>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Zhang Rui <rui.zhang@intel.com>, linux-input@atrey.karlin.mff.cuni.cz
Cc: linux-acpi@vger.kernel.org, mjg59@srcf.ucam.org, dmitry.torokhov@gmail.com, hmh@hmh.eng.hr, hughsient@gmail.com, luming.yu@intel.com
List-Id: linux-input@vger.kernel.org

On Friday 10 August 2007 17:07, Zhang Rui wrote:
> Both ACPI_VIDEO_NOTIFY_SWITCH and ACPI_VIDEO_NOTIFY_PROBE
> are valid for video Display Devices only.
> 
> ACPI video output devices should not handle these kinds of events.

please update this description to clarify that
these event codes are handled by the video bus,
and thus should simply not be here in the video device.

> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
>  drivers/acpi/video.c |    4 ----
>  1 file changed, 4 deletions(-)
> 
> Index: linux-2.6.23-rc2/drivers/acpi/video.c
> ===================================================================
> --- linux-2.6.23-rc2.orig/drivers/acpi/video.c
> +++ linux-2.6.23-rc2/drivers/acpi/video.c
> @@ -1813,10 +1813,6 @@ static void acpi_video_device_notify(acp
>  	device = video_device->dev;
>  
>  	switch (event) {
> -	case ACPI_VIDEO_NOTIFY_SWITCH:	/* change in status (cycle output device) */
> -	case ACPI_VIDEO_NOTIFY_PROBE:	/* change in status (output device status) */
> -		acpi_bus_generate_event(device, event, 0);
> -		break;
>  	case ACPI_VIDEO_NOTIFY_CYCLE_BRIGHTNESS:	/* Cycle brightness */
>  	case ACPI_VIDEO_NOTIFY_INC_BRIGHTNESS:	/* Increase brightness */
>  	case ACPI_VIDEO_NOTIFY_DEC_BRIGHTNESS:	/* Decrease brightness */
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
