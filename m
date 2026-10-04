Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25AB3BE16A
	for <linux-input@vger.kernel.org>; Sun,  4 Oct 2026 16:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791130292; cv=none; b=n5c39E41FIRzujy04piCy/144kdXE5sAZ03nTU27MsKNpdybPMLmjYas+VYocQGYPOp5e0GRyZSZ9OK0Vej/52ZJFV7gJmi9BHoG3Sfr8VeUK+fvAuhSB03mPA0z6pRBOeLUUirxCeGC1MtzpiapCR1IvCoJ0ezcDYCSgzXnevE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791130292; c=relaxed/simple;
	bh=wUYNiTWX+TL0NiUCwgeJWYmNnbHCGNo0gWd36ZomX74=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rpDnunS0W54T57X7tVNqRfAxZ2nLmIFq35QeQFGFIZJu6zQqd5G1Xo0APva4cets4cwAS/eZL/hGXgtdqrN/uNezsODAxQQHRH5c+SWUU9OrDhlkkCunUzI5Uc/LQtM40k+t57dU2EW0a6hZBVSAth10F9yZ2J3X8arfVgqggfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jH+59CTY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jH+59CTY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25BF41F000FF;
	Sun,  4 Oct 2026 16:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791130289;
	bh=06WCtls/oIRC8GY7pl88lIO8H9STtlZPe3lyvKprJTQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jH+59CTYgiUoj2anOTuvTultDZbpgu0jUT4eTwprH/fPte114XJzVjvtCYXn2ATeQ
	 A8KjTyGoquwEofy1rGn0pzAmbMpT7GKyWoeOUusbbllZbsML/dr4clQDdF9nx+x+S9
	 QRzvAu7DJq8b19Vw6vpl9LRH1VzhJTv8/v03mc+IlYCUN2uveWI4OSj45JfJv/4kts
	 1cLtyJN/t7lDZhxbrGnd2xgK2pcAwW567S7iAZlos1WgnkB43vDtUmy0WSWQOUwHK4
	 Frhai8qlYpxwSzC6s0SA3KpOVe/gMDm22sAOXJ14wINpfLOEPCiA8Trk3qkpr4w0lZ
	 f/pQslM2u5h+g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH -next 2/3] HID: amd_sfh: Add operating-mode telemetry
 sysfs attributes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Basavaraj Natikar" <Basavaraj.Natikar@amd.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20261004155919.726226-3-Basavaraj.Natikar@amd.com>
References: <20261004155919.726226-1-Basavaraj.Natikar@amd.com>
 <20261004155919.726226-3-Basavaraj.Natikar@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 04 Oct 2026 16:11:28 +0000
Message-Id: <20261004161129.25BF41F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] amd_sfh: torn read of telemetry data via memcpy_fromio()
- [Low] amd_sfh: build failures due to undefined identifiers
--

commit 74c8f353108e77a41e51aa1613b0b46c89693fcd
Author: Basavaraj Natikar <Basavaraj.Natikar@amd.com>

HID: amd_sfh: Add operating-mode telemetry sysfs attributes

The Sensor Fusion Hub reports additional operating-mode telemetry
through the SRA sensor, such as in-bag and out-of-bag detection,
on-table or on-lap placement, hinge angle, lid status and the platform
device mode.

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

[Severity: Low]
Is MP2_VER_1_2 defined in this tree? Compiling this patch results in a build
failure because MP2_VER_1_2 is undeclared.

> +		sensoraddr =3D mp2->vsbase +
> +			(SRA_IDX * SENSOR_DATA_MEM_SIZE_DEFAULT) +
> +			OFFSET_SENSOR_DATA_DEFAULT;
> +		memcpy_fromio(&accel_data, sensoraddr, sizeof(struct sfh_accel_data));

[Severity: Medium]
Could this memcpy_fromio() lead to torn reads? Since memcpy_fromio() perfor=
ms
bulk non-atomic reads, concurrent firmware updates to the shared MMIO region
might expose a corrupted mixture of old and new telemetry states to userspa=
ce
when reading these sysfs attributes.

Should this use an atomic read like readl() instead?

> +		mode->val =3D accel_data.c2p3_data;

[Severity: Low]
Does struct sfh_accel_data contain a c2p3_data field? Looking at
drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_interface.h:

struct sfh_accel_data {
        struct sfh_common_data commondata;
        struct sfh_float32 acceldata;
        u32 accelstatus;
};

It appears the field c2p3_data is missing, which causes a build failure
when compiling this driver.

> +	} else {
> +		mode->val =3D readl(mp2->mmio + amd_get_c2p_val(mp2, 3));
> +	}
> +
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261004155919.7262=
26-1-Basavaraj.Natikar@amd.com?part=3D2
