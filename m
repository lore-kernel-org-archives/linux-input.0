Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31589341ABB;
	Sun, 13 Sep 2026 15:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789314639; cv=none; b=obFGOBftVfqZqyEjV0LDSugA2naXd6v7dwVURNbe5bh6FRlT9Qsrp14LSeUoJBsLJ0ErGZBcrNHvzEixfmazv23ddcaLpzEijNFCBO1FK7pTB4mA2JfHjZmC9f6E/KARo5wJMUat7UpMxBKFK/S/g+iw71CAuD1/kpbUnkjSPc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789314639; c=relaxed/simple;
	bh=dRteHYasmjthFzv5sHQomdySo23tvUJL1a7vD9geNzU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ILfl76AbCFxeedjG2oFAEInQsOLtuDVXQrHehtfcUWzS7n7bYP3DukPDB0Nvt7uCRJ9Bn1qVoKPcwjqOPVvEVlaSyTytaT5ZTPAz19+J+tTfvz1X7du+hQRvHfdn0NlCmJ3Jr4elrpEkKvvGBS87ln2Xw0azQfZxTiPsCqbcev4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ONZ02eX8; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ONZ02eX8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789314637; x=1820850637;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=dRteHYasmjthFzv5sHQomdySo23tvUJL1a7vD9geNzU=;
  b=ONZ02eX8UU1R+suoFE5wiCvCEGi4Yzg4mOVPp0Xv6Osif/Wx8Psw/Lrp
   7Lh89DUudL9jBezYHVZSIYvqGJGphCTX1iNUGYh4T1euvCXZo1EXKl7bV
   DbFYMdvJCRwwLFpHEf3BOGUOafoXDURsIP47pj022FqtAWD3XtS+hxj/X
   NPuHhYwepTSqyXmIuK42VuKRbIdj7rOuFQwce3DJ/DS28B8tQ0bP9lACy
   uWrVAGqcNE89Wz2+iMvzjpSPVZZUDtchqBUYXG6spwhw+08rbDpZkesmF
   gOdCH9bdO0yCJPfHmO1yH1CaSSh+YZfH5lFf6rzEZquVIzU4x6BwdM68w
   A==;
X-CSE-ConnectionGUID: TIo51lXoQ5auxBDdm/0pvg==
X-CSE-MsgGUID: dea/sK+XRDSW9p1wngsk6g==
X-IronPort-AV: E=McAfee;i="6800,10657,11904"; a="101212720"
X-IronPort-AV: E=Sophos;i="6.27,100,1787036400"; 
   d="scan'208";a="101212720"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2026 08:50:37 -0700
X-CSE-ConnectionGUID: wgGW3RYCTRqv+6VtHKXX0Q==
X-CSE-MsgGUID: oCNbfysJThCNIWUZA71gGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,100,1787036400"; 
   d="scan'208";a="269122611"
Received: from dnelso2-mobl.amr.corp.intel.com (HELO [10.125.108.113]) ([10.125.108.113])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2026 08:50:36 -0700
Message-ID: <5b28a9e82b8f3d4458b678505ef7063525ce1141.camel@linux.intel.com>
Subject: Re: [PATCH v3] HID: sensor-hub: Fail unfinished multi-value reads
 on removal
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: Yibo Tan <lhfff@tju.edu.cn>, Jiri Kosina <jikos@kernel.org>, Jonathan
 Cameron <jic23@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, Zhang Lixu	
 <lixu.zhang@intel.com>, linux-input@vger.kernel.org,
 linux-iio@vger.kernel.org, 	linux-kernel@vger.kernel.org
Date: Sun, 13 Sep 2026 08:50:35 -0700
In-Reply-To: <20260913072910.1944300-1-lhfff@tju.edu.cn>
References: <20260913045411.5e2f5b25@jic23-hlaptop>
	 <20260913072910.1944300-1-lhfff@tju.edu.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2026-09-13 at 15:29 +0800, Yibo Tan wrote:
