Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D72C381AE2;
	Sun, 13 Sep 2026 17:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789320087; cv=none; b=lUm9Gw29IQCs58Rd6GslTLjr8J53/I0Nbl3suWHeiLVxgrUBAoq78XXhVWgvR/QtfcKuZPjJQDKBKqgpDif3VbP/Kc0VLewBxcPJUNSt4m2cHQ0+eysrqfo6Hc9MEc0GOceZmTyuhnVl2OpwmU+/yVfxjvjtpIi+3ws/5wRrKSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789320087; c=relaxed/simple;
	bh=ibsyCQUx5JJPZjKjymm6etyfq6eZ+zNFfvVnk0Szs+4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bm+EfAWf2noTzEYzeK3/mnLvAT/rxKkfbniylnJ3KZC8Tq5p0mb0kJzAsWd4cHFq0OE4NTOxZfFx/mgwk/B2dqUmm77ES+24vrLIiyl1EM+v8pp84BCbsdAlx4rEY8DHoBfLdESXBwF6DHZIdanG+IutFbitoLrgwn7s4AQPVAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=io2G0+3f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="io2G0+3f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D46D41F000FF;
	Sun, 13 Sep 2026 17:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789320083;
	bh=/AQhHGpDS3GlYnXDOLzqUJHUjBnTWicJ4ANeSkeCGBw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=io2G0+3fMSguheHjoA/bAKYKo43btvSOkzeOMvLWXKjC2PM1PzK+NS/lQJFkRfyg8
	 RuMhIKKAMiUTV3b3MDu4vXaUsKDp7IXHepdGwssICBXh47qRgAMdo00/tZY3npFDPt
	 tgaUOxBbvMtnbd9DL1hBDxVsGPTOJKNxb/EXxoilnStUeC3G2N5vem6NGgBwwCDnpG
	 Mua6Lye29ynXdkyUqjuxFZqyHduAL5Aj71qzbwYvg95YYlU4D35K04lc54qYe0ue9p
	 T7Cn7z8RJha9I0frkSaAs10vQ3siD4e4Oyw00JbkkeTOF36Tq41OKt88vS5vElpbz+
	 Kjol6hd8qHvvw==
Date: Sun, 13 Sep 2026 18:21:20 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Yibo Tan <lhfff@tju.edu.cn>, Jiri Kosina <jikos@kernel.org>, Benjamin
 Tissoires <bentiss@kernel.org>, Andy Shevchenko
 <andriy.shevchenko@intel.com>, Zhang Lixu	 <lixu.zhang@intel.com>,
 linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] HID: sensor-hub: Fail unfinished multi-value reads
 on removal
Message-ID: <20260913182120.01bac5c3@jic23-hlaptop>
In-Reply-To: <5b28a9e82b8f3d4458b678505ef7063525ce1141.camel@linux.intel.com>
References: <20260913045411.5e2f5b25@jic23-hlaptop>
	<20260913072910.1944300-1-lhfff@tju.edu.cn>
	<5b28a9e82b8f3d4458b678505ef7063525ce1141.camel@linux.intel.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 13 Sep 2026 08:50:35 -0700
srinivas pandruvada <srinivas.pandruvada@linux.intel.com> wrote:

