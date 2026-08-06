Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB10257845
	for <linux-input@vger.kernel.org>; Thu,  6 Aug 2026 12:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786020040; cv=none; b=HTe/uNl30xkuLigXM5QGdDyaYqcAQs2SczhfJ+Q/2ztLNMNIs0rzQYfvmw20Bl5sEo8mOwZuY1VwRo8CIg7cRw4G0JZZ94fOan2dKmsrC4lVNoVYOZC0m1Eh85Di39fPOEWNv9/8CyTPjcDKlob5QNXjsgmT4N2HjPde6/93o+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786020040; c=relaxed/simple;
	bh=jzc7dPMlzssajnaZsd0YDs8ZtdaXwwlW27jiyrgv6CI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OOcJKoM1AuASuyQbzEZgYNW5KJW9M+uQrxWiHwvvLlWrhbljvPP292ys6DjUKMypaSmWv3Psg9TIfUToyQ4MjAW5e5NxTMWAosh96yf88aDGgYJg4jgc06B1u6v5co0U24vLzBEZrgtSWqSU1Sbn4gIHH6HxnGKK/+FEi9EtNS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f8NpSFrm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f8NpSFrm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13E0B1F000E9;
	Thu,  6 Aug 2026 12:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786020039;
	bh=jzc7dPMlzssajnaZsd0YDs8ZtdaXwwlW27jiyrgv6CI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=f8NpSFrmCp90c/hpofh43WTrLnVMTPUC7hfXHylpGCQY2J74hZRC1u4OHt/vEd8i6
	 cR7/smKRtdhNtG3z4Vn0vU23nhMU12/tvIUF9b0eZDlmeXk1OP4FbgS/2vnMh1HR9C
	 yo65cxCT6vI8W40kHB6Ktx4xboz5LLsUk2e4lNsYrKbztw2un9mWVlW8Kv+9bqG+Yg
	 kE/zJFv2/dn/pfjatEEQy4PGHiKBaOK+MXFmdXI4A5D1NXSbrU0AOydN4yM8ECZjOB
	 bvHVzujkW//pCcteu2DK34hMcEWMosZayEw381FsurCbzrVlS5UBOTavrbtYNdQ7mh
	 BdXe+i54IDSMA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 04/13] iio: gyro: hid-sensor-gyro-3d: convert probe
 and teardown to devm-managed resources
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sanjay Chitroda" <sanjayembeddedse@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260806-28-apr-iio-redundant-argument-v5-temp-v5-4-f1f92c1d830f@gmail.com>
References: <20260806-28-apr-iio-redundant-argument-v5-temp-v5-0-f1f92c1d830f@gmail.com>
 <20260806-28-apr-iio-redundant-argument-v5-temp-v5-4-f1f92c1d830f@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 12:40:38 +0000
Message-Id: <20260806124039.13E0B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Preexisting UAF race between HID sensor event delivery and device =
unbinding.
--

--- Patch [4]: [PATCH v5 04/13] iio: gyro: hid-sensor-gyro-3d: convert prob=
e and teardown to devm-managed resources ---
Note: The format of this report is altered due to recitation restrictions. =
The original patch diff is not quoted.

commit 0412f8ea67eb98e8cb4da48580ccc04772e8482a
Author: Sanjay Chitroda <sanjayembeddedse@gmail.com>

iio: gyro: hid-sensor-gyro-3d: convert probe and teardown to devm-managed r=
esources

Convert HID IIO driver resource management to use devm-managed helpers,
tying the lifetime of all resources to the device. This simplifies the
probe path by removing goto-based error handling and eliminates the
remove callback entirely.

[Severity: High]
This is a pre-existing issue, but I noticed a potential Use-After-Free race
between HID sensor event delivery and device unbinding that could be exposed
here.

In drivers/hid/hid-sensor-hub.c:sensor_hub_remove_callback(), the callback
is removed from the list while holding dyn_callback_lock, but the function
returns immediately without synchronizing with or waiting for concurrent
readers to finish.

If a concurrent event is being processed in sensor_hub_raw_event(), it drops
dyn_callback_lock before invoking callback->capture_sample and accessing
callback->pdev.

During device unbind, the devres cleanup for the newly introduced
devm_sensor_hub_register_callback() will remove the callback. Immediately
after, the devres cleanup for devm_iio_device_alloc() frees indio_dev,
which contains the gyro_state->callbacks structure.

If sensor_hub_raw_event() is executing concurrently with an unbind (for
example, via sysfs), could it dereference the freed callback pointer to call
callback->capture_sample, leading to a Use-After-Free?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806-28-apr-iio=
-redundant-argument-v5-temp-v5-0-f1f92c1d830f@gmail.com?part=3D4
