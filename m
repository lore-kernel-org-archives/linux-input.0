Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8597438A739
	for <linux-input@vger.kernel.org>; Sat,  4 Jul 2026 06:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783145332; cv=none; b=inN9IhMN3VByjRPHh/nWcbGduROpgvEL8++TJ6DXaGc986IOBTOg4XuluEiBNg1igIfr6EPF6P0SVEshSRNNtlVeEuPBMG7EmP+qZvH7M3QdjYGq8vU3mgymXiICapUjh9fl6VjSM7VLylnDJH+PpigioJ6yGj02Yu12PdJggKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783145332; c=relaxed/simple;
	bh=3O0Mfexr0iL6d51hqC1h3Wmq9ErqiSAkepzyLBam/AU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=j3djBFp9Lzz680IGi8HtN6OaSB8I3OWKMP/HCDJtM3semNVb3wS2YfavqHRQzozFeOZETvl2GKYRmjZYXcY0JZ9DNGySJHkZ8sAKixR85dG4P7Fe6baYsMDV3wFfS5m/bm9Sl7U6DMZYbF9+KyVNIVjuDwDRj8VDWQKdoVX4GVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ceTeoVjM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ceTeoVjM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD33A1F000E9;
	Sat,  4 Jul 2026 06:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783145329;
	bh=zJinRKaoEgvWbEf6LPdPgNKniuLLS9cxrvvbmeaP1eo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ceTeoVjMIkL0R3zD/hokuTT5ndDcg1tzIOf8tSuqOR8dVRMy8gNjp3QN9B3Om+pSS
	 /CvwxHbHZHjMLGYxk0cJOpq6gODVuZV8Kf68Sx8oAfr+Ei/+zBjmevdBPfxvjdesZ9
	 tNmhrewO+U46SVZoArbKdqilOhMR4oSmNnVG+TpPLIh2iWl/nJjhnGg6UBAYmAGjh2
	 AOOHVWjbstXxyckYL/ZlqMnSP1+3guqLkCtZwKrct8kqxfDhbZo6VjN0rinRanhvpe
	 Y82wqKzVsgV6FMWj09ymkFuI/3BpHTmWpETblDF7zattQnj2BPGn8Rzcqdsb8Z0oNd
	 S/KbmgNoYApNA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 14/26] mtd: maps: vmu-flash: remove unused mdev->driver
 assignment
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260703-b4-maple-cleanup-v1-14-41e424964da5@gmail.com>
References: <20260703-b4-maple-cleanup-v1-0-41e424964da5@gmail.com>
 <20260703-b4-maple-cleanup-v1-14-41e424964da5@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 04 Jul 2026 06:08:48 +0000
Message-Id: <20260704060848.CD33A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Dangling pointers for `fileerr_handler` and `can_unload` left =
on `maple_device` if `probe` fails.
- [Critical] Use-after-free of `card` structure due to dangling `mdev->call=
back` on probe error path.
- [High] Out-of-bounds read in `vmu_connect` when parsing device `function_=
data`.
- [High] NULL pointer dereference in `vmu_disconnect` if `vmu_queryblocks` =
fails.
--

commit aec7eca58a1d1d49c7c51af4d1d0fb848ff3245c
Author: Dmitry Torokhov <dmitry.torokhov@gmail.com>

mtd: maps: vmu-flash: remove unused mdev->driver assignment

This commit removes the unused assignment to mdev->driver and the now unused
mdrv variable in probe_maple_vmu. The driver field in struct maple_device is
no longer used since earlier cleanups.

