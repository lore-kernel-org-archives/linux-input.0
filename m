From: Przemo Firszt <przemo@firszt.eu>
Subject: Re: [PATCH 11/10] Input - wacom: Check for bluetooth protocol while
 setting OLEDs
Date: Sat, 26 Jul 2014 13:05:31 +0100
Message-ID: <1406376331.2611.3.camel@fedora-lan>
References: <1406225645-32141-1-git-send-email-benjamin.tissoires@redhat.com>
	 <1406330411-7851-1-git-send-email-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1406330411-7851-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, Ping Cheng <pinglinux@gmail.com>, Jason Gerecke <killertofu@gmail.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Whole series (after including bt image fix):
Tested-By: Przemo Firszt <przemo@firszt.eu>

Dnia 2014-07-25, pi=C4=85 o godzinie 19:20 -0400, Benjamin Tissoires pi=
sze:
> Bluetooth Intuos 4 use 1-bit definition while the USB ones use a 4-bi=
ts
> definition. This changes the size of the raw image we receive, and th=
us
> the kernel will only accept 1-bit images for Bluetooth and 4-bits for
> USB.
>=20
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> ---
>  drivers/hid/wacom_sys.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
> index 3adc6ef..42f139f 100644
> --- a/drivers/hid/wacom_sys.c
> +++ b/drivers/hid/wacom_sys.c
> @@ -531,12 +531,14 @@ static int wacom_led_control(struct wacom *waco=
m)
>  	return retval;
>  }
> =20
> -static int wacom_led_putimage(struct wacom *wacom, int button_id, co=
nst void *img)
> +static int wacom_led_putimage(struct wacom *wacom, int button_id,
> +		const unsigned len, const void *img)
>  {
>  	unsigned char *buf;
>  	int i, retval;
> +	const unsigned chunk_len =3D len / 4; /* 4 chunks are needed to be =
sent */
> =20
> -	buf =3D kzalloc(259, GFP_KERNEL);
> +	buf =3D kzalloc(chunk_len + 3 , GFP_KERNEL);
>  	if (!buf)
>  		return -ENOMEM;
> =20
> @@ -552,11 +554,11 @@ static int wacom_led_putimage(struct wacom *wac=
om, int button_id, const void *im
>  	buf[1] =3D button_id & 0x07;
>  	for (i =3D 0; i < 4; i++) {
>  		buf[2] =3D i;
> -		memcpy(buf + 3, img + i * 256, 256);
> +		memcpy(buf + 3, img + i * chunk_len, chunk_len);
> =20
>  		retval =3D wacom_set_report(wacom->hdev, HID_FEATURE_REPORT,
>  					  WAC_CMD_ICON_XFER,
> -					  buf, 259, WAC_CMD_RETRIES);
> +					  buf, chunk_len + 3, WAC_CMD_RETRIES);
>  		if (retval < 0)
>  			break;
>  	}
> @@ -657,13 +659,14 @@ static ssize_t wacom_button_image_store(struct =
device *dev, int button_id,
>  	struct hid_device *hdev =3D container_of(dev, struct hid_device, de=
v);
>  	struct wacom *wacom =3D hid_get_drvdata(hdev);
>  	int err;
> +	const unsigned len =3D hdev->bus =3D=3D BUS_BLUETOOTH ? 256 : 1024;
> =20
> -	if (count !=3D 1024)
> +	if (count !=3D len)
>  		return -EINVAL;
> =20
>  	mutex_lock(&wacom->lock);
> =20
> -	err =3D wacom_led_putimage(wacom, button_id, buf);
> +	err =3D wacom_led_putimage(wacom, button_id, len, buf);
> =20
>  	mutex_unlock(&wacom->lock);
> =20

--=20
Kind regards,
Przemo Firszt
