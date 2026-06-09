Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05FB82FFFA5;
	Tue,  9 Jun 2026 05:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780981284; cv=none; b=BjNuRvzt6vb0/RLGJph5fsetUZF/Kt5F7SoaOAKP6+2E+P1FiaOmLlLaXC235M+CVAiiUMQHNWxdQmMY1kACj7cl8WgP3rgIJs3fCwQBEvF7AlK0br/7MJuypVcRz4F5kWoiI2W1EIqFnjajSxylJOrsXwt81udm2zo558JbcWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780981284; c=relaxed/simple;
	bh=ynmUeUjXvWEyDNLw2h/GlqAPMLTYX/6Tj2q0nC8BOis=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=McPxUVhMoZ20wFIKNmVyBIGGeE3uhQHwuZ3q4eABniqrHebeF8WHbJkL/lt1Ae5EGMvFdHRNr1NniBJ28LOZs6yTJfhF0RhunROVe98QM/9QyvHTzR/SS9QhEMeTwX4fh8bDJaCHjYFYxb9BUA1EoAlRiNPtyzj/i5aWO4cVVxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aZo8sicr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aZo8sicr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 480F71F00893;
	Tue,  9 Jun 2026 05:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780981282;
	bh=SxVnS4f4PFryJmFXXmeh466sR8wOIrgQ5x/TdsyQPsM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aZo8sicr8mQXbd4s/2FiGevzyeqZcLYj/jrOy1reXrC47piWTp9aEU8SJRK7uneDM
	 eYv9OnFillw9fpKREwuJHEbqXnueJ094raAmkpiSO+ATcXhDnES5dSjWZ/tytr03BQ
	 Bn93XBSwLuR45/8pRERmqJBYZwrg/VwG8p43CHVqamkfdnYBAy0MzpTTsl63x6SFQV
	 QM/lw8QN0BSReSXhE5+lLfSUGYzdou3QPoEnJtZ5BintSc4bY+YXGccwp196+r3xL0
	 9bL9eL2PB3AsevP+aAZuygtqU8Bt14Pd91SUuETxAvk8bMO0IQjhCPRgAVepe+r2m8
	 7SVu3yiYS83rA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 07/11] HID: spi_hid: add ACPI support for SPI over
 HID
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jingyuan Liang" <jingyliang@chromium.org>
Cc: robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260609-send-upstream-v4-7-b843d5e6ced3@chromium.org>
References: <20260609-send-upstream-v4-7-b843d5e6ced3@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 05:01:21 +0000
Message-Id: <20260609050122.480F71F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] spi_hid_acpi_deassert_reset() silently fails to execute the ACPI _=
RST method, breaking device initialization.
- [High] Use-After-Free due to flawed cleanup ordering: the reset workqueue=
 is cancelled before the HID device is destroyed.
- [High] The shared buffer `shid->response` is read without holding `output=
_lock`, leading to data corruption if concurrent HID requests occur.
--

commit 8f475e9d4e137ed8f5267ef4406acd64e1baca61
Author: Angela Czubak <acz@semihalf.com>
Subject: HID: spi_hid: add ACPI support for SPI over HID

This commit detects and adds ACPI support for SPI HID devices.

> diff --git a/drivers/hid/spi-hid/spi-hid-acpi.c b/drivers/hid/spi-hid/spi=
-hid-acpi.c
> new file mode 100644
> index 0000000000000..298e3ba44d8a0
> --- /dev/null
> +++ b/drivers/hid/spi-hid/spi-hid-acpi.c
> @@ -0,0 +1,253 @@
[ ... ]
> +static int spi_hid_acpi_deassert_reset(struct spihid_ops *ops)
> +{
> +	struct spi_hid_acpi_config *conf =3D container_of(ops,
> +							struct spi_hid_acpi_config,
> +							ops);
> +
> +	return device_reset(&conf->adev->dev);

[Severity: High]
Does device_reset() work correctly here?

Since conf->adev->dev is the internal ACPI device structure without its fwn=
ode
set, ACPI_HANDLE() will return null, causing __device_reset() to skip the A=
CPI
reset.

Also, looking at spi_hid_dev_init(), the return value of deassert_reset()
is ignored:

drivers/hid/spi-hid/spi-hid-core.c:spi_hid_dev_init() {
    ...
	shid->ops->deassert_reset(shid->ops);
    ...
}

Should it evaluate _RST directly or use &spi->dev instead, and should the
return value be checked to prevent hardware reset from silently failing?

> +}

[Severity: High]
Can the cleanup ordering lead to a use-after-free regression during removal?

In spi_hid_core_remove(), cancel_work_sync() is called before
spi_hid_stop_hid():

drivers/hid/spi-hid/spi-hid-core.c:spi_hid_core_remove() {
    ...
	cancel_work_sync(&shid->reset_work);

	spi_hid_stop_hid(shid);
    ...
}

Since spi_hid_stop_hid() calls hid_destroy_device(), the HID device is still
accessible to userspace between the work cancellation and device destructio=
n.

If a userspace process concurrently issues an ioctl during this window,
spi_hid_sync_request() will timeout, and the error handler in
spi_hid_get_request() could incorrectly schedule reset_work. Once removal
finishes and devm frees the shid structure, could the mistakenly scheduled
work execute and dereference the freed shid pointer?

Should spi_hid_stop_hid() be called before cancel_work_sync() to prevent th=
is?

[Severity: High]
Can the shared buffer shid->response be read while corrupted if concurrent
HID requests occur?

In spi_hid_sync_request(), output_lock is acquired via scoped guard and is
implicitly released upon function return:

drivers/hid/spi-hid/spi-hid-core.c:spi_hid_sync_request() {
    ...
	guard(mutex)(&shid->output_lock);
    ...
}

Functions like spi_hid_ll_raw_request() call into spi_hid_sync_request()
and then read from shid->response after the lock has been released:

drivers/hid/spi-hid/spi-hid-core.c:spi_hid_ll_raw_request() {
    ...
	ret =3D spi_hid_sync_request(shid, ...);
    ...
	ret =3D min_t(size_t, len,
		    (shid->response->body[1] | (shid->response->body[2] << 8)) + 1);
	buf[0] =3D shid->response->body[3];
	memcpy(&buf[1], &shid->response->content, ret);
    ...
}

If multiple threads concurrently issue ioctls, could the second thread acqu=
ire
output_lock and overwrite shid->response with its own data before the first
thread has finished reading it?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609-send-upstr=
eam-v4-0-b843d5e6ced3@chromium.org?part=3D7
