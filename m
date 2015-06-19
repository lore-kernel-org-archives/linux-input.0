From: Jason Gerecke <killertofu@gmail.com>
Subject: Re: [PATCH] HID: wacom: remove the extra Pen interface for Wacom
 Bamboo PAD
Date: Fri, 19 Jun 2015 09:06:00 -0700
Message-ID: <55843DE8.6060009@gmail.com>
References: <1434657524-5374-1-git-send-email-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1434657524-5374-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jkosina@suse.cz>, Ping Cheng <pinglinux@gmail.com>, Aaron Skomra <skomra@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On 6/18/2015 12:58 PM, Benjamin Tissoires wrote:
> As mentioned in the comment in the code, both the pen and touch data
> come from the interface tagged as BAMBOO_PAD. The driver re-routes th=
e
> events for the Pen to the generic HID interface and keeps the ones fo=
r
> the touch through this current interface.
>=20
> Clearing the WACOM_DEVICETYPE_PEN bit removes the extra unused interf=
ace
> and makes the Bamboo PAD to behave like in 4.1.
>=20
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> ---
>=20
> Hi,
>=20
> well, the fix was definitively easy to restore the Bamboo PAD interfa=
ce.
>=20
> Thanks Jason for the good cleanup and sorry for not having the time t=
o review
> the previous series.
>=20
> Cheers,
> Benjamin
>=20
>  drivers/hid/wacom_wac.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
> index 232da89..d260528 100644
> --- a/drivers/hid/wacom_wac.c
> +++ b/drivers/hid/wacom_wac.c
> @@ -2223,7 +2223,7 @@ void wacom_setup_device_quirks(struct wacom *wa=
com)
>  	 * so rewrite this one to be of type BTN_TOOL_FINGER.

Nit: Looks like I forgot to update this comment to say
WACOM_DEVICETYPE_TOUCH. Mind fixing that in this patch since you're her=
e
anyway?

Otherwise, looks good :)

Reviewed-by: Jason Gerecke <jason.gerecke@wacom.com>

--=20
Jason
---
Now instead of four in the eights place /
you=92ve got three, =91Cause you added one /
(That is to say, eight) to the two, /
But you can=92t take seven from three, /
So you look at the sixty-fours....

>  	 */
>  	if (features->type =3D=3D BAMBOO_PAD)
> -		features->device_type |=3D WACOM_DEVICETYPE_TOUCH;
> +		features->device_type =3D WACOM_DEVICETYPE_TOUCH;
> =20
>  	if (wacom->hdev->bus =3D=3D BUS_BLUETOOTH)
>  		features->quirks |=3D WACOM_QUIRK_BATTERY;
>=20
