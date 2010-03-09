From: Rafi Rubin <rafi@seas.upenn.edu>
Subject: Re: [PATCH 4/7] HID: N-trig MTM Driver fix And cleanup Patch 4
Date: Mon, 08 Mar 2010 20:10:06 -0500
Message-ID: <4B959FEE.4070907@seas.upenn.edu>
References: <1268082827-2680-1-git-send-email-micki@n-trig.com> <1268082827-2680-2-git-send-email-micki@n-trig.com> <1268082827-2680-3-git-send-email-micki@n-trig.com> <1268082827-2680-4-git-send-email-micki@n-trig.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1268082827-2680-4-git-send-email-micki@n-trig.com>
Sender: linux-kernel-owner@vger.kernel.org
To: mickib1@gmail.com
Cc: jkosina@suse.cz, chatty@enac.fr, peterhuewe@gmx.de, micki@n-trig.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Very interesting.

Minor side point.  This would be the patch to add the usb includes.

Rafi

On 03/08/2010 04:13 PM, mickib1@gmail.com wrote:
> From: micki<micki@micki-laptop.(none)>
>
> Add ntrig_send_report - enable us to configure firmware.
>
> N-trig is changing the way people interact with computers by providin=
g a dual-mode pen and true multi-touch input device, specifically desig=
ned for today's advanced computing world.
> N-trig DuoSense=C2=AE solution provides a real Hands-on computing=C2=AE=
 experience, and sets the stage for OEMs and ISVs to introduce innovati=
ve computer products and applications for an intuitive, Hands-on=C2=AE =
experience directly onscreen.
> DuoSense digitizers are easily integrated into existing technologies,=
 support all LCDs, keep devices slim and light, and can be implemented =
in a broad range of products, ranging from small notebooks to large LCD=
s.
> N-trig has offices in Israel, the US, Taiwan and Japan.
>
> Signed-off-by: Micki Balanga<micki@n-trig.com>
> ---
>   drivers/hid/hid-ntrig.c |   50 ++++++++++++++++++++++++++++++++++++=
+++++++++++
>   1 files changed, 50 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/hid/hid-ntrig.c b/drivers/hid/hid-ntrig.c
> index 8130c3c..8cdb3c2 100644
> --- a/drivers/hid/hid-ntrig.c
> +++ b/drivers/hid/hid-ntrig.c
> @@ -17,6 +17,8 @@
>    *		Add debug Paramater change Driver name in hid_driver structure
>    *	1.2 - N-trig - Change ntrig_input_mapping
>    *	1.3 - N-trig - Change ntrig_input_mapped
> + *	1.4 - N-trig - Add ntrig_send_report function
> + *		send set feature command to firmware
>    */
>
>   /*
> @@ -361,6 +363,54 @@ static int ntrig_event(struct hid_device *hid, s=
truct hid_field *field,
>   	return 1;
>   }
>
> +/*
> + * This function used to configure N-trig firmware
> + * The first command we need to send to firmware is change
> + * to Multi-touch Mode we don't receive a reply
> + */
> +static int ntrig_send_report(struct hid_device *hid)
> +{
> +	struct hid_report *report;
> +	struct list_head *report_list =3D
> +			&hid->report_enum[HID_FEATURE_REPORT].report_list;
> +
> +	if (list_empty(report_list)) {
> +		ntrig_dbg("no feature reports found\n");
> +		return -ENODEV;
> +	}
> +	report =3D list_first_entry(report_list, struct hid_report, list);
> +	if (report->maxfield<  1)
> +		return -ENODEV;
> +
> +	list_for_each_entry(report,
> +			    report_list, list) {
> +		if (report->maxfield<  1) {
> +		      ntrig_dbg("no fields in the report\n");
> +		      continue;
> +		}
> +		ntrig_dbg("Report ID %x\n", report->id);
> +		switch (report->id) {
> +		case REPORTID_DRIVER_ALIVE:
> +		      usbhid_submit_report(hid, report, USB_DIR_OUT);
> +		      break;
> +		      /*
> +		       * These command will implement later accroding to demand
> +		       */
> +		case REPORTID_GET_VERSION:	/* FALLTHRU */
> +		case REPORTID_SET_MODE_DUAL:	/* FALLTHRU */
> +		case REPORTID_CALIBRATION:	/* FALLTHRU */
> +		case REPORTID_GET_MODE:		/* FALLTHRU */
> +		case REPORTID_SET_MODE_PEN:	/* FALLTHRU */
> +		case REPORTID_SET_MODE_TOUCH:	/* FALLTHRU */
> +		case REPORTID_CALIBRATION_RESPOND:/* FALLTHRU */
> +		case HID_CAPACITORS_CALIB:	/* FALLTHRU */
> +		case HID_GET_CAPACITORS_CALIB_DONE:
> +		      break;
> +		}
> +	}
> +	return 0;
> +}
> +
>   static int ntrig_probe(struct hid_device *hdev, const struct hid_de=
vice_id *id)
>   {
>   	int ret;
