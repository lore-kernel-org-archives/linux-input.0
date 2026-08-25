Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7DC33E5EFD;
	Tue, 25 Aug 2026 08:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787648306; cv=none; b=YaD0FzYZ/W2csDkBjYnugJZl+UL6hOzbmIepGO5fooWkGAZoirCwudKlZ0AUqkqOnCO8TQ9FIgWm/x/Ct2JlVw5JFPC7ZtqjRP3rgY2kCAbqpWL3FdZeiR53oFeoXnHYgoC1Zd5IQ4swDA8VmV2u6NieAl2qmTJEVHhg/JcNSZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787648306; c=relaxed/simple;
	bh=EK1/Ib+rBSpQ9pKoq2169QpNgDqsI7CRk3X7Qt6XL2Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iX3h2PgkChgoVhWqINyr0DfjyPXVZLFuFwPzYlVnfcJCsVuy7C2hWRFTpQMl708e4BUE5m7E5YzKUJI2rIAOOuBjAvPQiGHztLvTtO+/6WKmzh9+9rvlfdsUqrAll6OEni8qq9OsZZ3rw+AW7VWPj1ozW/ylUL6mQRjf6Ob1tI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I5jE7QSo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I5jE7QSo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44AAC1F000E9;
	Tue, 25 Aug 2026 08:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787648304;
	bh=6GNfiK6XsGpiEpLb7Pb6WGqBKmvn7uV9/5pPZmhSERA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=I5jE7QSomTTfZJpAzSpItwHzpUcmw84er0FVbsMVnbWXAvGHBOsvwzopsmuF0INkU
	 gDFL9Z84E6OAxIXV3cF9zEpdfxRsV6LdhB43tsiZxR4phkOzR3dRtBpH8Ee13O9Lel
	 qoRy8YRMjSq5UXQCKk7HLjJJgBUoQNg3/bM1ieR/D9a3EenIx3EacXPAHo3FMr2WIr
	 27t7wVgxQNVs3RlIFWmuP+lC/evrh91dj8iqVyXf5bNeqoww8cId0Ns39Tpe05nv1F
	 LZ8pbltqgrHfMcWoCtuzh1sZH5/SVXSLJsug/PnZ3udO29k3IwrfGL33qAhW1s6Z+m
	 tvXM1IZWB9/Vg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] selftests/hid: Add a test to ensure we can write
 fields in hid_device
Reply-To: sashiko-reviews@lists.linux.dev
To: "Benjamin Tissoires" <bentiss@kernel.org>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <20260825-wip-bpf-safe-v1-2-ab9e0e111c5c@kernel.org>
References: <20260825-wip-bpf-safe-v1-0-ab9e0e111c5c@kernel.org>
 <20260825-wip-bpf-safe-v1-2-ab9e0e111c5c@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 25 Aug 2026 08:58:23 +0000
Message-Id: <20260825085824.44AAC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Flaky test due to off-by-one error when searching for the null t=
erminator of a device ID string.
- [Low] Incorrect macro undefinition leaves `HID_BPF_MEMCPY` defined and at=
tempts to undefine a nonexistent macro.
--

--- Patch [2]: [PATCH 2/3] selftests/hid: Add a test to ensure we can write=
 fields in hid_device ---
commit ac5a75219b6789481c51176040f60dd282ac248f
Author: Benjamin Tissoires <bentiss@kernel.org>

selftests/hid: Add a test to ensure we can write fields in hid_device

This commit adds a selftest to verify that the name, uniq, and phys
fields of struct hid_device can be modified by a BPF program. This
ensures these fields remain writeable for BPF programs.

> diff --git a/tools/testing/selftests/hid/hid_bpf.c b/tools/testing/selfte=
sts/hid/hid_bpf.c
> index b851339308c21..069ebdbb4d1c4 100644
> --- a/tools/testing/selftests/hid/hid_bpf.c
> +++ b/tools/testing/selftests/hid/hid_bpf.c
[ ... ]
> +TEST_F(hid_bpf, test_rdesc_fixup_change_uniq_name_phys)
> +{
[ ... ]
> +	snprintf(expected, sizeof(expected), "%d phys:coming:from:bpf", self->h=
id.dev_id);
> +
> +	err =3D ioctl(self->hidraw_fd, HIDIOCGRAWPHYS(sizeof(buf)), buf);
> +	ASSERT_GE(err, 0) TH_LOG("HIDIOCGRAWPHYS");
> +	ASSERT_STREQ(expected, buf);

[Severity: Medium]
Will this test intermittently trigger a regression if dev_id is 1000 or
greater?

In setup_uhid(), dev_id is set as a random number between 0 and 1023. If
the number is 4 digits long, the string representation takes 4 characters,
placing the null terminator at index 4, which the BPF loop below doesn't
reach. This would cause the ASSERT_STREQ check to fail because the suffix
is not appended.

[ ... ]
> diff --git a/tools/testing/selftests/hid/progs/hid.c b/tools/testing/self=
tests/hid/progs/hid.c
> index b21fbb13c926f..b5d9aea1bda1d 100644
> --- a/tools/testing/selftests/hid/progs/hid.c
> +++ b/tools/testing/selftests/hid/progs/hid.c
[ ... ]
> +SEC("?struct_ops.s/hid_rdesc_fixup")
> +int BPF_PROG(hid_rdesc_fixup_change_uniq_name_phys, struct hid_bpf_ctx *=
hid_ctx)
> +{
> +#define HID_BPF_MEMCPY(target, str) \
> +	__builtin_memcpy(target, str, sizeof(str))
> +
> +	HID_BPF_MEMCPY(hid_ctx->hid->name, "name coming from bpf");
> +	HID_BPF_MEMCPY(hid_ctx->hid->uniq, "uniq:coming:from:bpf");
> +	/* hid_bpf relies on a phys being a rand % 1024 */
> +	for (int i =3D 0; i < 4; i++) {
> +		if (!hid_ctx->hid->phys[i]) {
> +			HID_BPF_MEMCPY(hid_ctx->hid->phys + i, " phys:coming:from:bpf");
> +			break;
> +		}
> +	}

[Severity: Medium]
Could this loop condition cause regressions when the phys string is 4
characters long?

If the random dev_id is >=3D 1000, the string will take up indices 0
through 3, and the null terminator will be at index 4. The loop stops at
i =3D 3, so it will miss the null terminator and skip the memcpy. Should the
loop condition be i < 5?

> +
> +#undef HID_BPF_CONCAT

[Severity: Low]
This isn't a bug, but it looks like there is a typo here. Should this be
undefining HID_BPF_MEMCPY instead?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260825-wip-bpf-sa=
fe-v1-0-ab9e0e111c5c@kernel.org?part=3D2
