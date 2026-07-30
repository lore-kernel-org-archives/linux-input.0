Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0614219E7;
	Thu, 30 Jul 2026 20:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785443396; cv=none; b=HBIq5OneN8f9RrvBl1AFEA9CYXAT655oAdf/oYz3txeaIOSWga3t0j9t/BO4+eGXHqoZ9xoWVNbNPKmZzMykIz7ArCsrfJ0LehBCwZoGCaIkISRkCBZ+VpPS6nP+nHxVMwzSUUnnX9K/YAeC0F7IhrdmgRkJMxRhcIZ9AR8qMr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785443396; c=relaxed/simple;
	bh=9s9qvb0Yqifrjl+UhwI8LkPNBSjOgXWIwfkJVTojDnM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SX9+M9KDKI6rsKHz57d3d44lwPWwN768rBesUCtAohbC8/2UcgpLWz5iwA7opo/qeM2ogmr5qU0xXIefg5yqygb/EjiiMmisQ7mdrt9RVdFUuNsA1e24FL/0naLEyMDn6HzbGq0Ej2P5opNhMF+U/dNJ+M1jiMy7Z/M0jiBMUO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X7iCB2ST; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X7iCB2ST"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA2351F000E9;
	Thu, 30 Jul 2026 20:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785443386;
	bh=baCxA6V7+2+SBHgHyrGiPxKPK/RmqEGOEVcXNdkcMA8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=X7iCB2STCjM+o/fo/4FifbQuMyk5QvMEfyNS+AZhW938q3ox3CQ3we44fAyzSXqwi
	 xOoeq+IC12ibkWkR0RVBYMPe3ErfdKNyQK8tqnAzoGNAQqt+BE72uTaLoAjPQdf2Tn
	 c78utGEmmoe2W2sgVLL9qOc5K+/yNS+AppqFJFFm0zwPu9yontIEPz9q9D9xQNA4MT
	 B5W9f5vhw20sTct22KiCOQSSOmzcIyou/+useK8eXYHTd4Hal+x8PzJVwqMTcJwlYs
	 gn8iL/jNHgF+PhONv37Kzk3ijFH0/y1pMMSzgv4ntLe4wBbtaKWt2RZjGzZWVFvEws
	 6oVIbk9rv6VlQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/5] Input: zinitix - add support for modes 0 and 1
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kaustabh Chakraborty" <kauschluss@disroot.org>
Cc: devicetree@vger.kernel.org, robh@kernel.org, linux-input@vger.kernel.org, conor+dt@kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260731-zinitix-modes-v3-3-2c8de712997a@disroot.org>
References: <20260731-zinitix-modes-v3-0-2c8de712997a@disroot.org>
 <20260731-zinitix-modes-v3-3-2c8de712997a@disroot.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 20:29:45 +0000
Message-Id: <20260730202945.AA2351F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Race condition in probe leading to NULL pointer dereference in IRQ=
 handler
--

--- Patch [3]: [PATCH v3 3/5] Input: zinitix - add support for modes 0 and =
1 ---
commit d8a438a256bc9e4876b89aa10b882e0dd303cf72
Author: Kaustabh Chakraborty <kauschluss@disroot.org>

Input: zinitix - add support for modes 0 and 1

The commit adds support for touch coordinate modes 0 and 1 for zinitix
touchscreens. It abstracts the reading function into a function pointer
read_point_status inside the device's private struct, assigned based on
the zinitix,mode property.

> diff --git a/drivers/input/touchscreen/zinitix.c b/drivers/input/touchscr=
een/zinitix.c
> index a0a89d25e25bb..aafd0b7d8edbd 100644
> --- a/drivers/input/touchscreen/zinitix.c
> +++ b/drivers/input/touchscreen/zinitix.c
> @@ -451,8 +563,7 @@ static irqreturn_t zinitix_ts_irq_handler(int irq, vo=
id *bt541_handler)
> =20
>  	memset(&touch_event, 0, sizeof(struct touch_event));
> =20
> -	error =3D zinitix_read_data(bt541->client, ZINITIX_POINT_STATUS_REG,
> -				  &touch_event, sizeof(struct touch_event));
> +	error =3D bt541->read_point_status(bt541, &touch_event);

[Severity: High]
Is there a possibility of a NULL pointer dereference here?

In zinitix_ts_probe(), zinitix_init_input_dev() is called before the
read_point_status function pointer is assigned.

zinitix_init_input_dev() registers the input device, making it visible to
userspace. If a userspace process opens the device immediately and an inter=
rupt
fires, zinitix_ts_irq_handler() could run and dereference this function poi=
nter
while it is still NULL.

>  	if (error) {
>  		dev_err(&client->dev, "Failed to read in touchpoint struct\n");
>  		goto out;

[ ... ]

> @@ -682,13 +793,19 @@ static int zinitix_ts_probe(struct i2c_client *clie=
nt)
>  		bt541->zinitix_mode =3D DEFAULT_TOUCH_POINT_MODE;
>  	}
> =20
> -	if (bt541->zinitix_mode !=3D 2) {
> -		/*
> -		 * If there are devices that don't support mode 2, support
> -		 * for other modes (0, 1) will be needed.
> -		 */
> +	switch (bt541->zinitix_mode) {
> +	case 0:
> +		bt541->read_point_status =3D zinitix_read_point_status_mode0;
> +		break;
> +	case 1:
> +		bt541->read_point_status =3D zinitix_read_point_status_mode1;
> +		break;
> +	case 2:
> +		bt541->read_point_status =3D zinitix_read_point_status_mode2;
> +		break;
> +	default:
>  		dev_err(&client->dev,
> -			"Malformed zinitix,mode property, must be 2 (supplied: %d)\n",
> +			"Malformed zinitix,mode property, must be 0, 1, or 2 (supplied: %d)\n=
",
>  			bt541->zinitix_mode);
>  		return -EINVAL;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731-zinitix-mo=
des-v3-0-2c8de712997a@disroot.org?part=3D3
