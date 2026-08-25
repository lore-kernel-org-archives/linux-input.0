Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ADC23D525F
	for <linux-input@vger.kernel.org>; Tue, 25 Aug 2026 10:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787654871; cv=none; b=pX1SpV11vNXNbZB3ZL18fdkwjHRp0FK+MOU+44H3wr2meuYlDbgpj5XPwtttckssOTl+ZRgGr+Rxgto9dLZOpeTbD5UwUI6wGd9itSR8tE3hZOYrA+iOl/6nCCUw4qNmOI2FYvtEQvfsQbqN2k7ZhiUcFUSLcpC/g0aFIHRGK5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787654871; c=relaxed/simple;
	bh=FgfvUaBZNrENqgEHpbze+ONkMSalbkqTU60oOuF1WBM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VyqEezt7EO0djg4egm8G3INuQZklGd5ohDZwTqdeJ7w1RIPLdEvgz/PUQ0ztYPwG/8/W1RCcm6JKPfrsfzaJ+ApsuiQcIwm0lET/+17+ujzS/gw3eN6TliHjCmwGNQLJ5Dyal1Lxhfe4h3cqWwRPVd9jM0q/T2cWyLNhVHHepN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RU9CwC6w; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RU9CwC6w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00A8F1F000E9;
	Tue, 25 Aug 2026 10:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787654870;
	bh=AT1P5JxI1INiNLVO3CbwugDUX2rGr6ye5OIIpHa7TNw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RU9CwC6wPiiX0KvR7c0tQEWjK4o4VXecHy4/3Y3JkKUqRhEPAxUcQqsY0AMzGc+7v
	 hz8TDckq217OTIHZc39dg6E9O3Tw613ttww9KIj8If/Fa7O1iuKgP78PCqsLwX0f1Q
	 skxXcBMbvXcp6+Oez37XQ5PR0Lkp8OJGp3f0c1l6b7pdoDW2UOs/Z2woUymLhE/OKi
	 X4zPdbJoI9ZzwF2rvZSvodgnD1Np+JjDHlBIKzcdV4M5vQ1QB76a9daG6g8onAGCIx
	 sGdaAwaJEzzz4dZX4mluA9HnTFQtlL/HJVmStsKKP6HqTbt9DMcHY+Z1MuC8hM5hFY
	 xUk9QS442jyzQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] HID: wacom: fix OOB read in
 wacom_wac_pen_serial_enforce()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wei Jie Law" <98lawweijie@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260825103104.12090-1-98lawweijie@gmail.com>
References: <20260825103104.12090-1-98lawweijie@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 25 Aug 2026 10:47:49 +0000
Message-Id: <20260825104750.00A8F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Out-of-bounds Read / Information Disclosure in `wacom_wac_pen_seri=
al_enforce()` due to ignored `report_size`
- [High] Out-of-bounds Read / Information Disclosure in `wacom_wac_pen_seri=
al_enforce()` for unnumbered reports
- [High] Use-After-Free / Resource Leak in `wacom_parse_and_register()` err=
or path
--

--- Patch [1]: [PATCH v2] HID: wacom: fix OOB read in wacom_wac_pen_serial_=
enforce() ---
commit 4746f43ad261e437fb8781af2fd3818e85fdf59b
Author: Wei Jie Law <98lawweijie@gmail.com>

HID: wacom: fix OOB read in wacom_wac_pen_serial_enforce()

This commit attempts to fix an out-of-bounds read in
wacom_wac_pen_serial_enforce() by clamping the inner loop to the minimum of
the field's maxusage and report_count. This prevents the loop from extracti=
ng
usages that have no corresponding report data.

Link: https://lore.kernel.org/linux-input/20260822120926.153849-1-98lawweij=
ie@gmail.com/

> diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
> index 0eafa483b7f75..1ea8763b68a82 100644
> --- a/drivers/hid/wacom_sys.c
> +++ b/drivers/hid/wacom_sys.c
> @@ -113,8 +113,10 @@ static int wacom_wac_pen_serial_enforce(struct hid_d=
evice *hdev,
> =20
>  	/* Queue events which have invalid tool type or serial number */
>  	for (i =3D 0; i < report->maxfield; i++) {
> -		for (j =3D 0; j < report->field[i]->maxusage; j++) {
> -			struct hid_field *field =3D report->field[i];
> +		struct hid_field *field =3D report->field[i];
> +		unsigned int count =3D min(field->maxusage, field->report_count);
> +
> +		for (j =3D 0; j < count; j++) {
>  			struct hid_usage *usage =3D &field->usage[j];
>  			unsigned int equivalent_usage =3D wacom_equivalent_usage(usage->hid);
>  			unsigned int offset;

[Severity: High]
This is a pre-existing issue, but does this function still have an
out-of-bounds read because it ignores the report_size parameter?

Slightly further down in this loop, hid_field_extract() is called:

    value =3D hid_field_extract(hdev, raw_data+1, offset + j * size, size);

The extraction is based purely on the descriptor offsets and a hardcoded
raw_data+1 offset. If a device sends a physical report smaller than the
descriptor claims, couldn't this still read past the end of the raw_data
buffer?

[Severity: High]
This is also a pre-existing issue, but does hardcoding raw_data+1
cause an out-of-bounds read for unnumbered reports?

If a device provides an unnumbered report descriptor, the core passes the
physical payload directly without a prepended report id. Since this
function always skips the first byte by using raw_data+1, won't it read
one byte past the end of the buffer when hid_field_extract() is called?

I also noticed another pre-existing issue in this same file:

[Severity: High]
This is a pre-existing issue, but does the error path in
wacom_parse_and_register() cause a use-after-free?

drivers/hid/wacom_sys.c:wacom_parse_and_register() {
    ...
fail_hw_stop:
        hid_hw_stop(hdev);
fail:
        wacom_release_resources(wacom);
        return error;
}

If device initialization fails after wacom->init_work is scheduled or timers
like idleprox_timer are armed, this error path does not appear to cancel th=
em
before devres frees the wacom structure. When the timer or delayed work lat=
er
executes, will it access the freed wacom structure?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260825103104.1209=
0-1-98lawweijie@gmail.com?part=3D1
