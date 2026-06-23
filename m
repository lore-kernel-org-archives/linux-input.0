Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 249A82F7F1B
	for <linux-input@vger.kernel.org>; Tue, 23 Jun 2026 17:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782236113; cv=none; b=kg2f8AS0/QoFRHjEZ9FWVXUD1McM2g1/03XqDaa8Ihb90bcuduuo1ksE8VGYQ9vCOJ7oMSEjcgF8jj3XYHH8RzHXNorX6GOVAKNcp7WKFXgYaT0TF1gvldAjbqxmYweK4bJ+EGNibIYjlr8E/vBMpcDdHx0skpL3qbKlBeUnbh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782236113; c=relaxed/simple;
	bh=VLbW0k0Gsmk4UOj6/IysYs1mO9EMPWOJVLkrOZFLvhY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nDilgljVB1uola9qGq+dILqoNRjH8TKvp9likllW62PKZlVTRJVhxW6GZQVPWwxLIoJxiOitRCmProsZRGnQIZPsJVjiev6zt6NQ1OanMmz0EK1u/YmBPgK8WUOUId7ulB5bK7iZ0Vb/tw3GeSHFhHfEakfg1ZMKhQAyNNFRCbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kAgP58EH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kAgP58EH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B7531F000E9;
	Tue, 23 Jun 2026 17:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782236111;
	bh=WnFCzdxZOfsGXbG9KVQEeo48vmA/rvFxKEtWVenmsL0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kAgP58EHTVLlb7dYzniVjBLKY8IK5XmKzZWyv58NbiEwEDABiIyeNCyOlQqTSOVZ4
	 c/RwpDFAxT3TKvDTgHKRXD0ZDaM+v2Dh/SmcsfmmZNBkBD+98dkn+NFpECvTg4dBz3
	 LvwwQ95ciJa6eRBvUTTx5IQtehUP6fcEn2sSczxmg6JNlKitdxdWVC97XGUT/3aNXq
	 ZS75Y/UGncsLoaGglpKJqvbLdpXFlu8eCm1zURl4J1yg70Fap2sxQOU6ONrgSwhqCa
	 D/E9LesLTiR7QzMA+0dVwcYRFfFTyfKUOsdsa/bljwnowH2dj8vrWcPGyXkUPXw4Ns
	 QZE2wAt61J9qA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 10/10] HID: steelseries: Add support for Arctis Nova
 7 Gen2 family
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sriman Achanta" <srimanachanta@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260623172310.272708-11-srimanachanta@gmail.com>
References: <20260623172310.272708-1-srimanachanta@gmail.com>
 <20260623172310.272708-11-srimanachanta@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 17:35:11 +0000
Message-Id: <20260623173511.9B7531F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Medium] The unconditional minimum size check in the Gen2 parsing functio=
n may silently drop valid unsolicited status updates.

Pre-existing issues:
- [High] Unsafe fetching of the sibling interface's private data lacks driv=
er validation and synchronization, leading to Type Confusion and Use-After-=
Free.
--

commit ca415cb624472143e783db3389a867c4e203e6c8
Author: Sriman Achanta <srimanachanta@gmail.com>

HID: steelseries: Add support for Arctis Nova 7 Gen2 family

This commit adds support for the Arctis Nova 7 Gen2 headsets.
It introduces a new parsing helper for the Gen2 status format and uses an
async interface to handle unsolicited battery and connection updates without
polling.

> diff --git a/drivers/hid/hid-steelseries-arctis.c b/drivers/hid/hid-steel=
series-arctis.c
> --- a/drivers/hid/hid-steelseries-arctis.c
> +++ b/drivers/hid/hid-steelseries-arctis.c
[ ... ]
> @@ -163,6 +170,30 @@ static void steelseries_arctis_9_parse_status(struct=
 steelseries_device *sd,
>  	}
>  }
> =20
> +static void steelseries_arctis_nova_7_gen2_parse_status(struct steelseri=
es_device *sd,
> +							u8 *data, int size)
> +{
> +	if (size < 4)
> +		return;

[Severity: Medium]
Will this strict minimum size check silently drop valid short packets?

Since opcodes like 0xb7, 0xb9, and 0xbb only appear to require 2 bytes of
payload (e.g., data[0] and data[1]), if the hardware sends an unsolicited
report as a 2 or 3 byte packet, it seems it would be dropped before
processing.

> +
> +	switch (data[0]) {
> +	case 0xb0:
> +		sd->headset_connected =3D (data[1] =3D=3D 0x03);
> +		sd->battery_capacity =3D data[2];
> +		sd->battery_charging =3D (data[3] =3D=3D 0x01);
> +		break;
> +	case 0xb7:
> +		sd->battery_capacity =3D data[1];
> +		break;
> +	case 0xb9:
> +		sd->headset_connected =3D (data[1] =3D=3D 0x03);
> +		break;
> +	case 0xbb:
> +		sd->battery_charging =3D (data[1] =3D=3D 0x01);
> +		break;
> +	}
> +}
> +
>  /*
>   * Device info definitions
>   */
> @@ -181,6 +212,14 @@ static const struct steelseries_device_info arctis_9=
_info =3D {
>  	.parse_status =3D steelseries_arctis_9_parse_status,
>  };
> =20
> +static const struct steelseries_device_info arctis_nova_7_gen2_info =3D {
> +	.sync_interface =3D 3,
> +	.async_interface =3D 5,

[Severity: High]
This isn't a bug introduced by this patch, but since these devices use an
async interface, does the sibling interface lookup in=20
steelseries_get_sibling_hdev() have adequate locking and validation?

When a device probes the async interface, it appears
steelseries_get_sibling_hdev() fetches intfdata from the sibling interface
via usb_get_intfdata() locklessly.

If the sibling interface (interface 3) is unbound via sysfs and bound to
another driver (like usbfs), or physically unplugged concurrently, could
this return a foreign private context or a soon-to-be-freed pointer?

Then in steelseries_arctis_probe(), this unvalidated pointer is cast and
dereferenced to get the driver data:

    sd =3D hid_get_drvdata(master_hdev);
    kref_get(&sd->refcnt);

Could this lead to type confusion or a use-after-free if the sibling driver
is no longer the expected usbhid driver?

> +	.capabilities =3D SS_CAP_BATTERY,
> +	.request_status =3D steelseries_arctis_nova_request_status,
> +	.parse_status =3D steelseries_arctis_nova_7_gen2_parse_status,
> +};
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623172310.2727=
08-1-srimanachanta@gmail.com?part=3D10