> On Sun, 2026-09-13 at 15:29 +0800, Yibo Tan wrote:
> > sensor_hub_remove() completes pending reads after stopping the HID
> > device,
> > but does not record why they completed.=C2=A0 A successful completion w=
ait
> > therefore returns zero even if no complete input report was received.
> > Multi-value IIO callers then format their untouched automatic buffer
> > as a
> > successful result.
> >=20
> > With a valid four-element signed 32-bit quaternion report descriptor,
> > an
> > unprivileged reader received all 16 bytes of the untouched buffer.=C2=A0
> > Across
> > 11 independent KASLR-enabled boots, four reads exposed exact pointers
> > to
> > dev_rot_channels or dev_sysfs_ops.=C2=A0 Subtracting the matching link-
> > time
> > symbol address recovered the kernel KASLR slide in all four cases.
> >=20
> > The reader ran as UID/GID 65534 with no effective capabilities
> > through the
> > mode-0644 IIO attribute.=C2=A0 The test used a privileged UHID broker to
> > create
> > and remove the provider; it does not demonstrate unprivileged
> > provider
> > removal.
> >=20
> > Mark a pending request as shut down before completing it from the
> > removal
> > path, and return -ENODEV from a multi-value read that observes the
> > marker
> > after a successful wait.=C2=A0 Let removal win even if a response raced
> > with
> > teardown, since the device is no longer available.
> >=20
> > The Root B-only repair returned -ENODEV with no payload or kernel
> > diagnostic in 3/3 matching signed-32-bit runs.=C2=A0 The source
> > reproducer,
> > complete vulnerable and fixed serial logs, result tables, and
> > checksums are
> > available in [1].
> >=20
> > Link:
> > https://github.com/kimaiden1984-boop/linux-kernel-poc-collections/tree/=
main/cases/hid-sensor-quaternion-root-b-kaslr
> > =C2=A0[1]
> > Fixes: f784fcea4506 ("HID: sensor-hub: Add
> > sensor_hub_input_attr_read_values() for multi-byte reads")
> > Cc: stable@vger.kernel.org
> > Suggested-by: Jonathan Cameron <jic23@kernel.org>
> > Assisted-by: LLM
> > Signed-off-by: Yibo Tan <lhfff@tju.edu.cn> =20
>=20
>=20
> Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Applied to the fixes branch of iio.git.

It might or might not go upstream before the next merge windows. In practice
I'm going to assume these devices are typically not hotplugable except in
dev kits so we are unlikely to see this on production devices unless
someone manually removes?  That does affect whether to fix it, but only how
fast we rush it upstream!

Jonathan

>=20
>=20
> > ---
> > Changes in v3:
> > - Replace the raw_size error sentinel with a dedicated teardown flag,
> > as
> > =C2=A0 suggested by Jonathan Cameron.
> > - Let teardown win if it races with a completed response.
> >=20
> > v2:
> > https://lore.kernel.org/r/20260912050257.837340-1-lhfff@tju.edu.cn/
> >=20
> > =C2=A0drivers/hid/hid-sensor-hub.c=C2=A0=C2=A0 | 6 +++++-
> > =C2=A0include/linux/hid-sensor-hub.h | 2 ++
> > =C2=A02 files changed, 7 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-
> > hub.c
> > index 6470a290ebfc..a9bd72218c07 100644
> > --- a/drivers/hid/hid-sensor-hub.c
> > +++ b/drivers/hid/hid-sensor-hub.c
> > @@ -334,6 +334,8 @@ int sensor_hub_input_attr_read_values(struct
> > hid_sensor_hub_device *hsdev,
> > =C2=A0			ret =3D -ETIMEDOUT;
> > =C2=A0		else if (cycles < 0)
> > =C2=A0			ret =3D cycles;
> > +		else if (hsdev->pending.shutdown)
> > +			ret =3D -ENODEV;
> > =C2=A0
> > =C2=A0		hsdev->pending.status =3D false;
> > =C2=A0	}
> > @@ -805,8 +807,10 @@ static int sensor_hub_finalize_pending_fn(struct
> > device *dev, void *data)
> > =C2=A0{
> > =C2=A0	struct hid_sensor_hub_device *hsdev =3D dev->platform_data;
> > =C2=A0
> > -	if (hsdev->pending.status)
> > +	if (hsdev->pending.status) {
> > +		hsdev->pending.shutdown =3D true;
> > =C2=A0		complete(&hsdev->pending.ready);
> > +	}
> > =C2=A0
> > =C2=A0	return 0;
> > =C2=A0}
> > diff --git a/include/linux/hid-sensor-hub.h b/include/linux/hid-
> > sensor-hub.h
> > index ab5cc8db3fbb..5aecf4474183 100644
> > --- a/include/linux/hid-sensor-hub.h
> > +++ b/include/linux/hid-sensor-hub.h
> > @@ -38,6 +38,7 @@ struct hid_sensor_hub_attribute_info {
> > =C2=A0/**
> > =C2=A0 * struct sensor_hub_pending - Synchronous read pending informati=
on
> > =C2=A0 * @status:		Pending status true/false.
> > + * @shutdown:		The device is being removed.
> > =C2=A0 * @ready:		Completion synchronization data.
> > =C2=A0 * @usage_id:		Usage id for physical device, e.g. gyro
> > usage id.
> > =C2=A0 * @attr_usage_id:	Usage Id of a field, e.g. X-axis for a gyro.
> > @@ -48,6 +49,7 @@ struct hid_sensor_hub_attribute_info {
> > =C2=A0 */
> > =C2=A0struct sensor_hub_pending {
> > =C2=A0	bool status;
> > +	bool shutdown;
> > =C2=A0	struct completion ready;
> > =C2=A0	u32 usage_id;
> > =C2=A0	u32 attr_usage_id; =20
>=20

