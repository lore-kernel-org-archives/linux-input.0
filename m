From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 5/6] HID: hid-sensor-hub: use mfd_add_hotplug_devices
 helper
Date: Tue, 7 Oct 2014 10:24:52 +0100
Message-ID: <20141007092452.GU25331@lee--X1>
References: <1411728933-13351-1-git-send-email-johan@kernel.org>
 <1411728933-13351-6-git-send-email-johan@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f179.google.com ([209.85.213.179]:35785 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753277AbaJGJY6 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 7 Oct 2014 05:24:58 -0400
Received: by mail-ig0-f179.google.com with SMTP id h18so4345570igc.6
        for <linux-input@vger.kernel.org>; Tue, 07 Oct 2014 02:24:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1411728933-13351-6-git-send-email-johan@kernel.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Johan Hovold <johan@kernel.org>
Cc: Samuel Ortiz <sameo@linux.intel.com>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org

On Fri, 26 Sep 2014, Johan Hovold wrote:

> Use mfd_add_hotplug_devices helper to register the subdevices.
>=20
> Compile-only tested.
>=20
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---
>  drivers/hid/hid-sensor-hub.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)

Applied for v3.19 with Jiri's Ack.

> diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-hu=
b.c
> index 2ac25760a9a9..fbe1a6d2aa53 100644
> --- a/drivers/hid/hid-sensor-hub.c
> +++ b/drivers/hid/hid-sensor-hub.c
> @@ -641,9 +641,6 @@ static int sensor_hub_probe(struct hid_device *hd=
ev,
>  					goto err_stop_hw;
>  			}
>  			sd->hid_sensor_hub_client_devs[
> -				sd->hid_sensor_client_cnt].id =3D
> -							PLATFORM_DEVID_AUTO;
> -			sd->hid_sensor_hub_client_devs[
>  				sd->hid_sensor_client_cnt].name =3D name;
>  			sd->hid_sensor_hub_client_devs[
>  				sd->hid_sensor_client_cnt].platform_data =3D
> @@ -659,8 +656,9 @@ static int sensor_hub_probe(struct hid_device *hd=
ev,
>  	if (last_hsdev)
>  		last_hsdev->end_collection_index =3D i;
> =20
> -	ret =3D mfd_add_devices(&hdev->dev, 0, sd->hid_sensor_hub_client_de=
vs,
> -		sd->hid_sensor_client_cnt, NULL, 0, NULL);
> +	ret =3D mfd_add_hotplug_devices(&hdev->dev,
> +			sd->hid_sensor_hub_client_devs,
> +			sd->hid_sensor_client_cnt);
>  	if (ret < 0)
>  		goto err_stop_hw;
> =20

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