> sensor_hub_remove() completes pending reads after stopping the HID
> device,
> but does not record why they completed.=C2=A0 A successful completion wai=
t
> therefore returns zero even if no complete input report was received.
> Multi-value IIO callers then format their untouched automatic buffer
> as a
> successful result.
>=20
> With a valid four-element signed 32-bit quaternion report descriptor,
> an
> unprivileged reader received all 16 bytes of the untouched buffer.=C2=A0
> Across
> 11 independent KASLR-enabled boots, four reads exposed exact pointers
> to
> dev_rot_channels or dev_sysfs_ops.=C2=A0 Subtracting the matching link-
> time
> symbol address recovered the kernel KASLR slide in all four cases.
>=20
> The reader ran as UID/GID 65534 with no effective capabilities
> through the
> mode-0644 IIO attribute.=C2=A0 The test used a privileged UHID broker to
> create
> and remove the provider; it does not demonstrate unprivileged
> provider
> removal.
>=20
> Mark a pending request as shut down before completing it from the
> removal
> path, and return -ENODEV from a multi-value read that observes the
> marker
> after a successful wait.=C2=A0 Let removal win even if a response raced
> with
> teardown, since the device is no longer available.
>=20
> The Root B-only repair returned -ENODEV with no payload or kernel
> diagnostic in 3/3 matching signed-32-bit runs.=C2=A0 The source
> reproducer,
> complete vulnerable and fixed serial logs, result tables, and
> checksums are
> available in [1].
>=20
> Link:
> https://github.com/kimaiden1984-boop/linux-kernel-poc-collections/tree/ma=
in/cases/hid-sensor-quaternion-root-b-kaslr
> =C2=A0[1]
> Fixes: f784fcea4506 ("HID: sensor-hub: Add
> sensor_hub_input_attr_read_values() for multi-byte reads")
> Cc: stable@vger.kernel.org
> Suggested-by: Jonathan Cameron <jic23@kernel.org>
> Assisted-by: LLM
> Signed-off-by: Yibo Tan <lhfff@tju.edu.cn>


Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>


> ---
> Changes in v3:
> - Replace the raw_size error sentinel with a dedicated teardown flag,
> as
> =C2=A0 suggested by Jonathan Cameron.
> - Let teardown win if it races with a completed response.
>=20
> v2:
> https://lore.kernel.org/r/20260912050257.837340-1-lhfff@tju.edu.cn/
>=20
> =C2=A0drivers/hid/hid-sensor-hub.c=C2=A0=C2=A0 | 6 +++++-
> =C2=A0include/linux/hid-sensor-hub.h | 2 ++
> =C2=A02 files changed, 7 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-
> hub.c
> index 6470a290ebfc..a9bd72218c07 100644
> --- a/drivers/hid/hid-sensor-hub.c
> +++ b/drivers/hid/hid-sensor-hub.c
> @@ -334,6 +334,8 @@ int sensor_hub_input_attr_read_values(struct
> hid_sensor_hub_device *hsdev,
> =C2=A0			ret =3D -ETIMEDOUT;
> =C2=A0		else if (cycles < 0)
> =C2=A0			ret =3D cycles;
> +		else if (hsdev->pending.shutdown)
> +			ret =3D -ENODEV;
> =C2=A0
> =C2=A0		hsdev->pending.status =3D false;
> =C2=A0	}
> @@ -805,8 +807,10 @@ static int sensor_hub_finalize_pending_fn(struct
> device *dev, void *data)
> =C2=A0{
> =C2=A0	struct hid_sensor_hub_device *hsdev =3D dev->platform_data;
> =C2=A0
> -	if (hsdev->pending.status)
> +	if (hsdev->pending.status) {
> +		hsdev->pending.shutdown =3D true;
> =C2=A0		complete(&hsdev->pending.ready);
> +	}
> =C2=A0
> =C2=A0	return 0;
> =C2=A0}
> diff --git a/include/linux/hid-sensor-hub.h b/include/linux/hid-
> sensor-hub.h
> index ab5cc8db3fbb..5aecf4474183 100644
> --- a/include/linux/hid-sensor-hub.h
> +++ b/include/linux/hid-sensor-hub.h
> @@ -38,6 +38,7 @@ struct hid_sensor_hub_attribute_info {
> =C2=A0/**
> =C2=A0 * struct sensor_hub_pending - Synchronous read pending information
> =C2=A0 * @status:		Pending status true/false.
> + * @shutdown:		The device is being removed.
> =C2=A0 * @ready:		Completion synchronization data.
> =C2=A0 * @usage_id:		Usage id for physical device, e.g. gyro
> usage id.
> =C2=A0 * @attr_usage_id:	Usage Id of a field, e.g. X-axis for a gyro.
> @@ -48,6 +49,7 @@ struct hid_sensor_hub_attribute_info {
> =C2=A0 */
> =C2=A0struct sensor_hub_pending {
> =C2=A0	bool status;
> +	bool shutdown;
> =C2=A0	struct completion ready;
> =C2=A0	u32 usage_id;
> =C2=A0	u32 attr_usage_id;
