From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 2/6] mfd: rtsx_usb: fix platform device-id collision
Date: Tue, 7 Oct 2014 10:22:58 +0100
Message-ID: <20141007092258.GR25331@lee--X1>
References: <1411728933-13351-1-git-send-email-johan@kernel.org>
 <1411728933-13351-3-git-send-email-johan@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f169.google.com ([209.85.213.169]:37946 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753560AbaJGJXE (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 7 Oct 2014 05:23:04 -0400
Received: by mail-ig0-f169.google.com with SMTP id uq10so6288731igb.2
        for <linux-input@vger.kernel.org>; Tue, 07 Oct 2014 02:23:03 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1411728933-13351-3-git-send-email-johan@kernel.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Johan Hovold <johan@kernel.org>
Cc: Samuel Ortiz <sameo@linux.intel.com>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org

On Fri, 26 Sep 2014, Johan Hovold wrote:

> Hot-pluggable multi-function devices should use PLATFORM_DEVID_AUTO t=
o
> avoid name collisions on the platform bus.
>=20
> This driver currently uses the USB-device address as an id. This make=
s
> name collisions unlikely, but it could still happen if two devices ar=
e
> connected to separate buses and gets assigned the same address.
>=20
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---
>  drivers/mfd/rtsx_usb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

This patch is superfluous.

Just wait until the hotpluggable version is applied, then use it.

> diff --git a/drivers/mfd/rtsx_usb.c b/drivers/mfd/rtsx_usb.c
> index 71f387ce8cbd..78073e4b87e4 100644
> --- a/drivers/mfd/rtsx_usb.c
> +++ b/drivers/mfd/rtsx_usb.c
> @@ -647,7 +647,7 @@ static int rtsx_usb_probe(struct usb_interface *i=
ntf,
>  	/* initialize USB SG transfer timer */
>  	setup_timer(&ucr->sg_timer, rtsx_usb_sg_timed_out, (unsigned long) =
ucr);
> =20
> -	ret =3D mfd_add_devices(&intf->dev, usb_dev->devnum, rtsx_usb_cells=
,
> +	ret =3D mfd_add_devices(&intf->dev, PLATFORM_DEVID_AUTO, rtsx_usb_c=
ells,
>  			ARRAY_SIZE(rtsx_usb_cells), NULL, 0, NULL);
>  	if (ret)
>  		goto out_init_fail;

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
