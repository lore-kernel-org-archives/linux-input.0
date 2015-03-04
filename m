From: Jason Gerecke <killertofu@gmail.com>
Subject: Re: [PATCH] HID: wacom: ask for a in-prox report when it was missed
Date: Tue, 03 Mar 2015 17:30:42 -0800
Message-ID: <54F66042.60107@gmail.com>
References: <1425403228-19841-1-git-send-email-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f169.google.com ([209.85.192.169]:34320 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751500AbbCDBar (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 3 Mar 2015 20:30:47 -0500
In-Reply-To: <1425403228-19841-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jkosina@suse.cz>, Ping Cheng <pinglinux@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On 3/3/2015 9:20 AM, Benjamin Tissoires wrote:
> If noone listens to the input device when a tool comes in proximity,
> the tablet does not send the in-prox event when a client becomes avai=
lable.
> That means that no events will be sent until the tool is taken out of
> proximity.
>
> In this situation, ask for the report WACOM_REPORT_INTUOSREAD which w=
ill
> read the corresponding feature and generate an in-prox event.
>
> We don't schedule this read while we are in an IO interrupt because w=
e
> know that usbhid will do it asynchronously. If this is triggered by u=
hid
> then this is obviously a client side bug :)
>
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Ping and I were both a little confused by this patch. Our first=20
impression was that this wouldn't accomplish anything since the driver=20
would see events from the tablet regardless of if a client were=20
connected or not. Testing proved us wrong though, with the events=20
clearly going to that great /dev/null in the sky. Is this behavior=20
different from the USB and HID subsystems? IIRC, the prox code didn't=20
use to behave like this...

Under the assumption that USB events are indeed being dropped until a=20
client is connected, then this patch looks fairly reasonable. It=20
doesn't, however, seem to work reliably across tablets. An Intuos Pro=20
reacted as I'd expect (with the patch in place, already-in-prox tools=20
actually send events once e.g. evemu-record is run) but didn't seem to=20
do anything for an Intuos5 or Intuos3 (nothing comes through=20
evemu-record until I removed the tool from prox and then put it back in=
).

--=20
Jason
---
Now instead of four in the eights place /
you=92ve got three, =91Cause you added one /
(That is to say, eight) to the two, /
But you can=92t take seven from three, /
So you look at the sixty-fours....

> ---
>   drivers/hid/wacom_wac.c | 18 +++++++++++++++++-
>   1 file changed, 17 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
> index 9ec4545..ff9a7ab 100644
> --- a/drivers/hid/wacom_wac.c
> +++ b/drivers/hid/wacom_wac.c
> @@ -430,6 +430,19 @@ exit:
>   	return retval;
>   }
>  =20
> +static void wacom_intuos_schedule_prox_event(struct wacom_wac *wacom=
_wac)
> +{
> +	struct wacom *wacom =3D container_of(wacom_wac, struct wacom, wacom=
_wac);
> +	struct hid_report *r;
> +	struct hid_report_enum *re;
> +
> +	re =3D &(wacom->hdev->report_enum[HID_FEATURE_REPORT]);
> +	r =3D re->report_id_hash[WACOM_REPORT_INTUOSREAD];
> +	if (r) {
> +		hid_hw_request(wacom->hdev, r, HID_REQ_GET_REPORT);
> +	}
> +}
> +
>   static int wacom_intuos_inout(struct wacom_wac *wacom)
>   {
>   	struct wacom_features *features =3D &wacom->features;
> @@ -609,8 +622,11 @@ static int wacom_intuos_inout(struct wacom_wac *=
wacom)
>   	}
>  =20
>   	/* don't report other events if we don't know the ID */
> -	if (!wacom->id[idx])
> +	if (!wacom->id[idx]) {
> +		/* but reschedule a read of the current tool */
> +		wacom_intuos_schedule_prox_event(wacom);
>   		return 1;
> +	}
>  =20
>   	return 0;
>   }
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
