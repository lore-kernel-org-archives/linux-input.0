From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 6/6] mfd: core: fix platform-device id generation
Date: Tue, 7 Oct 2014 10:25:12 +0100
Message-ID: <20141007092512.GV25331@lee--X1>
References: <1411728933-13351-1-git-send-email-johan@kernel.org>
 <1411728933-13351-7-git-send-email-johan@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f171.google.com ([209.85.223.171]:49828 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753721AbaJGJZS (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 7 Oct 2014 05:25:18 -0400
Received: by mail-ie0-f171.google.com with SMTP id tr6so4981321ieb.2
        for <linux-input@vger.kernel.org>; Tue, 07 Oct 2014 02:25:18 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1411728933-13351-7-git-send-email-johan@kernel.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Johan Hovold <johan@kernel.org>
Cc: Samuel Ortiz <sameo@linux.intel.com>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org

On Fri, 26 Sep 2014, Johan Hovold wrote:

> Make sure to always honour multi-function devices registered with
> PLATFORM_DEVID_NONE (-1) or PLATFORM_DEVID_AUTO (-2) as id base. In t=
his
> case it does not make sense to append the cell id to the mfd-id base =
and
> potentially change the requested behaviour.
>=20
> Specifically this will allow multi-function devices to be registered
> with PLATFORM_DEVID_AUTO while still having non-zero cell ids.
>=20
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---
>  drivers/mfd/mfd-core.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)

Applied for v3.19.

> diff --git a/drivers/mfd/mfd-core.c b/drivers/mfd/mfd-core.c
> index 892d343193ad..79f25633d7db 100644
> --- a/drivers/mfd/mfd-core.c
> +++ b/drivers/mfd/mfd-core.c
> @@ -87,9 +87,15 @@ static int mfd_add_device(struct device *parent, i=
nt id,
>  	struct platform_device *pdev;
>  	struct device_node *np =3D NULL;
>  	int ret =3D -ENOMEM;
> +	int platform_id;
>  	int r;
> =20
> -	pdev =3D platform_device_alloc(cell->name, id + cell->id);
> +	if (id < 0)
> +		platform_id =3D id;
> +	else
> +		platform_id =3D id + cell->id;
> +
> +	pdev =3D platform_device_alloc(cell->name, platform_id);
>  	if (!pdev)
>  		goto fail_alloc;
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
