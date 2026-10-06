Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D6C39A7F2
	for <linux-input@vger.kernel.org>; Tue,  6 Oct 2026 10:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791283824; cv=none; b=TW57JcvBiNdAhAVqjvUZRz/ShUYfAcIPPdCPTCreAPAj6B//AcMcmgVzaqhipNg3h52a9wGoCzy56ulfG9BYdhGK2m7G1FboPmKOF1+4p0ka8rsmq6EPyLNa8JVIKBmKGlVsa3Mjw55OCx69PQwuy+4+akJM84EFPJ12pG6dbLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791283824; c=relaxed/simple;
	bh=V+snvFTtHCSaH53jeGJbCejJFBu8kAAyLKdptcEy9sA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Iw+c9fw8pJ92HksIhQmUG1gvvcSgM6Y7uzVLdePxbWlP/MR6XMGMA3n2nl6ViJ7U/T+O/3L92Py+ri/hCWb4msNTZUrFjPmwaRXF2ehG18c0404ACFZYNrSNUG58As490n2EauEG0t49I4Uc8h60pQUcGIzz+6qt92spvo3su9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KhAkdNuR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KhAkdNuR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DEBD1F000FF;
	Tue,  6 Oct 2026 10:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791283823;
	bh=zehTSoLIr28n6xHsORK4UOvb3AMLaCqtB3Hy2z1QUaA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KhAkdNuRwMqlKn//avKANtCrr7GcYr2O5/6kp0abVrVuMLGfh5NDr6KO25UwNp8iw
	 AgI+mMj20M3+Ho6i8U9dcThcGqeuO6AcWSmYK0WMcixXbbAdyqPGh9lB/90tA/5hL9
	 orr4YNT88DgzE+LB41OTqvXbIORnJKii4UGcNZYeLXKl78wEGmbq35n/cuz8po2eaj
	 DxQF46ACwQc/tkTStht2UDubM/56BD+IhTRkCPBQoRW42kgn4mcaUK9LHW5HWeqh/N
	 ncmN6j2R4N0/bEZ+K5fW/xmi2JkZjs5ZC6W7tofoofmgaEp7zoc7Y0ciqgMhijQVYG
	 6CIoy6scvgXxA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH -next v2 2/4] HID: amd_sfh: Add operating-mode telemetry
 sysfs attributes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Basavaraj Natikar" <Basavaraj.Natikar@amd.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20261006103754.3614316-3-Basavaraj.Natikar@amd.com>
References: <20261006103754.3614316-1-Basavaraj.Natikar@amd.com>
 <20261006103754.3614316-3-Basavaraj.Natikar@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Oct 2026 10:50:22 +0000
Message-Id: <20261006105023.1DEBD1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] hid: non-atomic copy into mismatched struct for SRA data
- [Low] hid: build failure due to non-existent c2p3_data member
--

commit ee7fce24f1e5a01f6f7e6e6cd19e09582b434ae4
Author: Basavaraj Natikar <Basavaraj.Natikar@amd.com>

HID: amd_sfh: Add operating-mode telemetry sysfs attributes

The Sensor Fusion Hub reports additional operating-mode telemetry through
the SRA sensor. This commit exposes these states read-only through sysfs
so that userspace can consume them.

> diff --git a/drivers/hid/amd-sfh-hid/amd_sfh_sysfs.c b/drivers/hid/amd-sf=
h-hid/amd_sfh_sysfs.c
> index db1cc205d25b9..8af4df09760f0 100644
> --- a/drivers/hid/amd-sfh-hid/amd_sfh_sysfs.c
> +++ b/drivers/hid/amd-sfh-hid/amd_sfh_sysfs.c
[ ... ]
> @@ -41,19 +43,78 @@ static ssize_t hpd_store(struct device *dev,
>  }
>  static DEVICE_ATTR_RW(hpd);
> =20
> +/* Operating-mode telemetry reported by the SRA sensor, exposed read-onl=
y. */
> +static int amd_sfh_read_op_mode(struct amd_mp2_dev *mp2, struct sfh_op_m=
ode *mode)
> +{
> +	struct sfh_accel_data accel_data;
> +	void __iomem *sensoraddr;
> +
> +	if (!mp2->sfh1_1_ops || !mp2->dev_en.is_sra_present)
> +		return -ENODEV;
> +
> +	if (mp2->mp2_ver >=3D MP2_VER_1_2) {
> +		sensoraddr =3D mp2->vsbase +
> +			(SRA_IDX * SENSOR_DATA_MEM_SIZE_DEFAULT) +
> +			OFFSET_SENSOR_DATA_DEFAULT;
> +		memcpy_fromio(&accel_data, sensoraddr, sizeof(struct sfh_accel_data));

[Severity: Medium]
Does amd_sfh_read_op_mode() perform a multi-byte, non-atomic bulk I/O copy
from shared hardware memory using the wrong struct type (accelerometer inst=
ead
of SRA)?

Reading any of the new SRA telemetry sysfs attributes on a device with MP2
version >=3D 1.2 could risk torn reads from concurrent hardware updates.

Could a targeted, atomic readl() be used instead to read the single 32-bit
register value?

> +		mode->val =3D accel_data.c2p3_data;

[Severity: Low]
Does struct sfh_accel_data have a c2p3_data member?

It appears this member does not exist, which causes an immediate compilation
failure when compiling the amd_sfh module.

> +	} else {
> +		mode->val =3D readl(mp2->mmio + amd_get_c2p_val(mp2, 3));
> +	}
> +
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261006103754.3614=
316-1-Basavaraj.Natikar@amd.com?part=3D2
