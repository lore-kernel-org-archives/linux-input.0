Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D4B3AD50F
	for <linux-input@vger.kernel.org>; Fri, 26 Jun 2026 05:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782451867; cv=none; b=jYvivgtl5Q8GA+v82VWQRAWQxWOKq4pwDorzOtZzblSPYKz5z7b2FlhnbqtEeSeErOQ6Fp0bMZUR+WnUfPPMzgcAzgkCR5ZKbEKJter0uQAZZTZ8GVnVZxDLPnlq52SlPlUYV0NVhJbyZ6UtUQyKFKMsfaNFrO7WAJshTYDrlvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782451867; c=relaxed/simple;
	bh=7v96wrFjVlCg17UaMO6GjNQHoUhKTcDSYeAfZvwZqc0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qtNSilLeym0ySo1yFLKEwKEffOnp8LUJfZsaWwchnS0jUYCjxcUAtiRhxI75iTheAcTEP9pmL5K5py272ADcUoGDBvRH2wNjxVqqQfYoWFKI2TfEfXUdVjDQFF9+WgGVveIplGB7Wtb3BXAaXYnHQXfew66ypmiE2ROGICSA57Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cF+RSzFd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cF+RSzFd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1C241F000E9;
	Fri, 26 Jun 2026 05:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782451861;
	bh=3mCOoA9s3D6/ff47v8KHbDpGC7dksGzGQagwWx1lENw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cF+RSzFdkdhS8JjlShsWOperfPwaWVQomZB2kqc/yAZ4HHXpqXKuxr3xD57/8lDRw
	 8u6j69pdE7FoDUr9WufehzonFkjSSG6x2xrZJJMzZhGkFO3upFosgRFVhBqYz85CCZ
	 8GB6Snwa/URPGTSCTuoJiTUjLWfse5Ftw7hpGHwKkKPPhzrWTdoP9Hwr1KxVwmG/IQ
	 mWlEqBZ3cQppQ6q9n0s40I/FvAaGerF9Ok4VaJmHEsYVE/bdSYk+TjoJKapPOgrYQb
	 DHGqXMV+I4Xrk070U1lx7w7BzQ4hqhmnhuBeCKs6iQMnyQJMEgWeLuw3xNbq6ZL/iY
	 ObkQjWaiPa3mQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 01/10] Input: synaptics-rmi4 - fix F55 transmitter
 electrode count typo
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260626051802.4033172-1-dmitry.torokhov@gmail.com>
References: <20260626051802.4033172-1-dmitry.torokhov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jun 2026 05:31:00 +0000
Message-Id: <20260626053100.C1C241F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Medium] F55:Ctrl2 register array is read from an incorrect static offset=
, causing overlapping reads with the preceding F55:Ctrl1 register array.
--

commit b444f8759d3d03dbb87e0c3fd33dd8bdd2ff2bcf
Author: Dmitry Torokhov <dmitry.torokhov@gmail.com>

    Input: synaptics-rmi4 - fix F55 transmitter electrode count typo

    This commit fixes a typo during F55 sensor detection where the transmit=
ter
    electrode count was incorrectly assigned the value of the receiver elec=
trode
    count. The incorrect value was then propagated to the driver data and
    inflated the perceived TX count for F54, potentially leading to
    out-of-bounds buffer accesses.

> diff --git a/drivers/input/rmi4/rmi_f55.c b/drivers/input/rmi4/rmi_f55.c
> index 488adaca4dd00..a0877d32a9141 100644
> --- a/drivers/input/rmi4/rmi_f55.c
> +++ b/drivers/input/rmi4/rmi_f55.c
> @@ -54,10 +54,10 @@ static int rmi_f55_detect(struct rmi_function *fn)
>  	f55->num_tx_electrodes =3D f55->qry[F55_NUM_TX_OFFSET];
> =20
>  	f55->cfg_num_rx_electrodes =3D f55->num_rx_electrodes;
> -	f55->cfg_num_tx_electrodes =3D f55->num_rx_electrodes;
> +	f55->cfg_num_tx_electrodes =3D f55->num_tx_electrodes;
> =20
>  	drv_data->num_rx_electrodes =3D f55->cfg_num_rx_electrodes;
> -	drv_data->num_tx_electrodes =3D f55->cfg_num_rx_electrodes;
> +	drv_data->num_tx_electrodes =3D f55->cfg_num_tx_electrodes;
> =20
>  	if (f55->qry[F55_PHYS_CHAR_OFFSET] & F55_CAP_SENSOR_ASSIGN) {
>  		int i, total;

[Severity: Medium]
This is a pre-existing issue, but I have a question about the offset used w=
hen
reading the F55:Ctrl2 register array.

Just below this hunk in rmi_f55_detect(), the code reads the transmitter
assignment array using a hardcoded +2 offset:

drivers/input/rmi4/rmi_f55.c:rmi_f55_detect() {
    ...
		error =3D rmi_read_block(fn->rmi_dev,
				       fn->fd.control_base_addr + 1,
				       buf, f55->num_rx_electrodes);
    ...
		error =3D rmi_read_block(fn->rmi_dev,
				       fn->fd.control_base_addr + 2,
				       buf, f55->num_tx_electrodes);
    ...
}

Will using a hardcoded +2 offset for Ctrl2 cause it to overlap with the Ctr=
l1
array if num_rx_electrodes > 1, or skip a byte if num_rx_electrodes =3D=3D =
0?

Should the offset dynamically account for the size of Ctrl1, such as using
control_base_addr + 1 + f55->num_rx_electrodes?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626051802.4033=
172-1-dmitry.torokhov@gmail.com?part=3D1
