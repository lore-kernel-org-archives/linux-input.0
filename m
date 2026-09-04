Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C01335066
	for <linux-input@vger.kernel.org>; Fri,  4 Sep 2026 13:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788527572; cv=none; b=RF89lv/MSpa/oskE8yknxjygtNgcL6WMe8QKMzYhcqDHIVxkTP8H6HRGm7/8I+qGWgAADBGhU8Eedb9m7Q186TozIgHdAwu6aRngIHDch2lRZSoCx1lPSeS9T/JscuLRH6bgGS/vLKgouuZfwYiKcz/AlTTZ2QeNyitsF3MRHNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788527572; c=relaxed/simple;
	bh=9gmtEaD5LVi/SReVVbH3ERPMOk75087En0ad1SWXdvY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PxUfBWbplOSqG7R/+yXSZ+CxFQ0zccEJ3bLxFo/aLs7QlPN7n4SDgWsUVK8arKqHOH3k9YSgnKO7hS3yP5A4/vJH7mRP8jKI3WQrM3whTRrLlB4zSL9xIOxyTXYTSmRI8g9Mgc7q+hzrC+7iD5Tak/suSqa+l1XjwU4uK0PtNvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eR+ScREr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eR+ScREr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D84C31F00A3D;
	Fri,  4 Sep 2026 13:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788527571;
	bh=iicwhwDQIsWOAyUW+FNIcux9JLQdzFIHEvV8M8a/jf8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eR+ScREr5f/JANCtTIOREixqjU+4LOt+INr1PxoNRZWwNQJw4QHieXrt2vttYq/iD
	 FYxzLrX+7OlOXSjBNxBAwkjcMmo4+2HwhueOcbGnfLVz2wUAzTzk/e/vE+6HOC6oJ0
	 uChuM4b35n/tq+7nCIX2s0pDWpjGj5Sxv+fggkVJi3xJye6UzzoZi3QxmLvbRgHZfe
	 6xCS8w3N33AhOKA77Kcl4Wws1epT5Of3NAp16wK1Kl4RrCdQB8gshvymlIEyibt6aw
	 sSt+tAMs8Ee72xz5M40eqHDHn1fGZxRAzth65LlsAvxbkdWo2LElnsE+Zr9qk7PRqe
	 le5W5RckDIpeQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] selftests/hid: add unnumbered variant to the
 hid_bpf tests
Reply-To: sashiko-reviews@lists.linux.dev
To: "Benjamin Tissoires" <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260904-wip-bpf-check_report-v1-3-efe9a2a1ed28@kernel.org>
References: <20260904-wip-bpf-check_report-v1-0-efe9a2a1ed28@kernel.org>
 <20260904-wip-bpf-check_report-v1-3-efe9a2a1ed28@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 13:12:50 +0000
Message-Id: <20260904131250.D84C31F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The newly added unnumbered test variant runs against unadapted t=
ests, leading to test suite regressions and false passes.
--

commit 25b4cfc0df88875655d4c7a83e9318718c0ae97f
Author: Benjamin Tissoires <bentiss@kernel.org>

selftests/hid: add unnumbered variant to the hid_bpf tests

A bug appeared in hid_bpf_dispatch.c where it wasn't properly handling
unnumbered reports. Add a device variant without report IDs so we can
also test them.

> diff --git a/tools/testing/selftests/hid/hid_bpf.c b/tools/testing/selfte=
sts/hid/hid_bpf.c
> index e865ee55b4f1d..d1bd07caf9919 100644
> --- a/tools/testing/selftests/hid/hid_bpf.c
> +++ b/tools/testing/selftests/hid/hid_bpf.c
> @@ -54,11 +54,27 @@ FIXTURE_TEARDOWN(hid_bpf) {
>  	hid_bpf_teardown(_metadata, self, variant); \
>  } while (0)
> =20
> +FIXTURE_VARIANT(hid_bpf) {
> +	__u8 *rdesc;
> +	size_t rdesc_size;
> +};
> +
> +FIXTURE_VARIANT_ADD(hid_bpf, numbered) {
> +	.rdesc =3D rdesc,
> +	.rdesc_size =3D sizeof(rdesc),
> +};
> +
> +FIXTURE_VARIANT_ADD(hid_bpf, unnumbered) {
> +	.rdesc =3D fido2_rdesc,
> +	.rdesc_size =3D sizeof(fido2_rdesc),
> +};
> +

[Severity: Medium]
Will unadapted tests such as raw_event() and
test_hid_filter_raw_request_call() fail when run against this new unnumbered
variant?

Since FIXTURE_VARIANT_ADD registers this variant for all tests in the hid_b=
pf
fixture, tests that weren't adapted might now fail because they still hardc=
ode
assumptions about the 6-byte numbered report. For instance, raw_event()
expects exactly 6 bytes:

	err =3D read(self->hidraw_fd, buf, sizeof(buf));
	ASSERT_EQ(err, 6) TH_LOG("read_hidraw");

test_hid_user_raw_request_call() hardcodes a report ID of 1:

	args.hid =3D self->hid.hid_id;
	args.data[0] =3D 1; /* report ID */

And test_hid_filter_raw_request_call() injects a 6-byte event:

	buf[0] =3D 1;
	buf[1] =3D 42;
	uhid_send_event(_metadata, &self->hid, buf, 6);

Do these other tests need similar if/else logic for variant->rdesc, or
should they explicitly call SKIP() for the unnumbered variant like
test_rdesc_fixup() does?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904-wip-bpf-ch=
eck_report-v1-0-efe9a2a1ed28@kernel.org?part=3D3
