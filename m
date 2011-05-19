From: Chase Douglas <chase.douglas@canonical.com>
Subject: Re: 35022: hid-magicmouse broken
Date: Thu, 19 May 2011 14:03:01 -0400
Message-ID: <4DD55B55.3020306@canonical.com>
References: <4DD26CB8.7070409@canonical.com> <alpine.LNX.2.00.1105171448230.28291@pobox.suse.cz> <4DD2C913.4000403@canonical.com> <alpine.LNX.2.00.1105191357350.28291@pobox.suse.cz> <4DD51763.1020209@canonical.com> <alpine.LNX.2.00.1105191648480.28291@pobox.suse.cz> <4DD539E8.8090301@canonical.com> <alpine.LNX.2.00.1105191801540.28291@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from adelie.canonical.com ([91.189.90.139]:52398 "EHLO
	adelie.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933758Ab1ESSDI (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 19 May 2011 14:03:08 -0400
In-Reply-To: <alpine.LNX.2.00.1105191801540.28291@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input <linux-input@vger.kernel.org>, Michael Poole <mdpoole@troilus.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Alan Ott <alan@signal11.us>

On 05/19/2011 12:03 PM, Jiri Kosina wrote:
> On Thu, 19 May 2011, Chase Douglas wrote:
>=20
>>>> [  195.491735] Bluetooth: HIDP (Human Interface Emulation) ver 1.2
>>>> [  222.693947] input: cndougla=92s trackpad as
>>>> /devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.3/1-1.3.3/1-1.3.3:1.=
0/bluetooth/hci0/hci0:12/input16
>>>> [  222.694119] magicmouse 0005:05AC:030E.0005: input,hidraw3: BLUE=
TOOTH
>>>> HID v1.60 Mouse [cndougla=92s trackpad] on 50:63:13:90:AF:A4
>>>> [  222.694128] hidp_output_raw_report, report_type: 2
>>>> [  222.808111] session ffff88012d9b1200 param 0x02
>>>> [  222.808198] hidp: returnign -EIO because of !output_report_succ=
ess
>>>> [  222.808209] magicmouse 0005:05AC:030E.0005: unable to request t=
ouch
>>>> data (-5)
>>>> [  222.809358] session ffff88012d9b1200 param 0x02
>>>> [  222.810606] session ffff88012d9b1200 param 0x02
>>>> [  222.813113] session ffff88012d9b1200 param 0x00
>>>> [  223.045363] magicmouse: probe of 0005:05AC:030E.0005 failed wit=
h error -5
>>>
>>> Ok, so what is happening here is that magicmouse_probe() sends the =
{ 0xd7,=20
>>> 0x01 } feature report to the device, and it responds with=20
>>> HIDP_HSHK_ERR_INVALID_REPORT_ID.
>>>
>>> That's why the _raw callback (correctly) returns error.
>>>
>>> So the question to the driver authors is -- what is the point behin=
d the {=20
>>> 0xd7, 0x01 } report? Clearly the device doesn't like it during prob=
e=20
>>> because of invalid report ID.
>>> And it never did, we just silently ignored the error with the older=
=20
>>> kernels.
>>
>> The feature report is what flips the devices (magic mouse, magic
>> trackpad) into multitouch mode. Without the report, the mouse will n=
ot
>> emit the location of any touches on its surface, and the trackpad wi=
ll
>> only emit single touch data.
>>
>> What do you think we should do? We can't get rid of the report. Shou=
ld
>> we silently ignore the error?
>=20
> Hmm, I am afraid that it's the only option (apart from thowing the wh=
ole=20
> 'waiting for ack' infrastructure away, which would be sad, as it's a =
good=20
> thing in principle).
>=20
> So how about the patch below? :/ Could you please verify that it make=
s=20
> hid-magicmouse work again? Thanks.
>=20
>=20
>=20
> From: Jiri Kosina <jkosina@suse.cz>
> Subject: [PATCH] HID: magicmouse: ignore 'ivalid report id' while swi=
tching modes
>=20
> The device reponds with 'invalid report id' when feature report switc=
hing it
> into multitouch mode is sent to it.
>=20
> This has been silently ignored before 0825411ade ("HID: bt: Wait for =
ACK
> on Sent Reports"), but since this commit, it propagates -EIO from the=
 _raw
> callback .
>=20
> So let the driver ignore -EIO as response to 0xd7,0x01 report, as tha=
t's
> how the device reacts in normal mode.
>=20
> Sad, but following reality.
>=20
> This fixes https://bugzilla.kernel.org/show_bug.cgi?id=3D35022
>=20
> Signed-off-by: Jiri Kosina <jkosina@suse.cz>
> ---
>  drivers/hid/hid-magicmouse.c |   10 +++++++++-
>  1 files changed, 9 insertions(+), 1 deletions(-)
>=20
> diff --git a/drivers/hid/hid-magicmouse.c b/drivers/hid/hid-magicmous=
e.c
> index 0ec91c1..a5eda4c 100644
> --- a/drivers/hid/hid-magicmouse.c
> +++ b/drivers/hid/hid-magicmouse.c
> @@ -501,9 +501,17 @@ static int magicmouse_probe(struct hid_device *h=
dev,
>  	}
>  	report->size =3D 6;
> =20
> +	/*
> +	 * The device reponds with 'invalid report id' when feature
> +	 * report switching it into multitouch mode is sent to it.
> +	 *
> +	 * This results in -EIO from the _raw low-level transport callback,
> +	 * but there seems to be no other way of switching the mode.
> +	 * Thus the super-ugly hacky success check below.
> +	 */
>  	ret =3D hdev->hid_output_raw_report(hdev, feature, sizeof(feature),
>  			HID_FEATURE_REPORT);
> -	if (ret !=3D sizeof(feature)) {
> +	if (ret !=3D -EIO) {
>  		hid_err(hdev, "unable to request touch data (%d)\n", ret);
>  		goto err_stop_hw;
>  	}

Seems to work for me :).

Reviewed-by: Chase Douglas <chase.douglas@canonical.com>

Thanks!
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