> diff --git a/drivers/mtd/maps/vmu-flash.c b/drivers/mtd/maps/vmu-flash.c
> index 10244e6731d07..8f7028ac1b56a 100644
> --- a/drivers/mtd/maps/vmu-flash.c
> +++ b/drivers/mtd/maps/vmu-flash.c
> @@ -772,11 +772,9 @@ static void vmu_file_error(struct maple_device *mdev=
, void *recvbuf)
>  static int probe_maple_vmu(struct device *dev)
>  {
>  	struct maple_device *mdev =3D to_maple_dev(dev);
> -	struct maple_driver *mdrv =3D to_maple_driver(dev->driver);
> =20
>  	mdev->can_unload =3D vmu_can_unload;
>  	mdev->fileerr_handler =3D vmu_file_error;
> -	mdev->driver =3D mdrv;
> =20
>  	return vmu_connect(mdev);

[Severity: Critical]
This is a pre-existing issue, but if vmu_connect() fails below, are these
pointers properly cleared?

If vmu_connect() fails, the probe aborts and the device is left unbound, but
the function pointers to vmu_can_unload() and vmu_file_error() remain
assigned to the persistent maple_device structure.=20

If the vmu-flash module is subsequently unloaded, could a later
MAPLE_RESPONSE_FILEERR event cause the maple bus core to dereference the
now-dangling mdev->fileerr_handler pointer?

>  }

While reviewing the context of this patch, I noticed a few other pre-existi=
ng
issues in the surrounding code:

> static int vmu_connect(struct maple_device *mdev)
> {
> 	unsigned long test_flash_data, basic_flash_data;
> 	int c, error;
> 	struct memcard *card;
> 	u32 partnum =3D 0;
>=20
> 	test_flash_data =3D be32_to_cpu(mdev->devinfo.function);
> 	/* Need to count how many bits are set - to find out which
> 	 * function_data element has details of the memory card
> 	 */
> 	c =3D hweight_long(test_flash_data);
>=20
> 	basic_flash_data =3D be32_to_cpu(mdev->devinfo.function_data[c - 1]);

[Severity: High]
This is a pre-existing issue, but does this array access risk an out-of-bou=
nds
read?

Since test_flash_data is derived directly from the hardware packet, it could
have up to 32 bits set. If a malfunctioning device reports 0 bits or more t=
han
3 bits set, does using c - 1 read past the bounds of the 3-element
function_data array?

[ ... ]

> 	/*
> 	* We want to trap meminfo not get cond
> 	* so set interval to zero, but rely on maple bus
> 	* driver to pass back the results of the meminfo
> 	*/
> 	maple_getcond_callback(mdev, vmu_queryblocks, 0,
> 		MAPLE_FUNC_MEMCARD);

[ ... ]

> 	error =3D maple_add_packet(mdev, MAPLE_FUNC_MEMCARD,
> 		MAPLE_COMMAND_GETMINFO, 2, &partnum);
> 	if (error) {
> 		dev_err(&mdev->dev, "Could not lock VMU at (%d, %d)"
> 			" error is 0x%X\n", mdev->port, mdev->unit, error);
> 		goto fail_mtd_info;
> 	}
> 	return 0;
>=20
> fail_device_busy:
> 	kfree(card->mtd);
> fail_mtd_info:
> 	kfree(card->parts);
> fail_partitions:
> 	kfree(card);
> fail_nomem:
> 	return error;
> }

[Severity: Critical]
This is a pre-existing issue, but if maple_add_packet() fails, is the card
structure freed while the callback is still active?

In vmu_connect(), an asynchronous callback is registered via
maple_getcond_callback(). If a subsequent operation like maple_add_packet()
fails, the error path frees the card structure but does not clear
mdev->callback.

If a delayed or stray MAPLE_RESPONSE_DATATRF packet arrives later, could
maple_dma_handler() invoke the lingering mdev->callback, writing hardware
response data to the already freed card memory?

Regarding vmu_disconnect():

If vmu_queryblocks() fails, it branches to an error path that frees the
priv pointer and sets it to NULL:

> 	for (error =3D 0; error <=3D card->partition; error++) {
> 		kfree(((card->mtd)[error]).priv);
> 		((card->mtd)[error]).priv =3D NULL;
> 	}

Because the initial probe returned success, the device remains bound. When
it is eventually disconnected, vmu_disconnect() executes:

> 	for (x =3D 0; x < card->partitions; x++) {
> 		mpart =3D ((card->mtd)[x]).priv;
> 		mpart->mdev =3D NULL;

[Severity: High]
This is a pre-existing issue, but if vmu_queryblocks() encountered an
asynchronous failure earlier, will vmu_disconnect() blindly dereference a
NULL pointer here?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260703-b4-maple-c=
leanup-v1-0-41e424964da5@gmail.com?part=3D14
